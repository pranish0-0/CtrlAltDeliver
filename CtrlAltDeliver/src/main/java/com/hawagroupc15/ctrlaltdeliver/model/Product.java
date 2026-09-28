/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author Pranish
 */
public class Product {

    private int productId;
    private Integer categoryId;
    private String name;
    private String brand;
    private String description;
    private BigDecimal price;
    private String tag;
    private BigDecimal discountPercent;
    private int stockQuantity;
    private String imagePath;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private String categoryName;
    private int totalSold;

    // ── Constructors ──────────────────────────────────────────────────────────
    public Product() {
    }

    /**
     * constructor for creating a new product.
     */
    public Product(Integer categoryId, String name, String brand, String tag,
            String description, BigDecimal price, BigDecimal discountPercent,
            int stockQuantity, String imagePath, String status) {
        this.categoryId = categoryId;
        this.name = name;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.discountPercent = discountPercent;
        this.stockQuantity = stockQuantity;
        this.imagePath = imagePath;
        this.status = status;
    }

    /**
     * Full constructor
     */
    public Product(int productId, Integer categoryId, String name, String brand,
            String description, BigDecimal price, String tag,
            BigDecimal discountPercent, int stockQuantity, String imagePath,
            String status, Timestamp createdAt, Timestamp updatedAt) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.name = name;
        this.brand = brand;
        this.description = description;
        this.price = price;
        this.tag = tag;
        this.discountPercent = discountPercent;
        this.stockQuantity = stockQuantity;
        this.imagePath = imagePath;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ── Getters & Setters ─────────────────────────────────────────────────────
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getTotalSold() {
        return totalSold;
    }

    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public BigDecimal getEffectivePrice() {
        if (discountPercent == null || discountPercent.compareTo(BigDecimal.ZERO) == 0) {
            return price;
        }
        BigDecimal multiplier = BigDecimal.ONE
                .subtract(discountPercent.divide(new BigDecimal("100")));
        return price.multiply(multiplier).setScale(2, java.math.RoundingMode.HALF_UP);
    }

    public boolean isInStock() {
        return stockQuantity > 0;
    }

}
