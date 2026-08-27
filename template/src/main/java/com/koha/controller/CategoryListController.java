package com.koha.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.koha.model.Category;
import com.koha.service.CategoryService;
import com.koha.service.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/category/list", "/admin/categories"})
public class CategoryListController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null) {
            keyword = req.getParameter("search");
        }

        List<Category> cateList;
        if (keyword != null && !keyword.trim().isEmpty()) {
            cateList = cateService.search(keyword.trim());
            req.setAttribute("keyword", keyword.trim());
        } else {
            cateList = cateService.getAll();
        }

        req.setAttribute("cateList", cateList);
        req.getRequestDispatcher("/views/admin/list-category.jsp").forward(req, resp);
    }
}
