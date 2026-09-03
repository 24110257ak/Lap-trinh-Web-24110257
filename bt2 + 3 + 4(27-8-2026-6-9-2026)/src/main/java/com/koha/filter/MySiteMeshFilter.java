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
 * 1. Khắc phục lỗi "Cannot forward after response has been committed" bằng include().
 * 2. Khắc phục lỗi nhân đôi prefix "/WEB-INF/decorators/decorators/web.jsp" bằng setDecoratorPrefix("").
 * 3. Chuẩn hóa đường dẫn an toàn trong hàm dispatch().
 */
public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    private FilterConfig filterConfig;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
        super.init(filterConfig);
    }

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Đặt prefix rỗng để không bị sitemesh tự động cộng dồn /WEB-INF/decorators/
        builder.setDecoratorPrefix("");

        // Cấu hình đường dẫn decorator
        builder.addDecoratorPath("/profile", "/decorators/web.jsp")
               .addDecoratorPath("/user/*", "/decorators/web.jsp")
               .addDecoratorPath("/home", "/decorators/web.jsp")
               .addDecoratorPath("/product", "/decorators/web.jsp")
               .addDecoratorPath("/product/*", "/decorators/web.jsp")
               .addDecoratorPath("/admin/*", "/decorators/admin.jsp")
               .addExcludedPath("/login")
               .addExcludedPath("/register")
               .addExcludedPath("/verify-otp")
               .addExcludedPath("/forgot-password")
               .addExcludedPath("/reset-password")
               .addExcludedPath("/image");
    }

    @Override
    protected Filter setup() throws ServletException {
        ObjectFactory objectFactory = getObjectFactory();
        SiteMeshFilterBuilder builder = new SiteMeshFilterBuilder();

        FilterConfig cfg = this.filterConfig;

        try {
            new PropertiesFilterConfigurator(objectFactory, getConfigProperties(cfg)).configureFilter(builder);
        } catch (Exception ignored) {
        }

        try {
            Element xml = loadConfigXml(cfg, getConfigFileName());
            if (xml != null) {
                new XmlFilterConfigurator(objectFactory, xml).configureFilter(builder);
            }
        } catch (Exception e) {
            System.err.println("[SiteMesh Warning] XML config not loaded: " + e.getMessage());
        }

        // Áp dụng cấu hình chuẩn
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
                        String targetPath = path;

                        // Xử lý loại bỏ nhân đôi prefix nếu có
                        if (targetPath.contains("/WEB-INF/decorators/decorators/")) {
                            targetPath = targetPath.replace("/WEB-INF/decorators/decorators/", "/decorators/");
                        }

                        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(targetPath);
                        if (dispatcher == null) {
                            dispatcher = getServletContext().getRequestDispatcher("/decorators/web.jsp");
                        }

                        // Dùng include thay vì forward để không bị lỗi IllegalStateException trên Tomcat 11
                        dispatcher.include(req, res);
                    }
                };
            }
        };
    }
}
