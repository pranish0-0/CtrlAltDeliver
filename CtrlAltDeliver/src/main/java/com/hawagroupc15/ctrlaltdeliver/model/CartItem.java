/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

import java.sql.Timestamp;

/**
 *
 * @author Pranish
 */
public class CartItem {
    private int cart_item_id;
    private int cart_id;
    private int product_id ;
    private int quantity;
    
//    Constructors 
    public CartItem(){}
    
    public CartItem(int cart_item_id, int cart_id, int product_id, int quanitity){
        this.cart_item_id = cart_item_id;
        this.cart_id = cart_id;
        this.product_id = product_id;
        this.quantity = quanitity;
    }
    
    //Getters and Setters
    public int getCartID() {return cart_id;}
    public void setCartID(int cart_id) {
        this.cart_id = cart_id;
    }

    public int getCartItemID() {return cart_item_id;}
    public void setCartItemID(int cart_item_id) {
        this.cart_item_id = cart_item_id;
    }
    
    public int getProductID(){ return product_id; }
    public void setProductID(int product_id){
        this.product_id = product_id;
    }
    
    public int getQuantity(){ return quantity; }
    public void setQuantity(int quantity){
        this.quantity = quantity;
    }
}
