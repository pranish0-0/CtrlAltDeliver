/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

/**
 *
 * @author Pranish
 */
public class ProductImages {
    private int image_id;
    private int product_id;
    private String imagePath;
    
//    Constructors
    public ProductImages(){}
    
    public ProductImages(int image_id, int product_id, String imagePath){
        this.image_id = image_id;
        this.product_id = product_id;
        this.imagePath = imagePath;
    }
    
//    getters and setters
    public int getImageId(){return image_id;}
    public int getProductId(){return product_id;}
    public String getImagePath(){return imagePath;}
    
    public void setImageId(int image_id){this.image_id = image_id;}
    public void setProductId(int product_id){this.product_id = product_id;}
    public void setImagePath(String imagePath){this.imagePath = imagePath;}
}
