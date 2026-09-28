/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.hawagroupc15.ctrlaltdeliver.utilities;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Pranish
 */
public class PasswordUtil {
    private final static int COST = 10;  
    
    public static String getHashPassword(String inputPassword){
        // Generate a salt 
        String salt = BCrypt.gensalt(COST);
        // Hash the password with the generated salt
        return BCrypt.hashpw(inputPassword, salt);
    }
    
    public static boolean checkPassword(String passwordTyped, String hashedPassword){
        return BCrypt.checkpw(passwordTyped, hashedPassword);
    }
}
