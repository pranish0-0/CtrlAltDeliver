/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

/**
 *
 * @author Pranish
 */
public class Category {

    private int category_id;
    private String category_name;
    private String description;
    private String image;
    private int totalSold;

//    Constructors
    public Category() {
    }

    public Category(int category_id, String category_name, String description, String image) {
        this.category_id = category_id;
        this.category_name = category_name;
        this.description = description;
        this.image = image;
    }

//    Getters & Setters
    public int getTotalSold() {return totalSold;}
    public void setTotalSold(int totalSold) {
        this.totalSold = totalSold;
    }

    public int getCategoryId() {
        return category_id;
    }

    public void setCategoryId(int category_id) {
        this.category_id = category_id;
    }

    public String getCategoryName() {
        return category_name;
    }

    public void setCategoryName(String category_name) {
        this.category_name = category_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }
}
