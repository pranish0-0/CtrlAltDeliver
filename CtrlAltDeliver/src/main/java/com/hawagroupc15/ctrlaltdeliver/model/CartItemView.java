/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

import java.math.BigDecimal;

/**
 *
 * @author Pranish
 */
public class CartItemView {
//    cartItems + Cart + Products

    private int cartItemId;
    private int cartId;
    private int productId;
    private int quantity;

    private String name;
    private BigDecimal price;
    private String image_path;
    private BigDecimal discountPercent;

//    constructors
    public CartItemView() {
    }

    // getters + setters
    public int getCartItemID() {
        return cartItemId;
    }

    public void setCartItemID(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCartID() {
        return cartId;
    }

    public void setCartID(int cartId) {
        this.cartId = cartId;
    }

    public int getProductID() {
        return productId;
    }

    public void setProductID(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImagePath() {
        return image_path;
    }

    public void setImagePath(String image_path) {
        this.image_path = image_path;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public BigDecimal getEffectivePrice() {
        if (discountPercent == null || discountPercent.compareTo(BigDecimal.ZERO) == 0) {
            return price;
        }
        BigDecimal multiplier = BigDecimal.ONE.subtract(discountPercent.divide(new BigDecimal("100")));
        return price.multiply(multiplier).setScale(2, java.math.RoundingMode.HALF_UP);
    }
}
