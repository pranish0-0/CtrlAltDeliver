/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.CategoryDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.Category;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
public class CategoryDAO implements CategoryDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public CategoryDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("CategoryDAO:" + ex.getLocalizedMessage());
        }
    }

    @Override
    public ArrayList<Category> fetchAllCategory() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            String sql = "SELECT * FROM categories";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("category_id"));
                c.setCategoryName(rs.getString("category_name"));
                c.setDescription(rs.getString("description"));
                c.setImage(rs.getString("image"));
                categories.add(c);
            }

            return categories;

        } catch (SQLException ex) {
            System.out.println("CategoryDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public Category fetchCategoryByProductId(int productId) {
        Category category = new Category();
        try {
            String sql = "SELECT c.* FROM categories c JOIN products p ON c.category_id = p.category_id WHERE p.product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setImage(rs.getString("image"));
            }

            return category;

        } catch (SQLException ex) {
            System.out.println("CategoryDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public Category fetchCategoryById(int catId) {
        Category category = null;
        try {
            String sql = "SELECT * FROM categories WHERE category_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, catId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setImage(rs.getString("image"));
            }

            return category;

        } catch (SQLException ex) {
            System.out.println("CategoryDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Category> getCategoriesForAdmin(String search) {

        ArrayList<Category> categories = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT * FROM categories WHERE 1=1 "
        );

        if (search != null && !search.isBlank()) {
            sql.append("AND category_name LIKE ? ");
        }

        sql.append("ORDER BY category_id DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.isBlank()) {
                ps.setString(index++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Category category = new Category();

                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                category.setDescription(rs.getString("description"));
                category.setImage(rs.getString("image"));

                categories.add(category);
            }

        } catch (SQLException ex) {
            System.out.println("Category DAO Error: " + ex.getLocalizedMessage());
        }

        return categories;
    }

    @Override
    public boolean updateCategory(Category category) {

        String sql = "UPDATE categories SET category_name=?, description=? WHERE category_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setInt(3, category.getCategoryId());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("updateCategory: " + ex.getMessage());
        }

        return false;
    }

    @Override
    public boolean removeCategory(int categoryId) {
        try {
            final String sql = "DELETE FROM categories WHERE category_id = ?";
            PreparedStatement pSt = conn.prepareStatement(sql);
            pSt.setInt(1, categoryId);

            return pSt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return false;
        }
    }

    @Override
    public boolean insertCategory(Category category) {

        String sql
                = "INSERT INTO categories "
                + "(category_name, description, image) "
                + "VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setString(2, category.getDescription());
            ps.setString(3, category.getImage());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {

            System.out.println("insertCategory: " + ex.getMessage());
        }

        return false;
    }

}