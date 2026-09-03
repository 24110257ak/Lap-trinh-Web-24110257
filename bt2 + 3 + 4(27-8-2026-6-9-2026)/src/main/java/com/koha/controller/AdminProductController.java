package com.koha.controller;

import java.io.File;
import java.io.IOException;
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
import com.koha.entity.Product;
import com.koha.service.ICategoryService;
import com.koha.service.IProductService;
import com.koha.service.impl.CategoryServiceImpl;
import com.koha.service.impl.ProductServiceImpl;
import com.koha.util.Constant;

@WebServlet(urlPatterns = {
    "/admin/products",
    "/admin/product/list",
    "/admin/product/add",
    "/admin/product/insert",
    "/admin/product/edit",
    "/admin/product/update",
    "/admin/product/delete",
    "/admin/product/search"
})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AdminProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService categoryService = new CategoryServiceImpl();

    /**
     * Phương thức trích xuất tên file upload theo đúng chuẩn slide giáo trình 10_UploadFile_servlet_jakarta.pdf
     */
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                String fileName = content.substring(content.indexOf("=") + 2, content.length() - 1);
                // Xử lý lấy tên file thuần túy nếu có đường dẫn tuyệt đối từ client IE/Windows
                return Paths.get(fileName).getFileName().toString();
            }
        }
        return Constant.DEFAULT_FILENAME;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/product/add")) {
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
                req.getSession().setAttribute("message", "Đã xóa sản phẩm thành công!");
            } catch (Exception e) {
                req.getSession().setAttribute("error", "Lỗi xóa sản phẩm: " + e.getMessage());
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else {
            // Mặc định hiển thị danh sách sản phẩm
            String keyword = req.getParameter("keyword");
            List<Product> list;
            if (keyword != null && !keyword.trim().isEmpty()) {
                list = productService.searchByName(keyword.trim());
                req.setAttribute("keyword", keyword.trim());
            } else {
                list = productService.findAll();
            }
            req.setAttribute("productList", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            String name = req.getParameter("productName");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Category category = categoryService.findById(categoryId);

            Product product = new Product();
            product.setProductName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setQuantity(quantity);
            product.setStatus(status);
            product.setCategory(category);

            // Xử lý upload file hình ảnh theo chuẩn Multipart
            String uploadPath = Constant.PRODUCT_UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            Part part = req.getPart("imageFile");
            String imageLink = req.getParameter("imageLink");

            if (part != null && part.getSize() > 0) {
                String originalFileName = getFileName(part);
                if (!originalFileName.equals(Constant.DEFAULT_FILENAME) && !originalFileName.trim().isEmpty()) {
                    String extension = "";
                    int i = originalFileName.lastIndexOf('.');
                    if (i > 0) {
                        extension = originalFileName.substring(i);
                    }
                    String newFileName = System.currentTimeMillis() + extension;
                    part.write(uploadPath + File.separator + newFileName);
                    product.setImages("product/" + newFileName);
                }
            } else if (imageLink != null && !imageLink.trim().isEmpty()) {
                product.setImages(imageLink.trim());
            }

            productService.insert(product);
            req.getSession().setAttribute("message", "Thêm sản phẩm mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");

        } else if (url.contains("/admin/product/update")) {
            int id = Integer.parseInt(req.getParameter("productId"));
            String name = req.getParameter("productName");
            String description = req.getParameter("description");
            double price = Double.parseDouble(req.getParameter("price"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            int status = Integer.parseInt(req.getParameter("status"));
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));

            Product product = productService.findById(id);
            if (product != null) {
                Category category = categoryService.findById(categoryId);
                product.setProductName(name);
                product.setDescription(description);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setStatus(status);
                product.setCategory(category);

                String uploadPath = Constant.PRODUCT_UPLOAD_DIR;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                Part part = req.getPart("imageFile");
                String imageLink = req.getParameter("imageLink");

                if (part != null && part.getSize() > 0) {
                    String originalFileName = getFileName(part);
                    if (!originalFileName.equals(Constant.DEFAULT_FILENAME) && !originalFileName.trim().isEmpty()) {
                        String extension = "";
                        int i = originalFileName.lastIndexOf('.');
                        if (i > 0) {
                            extension = originalFileName.substring(i);
                        }
                        String newFileName = System.currentTimeMillis() + extension;
                        part.write(uploadPath + File.separator + newFileName);
                        product.setImages("product/" + newFileName);
                    }
                } else if (imageLink != null && !imageLink.trim().isEmpty()) {
                    product.setImages(imageLink.trim());
                }

                productService.update(product);
                req.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }
}
