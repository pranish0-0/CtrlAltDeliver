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
public class Cart {
    private int cart_id;
    private int user_id;
    
    //Constructors
    public Cart(){}
    
    public Cart(int cart_id, int user_id){
        this.cart_id = cart_id;
        this.user_id = user_id;
    }
    
//    Getters and Setters
    
    
    public int getCartID(){ return cart_id; }
    public void setCartID(int cart_id){
        this.cart_id = cart_id;
    }
    
    public int getUserID(){ return user_id; }
    public void setUserID(int user_id){
        this.user_id = user_id;
    }
}
