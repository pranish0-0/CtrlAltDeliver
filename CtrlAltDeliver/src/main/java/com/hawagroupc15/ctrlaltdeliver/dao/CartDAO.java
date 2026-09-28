/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.CartDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.CartItem;
import com.hawagroupc15.ctrlaltdeliver.model.CartItemView;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
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
public class CartDAO implements CartDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public CartDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("CartDAO" + ex.getLocalizedMessage());
        }
    }

    @Override
    public List<CartItemView> fetchUserCart(int userId) {
        List<CartItemView> cartItems = new ArrayList<>();

        try {
            String sql = """
                         SELECT 
                         ci.cart_item_id,
                         ci.cart_id,
                         ci.quantity,
                         p.product_id,
                         p.name,
                         p.price,
                         p.image_path,
                         p.discount_percent,
                         ROUND(p.price * (1 - p.discount_percent / 100), 2) AS Discounted_Price,
                         ROUND(p.price * (1 - p.discount_percent / 100) * ci.quantity, 2) AS Item_Total
                         FROM cart c
                         JOIN cart_items ci ON c.cart_id = ci.cart_id
                         JOIN products p   ON ci.product_id = p.product_id
                         WHERE c.user_id  = ?
                         """;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItemView item = new CartItemView();

                item.setCartItemID(rs.getInt("cart_item_id"));
                item.setCartID(rs.getInt("cart_id"));
                item.setProductID(rs.getInt("product_id"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getBigDecimal("price"));
                item.setImagePath(rs.getString("image_path"));
                item.setQuantity(rs.getInt("quantity"));
                item.setDiscountPercent(rs.getBigDecimal("discount_percent"));

                cartItems.add(item);
            }
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
        }
        return cartItems;
    }

    @Override
    public CartItem getCartItemById(int cartItemId) {
        CartItem item = null;
        try {
            final String sql = "SELECT * FROM cart_items WHERE cart_item_id = ?";
            PreparedStatement pSt = conn.prepareStatement(sql);
            pSt.setInt(1, cartItemId);
            ResultSet rs = pSt.executeQuery();

            if (rs.next()) {
                item = new CartItem();
                item.setCartItemID(rs.getInt("cart_item_id"));
                item.setCartID(rs.getInt("cart_id"));
                item.setProductID(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
            }
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
        }
        return item;
    }

    @Override
    public boolean updateCartItemQunatity(int quantity, int cartItemID) {
        try {
            final String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
            PreparedStatement pSt = conn.prepareStatement(sql);
            pSt.setInt(1, quantity);
            pSt.setInt(2, cartItemID);

            return pSt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return false;
        }
    }

    @Override
    public boolean addItemToCart(int userId, int productId, int quantity) {
        try {
            // STEP 1: Check if cart exists for this user
            int cartId = getOrCreateCart(userId);
            if (cartId == -1) {
                return false;
            }

            // STEP 2: Check if product already exists in cart
            // (increment quantity instead of inserting duplicate)
            String checkSql = "SELECT cart_item_id, quantity FROM cart_items WHERE cart_id = ? AND product_id = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, cartId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // Product already in cart → update quantity
                int existingQty = rs.getInt("quantity");
                int cartItemId = rs.getInt("cart_item_id");
                return updateCartItemQunatity((existingQty + quantity), cartItemId);
            } else {
                // Product not in cart → insert new row
                String insertSql = "INSERT INTO cart_items (cart_id, product_id, quantity) VALUES (?, ?, ?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, cartId);
                insertPs.setInt(2, productId);
                insertPs.setInt(3, quantity);
                return insertPs.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return false;
        }
    }

// Returns existing cartId or creates a new cart and returns the new cartId
    @Override
    public int getOrCreateCart(int userId) {
        try {
            // Check if cart exists
            String sql = "SELECT cart_id FROM cart WHERE user_id = ?";
            PreparedStatement selectPs = conn.prepareStatement(sql);
            selectPs.setInt(1, userId);
            ResultSet rs = selectPs.executeQuery();

            if (rs.next()) {
                // Cart exists → return its ID
                return rs.getInt("cart_id");
            } else {
                // Cart doesn't exist → create one
                String insertSql = "INSERT INTO cart (user_id) VALUES (?)";
                PreparedStatement insertPs = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
                insertPs.setInt(1, userId);
                insertPs.executeUpdate();

                // Get the auto-generated cart_id
                ResultSet keys = insertPs.getGeneratedKeys();
                if (keys.next()) {
                    return keys.getInt(1);
                }
                return -1; // failed to create cart
            }
        } catch (SQLException e) {
            System.err.println(e.getLocalizedMessage());
            return 0;
        }
    }

    @Override
    public boolean removeCartItem(int cartItemID) {
        try {
            final String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
            PreparedStatement pSt = conn.prepareStatement(sql);
            pSt.setInt(1, cartItemID);

            return pSt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return false;
        }
    }

    public int getCartId(int userId) {

        try {

            String sql = "SELECT cart_id FROM cart WHERE user_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("cart_id");
            }

        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
        }

        return 0;
    }
}
