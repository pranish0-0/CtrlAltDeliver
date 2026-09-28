/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao.interfaces;

/**
 *
 * @author Pranish
 */
import com.hawagroupc15.ctrlaltdeliver.model.Product;
import com.hawagroupc15.ctrlaltdeliver.model.ProductImages;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public interface ProductDAOInterface {

    //Enter learning entry (TODO): Fetch all topics
    ArrayList<Product> fetchAllProducts();

    List<String> fetchAllCategoryNames();

    List<String> fetchAllBrands();

    ArrayList<Product> fetchAllFeaturedProducts();

    ArrayList<Product> fetchProductsByTag(String tag);

    Product fetchProductsByID(int product_id);

    ArrayList<Product> fetchProductsByCategory(int categoryID);

    ArrayList<ProductImages> fetchImagesByProductID(int productID);

//    Pagination
    List<Product> fetchAllProducts(int limit, int offset);

    int countAllProducts();

    List<Product> fetchByBrand(String brand, int limit, int offset);

    int countByBrand(String brand);

    List<Product> fetchByCategory(String category, int limit, int offset);

    int countByCategory(String category);

    List<Product> searchProducts(String query, int limit, int offset);

    int countSearchProducts(String query);

    List<Product> fetchSortedProducts(String sort, int limit, int offset);

    Product mapProduct(ResultSet rs) throws SQLException;

    List<Product> fetchFilteredProducts(String search, String brand, String category, String sort, int limit, int offset);
    
    int countFilteredProducts(String search, String brand, String category);
    
    ArrayList<Product> getProductsForAdmin(String search,Integer categoryId);
    
    boolean insertProduct(Product product);
    
    boolean removeProduct(int productId);
}
