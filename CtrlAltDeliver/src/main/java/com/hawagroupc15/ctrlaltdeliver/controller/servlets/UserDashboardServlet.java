/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.UserDAO;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.CookieUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.PasswordUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.Arrays;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
@MultipartConfig
@WebServlet(name = "UserDashboardServlet", urlPatterns = {"/userdashboard"})
public class UserDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            final RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {
            UserDAO udao = new UserDAO();

            String page = request.getParameter("page");
            if (page == null || page.isBlank()) {
                page = "myorders";
            }
            request.setAttribute("page", page);

            ArrayList<Order> completed;
            ArrayList<Order> pending;
            ArrayList<Order> processing;
            ArrayList<Order> cancelled;

            switch (page) {
                case "myorders":
                    ArrayList<Order> orders = udao.getUserOrders(user.getUserId(), "Delivered");
                    ArrayList<Order> cancelledOrders = udao.getUserOrders(user.getUserId(), "Cancelled");
                    if (cancelledOrders != null) {
                        orders.addAll(cancelledOrders);
                    }
                    request.setAttribute("orders", orders);
                    break;

                case "currentorders":
                    pending = udao.getUserOrders(user.getUserId(), "Pending");
                    processing = udao.getUserOrders(user.getUserId(), "Processing");
                    ArrayList<Order> currentorders = new ArrayList<>();
                    currentorders.addAll(pending);
                    currentorders.addAll(processing);
                    request.setAttribute("orders", currentorders);
//                    log(currentorders.toString());
                    break;

                case "manageacc":
                    completed = udao.getUserOrders(user.getUserId(), "Delivered");
                    pending = udao.getUserOrders(user.getUserId(), "Pending");
                    processing = udao.getUserOrders(user.getUserId(), "Processing");
                    cancelled = udao.getUserOrders(user.getUserId(), "Cancelled");
                    int total = completed.size() + pending.size() + processing.size() + cancelled.size();
                    request.setAttribute("totalOrders", total);
                    String[] address = user.getAddress().split(",");
                    String street = address[0];
                    String city = address[1];
                    String postal = address[2];
                    request.setAttribute("street", street);
                    request.setAttribute("city", city);
                    request.setAttribute("postal", postal);
                    break;

                default:
                    page = "myorders";
                    request.setAttribute("page", page);

                    ArrayList<Order> defaultOrders = udao.getUserOrders(user.getUserId(), "Delivered");
                    ArrayList<Order> defaultcancelledOrders = udao.getUserOrders(user.getUserId(), "Cancelled");
                    if (defaultcancelledOrders != null) {
                        defaultOrders.addAll(defaultcancelledOrders);
                    }
                    request.setAttribute("orders", defaultOrders);
                    System.out.println(defaultOrders);
                    break;
            }

            request.setAttribute("user", user);
            final RequestDispatcher rd = request.getRequestDispatcher("/pages/userdashboard.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) SessionUtil.getAttribute(request, "user");

        final String fullName = request.getParameter("fullname");
        final String email = request.getParameter("email");
        final String phone = request.getParameter("phone");

        final String streetAddress = request.getParameter("streetAddress");
        final String city = request.getParameter("city");
        final String postalCode = request.getParameter("postalCode");
        final String address = streetAddress + ',' + city + ',' + postalCode;

        final String currentpassword = request.getParameter("currentPassword");
        final String newpassword = request.getParameter("newPassword");
        final String cfPassword = request.getParameter("confirmPassword");

        String[] newDetails = {fullName, email, phone, address};

        if (user == null) {
            final RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else {
            String action = request.getParameter("action");
            if (action.equals("change")) {
                String[] oldDetails = {user.getFullName(), user.getEmail(), user.getPhone(), user.getAddress()};
                if (Arrays.equals(oldDetails, newDetails)) {
                    //                log("nochanges");
                    //                log(Arrays.toString(newDetails));
                    CookieUtil.addCookie(response, "message", "No-changes-made.", 10);
                    response.sendRedirect(request.getContextPath() + "/userdashboard?page=manageacc");
                    return;
                } else {
                    UserDAO userDAO = new UserDAO();
                    int check = userDAO.updateUser(user.getUserId(), fullName, phone, email, address);
                    switch (check) {
                        case 1:
                            CookieUtil.addCookie(response, "message", "Changes-made-sucessfully.", 10);
                            user.setFullName(fullName);
                            user.setEmail(email);
                            user.setPhone(phone);
                            user.setAddress(address);

                            SessionUtil.setAttribute(request, "user", user);
                            break;
                        case 2:
                            CookieUtil.addCookie(response, "message", "Email-already-exists.", 10);
                            break;
                        case 3:
                            CookieUtil.addCookie(response, "message", "Database-error.", 10);
                        default:
                            System.out.println("Server error: " + check + " :error code");
                            break;
                    }

                }
            }
            if (action.equals("changepassword")) {
                if (newpassword.equals(cfPassword)) {
                    //log("matched");
                    boolean matched = PasswordUtil.checkPassword(currentpassword, user.getPasswordHash());
                    if (!matched) {
                        CookieUtil.addCookie(response, "message", "Current-password-is-incorrect.", 10);
                    } else {
                        String hashedPassword = PasswordUtil.getHashPassword(newpassword);
                        UserDAO dao = new UserDAO();
                        int result = dao.changePassword(user.getUserId(), hashedPassword);

                        switch (result) {
                            case 1:
                                user.setPasswordHash(hashedPassword);
                                SessionUtil.setAttribute(request, "user", user);
                                CookieUtil.addCookie(response, "message", "Password-changed-successfully.", 10);
                                break;

                            case 0:
                                CookieUtil.addCookie(response, "message", "Password-was-not-updated.", 10);
                                break;

                            case 2:
                                CookieUtil.addCookie(response, "message", "Database-error.", 10);
                                break;
                        }
                    }
                } else {
                    CookieUtil.addCookie(response, "message", "The-password-does-not-match-with-confirm-passwords.", 10);
//                    request.setAttribute("message", "The password does not match with confirm passwords.");
                }
            }
        }

        response.sendRedirect(request.getContextPath() + "/userdashboard?page=manageacc");
    }
}
