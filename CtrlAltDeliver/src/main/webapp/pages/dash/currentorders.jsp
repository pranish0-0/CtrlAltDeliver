<%-- 
    Document   : myorders
    Created on : Jul 18, 2026, 9:15:25 PM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="dashboard-header">
    <h1>Current Orders</h1>
    <p>${message}</p>
</div>

<!--Current Orders-->
<!--${orders}-->

<div style="max-height: 87dvh; overflow-y: auto;">
    <c:forEach var="order" items="${orders}">
        <div class="order-card">
            <div class="order-image">
                <img src="${order.imagePath}"
                     alt="Product">
            </div>
            <div class="order-details">
                <div class="order-top">
                    <h2>${order.productName}</h2>
                    <span class="order-status ${fn:toLowerCase(order.orderStatus)}">
                        ${order.orderStatus}
                    </span>
                </div>
                <div class="order-meta">
                    <p>Quantity: ${order.quantity}</p>
                    <p>Price: Rs. ${order.unitPrice}</p>
                    <p>Order ID: #${order.orderId}</p>
                </div>
            </div>
        </div>
    </c:forEach>

    <c:if test="${empty orders}">
        <h1 style="text-align: center; padding: 10%;">Seems Like There Are No Orders To Display.</h1>
    </c:if>
</div>