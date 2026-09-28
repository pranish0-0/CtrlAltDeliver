/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao.interfaces;

import com.hawagroupc15.ctrlaltdeliver.model.CartItem;
import com.hawagroupc15.ctrlaltdeliver.model.CartItemView;
import java.util.List;

/**
 *
 * @author Pranish
 */
public interface CartDAOInterface  {
    List<CartItemView> fetchUserCart(int userId);
    boolean updateCartItemQunatity(int quantity, int cartItemID);
    boolean removeCartItem(int cartItemID);
    public CartItem getCartItemById(int cartItemId);
    public int getOrCreateCart(int userId);
    public boolean addItemToCart(int userId, int productId, int quantity);
    
}
