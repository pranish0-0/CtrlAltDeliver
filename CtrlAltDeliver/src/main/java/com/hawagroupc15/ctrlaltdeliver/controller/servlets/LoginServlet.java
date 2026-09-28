package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.UserDAO;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.PasswordUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String typedPassword = request.getParameter("password");
        UserDAO userDao = new UserDAO();
        User user = userDao.getUser(email);
        //if no user found in database send error message
        if (user == null) {
            request.setAttribute("error", "user or password mismatch!");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {
            String hashedPassword = user.getPasswordHash();
//            System.out.println(PasswordUtil.checkPassword(typedPassword, hashedPassword));
            boolean matched = PasswordUtil.checkPassword(typedPassword, hashedPassword);
            //if user and password matched, redirect to home
            if (matched) {
                // we store user object in session with user attribute
                SessionUtil.setAttribute(request, "user", user);
                // in seconds sec*min*hr=total sec
//                CookieUtil.addCookie(response, "email", user.getEmail(), 60 * 60 * 24);// 1 day
//                CookieUtil.addCookie(response, "full_name", user.getFullName().replace(" ", "_"), 60 * 60 * 24);// 1 day
//                CookieUtil.addCookie(response, "user_id", String.valueOf(user.getUserId()), 60 * 60 * 24);// 1 day
//                System.out.println(user);
                if (!user.isAdmin()) {
                    request.setAttribute("myprofile", "My Profile");
                    response.sendRedirect(request.getContextPath() + "/home");
                } else if (user.isAdmin()) {
                    request.setAttribute("admin", "yes");
                    response.sendRedirect(request.getContextPath() + "/admin");
                }
            } else {
                //if password is mismatched, send error message to login page
                request.setAttribute("error", "user or password mismatch!");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        }

    }

}
