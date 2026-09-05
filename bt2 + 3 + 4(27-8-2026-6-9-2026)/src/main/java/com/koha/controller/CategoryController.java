package com.koha.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import com.koha.entity.Category;
import com.koha.service.ICategoryService;
import com.koha.service.impl.CategoryServiceImpl;
import com.koha.util.Constant;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
@WebServlet(urlPatterns = {
    "/admin/categories",
    "/admin/category/list",
    "/admin/category/add",
    "/admin/category/insert",
    "/admin/category/edit",
    "/admin/category/update",
    "/admin/category/delete"
})
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/categories") || url.contains("/admin/category/list")) {
            String keyword = req.getParameter("keyword");
            if (keyword == null) {
                keyword = req.getParameter("search");
            }

            List<Category> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = cateService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = cateService.findAll();
            }

            req.setAttribute("listcate", list);
            req.setAttribute("cateList", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/edit")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    Category category = cateService.findById(id);
                    if (category != null) {
                        req.setAttribute("cate", category);
                        req.setAttribute("category", category);
                        req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/delete")) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    cateService.delete(id);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        if (url.contains("/admin/category/insert") || url.contains("/admin/category/add")) {
            String categoryname = req.getParameter("categoryname");
            if (categoryname == null) {
                categoryname = req.getParameter("name");
            }
            java.util.Map<String, String> errors = new java.util.HashMap<>();

            if (com.koha.util.ValidatorUtil.isEmpty(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            } else if (!com.koha.util.ValidatorUtil.isValidLength(categoryname, 2, 100)) {
                errors.put("categoryname", "Tên danh mục phải từ 2 đến 100 ký tự!");
            } else if (cateService.findByCategoryname(categoryname.trim()) != null) {
                errors.put("categoryname", "Tên danh mục '" + categoryname.trim() + "' đã tồn tại!");
            }

            String statusStr = req.getParameter("status");
            Integer status = com.koha.util.ValidatorUtil.parseIntSafe(statusStr);
            if (status == null || (status != 0 && status != 1)) {
                status = 1;
            }

            String images = req.getParameter("images");
            if (com.koha.util.ValidatorUtil.isNotEmpty(images) && !com.koha.util.ValidatorUtil.isValidImageUrl(images)) {
                errors.put("images", "Đường dẫn ảnh phải bắt đầu bằng http:// hoặc https://!");
            }

            Part part = null;
            try {
                part = req.getPart("images1");
                if (part == null) {
                    part = req.getPart("icon");
                }
                if (part != null && part.getSize() > 0) {
                    String subName = part.getSubmittedFileName();
                    if (subName != null && !com.koha.util.ValidatorUtil.isValidImageExtension(subName)) {
                        errors.put("imageFile", "Chỉ chấp nhận các định dạng ảnh: .jpg, .jpeg, .png, .gif, .webp!");
                    }
                    if (part.getSize() > 10 * 1024 * 1024) {
                        errors.put("imageFile", "Dung lượng ảnh tối đa là 10MB!");
                    }
                }
            } catch (Exception e) {
                errors.put("imageFile", "Lỗi tiếp nhận file ảnh: " + e.getMessage());
            }

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("oldCategoryName", categoryname);
                req.setAttribute("oldStatus", status);
                req.setAttribute("oldImages", images);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            String fname = "";
            String uploadPath = Constant.DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index >= 0 ? filename.substring(index) : ".jpg";
                    fname = System.currentTimeMillis() + ext;
                    part.write(uploadPath + File.separator + fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    fname = images.trim();
                } else {
                    fname = "avatar.png";
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);
            category.setImages(fname);

            cateService.insert(category);
            req.getSession().setAttribute("message", "Thêm danh mục mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");

        } else if (url.contains("/admin/category/update") || url.contains("/admin/category/edit")) {
            String idStr = req.getParameter("categoryid");
            if (idStr == null) {
                idStr = req.getParameter("id");
            }
            Integer categoryid = com.koha.util.ValidatorUtil.parseIntSafe(idStr);
            if (categoryid == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            Category category = cateService.findById(categoryid);
            if (category == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            String categoryname = req.getParameter("categoryname");
            if (categoryname == null) {
                categoryname = req.getParameter("name");
            }

            java.util.Map<String, String> errors = new java.util.HashMap<>();

            if (com.koha.util.ValidatorUtil.isEmpty(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống!");
            } else if (!com.koha.util.ValidatorUtil.isValidLength(categoryname, 2, 100)) {
                errors.put("categoryname", "Tên danh mục phải từ 2 đến 100 ký tự!");
            } else {
                Category exist = cateService.findByCategoryname(categoryname.trim());
                if (exist != null && exist.getCategoryId() != categoryid) {
                    errors.put("categoryname", "Tên danh mục '" + categoryname.trim() + "' đã tồn tại!");
                }
            }

            String statusStr = req.getParameter("status");
            Integer status = com.koha.util.ValidatorUtil.parseIntSafe(statusStr);
            if (status == null || (status != 0 && status != 1)) {
                status = 1;
            }

            String images = req.getParameter("images");
            if (com.koha.util.ValidatorUtil.isNotEmpty(images) && !com.koha.util.ValidatorUtil.isValidImageUrl(images)) {
                errors.put("images", "Đường dẫn ảnh phải bắt đầu bằng http:// hoặc https://!");
            }

            Part part = null;
            try {
                part = req.getPart("images1");
                if (part == null) {
                    part = req.getPart("icon");
                }
                if (part != null && part.getSize() > 0) {
                    String subName = part.getSubmittedFileName();
                    if (subName != null && !com.koha.util.ValidatorUtil.isValidImageExtension(subName)) {
                        errors.put("imageFile", "Chỉ chấp nhận các định dạng ảnh: .jpg, .jpeg, .png, .gif, .webp!");
                    }
                    if (part.getSize() > 10 * 1024 * 1024) {
                        errors.put("imageFile", "Dung lượng ảnh tối đa là 10MB!");
                    }
                }
            } catch (Exception e) {
                errors.put("imageFile", "Lỗi tiếp nhận file ảnh: " + e.getMessage());
            }

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                category.setCategoryname(categoryname);
                category.setStatus(status);
                req.setAttribute("category", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            String fileold = category.getImages();
            String fname = fileold;
            String uploadPath = Constant.DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            try {
                if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
                    // Xóa file cũ trên thư mục nếu không phải URL online
                    if (fileold != null && !fileold.startsWith("http") && !fileold.equals("avatar.png")) {
                        try {
                            deleteFile(uploadPath + File.separator + fileold);
                        } catch (Exception ex) {
                            // Bỏ qua nếu file không tồn tại
                        }
                    }

                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = index >= 0 ? filename.substring(index) : ".jpg";
                    fname = System.currentTimeMillis() + ext;
                    part.write(uploadPath + File.separator + fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    fname = images.trim();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            category.setCategoryname(categoryname.trim());
            category.setStatus(status);
            category.setImages(fname);

            cateService.update(category);
            req.getSession().setAttribute("message", "Cập nhật danh mục thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}

