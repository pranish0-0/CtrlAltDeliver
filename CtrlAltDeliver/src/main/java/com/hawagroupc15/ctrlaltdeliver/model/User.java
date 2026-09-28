/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;

/**
 *
 * @author Pranish
 */
public class User {

    public enum Role {
        ADMIN, MEMBER
    }

    private int user_id;
    private String full_name;
    private String email;
    private String passwordHash;
    private Role role;
    private String profile_image;
    private String address;
    private String phone;
    private Timestamp created_at;
    private Timestamp updated_at;
    private int totalOrders;
    private BigDecimal totalSpent;

    // ── Constructors ──────────────────────────────────────────────────────────
    public User() {}

    // Getters & Setters 
    public int getTotalOrders() {return totalOrders;}
    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
    
    public BigDecimal getTotalSpent() {return totalSpent;}
    public void setTotalSpent(BigDecimal totalSpent) {
        this.totalSpent = totalSpent;
    }
    
    public int getUserId() {
        return user_id;
    }

    public void setUserId(int user_id) {
        this.user_id = user_id;
    }

    public String getFullName() {
        return full_name;
    }

    public void setFullName(String full_name) {
        this.full_name = full_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getProfileImage() {
        return profile_image;
    }

    public void setProfileImage(String profile_image) {
        this.profile_image = profile_image;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Timestamp getCreatedAt() {
        return created_at;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.created_at = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updated_at;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updated_at = updatedAt;
    }

    public boolean isAdmin() {
        return Role.ADMIN.equals(this.role);
    }

    @Override
    public String toString() {
        return "User{userId=" + user_id
                + ", fullName='" + full_name + '\''
                + ", email='" + email + '\''
                + ", role=" + role
                + ", phone="+ phone
                + '}';
    }
}
