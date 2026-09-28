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
import com.hawagroupc15.ctrlaltdeliver.model.ProductImages;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.CookieUtil;
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
@WebServlet(name = "ProductViewServlet", urlPatterns = {"/product"})
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("id");
        if (productID == null || productID.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        int product_id = Integer.parseInt(productID);
        //Get Product DAO object for CRUD 
        final ProductDAO pdao = new ProductDAO();
        Product product = pdao.fetchProductsByID(product_id);
//        System.out.println(product);
        request.setAttribute("product", product);

        ArrayList<ProductImages> productImages = pdao.fetchImagesByProductID(product_id);
        request.setAttribute("productImages", productImages);
//        System.out.println("SIZE: " + productImages.size());
//        System.out.println("productImages: "+productImages);

        final CategoryDAO cdao = new CategoryDAO();
        Category category = cdao.fetchCategoryByProductId(product_id);
        request.setAttribute("category", category);

//        if (category.getCategoryName() == null || category.getCategoryName().isBlank()) {
//            request.setAttribute("checkProduct", "invalid");
//            final RequestDispatcher rd = request.getRequestDispatcher("/pages/productview.jsp");
//            rd.forward(request, response);
//            return;
//        }

        if (category == null) {
            category = new Category();
            category.setCategoryName("Uncategorized");
        }

        request.setAttribute("category", category);

        request.setAttribute("pageTitle", product.getName());
        final RequestDispatcher rd = request.getRequestDispatcher("/pages/productview.jsp");
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
                CookieUtil.addCookie(response, "cartmessage", "Item-Added-To-Cart!", 5);
                response.sendRedirect(request.getContextPath() + "/product?id="+productId);
            } else {
                request.setAttribute("cartmessage", "Failed to add item to cart.");
                request.getRequestDispatcher("/pages/productview.jsp").forward(request, response);
            }
        }
    }
    
    

}
