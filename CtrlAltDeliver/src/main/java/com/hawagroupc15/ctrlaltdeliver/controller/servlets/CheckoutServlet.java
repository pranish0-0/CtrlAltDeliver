/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.CartDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.OrderDAO;
import com.hawagroupc15.ctrlaltdeliver.model.CartItemView;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.CookieUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 *
 * @author Pranish
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) SessionUtil.getAttribute(request, "user");

        // User must be logged in
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        CartDAO cartDAO = new CartDAO();

        List<CartItemView> cartItems = cartDAO.fetchUserCart(user.getUserId());

        // Cart is empty
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        request.setAttribute("cartItems", cartItems);

        RequestDispatcher rd = request.getRequestDispatcher("/pages/checkout.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) SessionUtil.getAttribute(request, "user");

        String shippingAddress = request.getParameter("shippingAddress");
        OrderDAO orderDAO = new OrderDAO();

        if (!orderDAO.checkStockQuantity(user.getUserId())) {
            CookieUtil.addCookie(response, "errormessage", "One_or_more_products_are_out_of_stock.", 6);
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        int orderId = orderDAO.createOrder( user.getUserId(), shippingAddress);

        if (orderId == 0) {
            CookieUtil.addCookie(response, "errormessage", "An_Unexpected_Error_Occured.", 6);
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        
        if(orderDAO.createOrderItems(orderId, user.getUserId())){
            CookieUtil.addCookie(response, "message", "Order_Placed_Sucessfully.", 6);
        }else{CookieUtil.addCookie(response, "message", "Couldn't_Place_Order.", 6);}
        response.sendRedirect(request.getContextPath() + "/userdashboard?action=currentorders");

    }

}
