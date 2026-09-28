<%-- 
    Document   : mycart
    Created on : May 19, 2026, 2:17:19 AM
    Author     : Pranish
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <!--head via template-->
    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | My Cart"/>
        <jsp:param name="cssFile" value="mycart"/>
    </jsp:include>

    <body>

        <!--header via template-->
        <jsp:include page="/templates/nav.jsp">
            <jsp:param name="one" value="Browse"/>
            <jsp:param name="onehref" value="products"/>

            <jsp:param name="two" value="My Cart"/>
            <jsp:param name="twohref" value="cart"/>

            <jsp:param name="three" value="About Us"/>
            <jsp:param name="threehref" value="aboutus"/>

            <jsp:param name="four" value="${not empty user ? 'My Profile' : 'Log In'}"/>
            <jsp:param name="fourhref" value="${not empty user ? 'userdashboard' : 'login'}" />
        </jsp:include>


        <section class="mycart" >
            <div class="cartWrapper">

                <c:if test="${empty user}">
                    <div class="loginOverlay">
                        <div class="loginPromptCard">
                            <h2 style="color: var(--color-primary);">Login Required</h2>

                            <p style="color: var(--color-dark);">
                                Please login or create an account to continue using your cart.
                            </p>

                            <div class="loginActions">
                                <a href="${pageContext.request.contextPath}/login"
                                   class="loginBtn">
                                    Login
                                </a>

                                <a href="${pageContext.request.contextPath}/register"
                                   class="registerBtn">
                                    Register
                                </a>
                            </div>
                        </div>
                    </div>

                </c:if>

                <div class="${empty user ? 'cartLocked' : ''}">
                    <div class="cartContainer"> 
                        <h1 >My Cart</h1>
                        <c:set var="grandTotal" value="0"/>
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cartCard">
                                <!-- Left Section -->
                                <div class="cartLeft">

                                    <!-- Product Image -->
                                    <div class="cartImageWrapper">
                                        <img src="${item.imagePath}"
                                             alt="${item.name}"
                                             class="cartImage">
                                    </div>

                                    <!-- Product Details -->
                                    <div class="cartInfo">
                                        <h2 class="cartProductName">
                                            ${item.name}
                                        </h2>

                                        <p class="cartPrice">
                                            Rs.
                                            <fmt:formatNumber value="${item.price}" 
                                                              type="number" 
                                                              minFractionDigits="2" 
                                                              maxFractionDigits="2"/>
                                        </p>
                                        <p class="cartPrice">Discount - 
                                            <fmt:formatNumber value="${item.discountPercent}" type="number"/>% 
                                        </p>
                                        

                                        <div class="cartQuantity">
                                            Quantity:

                                            <form action="${pageContext.request.contextPath}/cart" method="POST" class="quantityControl">
                                                <!--<input type="hidden" name="productId" value="${item.productID}" />-->
                                                <input type="hidden" name="cartItemId" value="${item.cartItemID}" />
                                                <!-- Decrease button -->
                                                <button type="submit" name="action" value="decrease" class="qtyBtn">
                                                    −
                                                </button>

                                                <!-- Quantity display -->
                                                <input type="text"
                                                       name="quantity"
                                                       value="${item.quantity}"
                                                       class="qtyInput"
                                                       readonly />

                                                <!-- Increase button -->
                                                <button type="submit" name="action" value="increase" class="qtyBtn">
                                                    +
                                                </button>
                                            </form>

<!--<span>${item.quantity}</span>-->

                                        </div>
                                    </div>

                                </div>

                                <!-- Right Section -->
                                <div class="cartRight">

                                    <div class="cartRemove">
                                        <form action="${pageContext.request.contextPath}/cart" method="post">
                                            <input type="hidden" name="cartItemId" value="${item.cartItemID}" />
                                            <button class="qtyBtn" type="submit" name="action" value="removeItem" 
                                                    style="text-decoration: none; color: black;" >❌</button>
                                        </form>
                                    </div>

                                    <div class="cartItemTotalLabel">
                                        Total:
                                    </div>

                                    <div class="cartItemTotal">
                                        Rs.
                                        <fmt:formatNumber
                                            value="${item.effectivePrice * item.quantity}"
                                            type="number"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>
                                    </div>

                                </div>
                            </div>
                            <c:set var="grandTotal" value="${grandTotal + item.effectivePrice * item.quantity}"/>
                        </c:forEach>
                    </div>
                </div>
                <br/>
                
                <c:if test="${empty cartItems}">
                    <div style="display: flex;
                            flex-direction: column; 
                            align-items: center;
                            color:grey; 
                            margin: 150px 0;">
                        <h1 style="margin-bottom:0;">Looks like your cart is empty.</h1>
                        <h4 style="margin-top:5px;">Browse items to add to cart and continue shopping.</h4>
                        <a href="${pageContext.request.contextPath}/products" class="filter-btn">Browse</a>
                    </div>
                </c:if>
                
                <c:if test="${not empty cartItems}">
                <hr/>
                    <div class="cartBottom ${empty user ? 'cartLocked' : ''}" >
                        <div style="padding: 8px 20px; display: flex; justify-content: space-between">
                            <h1>Total</h1>
                            <h1>Rs.
                                <fmt:formatNumber
                                    value="${grandTotal}"
                                    type="number"
                                    minFractionDigits="2"
                                    maxFractionDigits="2"/>
                            </h1>
                        </div>

                        <div >
                            <form action="${pageContext.request.contextPath}/checkout" method="get">
                                <button class="buyNow">
                                    Proceed to Checkout
                                </button>
                            </form>
                        </div>


                    </div>
                </c:if>
            </div>

        </section>

<jsp:include page="/templates/footer.jsp" />
    </body>
</html>
