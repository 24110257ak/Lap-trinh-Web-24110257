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

@WebServlet(urlPatterns = {"/admin/category/add"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/admin/add-category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

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

        Category category = new Category();
        category.setName(name);
        category.setIcon(icon);

        cateService.insert(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
