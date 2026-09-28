/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.AdminDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.Category;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Arrays;

/**
 *
 * @author Pranish
 */
public class AdminDAO implements AdminDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public AdminDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("AdminDAO: " + ex.getLocalizedMessage());
        }
    }

    @Override
    public int getTotalProducts() {

        String sql = "SELECT COUNT(*) FROM products";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getTotalCustomers() {

        String sql = "SELECT COUNT(*) FROM users WHERE role = 'MEMBER'";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getTotalOrders() {

        String sql = "SELECT COUNT(*) FROM orders";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public double getTotalRevenue() {

        String sql = "SELECT IFNULL(SUM(grand_total),0) FROM orders";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getPendingOrders() {

        String sql = "SELECT COUNT(*) FROM orders WHERE order_status = 'Pending'";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getDeliveredOrders() {

        String sql = "SELECT COUNT(*) FROM orders WHERE order_status = 'Delivered'";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getLowStockProducts() {

        String sql = "SELECT COUNT(*) FROM products WHERE stock_quantity <= 5";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public int getTotalCategories() {

        String sql = "SELECT COUNT(*) FROM categories";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return 0;
    }

    @Override
    public ArrayList<Order> getRecentOrders(int limit) {

        ArrayList<Order> orders = new ArrayList<>();

        String sql
                = "SELECT o.order_id, "
                + "u.full_name, "
                + "o.order_date, "
                + "o.grand_total, "
                + "o.order_status, "
                + "o.payment_status, "
                + "o.shipment_status "
                + "FROM orders o "
                + "INNER JOIN users u ON o.user_id = u.user_id "
                + "ORDER BY o.order_date DESC "
                + "LIMIT ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Order order = new Order();

                    order.setOrderId(rs.getInt("order_id"));
                    order.setCustomerName(rs.getString("full_name"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setGrandTotal(rs.getBigDecimal("grand_total"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setShipmentStatus(rs.getString("shipment_status"));

                    orders.add(order);
                }

            }

        } catch (SQLException ex) {
            System.err.println(ex.getLocalizedMessage());
        }

        return orders;
    }

    @Override
    public ArrayList<Order> getOrdersForAdmin(String search,
            String paymentStatus,
            String orderStatus) {

        ArrayList<Order> orders = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT "
                + "o.order_id, "
                + "u.full_name, "
                + "o.order_date, "
                + "o.grand_total, "
                + "o.payment_status, "
                + "o.order_status, "
                + "o.shipment_status "
                + "FROM orders o "
                + "INNER JOIN users u "
                + "ON o.user_id = u.user_id "
                + "WHERE 1=1 "
        );

        // Search by Order ID or Customer Name
        if (search != null && !search.isBlank()) {
            sql.append(
                    "AND (CAST(o.order_id AS CHAR) LIKE ? "
                    + "OR u.full_name LIKE ?) "
            );
        }

        // Payment Status Filter
        if (paymentStatus != null && !paymentStatus.isBlank()) {
            sql.append("AND o.payment_status = ? ");
        }

        // Order Status Filter
        if (orderStatus != null && !orderStatus.isBlank()) {
            sql.append("AND o.order_status = ? ");
        }

        sql.append("ORDER BY o.order_date DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.isBlank()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }

            if (paymentStatus != null && !paymentStatus.isBlank()) {
                ps.setString(index++, paymentStatus);
            }

            if (orderStatus != null && !orderStatus.isBlank()) {
                ps.setString(index++, orderStatus);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerName(rs.getString("full_name"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setGrandTotal(rs.getBigDecimal("grand_total"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setShipmentStatus(rs.getString("shipment_status"));

                orders.add(order);
            }

        } catch (SQLException ex) {
            System.out.println("AdminDAO - getOrdersForAdmin(): " + ex.getLocalizedMessage());
        }

        return orders;
    }

    @Override
    public ArrayList<BigDecimal> getMonthlyRevenue() {

        ArrayList<BigDecimal> revenue = new ArrayList<>();

        String sql
                = "SELECT MONTH(order_date) AS month, SUM(grand_total) AS total FROM orders "
                + "WHERE payment_status='PAID' GROUP BY MONTH(order_date) ORDER BY MONTH(order_date)";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            BigDecimal[] months = new BigDecimal[12];

            for (int i = 0; i < 12; i++) {
                months[i] = BigDecimal.ZERO;
            }

            while (rs.next()) {
                months[rs.getInt("month") - 1] = rs.getBigDecimal("total");
            }

            revenue.addAll(Arrays.asList(months));

        } catch (SQLException ex) {
            System.out.println("getMonthlyRevenue: " + ex.getMessage());
        }

        return revenue;
    }

    @Override
    public int getOrderStatusCount(String status) {

        String sql
                = "SELECT COUNT(*) FROM orders WHERE order_status=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            System.out.println("getOrderStatusCount: " + ex.getMessage());
        }
        return 0;
    }

    @Override
    public ArrayList<Category> getCategorySales() {

        ArrayList<Category> list = new ArrayList<>();

        String sql
                = "SELECT c.category_name, "
                + "SUM(oi.quantity) AS total_sold "
                + "FROM order_items oi "
                + "INNER JOIN products p ON oi.product_id=p.product_id "
                + "INNER JOIN categories c ON p.category_id=c.category_id "
                + "GROUP BY c.category_id, c.category_name "
                + "ORDER BY total_sold DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Category c = new Category();

                c.setCategoryName(rs.getString("category_name"));
                c.setTotalSold(rs.getInt("total_sold"));

                list.add(c);
            }

        } catch (SQLException ex) {
            System.out.println("getCategorySales: " + ex.getMessage());
        }

        return list;
    }

    @Override
    public ArrayList<Product> getTopSellingProducts() {

        ArrayList<Product> products = new ArrayList<>();

        String sql
                = "SELECT p.product_id, "
                + "p.name, "
                + "SUM(oi.quantity) AS total_sold "
                + "FROM order_items oi "
                + "INNER JOIN products p ON oi.product_id=p.product_id "
                + "GROUP BY p.product_id, p.name "
                + "ORDER BY total_sold DESC "
                + "LIMIT 10";

        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Product p = new Product();

                p.setProductId(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setTotalSold(rs.getInt("total_sold"));

                products.add(p);
            }

        } catch (SQLException ex) {
            System.out.println("getTopSellingProducts: " + ex.getMessage());
        }

        return products;
    }

}
