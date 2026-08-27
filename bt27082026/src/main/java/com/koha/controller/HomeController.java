package com.koha.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.koha.entity.User;

@WebServlet(urlPatterns = {"", "/", "/home", "/waiting", "/admin/home"})
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        HttpSession session = req.getSession(false);

        if (url.contains("/waiting")) {
            if (session != null && (session.getAttribute("user") != null || session.getAttribute("account") != null)) {
                User u = (User) (session.getAttribute("user") != null ? session.getAttribute("user") : session.getAttribute("account"));
                req.setAttribute("username", u.getUsername());
                if (u.getRoleid() == 1) {
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/home");
                }
            } else {
                resp.sendRedirect(req.getContextPath() + "/login");
            }
            return;
        }

        req.getRequestDispatcher("/views/index.jsp").forward(req, resp);
    }
}
