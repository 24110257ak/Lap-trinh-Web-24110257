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

@WebServlet(urlPatterns = {"/verify-otp", "/resend-otp"})
public class VerifyOtpController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        HttpSession session = req.getSession();

        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("otp_username");
        }

        if (uri.contains("/resend-otp")) {
            if (username != null && !username.trim().isEmpty()) {
                boolean resent = userService.resendOtp(username.trim());
                if (resent) {
                    session.setAttribute("message", "Mã OTP mới đã được gửi lại thành công!");
                } else {
                    session.setAttribute("error", "Không thể gửi lại mã OTP, vui lòng kiểm tra lại tài khoản!");
                }
            }
            resp.sendRedirect(req.getContextPath() + "/verify-otp");
            return;
        }

        req.setAttribute("username", username);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        String username = req.getParameter("username");
        if (username == null || username.trim().isEmpty()) {
            username = (String) session.getAttribute("otp_username");
        }

        String otp = req.getParameter("otp");

        if (username == null || username.trim().isEmpty() || otp == null || otp.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ mã xác thực OTP!");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean verified = userService.verifyOtp(username.trim(), otp.trim());

        if (verified) {
            session.removeAttribute("otp_username");
            session.removeAttribute("otp_email");
            session.setAttribute("success_msg", "Kích hoạt tài khoản thành công! Bạn có thể đăng nhập ngay bây giờ.");
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn! Vui lòng thử lại hoặc bấm Gửi lại mã.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
