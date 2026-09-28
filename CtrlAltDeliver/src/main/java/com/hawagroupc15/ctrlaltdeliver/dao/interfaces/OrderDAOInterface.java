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
public interface OrderDAOInterface {
    Order getOrderById(int orderId);
    ArrayList<Order> getOrderItems(int orderId);
    boolean updateOrder(Order order);
    User getCustomerById(int userId);
    ArrayList<Order> getOrdersByUserId(int userId);
    
    boolean checkStockQuantity(int userId);
    int createOrder(int userId, String shippingAddress);
    boolean createOrderItems(int orderId, int userId);
    
}
