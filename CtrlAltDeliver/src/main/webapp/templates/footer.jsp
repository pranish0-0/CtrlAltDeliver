<%-- 
    Document   : footer
    Created on : May 20, 2026, 3:06:39 PM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css"/>

<footer>

    <div class="footerContainer">


        <div class="footerBrand">
            <div class="logo" >
                <a href="home" style="text-decoration: none">
                    <img src="${pageContext.request.contextPath}/resources/logo.png" width="250" alt="Logo" />
                </a>
            </div>

                <p style="max-width: 60%">
                Fast, reliable, and smart delivery solutions designed to
                simplify your online shopping experience.
            </p>

            <div class="socials">
                <a href="https://www.facebook.com/informaticscollegepkr/" target="_blank">F</a>
                <a href="https://www.instagram.com/icp.nepal/" target="_blank">I</a>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="footerSection">
            <h3>Quick Links</h3>

            <ul class="footerLinks" style="padding: 0;;">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/mycart">My Cart</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/aboutus.html">About Us</a></li>
                <li><a href="${pageContext.request.contextPath}/pages/privacy.html">Privacy</a></li>
            </ul>
        </div>


        <!-- Contact -->
        <div class="footerSection">
            <h3>Contact</h3>

            <div class="contactInfo">
                <p>Pokhara, Nepal</p>
                <p>support@ctrlaltdeliver.com</p>
                <p>+977 98XXXXXXXX</p>
            </div>
        </div>

    </div>

    <!-- Bottom -->
    <div class="footerBottom">

        <p>
            © 2026 CTRL ALT DELIVER. All Rights Reserved.
        </p>

        

    </div>

</footer>