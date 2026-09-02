package com.koha.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.koha.service.IUserService;
import com.koha.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/reset-password"})
public class ResetPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String account = req.getParameter("account");
        if (account == null || account.trim().isEmpty()) {
            account = (String) session.getAttribute("reset_account");
        }

        req.setAttribute("account", account);
        req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        String account = req.getParameter("account");
        if (account == null || account.trim().isEmpty()) {
            account = (String) session.getAttribute("reset_account");
        }

        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (account == null || account.trim().isEmpty() || otp == null || otp.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ tất cả các trường thông tin!");
            req.setAttribute("account", account);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("account", account);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.resetPassword(account.trim(), otp.trim(), newPassword.trim());

        if (success) {
            session.removeAttribute("reset_account");
            session.setAttribute("success_msg", "Đổi mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Mã xác thực OTP không chính xác hoặc đã hết hạn!");
            req.setAttribute("account", account);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}
