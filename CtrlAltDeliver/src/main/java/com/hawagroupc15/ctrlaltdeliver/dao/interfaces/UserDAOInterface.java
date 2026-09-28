/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.dao.interfaces;

import com.hawagroupc15.ctrlaltdeliver.model.Order;
import com.hawagroupc15.ctrlaltdeliver.model.User;
import java.util.ArrayList;

/**
 *
 * @author Pranish
 */
public interface UserDAOInterface {
    //create new user
    int insertUser(String name,  String password, String email, String phone);
    
    int updateUser(int userId, String fullName, String phone, String email, String address);
    
    int changePassword(int userId, String hashedPassword);
    
    User getUser(String email);
    
    ArrayList<Order> getUserOrders(int user_id, String status);
    ArrayList<User> getCustomersForAdmin(String search);
    User getCustomerById(int userId);
}

