/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.utilities.CookieUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Pranish
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalidate the session that delete the user data from session 
        SessionUtil.invalidateSession(request);
        //Delete name: user and id
        CookieUtil.deleteCookie(response, "email");
        CookieUtil.deleteCookie(response, "full_name");
        CookieUtil.deleteCookie(response, "user_id");
        // Now route to login page
        response.sendRedirect(request.getContextPath() + "/home");
    }

}
