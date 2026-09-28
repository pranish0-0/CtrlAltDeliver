<%-- 
    Document   : checkout
    Created on : Jul 20, 2026, 12:33:26 AM
    Author     : Pranish
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | Checkout"/>
        <jsp:param name="cssFile" value="checkout"/>
    </jsp:include>

    <body>

        <jsp:include page="/templates/nav.jsp">
            <jsp:param name="one" value="Browse"/>
            <jsp:param name="onehref" value="products"/>

            <jsp:param name="two" value="My Cart"/>
            <jsp:param name="twohref" value="cart"/>

            <jsp:param name="three" value="About Us"/>
            <jsp:param name="threehref" value="aboutus"/>

            <jsp:param name="four" value="${not empty user ? 'My Profile' : 'Log In'}"/>
            <jsp:param name="fourhref" value="${not empty user ? 'userdashboard' : 'login'}"/>
        </jsp:include>

        <section class="checkout">

            <div class="checkout-wrapper">

                <h1 class="page-title">Checkout</h1>
                <p>${errormessage}</p>

                <form action="${pageContext.request.contextPath}/checkout" method="post">

                    <div class="checkout-grid">

                        <!-- LEFT SIDE -->
                        <div class="checkout-left">

                            <div class="checkout-card">

                                <h2>Shipping Information</h2>

                                <div class="form-group">
                                    <label>Full Name</label>
                                    <input
                                        type="text"
                                        value="${user.fullName}"
                                        readonly>
                                </div>

                                <div class="form-group">
                                    <label>Email</label>
                                    <input
                                        type="email"
                                        value="${user.email}"
                                        readonly>
                                </div>

                                <div class="form-group">
                                    <label>Phone Number</label>
                                    <input
                                        type="text"
                                        value="${user.phone}"
                                        readonly>
                                </div>

                                <div class="form-group">
                                    <label>Shipping Address</label>

                                    <textarea
                                        name="shippingAddress"
                                        rows="5"
                                        required>${user.address}</textarea>

                                </div>

                            </div>

                        </div>

                        <!-- RIGHT SIDE -->
                        <div class="checkout-right">

                            <div class="checkout-card">

                                <h2>Order Summary</h2>

                                <c:set var="grandTotal" value="0"/>

                                <c:forEach items="${cartItems}" var="item">

                                    <div class="summary-item">

                                        <div>

                                            <strong>${item.name}</strong>
                                            
                                            Discount:
                                            ${item.discountPercent} %<br>

                                            Qty:
                                            ${item.quantity}

                                        </div>

                                        <div>

                                            Rs.
                                            <fmt:formatNumber
                                                value="${item.effectivePrice * item.quantity}"
                                                minFractionDigits="2"
                                                maxFractionDigits="2"/>

                                        </div>

                                    </div>

                                    <c:set var="grandTotal" value="${200 + grandTotal + item.effectivePrice * item.quantity}"/>

                                </c:forEach>

                                <div class="summary-item">

                                    <div>

                                        <strong>Shipping Fee</strong><br>

                                    </div>

                                    <div>

                                        Rs. 200

                                    </div>

                                </div>

                                <hr>

                                <div class="summary-total">

                                    <span>Total</span>

                                    <span>

                                        Rs.
                                        <fmt:formatNumber value="${grandTotal}" minFractionDigits="2" maxFractionDigits="2"/>

                                    </span>

                                </div>

                                <button type="submit" class="place-order-btn">

                                    Place Order

                                </button>

                            </div>

                        </div>

                    </div>

                </form>

            </div>

        </section>

        <jsp:include page="/templates/footer.jsp"/>

    </body>
</html>