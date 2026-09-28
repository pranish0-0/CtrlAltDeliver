/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.filters;

import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class AuthorizationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getServletPath();
//        System.out.println((request.getServletPath()));

        // Allow static resources
        if (path.startsWith("/resources/")
                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/fonts/")
                || path.startsWith("/icons/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".svg")
                || path.endsWith(".ico")) {

            chain.doFilter(req, res);
            return;
        }

        User user = (User) SessionUtil.getAttribute(request, "user");

        // ADMIN
        if (user != null && user.getRole() == User.Role.ADMIN) {

            if (path.equals("/admin") || path.equals("/logout")) {
                chain.doFilter(req, res);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin");
            }
            return;
        }

        // MEMBER
        if (user != null && user.getRole() == User.Role.MEMBER) {

            // Members cannot access admin
            if (path.equals("/admin")) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            chain.doFilter(req, res);
            return;
        }

        // GUEST
        if (isPublic(path)) {
            chain.doFilter(req, res);
            return;
        }

        // Protected pages require login
        response.sendRedirect(request.getContextPath() + "/login");
    }

    private boolean isPublic(String path) {

        return path.equals("/")
                || path.equals("/home")
                || path.equals("/login")
                || path.equals("/register")
                || path.equals("/products")
                || path.equals("/product")
                || path.equals("/pages/aboutus.html")
                || path.equals("/pages/privacy.html");
    }
}