/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import com.hawagroupc15.ctrlaltdeliver.utilities.SessionUtil;
import jakarta.servlet.RequestDispatcher;
import com.hawagroupc15.ctrlaltdeliver.dao.AdminDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.CategoryDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.OrderDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.ProductDAO;
import com.hawagroupc15.ctrlaltdeliver.dao.UserDAO;
import com.hawagroupc15.ctrlaltdeliver.model.Category;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.utilities.CookieUtil;
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
import jakarta.servlet.annotation.MultipartConfig;
import java.math.BigDecimal;
import jakarta.servlet.http.Part;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) SessionUtil.getAttribute(request, "user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (user.getRole() != User.Role.ADMIN) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String page = request.getParameter("page");

        if (page == null || page.isBlank()) {
            page = "dashboard";
        }

        final AdminDAO adminDAO = new AdminDAO();
        final CategoryDAO cdao = new CategoryDAO();
        final OrderDAO odao = new OrderDAO();
        final ProductDAO pdao = new ProductDAO();
        final UserDAO uDAO = new UserDAO();

        switch (page) {

            case "dashboard":
                request.setAttribute("totalProducts", adminDAO.getTotalProducts());
                request.setAttribute("totalCustomers", adminDAO.getTotalCustomers());
                request.setAttribute("totalOrders", adminDAO.getTotalOrders());
                request.setAttribute("totalRevenue", adminDAO.getTotalRevenue());

                request.setAttribute("pendingOrders", adminDAO.getPendingOrders());
                request.setAttribute("completedOrders", adminDAO.getDeliveredOrders());
                request.setAttribute("lowStockProducts", adminDAO.getLowStockProducts());
                request.setAttribute("totalCategories", adminDAO.getTotalCategories());

                request.setAttribute("recentOrders", adminDAO.getRecentOrders(5));
                break;

            case "products":
                String Psearch = request.getParameter("search");

                Integer categoryId = null;

                if (request.getParameter("category") != null && !request.getParameter("category").isBlank()) {
                    categoryId = Integer.valueOf(request.getParameter("category"));
                }

                request.setAttribute("products", pdao.getProductsForAdmin(Psearch, categoryId));
                request.setAttribute("categories", cdao.fetchAllCategory());
                if (pdao.getProductsForAdmin(Psearch, categoryId).size() == 0) {
                    request.setAttribute("emptymessage", "No Items Found !");
                }
                break;

            case "addproduct":
                request.setAttribute("categories", cdao.fetchAllCategory());

                if (request.getParameter("error") != null) {
                    request.setAttribute("error", "Unable to add product.");
                }
                break;

            case "editProduct":
                int productId = Integer.parseInt(request.getParameter("id"));

                request.setAttribute("categories", cdao.fetchAllCategory());
                request.setAttribute("product", pdao.fetchProductsByID(productId));
                break;

            case "categories":
                String Csearch = request.getParameter("search");
                if (Csearch == null) {
                    request.setAttribute("categories", cdao.fetchAllCategory());
                }
                request.setAttribute("categories", cdao.getCategoriesForAdmin(Csearch));
                if (cdao.getCategoriesForAdmin(Csearch).size() == 0) {
                    System.out.println(cdao.getCategoriesForAdmin(Csearch).size());
                    request.setAttribute("emptymessage", "No Items Found !");
                }
                break;

            case "addcategory":
                break;

            case "editCategory":
                int cId = Integer.parseInt(request.getParameter("id"));
                request.setAttribute("category", cdao.fetchCategoryById(cId));
                break;

            case "orders":
                String search = request.getParameter("search");
                String paymentStatus = request.getParameter("paymentstatus");
                String orderStatus = request.getParameter("orderstatus");

                if (adminDAO.getOrdersForAdmin(search, paymentStatus, orderStatus).size() == 0) {
                    request.setAttribute("emptymessage", "No Item Found !");
                }

                request.setAttribute("orders", adminDAO.getOrdersForAdmin(search, paymentStatus, orderStatus));
                break;

            case "vieworder":
                int orderId = Integer.parseInt(request.getParameter("id"));

                request.setAttribute("order", odao.getOrderById(orderId));
                request.setAttribute("orderItems", odao.getOrderItems(orderId));
                break;

            case "customers":
                String Customersearch = request.getParameter("search");
                request.setAttribute("customers", uDAO.getCustomersForAdmin(Customersearch));
                if (uDAO.getCustomersForAdmin(Customersearch).size() == 0) {
                    request.setAttribute("emptymessage", "No Item Found !");
                }
                break;

            case "viewcustomer":
                int userId = Integer.parseInt(request.getParameter("id"));

                User customer = uDAO.getCustomerById(userId);

                ArrayList<Order> customerOrders = odao.getOrdersByUserId(userId);

                request.setAttribute("customer", customer);
                request.setAttribute("customerOrders", customerOrders);

//                request.getRequestDispatcher("/WEB-INF/admindash.jsp").forward(request, response);
                break;

            case "reports":
                request.setAttribute("monthlyLabels", "['Jan','Feb','Mar','Apr','May','Jun']");
                request.setAttribute("monthlyRevenue", adminDAO.getMonthlyRevenue().toString());

                request.setAttribute("pendingOrders", adminDAO.getOrderStatusCount("Pending"));
                request.setAttribute("processingOrders", adminDAO.getOrderStatusCount("Processing"));
                request.setAttribute("completedOrders", adminDAO.getOrderStatusCount("Delivered"));
                request.setAttribute("cancelledOrders", adminDAO.getOrderStatusCount("Cancelled"));

                ArrayList<Category> categorySales = adminDAO.getCategorySales();

                List<String> categoryLabels = new ArrayList<>();
                List<Integer> categoryValues = new ArrayList<>();

                for (Category c : categorySales) {
//                    System.out.println(c.getCategoryName() + " - " + c.getTotalSold());
                    categoryLabels.add("'" + c.getCategoryName() + "'");
                    categoryValues.add(c.getTotalSold());
//                    System.out.println(categoryValues.toString());
                }

//                System.out.println(categoryLabels);
//                System.out.println(categoryValues);
                request.setAttribute("categoryLabels", categoryLabels.toString());
                request.setAttribute("categorySales", categoryValues.toString());

                ArrayList<Product> topProducts = adminDAO.getTopSellingProducts();

                List<String> productLabels = new ArrayList<>();
                List<Integer> productValues = new ArrayList<>();

                for (Product topProduct : topProducts) {

                    productLabels.add("'" + topProduct.getName() + "'");
                    productValues.add(topProduct.getTotalSold());

                }

                request.setAttribute("topProductLabels", productLabels.toString());
                request.setAttribute("topProductSales", productValues.toString());

                break;

            default:
                page = "dashboard";
                break;
        }

        request.setAttribute("page", page);
        request.setAttribute("user", user);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/admindash.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("admin");
            return;
        }
        ProductDAO pDAO = new ProductDAO();
        OrderDAO oDAO = new OrderDAO();
        CategoryDAO cDAO = new CategoryDAO();

        switch (action) {

            case "addproduct":

                final Product product = new Product();

                product.setName(request.getParameter("productName"));
                product.setBrand(request.getParameter("brand"));
                product.setDescription(request.getParameter("description"));
                product.setCategoryId(Integer.valueOf(request.getParameter("categoryId")));
                product.setPrice(new BigDecimal(request.getParameter("price")));
                product.setDiscountPercent(new BigDecimal(request.getParameter("discount")));
                product.setTag(request.getParameter("tag"));
                product.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));

                // ---------- Upload Image ----------
                Part imagePart = request.getPart("image");

                String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/resources/products");

                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imagePart.write(uploadPath + File.separator + fileName);

                product.setImagePath("resources/products/" + fileName);

                ProductDAO productDAO = new ProductDAO();

                boolean success = productDAO.insertProduct(product);

                if (success) {
                    response.sendRedirect("admin?page=products");
                } else {
                    request.setAttribute("error", "Unable to add product.");
                    response.sendRedirect(request.getContextPath() + "/admin?page=addproduct&error=1");
                }

                break;

            case "removeItem":
                final int productId = Integer.parseInt(request.getParameter("productId"));
                pDAO.removeProduct(productId);
                response.sendRedirect("admin?page=products");
                break;

            case "removeCategory":
                final int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                cDAO.removeCategory(categoryId);
                response.sendRedirect("admin?page=categories");
                break;

            case "updateproduct":
                Product updated = new Product();

                updated.setProductId(Integer.parseInt(request.getParameter("productId")));
                updated.setName(request.getParameter("productName"));
                updated.setBrand(request.getParameter("brand"));
                updated.setDescription(request.getParameter("description"));
                updated.setCategoryId(Integer.valueOf(request.getParameter("categoryId")));
                updated.setPrice(new BigDecimal(request.getParameter("price")));
                updated.setDiscountPercent(new BigDecimal(request.getParameter("discount")));
                updated.setTag(request.getParameter("tag"));
                updated.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));

                if (pDAO.updateProduct(updated)) {
                    response.sendRedirect("admin?page=products");
                } else {
                    CookieUtil.addCookie(response, "errormessage", "Could_not_udpate_product!", 6);
                    response.sendRedirect("admin?page=products");
                }
                break;

            case "updateorder":
                Order updatedOrder = new Order();

                updatedOrder.setOrderId(Integer.parseInt(request.getParameter("orderId")));
                updatedOrder.setOrderStatus(request.getParameter("orderStatus"));
                updatedOrder.setShipmentStatus(request.getParameter("shipmentStatus"));
                updatedOrder.setPaymentStatus(request.getParameter("paymentStatus"));

                if (oDAO.updateOrder(updatedOrder)) {
                    response.sendRedirect("admin?page=orders");
                } else {
                    CookieUtil.addCookie(response, "errormessage", "Could_not_udpate_product!", 6);
                    response.sendRedirect("admin?page=orders");
                }
                break;

            case "addcategory":

                Category category = new Category();

                category.setCategoryName(request.getParameter("categoryName"));
                category.setDescription(request.getParameter("description"));

                // Upload image
                Part catimagePart = request.getPart("image");

                String catfileName = Paths.get(catimagePart.getSubmittedFileName()).getFileName().toString();

                String catuploadPath = getServletContext().getRealPath("/resources/categories");

                File catuploadDir = new File(catuploadPath);

                if (!catuploadDir.exists()) {
                    catuploadDir.mkdirs();
                }

                catimagePart.write(catuploadPath + File.separator + catfileName);

                category.setImage("resources/categories/" + catfileName);

                if (cDAO.insertCategory(category)) {
                    response.sendRedirect("admin?page=categories");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin?page=addcategory&error=1");
                }

                break;

            case "updatecategory":
                Category updatedcategory = new Category();
                
                updatedcategory.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
                updatedcategory.setCategoryName(request.getParameter("categoryName"));
                updatedcategory.setDescription(request.getParameter("description"));

                if (cDAO.updateCategory(updatedcategory)) {
                    response.sendRedirect("admin?page=categories");
                } else {
                    request.setAttribute("error", "Failed to update category.");
                    request.setAttribute("category", updatedcategory);
                    request.setAttribute("contentPage", "/WEB-INF/pages/admin/editcategory.jsp");
                    request.getRequestDispatcher("/WEB-INF/pages/admin/admindash.jsp").forward(request, response);
                }

                break;

            default:
                response.sendRedirect("admin");
        }

    }

}
