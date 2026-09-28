/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao.interfaces;

import com.hawagroupc15.ctrlaltdeliver.model.Category;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
public interface CategoryDAOInterface {
    ArrayList<Category> fetchAllCategory();
    Category fetchCategoryByProductId(int productId);
    Category fetchCategoryById(int catId);
    ArrayList<Category> getCategoriesForAdmin(String search);
    boolean updateCategory(Category category);
    boolean removeCategory(int categoryId);
    boolean insertCategory(Category category);
}
