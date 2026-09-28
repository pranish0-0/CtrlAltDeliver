/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.UserDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import com.hawagroupc15.ctrlaltdeliver.model.User.Role;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
import static java.rmi.server.LogStream.log;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
public class UserDAO implements UserDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public UserDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("UserDAO:" + ex.getLocalizedMessage());
        }
    }

    @Override
    public int insertUser(String fullName, String password, String email, String phone) {
        try {
            //Check name and email already present
            final String CHECK_IF_USER = "select full_name, email from users where LOWER(full_name)=LOWER(?) or LOWER(email)=LOWER(?);";
            PreparedStatement pStm_ = conn.prepareStatement(CHECK_IF_USER);
            pStm_.setString(1, fullName);
            pStm_.setString(2, email);
            ResultSet rs = pStm_.executeQuery();
            if (rs.next()) {
                return 2;   // 2 for user or email already present
            }
            final String INSERT_USER = "insert into users (full_name,password_hash,email,phone) values (?,?,?,?);";
            PreparedStatement pStm = conn.prepareStatement(INSERT_USER);
            pStm.setString(1, fullName);
            pStm.setString(2, password);
            pStm.setString(3, email);
            pStm.setString(4, phone);

            int result = pStm.executeUpdate();
            return result;  //0 or 1 
        } catch (SQLException ex) {
            System.out.println("UserDAO:" + ex.getLocalizedMessage());
            return 3;  // if 3 fault in query
        }
    }

    @Override
    public int changePassword(int userId, String hashedPassword) {

        try {
            String sql = "UPDATE users SET password_hash = ? WHERE user_id = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            int result = ps.executeUpdate();

            if (result == 1) {
                return 1;   // Password updated successfully
            }

            return 0;       // No rows updated

        } catch (SQLException e) {
            e.printStackTrace();
            return 2;       // Database error
        }
    }

    @Override
    public User getUser(String email) {
        try {
            final String SELECT_USER = "select * from users where LOWER(email)=LOWER(?);";

            PreparedStatement pStm_ = conn.prepareStatement(SELECT_USER);
            pStm_.setString(1, email);
            ResultSet rs = pStm_.executeQuery();
            if (rs.next()) {
                final User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setEmail(rs.getString("email"));
                user.setRole(Role.valueOf(
                        rs.getString("role").trim().toUpperCase()
                ));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setCreatedAt(rs.getTimestamp("updated_at"));
                return user;
            }

        } catch (SQLException ex) {
            System.out.println("UserDAO:" + ex.getLocalizedMessage());
            return null;
        }
        return null;
    }

    @Override
    public ArrayList<Order> getUserOrders(int user_id, String status) {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            final String sql
                    = "SELECT "
                    + "o.order_id        AS order_id, "
                    + "o.order_status    AS order_status, "
                    + "o.shipment_status    AS shipment_status, "
                    + "oi.order_item_id  AS order_item_id, "
                    + "oi.product_id     AS product_id, "
                    + "p.name            AS product_name, "
                    + "p.image_path      AS image_path, "
                    + "oi.quantity       AS quantity, "
                    + "oi.unit_price     AS unit_price, "
                    + "oi.subtotal       AS subtotal "
                    + "FROM orders o "
                    + "JOIN order_items oi ON o.order_id = oi.order_id "
                    + "JOIN products p ON oi.product_id = p.product_id "
                    + "WHERE o.user_id = ? "
                    + "AND o.order_status = ? "
                    + "ORDER BY o.order_id DESC, oi.order_item_id;";

            PreparedStatement pStm = conn.prepareStatement(sql);
            pStm.setInt(1, user_id);
            pStm.setString(2, status);
            ResultSet rs = pStm.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderItemId(rs.getInt("order_item_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setProductName(rs.getString("product_name"));  // use alias
                order.setImagePath(rs.getString("image_path"));
                order.setQuantity(rs.getInt("quantity"));
                order.setUnitPrice(rs.getBigDecimal("unit_price"));
                order.setSubtotal(rs.getBigDecimal("subtotal"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setShipmentStatus(rs.getString("shipment_status"));
                orders.add(order);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching user orders: " + e.getMessage());
        }

        return orders;
    }

    @Override
    public int updateUser(int userId, String fullName, String phone, String email, String address) {
        try {
            String checkSql = "SELECT user_id FROM users WHERE LOWER(email)=LOWER(?) AND user_id<>?";

            PreparedStatement ps = conn.prepareStatement(checkSql);
            ps.setString(1, email);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return 2;
            } // emial already exists

            String sql = "UPDATE users SET full_name=?, phone=?, email=?, address=? WHERE user_id=?";

            PreparedStatement update = conn.prepareStatement(sql);

            update.setString(1, fullName);
            update.setString(2, phone);
            update.setString(3, email);
            update.setString(4, address);
            update.setInt(5, userId);

            return update.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return 3;
        }
    }

    @Override
    public ArrayList<User> getCustomersForAdmin(String search) {

        ArrayList<User> customers = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.full_name, u.email, u.phone, u.role, u.profile_image, u.created_at, "
                + "COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.grand_total),0) AS total_spent FROM users u "
                + "LEFT JOIN orders o ON u.user_id = o.user_id WHERE u.role='MEMBER' "
        );

        if (search != null && !search.isBlank()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
        }

        sql.append("GROUP BY u.user_id ");
        sql.append("ORDER BY u.full_name ASC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.isBlank()) {
                ps.setString(index++, "%" + search + "%");
                ps.setString(index++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfileImage(rs.getString("profile_image"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setTotalOrders(rs.getInt("total_orders"));
                user.setTotalSpent(rs.getBigDecimal("total_spent"));

                customers.add(user);

            }

        } catch (SQLException ex) {
            System.out.println("getCustomersForAdmin: " + ex.getMessage());
        }

        return customers;
    }

    @Override
    public User getCustomerById(int userId) {

        User user = null;

        String sql
                = "SELECT "
                + "u.user_id, "
                + "u.full_name, "
                + "u.email, "
                + "u.phone, "
                + "u.role, "
                + "u.profile_image, "
                + "u.created_at, "
                + "COUNT(o.order_id) AS total_orders, "
                + "COALESCE(SUM(o.grand_total),0) AS total_spent "
                + "FROM users u "
                + "LEFT JOIN orders o ON u.user_id=o.user_id "
                + "WHERE u.user_id=? "
                + "GROUP BY u.user_id";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(User.Role.valueOf(rs.getString("role")));
                user.setProfileImage(rs.getString("profile_image"));
                user.setCreatedAt(rs.getTimestamp("created_at"));

                user.setTotalOrders(rs.getInt("total_orders"));
                user.setTotalSpent(rs.getBigDecimal("total_spent"));

            }

        } catch (SQLException ex) {
            System.out.println("getCustomerById: " + ex.getMessage());
        }

        return user;
    }

}
