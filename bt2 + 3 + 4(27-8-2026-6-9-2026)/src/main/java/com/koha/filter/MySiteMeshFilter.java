package com.koha.filter;

import java.io.IOException;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.sitemesh.config.ObjectFactory;
import org.sitemesh.config.properties.PropertiesFilterConfigurator;
import org.sitemesh.config.xml.XmlFilterConfigurator;
import org.sitemesh.webapp.SiteMeshFilter;
import org.sitemesh.webapp.WebAppContext;
import org.sitemesh.webapp.contentfilter.ResponseMetaData;
import org.w3c.dom.Element;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Filter tương thích hoàn hảo cho Tomcat 11 (Jakarta Servlet 6.0).
 * Sửa lỗi "Cannot forward after response has been committed" bằng cách sử dụng
 * RequestDispatcher.include() thay vì RequestDispatcher.forward() khi render decorator.
 */
public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        super.init(filterConfig);
    }

    @Override
    protected Filter setup() throws ServletException {
        ObjectFactory objectFactory = getObjectFactory();
        SiteMeshFilterBuilder builder = new SiteMeshFilterBuilder();

        FilterConfig cfg = this.filterConfig;

        new PropertiesFilterConfigurator(objectFactory, getConfigProperties(cfg)).configureFilter(builder);

        Element xml = loadConfigXml(cfg, getConfigFileName());
        if (xml != null) {
            new XmlFilterConfigurator(objectFactory, xml).configureFilter(builder);
        }

        applyCustomConfiguration(builder);

        final boolean includeErrors = builder.isIncludeErrorPages();

        return new SiteMeshFilter(builder.getSelector(), builder.getContentProcessor(),
                builder.getDecoratorSelector(), includeErrors) {

            @Override
            protected WebAppContext createContext(String contentType, HttpServletRequest request,
                    HttpServletResponse response, ResponseMetaData metaData) {
                return new WebAppContext(contentType, request, response,
                        cfg.getServletContext(),
                        getContentProcessor(), metaData, includeErrors) {

                    @Override
                    protected void dispatch(HttpServletRequest req, HttpServletResponse res, String path)
                            throws ServletException, IOException {
                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(path);
                        if (dispatcher == null) {
                            throw new ServletException("Could not find decorator dispatcher for: " + path);
                        }
                        // Dùng include thay vì forward để không bị lỗi IllegalStateException trên Tomcat 11
                        dispatcher.include(req, res);
                    }
                };
            }
        };
    }
}
