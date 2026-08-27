package com.koha.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.koha.model.UserModel;
import com.koha.service.UserService;
import com.koha.service.UserServiceImpl;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Neu da dang nhap bang session thi chuyen ve home
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Kiem tra Cookie username de dien san vao o dang nhap (Remember Me)
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if ("username".equals(c.getName())) {
                    req.setAttribute("rememberUsername", c.getValue());
                    req.setAttribute("rememberChecked", true);
                    break;
                }
            }
        }

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uname = req.getParameter("username");
        String pword = req.getParameter("password");
        String remember = req.getParameter("remember");

        UserModel user = userService.login(uname, pword);

        if (user != null) {
            // 1. Luu thong tin vao Session (Login bang Session)
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);

            // 2. Xu ly Cookie (Remember Me)
            String contextPath = req.getContextPath().isEmpty() ? "/" : req.getContextPath();
            if (remember != null && (remember.equals("on") || remember.equals("true") || remember.equals("1"))) {
                Cookie cookie = new Cookie("username", uname);
                cookie.setMaxAge(60 * 60 * 24 * 7); // Luu 7 ngay
                cookie.setPath(contextPath);
                resp.addCookie(cookie);
            } else {
                // Xoa cookie neu khong tich Remember Me
                Cookie cookie = new Cookie("username", "");
                cookie.setMaxAge(0);
                cookie.setPath(contextPath);
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            req.setAttribute("rememberUsername", uname);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
