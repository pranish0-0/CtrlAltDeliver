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
@WebServlet(name = "BrowseServlet", urlPatterns = {"/products"})
public class BrowseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        doPost(request, response);
    }

    private static final int PAGE_SIZE = 12;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if("addToCartBtn".equals(action)){
            addToCart(request, response);
            return;
        }

        ProductDAO dao = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        
        // Category selected from Home page
        String categoryId = request.getParameter("categoryId");

        // ── INPUT PARAMETERS ─────────────────────────────
        String search = request.getParameter("search");
        String brand = request.getParameter("brand");
        String category = request.getParameter("category");
        String sort = request.getParameter("sort");
        
        if (categoryId != null && !categoryId.isBlank()) {
            try {
                Category cat = categoryDAO.fetchCategoryById(Integer.parseInt(categoryId));
                if (cat != null) {category = cat.getCategoryName();}
            } catch (NumberFormatException ex) {}
        }

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {
        }

        int offset = (page - 1) * PAGE_SIZE;

        // FETCH FILTERED PRODUCTS 
        List<Product> products = dao.fetchFilteredProducts(
                search, brand, category, sort, PAGE_SIZE, offset
        );

        int totalCount = dao.countFilteredProducts(search, brand, category);

        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        if (page < 1) {page = 1;}

        if (totalPages > 0 && page > totalPages) {page = totalPages;}
        
        request.setAttribute("products", products);
        request.setAttribute("brands", dao.fetchAllBrands());
        request.setAttribute("categories", dao.fetchAllCategoryNames());

        request.setAttribute("totalCount", totalCount);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

        // keep filters for UI
        request.setAttribute("search", search);
        request.setAttribute("brand", brand);
        request.setAttribute("category", category);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("/pages/products.jsp")
                .forward(request, response);
    }
    
    private void addToCart(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
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
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        } else {
            request.setAttribute("error", "Failed to add item to cart.");
            request.getRequestDispatcher("/pages/home.jsp").forward(request, response);
            return;
        }
    }
}
