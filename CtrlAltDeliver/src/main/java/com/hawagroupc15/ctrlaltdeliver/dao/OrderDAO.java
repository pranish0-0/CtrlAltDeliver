/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.OrderDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.CartItemView;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Pranish
 */
public class OrderDAO implements OrderDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public OrderDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("OrderDAO:" + ex.getLocalizedMessage());
        }
    }

    @Override
    public Order getOrderById(int orderId) {

        Order order = null;

        String sql
                = "SELECT o.order_id, o.order_date, o.grand_total, o.payment_status, o.order_status, o.shipment_status, "
                + "o.shipping_address, u.full_name, u.email, u.phone FROM orders o INNER JOIN users u ON o.user_id=u.user_id "
                + "WHERE o.order_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setGrandTotal(rs.getBigDecimal("grand_total"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setShipmentStatus(rs.getString("shipment_status"));
                order.setDeliveryAddress(rs.getString("shipping_address"));
                order.setCustomerName(rs.getString("full_name"));
                order.setCustomerEmail(rs.getString("email"));
                order.setCustomerPhone(rs.getString("phone"));

            }

        } catch (SQLException ex) {
            System.out.println("getOrderById: " + ex.getLocalizedMessage());
        }

        return order;

    }

    @Override
    public ArrayList<Order> getOrderItems(int orderId) {

        ArrayList<Order> items = new ArrayList<>();

        String sql
                = "SELECT oi.order_item_id, oi.quantity, oi.unit_price, oi.subtotal, p.product_id, "
                + "p.name, p.image_path FROM order_items oi INNER JOIN products p ON oi.product_id=p.product_id "
                + "WHERE oi.order_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order item = new Order();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("name"));
                item.setImagePath(rs.getString("image_path"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getBigDecimal("unit_price"));
                item.setSubtotal(rs.getBigDecimal("subtotal"));

                items.add(item);
            }
        } catch (SQLException ex) {
            System.out.println("getOrderItems: " + ex.getLocalizedMessage());
        }
        return items;
    }

    @Override
    public boolean updateOrder(Order order) {

        String sql = "UPDATE orders SET order_status=?, shipment_status=?, payment_status=? WHERE order_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, order.getOrderStatus());
            ps.setString(2, order.getShipmentStatus());
            ps.setString(3, order.getPaymentStatus());
            ps.setInt(4, order.getOrderId());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("updateOrder: " + ex.getMessage());
        }

        return false;
    }

    @Override
    public User getCustomerById(int userId) {

        User user = null;

        String sql
                = "SELECT * "
                + "FROM users "
                + "WHERE user_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));

            }

        } catch (SQLException ex) {
            System.out.println("getCustomerById : " + ex.getMessage());
        }

        return user;
    }

    @Override
    public ArrayList<Order> getOrdersByUserId(int userId) {

        ArrayList<Order> orders = new ArrayList<>();

        String sql
                = "SELECT order_id, order_date, grand_total, payment_status, "
                + "order_status, shipment_status "
                + "FROM orders "
                + "WHERE user_id=? "
                + "ORDER BY order_date DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setGrandTotal(rs.getBigDecimal("grand_total"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setShipmentStatus(rs.getString("shipment_status"));

                orders.add(order);
            }

        } catch (SQLException ex) {
            System.out.println("getOrdersByUserId : " + ex.getMessage());
        }

        return orders;
    }

    @Override
    public boolean checkStockQuantity(int userId) {

        try {

            String sql = """
            SELECT p.stock_quantity, ci.quantity
            FROM cart c
            JOIN cart_items ci ON c.cart_id = ci.cart_id
            JOIN products p ON p.product_id = ci.product_id
            WHERE c.user_id = ?
            """;

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                if (rs.getInt("stock_quantity") < rs.getInt("quantity")) {
                    System.out.println("no stock");
                    return false;
                }
            }

            return true;

        } catch (SQLException e) {
            System.out.println("OrderDAO- Check Stock:" + e.getLocalizedMessage());
            return false;
        }
    }

    @Override
    public int createOrder(int userId, String shippingAddress) {

        try {

            CartDAO cartDAO = new CartDAO();
            List<CartItemView> cartItems = cartDAO.fetchUserCart(userId);

            if (cartItems.isEmpty()) {
                return 0;
            }

            BigDecimal subtotal = BigDecimal.ZERO;
            BigDecimal discount = BigDecimal.ZERO;
            BigDecimal shippingFee = BigDecimal.valueOf(200);

            for (CartItemView item : cartItems) {

                BigDecimal itemSubtotal = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                BigDecimal itemDiscount = itemSubtotal.multiply(item.getDiscountPercent()).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

                subtotal = subtotal.add(itemSubtotal);
                discount = discount.add(itemDiscount);
            }

            BigDecimal grandTotal = subtotal.subtract(discount).add(shippingFee);

            String sql = "INSERT INTO orders (user_id,subtotal,shipping_fee,discount_amount,grand_total,shipping_address)"
                    + "VALUES (?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, userId);
            ps.setBigDecimal(2, subtotal);
            ps.setBigDecimal(3, shippingFee);
            ps.setBigDecimal(4, discount);
            ps.setBigDecimal(5, grandTotal);
            ps.setString(6, shippingAddress);

            if (ps.executeUpdate() == 0) {
                return 0;
            }
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) {
                return keys.getInt(1);
            }
            return 0;

        } catch (SQLException e) {
            System.out.println("OrderDAO-createOrder : " + e.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public boolean createOrderItems(int orderId, int userId) {

        try {
            CartDAO cartDAO = new CartDAO();
            List<CartItemView> cartItems = cartDAO.fetchUserCart(userId);
            if (cartItems.isEmpty()) {
                return false;
            }

            String insertSql = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)"
                + "VALUES (?,?,?,?,?)";

            PreparedStatement insertPs = conn.prepareStatement(insertSql);

            String stockSql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE product_id = ?";

            PreparedStatement stockPs = conn.prepareStatement(stockSql);

            for (CartItemView item : cartItems) {

                BigDecimal subtotal = item.getEffectivePrice().multiply(BigDecimal.valueOf(item.getQuantity()));

                // Insert order item
                insertPs.setInt(1, orderId);
                insertPs.setInt(2, item.getProductID());
                insertPs.setInt(3, item.getQuantity());
                insertPs.setBigDecimal(4, item.getEffectivePrice());
                insertPs.setBigDecimal(5, subtotal);

                insertPs.executeUpdate();

                // Reduce stock
                stockPs.setInt(1, item.getQuantity());
                stockPs.setInt(2, item.getProductID());

                stockPs.executeUpdate();
            }

            int cartId = cartDAO.getCartId(userId);

            if (cartId == 0) {
                return false;
            }

            String clearSql = "DELETE FROM cart_items WHERE cart_id=?";
            PreparedStatement clearPs = conn.prepareStatement(clearSql);
            clearPs.setInt(1, cartId);
            clearPs.executeUpdate();
            return true;

        } catch (SQLException e) {
            System.out.println("OrderDAO-createOrderItems : "+ e.getLocalizedMessage());
            return false;
        }
    }

}
