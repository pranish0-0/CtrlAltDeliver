/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao.interfaces;

import com.hawagroupc15.ctrlaltdeliver.model.Category;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import java.math.BigDecimal;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
public interface AdminDAOInterface {
    
    int getTotalProducts();
    int getTotalCustomers();
    int getTotalOrders();
    double getTotalRevenue();
    int getPendingOrders();
    int getDeliveredOrders();
    int getLowStockProducts();
    int getTotalCategories();
    ArrayList<Order> getRecentOrders(int limit);
    ArrayList<Order> getOrdersForAdmin(String search, String paymentStatus, String orderStatus);
    ArrayList<BigDecimal> getMonthlyRevenue();
    int getOrderStatusCount(String status);
    ArrayList<Category> getCategorySales();
    ArrayList<Product> getTopSellingProducts();
    
}
