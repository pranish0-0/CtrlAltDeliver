/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao;

import com.hawagroupc15.ctrlaltdeliver.dao.interfaces.ProductDAOInterface;
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import com.hawagroupc15.ctrlaltdeliver.model.ProductImages;
import com.hawagroupc15.ctrlaltdeliver.utilities.DBConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Pranish
 */
public class ProductDAO implements ProductDAOInterface {

    private Connection conn;
    private boolean isConnectionError = false;

    //getter for connection error status
    public boolean isIsConnectionError() {
        return isConnectionError;
    }

    public ProductDAO() {
        try {
            conn = DBConfig.getConnection();
        } catch (SQLException | ClassNotFoundException ex) {
            isConnectionError = true;
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
        }
    }

    @Override
    public ArrayList<Product> fetchAllProducts() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setTag(rs.getString("tag"));
                p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImagePath(rs.getString("image_path"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setUpdatedAt(rs.getTimestamp("updated_at"));
                products.add(p);
            }

            return products;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Product> fetchAllFeaturedProducts() {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products WHERE is_featured = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImagePath(rs.getString("image_path"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setUpdatedAt(rs.getTimestamp("updated_at"));
                products.add(p);
            }

            return products;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public Product fetchProductsByID(int product_id) {
        Product product = new Product();
        try {
            String sql = "SELECT * FROM products WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, product_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setCategoryId(rs.getInt("category_id"));
                product.setName(rs.getString("name"));
                product.setBrand(rs.getString("brand"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setTag(rs.getString("tag"));
                product.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImagePath(rs.getString("image_path"));
                product.setStatus(rs.getString("status"));
                product.setCreatedAt(rs.getTimestamp("created_at"));
                product.setUpdatedAt(rs.getTimestamp("updated_at"));
            }

            return product;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public ArrayList<Product> fetchProductsByCategory(int categoryID) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products WHERE category_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setTag(rs.getString("tag"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImagePath(rs.getString("image_path"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setUpdatedAt(rs.getTimestamp("updated_at"));
                products.add(p);
            }

            return products;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
            return new ArrayList<>();
        }
    }

    @Override
    public ArrayList<Product> fetchProductsByTag(String tag) {
        ArrayList<Product> products = new ArrayList<>();
        try {
            String sql = "SELECT * FROM products WHERE tag = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, tag.toUpperCase());
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId(rs.getInt("category_id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImagePath(rs.getString("image_path"));
                p.setStatus(rs.getString("status"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setUpdatedAt(rs.getTimestamp("updated_at"));
                products.add(p);
            }

            return products;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public ArrayList<ProductImages> fetchImagesByProductID(int productID) {
        ArrayList<ProductImages> produtImages = new ArrayList<>();
        try {
            String sql = "SELECT * FROM product_images WHERE product_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductImages pi = new ProductImages();
                pi.setImageId(rs.getInt("image_id"));
                pi.setProductId(rs.getInt("product_id"));
                pi.setImagePath(rs.getString("image_path"));
                produtImages.add(pi);
            }

            return produtImages;

        } catch (SQLException ex) {
            System.out.println("fetchImagesByProductID failed: " + ex.getLocalizedMessage());
            return null;
        }
    }

    @Override
    public List<String> fetchAllCategoryNames() {
        List<String> categories = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT c.category_name FROM   categories c INNER JOIN products p ON p.category_id = c.category_id ORDER BY c.category_name ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                categories.add(rs.getString("category_name"));
            }
        } catch (SQLException e) {
            System.out.println("fetchAllCategoryNames() failed: " + e.getMessage());
        }
        return categories;
    }

    @Override
    public List<String> fetchAllBrands() {
        List<String> brands = new ArrayList<>();
        try {
            String sql = "SELECT DISTINCT brand FROM products WHERE brand IS NOT NULL ORDER BY brand ASC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                brands.add(rs.getString("brand"));
            }
        } catch (SQLException e) {
            System.out.println("fetchAllBrands() failed: " + e.getMessage());
        }
        return brands;
    }

//    Pagination
    public List<Product> fetchAllProducts(int limit, int offset) {

        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT * FROM products
            ORDER BY product_id DESC
            LIMIT ? OFFSET ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countAllProducts() {

        String sql = "SELECT COUNT(*) FROM products";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    //filter
    public List<Product> fetchByBrand(String brand, int limit, int offset) {

        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT * FROM products
            WHERE brand = ?
            ORDER BY product_id DESC
            LIMIT ? OFFSET ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, brand);
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countByBrand(String brand) {

        String sql = "SELECT COUNT(*) FROM products WHERE brand = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, brand);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    //filter
    public List<Product> fetchByCategory(String category, int limit, int offset) {

        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT p.*
            FROM products p
            JOIN categories c ON p.category_id = c.category_id
            WHERE c.category_name = ?
            ORDER BY p.product_id DESC
            LIMIT ? OFFSET ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);
            ps.setInt(2, limit);
            ps.setInt(3, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countByCategory(String category) {

        String sql = """
            SELECT COUNT(*)
            FROM products p
            JOIN categories c ON p.category_id = c.category_id
            WHERE c.category_name = ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, category);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    //search
    public List<Product> searchProducts(String query, int limit, int offset) {

        List<Product> list = new ArrayList<>();

        String sql = """
            SELECT * FROM products
            WHERE name LIKE ?
               OR brand LIKE ?
            ORDER BY product_id DESC
            LIMIT ? OFFSET ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            String q = "%" + query + "%";

            ps.setString(1, q);
            ps.setString(2, q);
            ps.setInt(3, limit);
            ps.setInt(4, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int countSearchProducts(String query) {

        String sql = """
            SELECT COUNT(*)
            FROM products
            WHERE name LIKE ?
               OR brand LIKE ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            String q = "%" + query + "%";

            ps.setString(1, q);
            ps.setString(2, q);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

//    sorting
    public List<Product> fetchSortedProducts(String sort, int limit, int offset) {

        List<Product> list = new ArrayList<>();

        String orderBy = "product_id DESC";

        if ("price-asc".equals(sort)) {
            orderBy = "price ASC";
        } else if ("price-desc".equals(sort)) {
            orderBy = "price DESC";
        } else if ("name".equals(sort)) {
            orderBy = "name ASC";
        }

        String sql = "SELECT * FROM products ORDER BY " + orderBy + " LIMIT ? OFFSET ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapProduct(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    @Override
    public Product mapProduct(ResultSet rs) throws SQLException {

        Product p = new Product();

        p.setProductId(rs.getInt("product_id"));
        p.setName(rs.getString("name"));
        p.setBrand(rs.getString("brand"));
        p.setPrice(rs.getBigDecimal("price"));
        p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
        p.setStockQuantity(rs.getInt("stock_quantity"));
        p.setImagePath(rs.getString("image_path"));

        return p;
    }

    @Override
    public List<Product> fetchFilteredProducts(
            String search,
            String brand,
            String category,
            String sort,
            int limit,
            int offset
    ) {
        List<Product> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder("""
        SELECT p.*, c.category_name
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.category_id
        WHERE 1=1
    """);

        if (search != null && !search.isBlank()) {
            sql.append(" AND p.name LIKE ?");
        }
        if (brand != null && !brand.isBlank()) {
            sql.append(" AND p.brand = ?");
        }
        if (category != null && !category.isBlank()) {
            sql.append(" AND c.category_name = ?");
        }

        // sorting
        if ("price-asc".equals(sort)) {
            sql.append(" ORDER BY p.price ASC");
        } else if ("price-desc".equals(sort)) {
            sql.append(" ORDER BY p.price DESC");
        } else {
            sql.append(" ORDER BY p.name ASC");
        }

        sql.append(" LIMIT ? OFFSET ?");

        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());

            int i = 1;

            if (search != null && !search.isBlank()) {
                ps.setString(i++, "%" + search + "%");
            }
            if (brand != null && !brand.isBlank()) {
                ps.setString(i++, brand);
            }
            if (category != null && !category.isBlank()) {
                ps.setString(i++, category);
            }

            ps.setInt(i++, limit);
            ps.setInt(i, offset);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setProductId(rs.getInt("product_id"));
                p.setCategoryId((Integer) rs.getObject("category_id"));
                p.setName(rs.getString("name"));
                p.setBrand(rs.getString("brand"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getBigDecimal("price"));
                p.setTag(rs.getString("tag"));
                p.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                p.setStockQuantity(rs.getInt("stock_quantity"));
                p.setImagePath(rs.getString("image_path"));
                p.setStatus(rs.getString("status"));
                p.setCategoryName(rs.getString("category_name"));
                list.add(p);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return list;
    }

    @Override
    public int countFilteredProducts(String search, String brand, String category) {
        StringBuilder sql = new StringBuilder("""
        SELECT COUNT(*)
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.category_id
        WHERE 1=1
    """);

        // same filters
        // (repeat same logic as above but without limit/sort)
        try {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return 0;
    }

    @Override
    public ArrayList<Product> getProductsForAdmin(String search, Integer categoryId) {

        ArrayList<Product> products = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT p.*, c.category_name "
                + "FROM products p "
                + "INNER JOIN categories c ON p.category_id = c.category_id "
                + "WHERE 1=1 "
        );

        if (search != null && !search.isBlank()) {
            sql.append("AND p.name LIKE ? ");
        }

        if (categoryId != null) {
            sql.append("AND p.category_id = ? ");
        }

        sql.append("ORDER BY p.product_id DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;

            if (search != null && !search.isBlank()) {
                ps.setString(index++, "%" + search + "%");
            }

            if (categoryId != null) {
                ps.setInt(index++, categoryId);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Product product = new Product();

                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setBrand(rs.getString("brand"));
                product.setPrice(rs.getBigDecimal("price"));
                product.setStockQuantity(rs.getInt("stock_quantity"));
                product.setImagePath(rs.getString("image_path"));
                product.setDiscountPercent(rs.getBigDecimal("discount_percent"));

                product.setCategoryId(rs.getInt("category_id"));
                product.setCategoryName(rs.getString("category_name"));

                products.add(product);
            }

        } catch (SQLException ex) {
            System.out.println("Product DAO Error:" + ex.getLocalizedMessage());
        }

        return products;
    }

    @Override
    public boolean insertProduct(Product product) {

        String sql
                = "INSERT INTO products "
                + "(name, description, price, stock_quantity, brand, image_path, category_id, discount_percent, tag) "
                + "VALUES (?,?,?,?,?,?,?,?,?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setInt(4, product.getStockQuantity());
            ps.setString(5, product.getBrand());
            ps.setString(6, product.getImagePath());
            ps.setInt(7, product.getCategoryId());
            ps.setBigDecimal(8, product.getDiscountPercent());
            ps.setString(8, product.getTag());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("ProductDAO:" + ex.getLocalizedMessage());
        }

        return false;
    }

    @Override
    public boolean removeProduct(int productId) {
        try {
            final String sql = "DELETE FROM products WHERE product_id = ?";
            PreparedStatement pSt = conn.prepareStatement(sql);
            pSt.setInt(1, productId);

            return pSt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getLocalizedMessage());
            return false;
        }
    }

    public boolean updateProduct(Product product) {

        String sql
                = "UPDATE products SET "
                + "name=?, "
                + "brand=?, "
                + "description=?, "
                + "price=?, "
                + "stock_quantity=?, "
                + "category_id=?, "
                + "discount_percent=?, "
                + "tag=? "
                + "WHERE product_id=?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, product.getName());
            ps.setString(2, product.getBrand());
            ps.setString(3, product.getDescription());
            ps.setBigDecimal(4, product.getPrice());
            ps.setInt(5, product.getStockQuantity());
            ps.setInt(6, product.getCategoryId());
            ps.setBigDecimal(7, product.getDiscountPercent());
            ps.setString(8, product.getTag());
            ps.setInt(9, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("Update Product DAO:"+ex.getLocalizedMessage());
        }

        return false;
    }

}
