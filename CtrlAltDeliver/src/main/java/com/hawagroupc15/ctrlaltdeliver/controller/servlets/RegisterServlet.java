package com.hawagroupc15.ctrlaltdeliver.controller.servlets;

import com.hawagroupc15.ctrlaltdeliver.dao.UserDAO;
import com.hawagroupc15.ctrlaltdeliver.utilities.PasswordUtil;
import com.hawagroupc15.ctrlaltdeliver.utilities.ValidationUtil;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Pranish
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        final String firstName = request.getParameter("firstName");
        final String lastName = request.getParameter("lastName");
        final String fullName = firstName+ ' ' +lastName;
        final String email = request.getParameter("email");
        final String phone =  request.getParameter("phone");
        final String password = request.getParameter("password");
        final String cfPassword = request.getParameter("cpassword");

        // validate each inputs: Server side Validation
        //1. first and last name must not be empty, alphanumeric starting from alphabets 
        final boolean isValidName = 
                (!ValidationUtil.isNullOrEmpty(firstName)
                && ValidationUtil.isAlphabetic(firstName)
                && firstName.length() > 2)
                
                && 
                
                (!ValidationUtil.isNullOrEmpty(lastName)
                && ValidationUtil.isAlphabetic(lastName)
                && lastName.length() > 3);
        String errorUser = isValidName ? "" : "Name not Proper! ";

        //2. email:
        final boolean isValidMail = ValidationUtil.isValidEmail(email);
        String errorMail = isValidMail ? "" : "Mail not Proper! ";
        
        //3. Phone:
        final boolean isValidPhone = ValidationUtil.isValidPhoneNumber(phone);
        String errorPhone = isValidPhone ? "" : "Phone not Proper! ";

        //4. password: 6 character, least 1 capital letter, 1 number, and 1 symbol
        final boolean isValidPass = ValidationUtil.isValidPassword(password);
        String errorPass = isValidPass ? "" : "Password not Proper! ";

        //5. confirm password:
        final boolean isValidCon = ValidationUtil.doPasswordsMatch(password, cfPassword);
        String errorCon = isValidCon ? "" : "Password not matching! ";

        String error_ = errorUser + errorMail + errorPhone + errorPass + errorCon;
        request.setAttribute("error", error_);
        request.setAttribute("erFname", errorUser);
        request.setAttribute("erLname", errorUser);
        request.setAttribute("erPhone", errorPhone);
        request.setAttribute("erMail", errorMail);
        
        //if error in user data provide feedback to same page
        if (!error_.isBlank()) {
            RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
            rd.forward(request, response);

        } else {
            // if user details all good, hash it before storing it
            String hashedPassword = PasswordUtil.getHashPassword(password);

            //Create user entry on database users table
            final UserDAO userDAO = new UserDAO();
            int check = userDAO.insertUser(fullName, hashedPassword, email, phone);
            switch (check) {
                case 1:
                    //After successful login we will go to login page
                    response.sendRedirect(request.getContextPath() + "/login");
                    System.out.println(check);
                    break;
                //if check is 2 user already present display user already present error
                //send user present message to user in register page
                case 2:
                    request.setAttribute("error", "User/Email already present!");
                    RequestDispatcher rdisp = request.getRequestDispatcher("/register.jsp");
                    rdisp.forward(request, response);
                    break;
                default:
                    System.out.println("Server error: " + check + " :error code");
                    break;
            }
        }

    }

}
