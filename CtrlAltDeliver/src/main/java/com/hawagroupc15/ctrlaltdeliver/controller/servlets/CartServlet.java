/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.CartDAO;
import com.hawagroupc15.ctrlaltdeliver.model.CartItem;
import com.hawagroupc15.ctrlaltdeliver.model.CartItemView;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Pranish
 */
@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (SessionUtil.getAttribute(request, "user") != null) {
            final String action = request.getParameter("action");

            final CartDAO cdao = new CartDAO();
            User user = (User) SessionUtil.getAttribute(request, "user");
            int userId = user.getUserId();
//        System.out.println(user.getUserId());

            List<CartItemView> cart = cdao.fetchUserCart(userId);
            request.setAttribute("cartItems", cart);

//        System.err.println(action);
            final RequestDispatcher rd = request.getRequestDispatcher("/pages/mycart.jsp");
            rd.forward(request, response);
        } else {
            final RequestDispatcher rd = request.getRequestDispatcher("/pages/mycart.jsp");
            rd.forward(request, response);

        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        final String action = request.getParameter("action");
        final CartDAO cdao = new CartDAO();

        if (action != null) {

//            final int quantity = Integer.parseInt(request.getParameter("quantity"));
            switch (action) {
                case "increase": {
                    final int cartitemId = Integer.parseInt(request.getParameter("cartItemId"));
                    CartItem item = cdao.getCartItemById(cartitemId);
                    int quantity = item.getQuantity();
                    cdao.updateCartItemQunatity(quantity + 1, cartitemId);
                    break;
                }
                case "decrease": {
                    final int cartitemId = Integer.parseInt(request.getParameter("cartItemId"));
                    CartItem item = cdao.getCartItemById(cartitemId);
                    int quantity = item.getQuantity();
                    cdao.updateCartItemQunatity(quantity - 1, cartitemId);
                    break;
                }
                case "removeItem": {
                    final int cartitemId = Integer.parseInt(request.getParameter("cartItemId"));
                    cdao.removeCartItem(cartitemId);
//                    System.out.println("cartitemid"+cartitemId);
//                    System.out.println("remove cart item "+ cdao.removeCartItem(cartitemId));
                    break;
                }
            }

            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
