package com.koha.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.koha.model.Category;
import com.koha.service.CategoryService;
import com.koha.service.CategoryServiceImpl;
import com.koha.util.Constant;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(urlPatterns = {"/admin/category/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class CategoryEditController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Category category = cateService.get(id);
                if (category != null) {
                    req.setAttribute("category", category);
                    req.getRequestDispatcher("/views/admin/edit-category.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String icon = null;

        try {
            Part part = req.getPart("icon");
            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                String originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = originalFileName.contains(".") ? originalFileName.substring(originalFileName.lastIndexOf(".")) : ".jpg";
                String fileName = System.currentTimeMillis() + ext;

                File uploadDir = new File(Constant.CATEGORY_UPLOAD_DIR);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                part.write(uploadDir.getAbsolutePath() + File.separator + fileName);
                icon = "category/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                Category category = new Category();
                category.setId(id);
                category.setName(name);
                category.setIcon(icon);

                cateService.edit(category);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
