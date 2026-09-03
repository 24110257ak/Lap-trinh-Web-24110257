package com.koha.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import com.koha.entity.User;
import com.koha.service.IUserService;
import com.koha.service.impl.UserServiceImpl;
import com.koha.util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(urlPatterns = {"/profile", "/user/profile"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class ProfileController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute(Constant.SESSION_USERNAME);

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin mới nhất từ cơ sở dữ liệu
        User currentUser = userService.findById(sessionUser.getId());
        if (currentUser == null) {
            currentUser = sessionUser;
        }

        req.setAttribute("user", currentUser);
        req.getRequestDispatcher("/views/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute(Constant.SESSION_USERNAME);

        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String imageLink = req.getParameter("imageLink");

        User user = userService.findById(sessionUser.getId());
        if (user == null) {
            user = sessionUser;
        }

        String avatarImage = user.getImages();

        // 1. Xử lý upload file bằng Multipart (theo giáo trình 10_UploadFile_servlet_jakarta.pdf)
        try {
            Part part = req.getPart("imageFile");
            if (part != null && part.getSize() > 0) {
                String originalFileName = getFileName(part);
                if (originalFileName == null || originalFileName.equals(Constant.DEFAULT_FILENAME) || originalFileName.trim().isEmpty()) {
                    if (part.getSubmittedFileName() != null) {
                        originalFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    }
                }

                if (originalFileName != null && !originalFileName.trim().isEmpty() && !originalFileName.equals(Constant.DEFAULT_FILENAME)) {
                    String extension = "";
                    int dotIndex = originalFileName.lastIndexOf('.');
                    if (dotIndex >= 0) {
                        extension = originalFileName.substring(dotIndex);
                    } else {
                        extension = ".png";
                    }

                    String newFileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + extension;
                    String uploadPath = Constant.USER_UPLOAD_DIR;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }

                    part.write(uploadPath + File.separator + newFileName);
                    avatarImage = "user/" + newFileName;
                }
            } else if (imageLink != null && !imageLink.trim().isEmpty()) {
                avatarImage = imageLink.trim();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 2. Cập nhật thông tin vào CSDL qua JPA
        boolean updated = userService.updateProfile(user.getId(), fullname, phone, avatarImage);

        if (updated) {
            User refreshedUser = userService.findById(user.getId());
            session.setAttribute(Constant.SESSION_USERNAME, refreshedUser);
            session.setAttribute("success_msg", "Cập nhật hồ sơ cá nhân thành công!");
        } else {
            session.setAttribute("error_msg", "Có lỗi xảy ra khi cập nhật hồ sơ!");
        }

        resp.sendRedirect(req.getContextPath() + "/profile");
    }

    /**
     * Lấy tên file upload từ header content-disposition theo slide bài giảng
     */
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String token : contentDisposition.split(";")) {
                if (token.trim().startsWith("filename")) {
                    return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return Constant.DEFAULT_FILENAME;
    }
}
