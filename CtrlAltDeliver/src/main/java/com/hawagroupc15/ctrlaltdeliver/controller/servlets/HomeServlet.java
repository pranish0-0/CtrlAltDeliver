/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.CartDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.CategoryDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.ProductDAO;
import com.hawagroupc15.ctrlaltdeliver.model.Category;
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        final RequestDispatcher rd = request.getRequestDispatcher("/pages/home.jsp");
//        rd.forward(request, response);
//if no action parameter Null Pointer exception so handle it
        final String action = request.getParameter("action") == null ? "" : request.getParameter("action");
        //Get Product DAO object for CRUD Topics table
        final ProductDAO pdao = new ProductDAO();
        ArrayList<Product> products = null;
        switch (action) {
            case "bestseller": {
                products = pdao.fetchProductsByTag("bestseller");
                break;
            }
            case "new": {
                products = pdao.fetchProductsByTag("new");
                break;
            }
            case "discount": {
                products = pdao.fetchProductsByTag("discount");
                break;
            }
            case "limited": {
                products = pdao.fetchProductsByTag("limited");
                break;
            }
            default: {
                products = pdao.fetchAllFeaturedProducts();
                break;
            }
        }
        request.setAttribute("products", products);
//        System.out.println(products);

        final CategoryDAO tdao = new CategoryDAO();
        ArrayList<Category> categories = tdao.fetchAllCategory();
        request.setAttribute("categories", categories);
//        System.out.println(categories);

        request.setAttribute("myprofile", "Sign Out");
        final RequestDispatcher rd = request.getRequestDispatcher("/pages/home.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addToCartBtn".equals(action)) {
            // Get productId from hidden input
            int productId = Integer.parseInt(request.getParameter("productId"));

            // Get userId from sessioan
            User user = (User) SessionUtil.getAttribute(request, "user");

            // Guard: if not logged in, redirect to login
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            int userId = user.getUserId();

            // Add to cart (default quantity 1)
            CartDAO cartDao = new CartDAO();
            boolean success = cartDao.addItemToCart(userId, productId, 1);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/home");
            } else {
                request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
            }
        }
    }

}
