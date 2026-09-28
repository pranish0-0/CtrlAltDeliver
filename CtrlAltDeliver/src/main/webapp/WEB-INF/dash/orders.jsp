<%-- 
    Document   : dashboard
    Created on : Jul 26, 2026, 11:01:14 AM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<section class="dashboard-section">

    <div class="page-header">
        <div>
            <h2>Manage Orders</h2>
            <p>${errormessage}</p>
        </div>
    </div>

    <p value="${error}"></p>

    <!-- Filters -->

    <form method="get" action="admin" class="filter-bar">

        <input type="hidden" name="page" value="orders">

        <input type="text" name="search" class="search-input" placeholder="Search Order ID or Customer..." value="${param.search}">

        <select name="paymentstatus"
                class="filter-select">

            <option value="">Payment Status</option>

            <option value="Pending"
                    ${param.paymentstatus=='Pending'?'selected':''}>
                Pending
            </option>

            <option value="Paid"
                    ${param.paymentstatus=='Paid'?'selected':''}>
                Paid
            </option>

        </select>
        
        <select name="orderstatus"
                class="filter-select">

            <option value="">Order Status</option>

            <option value="Pending"
                    ${param.orderstatus=='Pending'?'selected':''}>
                Pending
            </option>

            <option value="Processing"
                    ${param.orderstatus=='Processing'?'selected':''}>
                Processing
            </option>

            <option value="Delivered"
                    ${param.orderstatus=='Delivered'?'selected':''}>
                Delivered
            </option>

            <option value="Cancelled"
                    ${param.orderstatus=='Cancelled'?'selected':''}>
                Cancelled
            </option>

        </select>

        <button class="primary-btn">
            Search
        </button>

        <a href="admin?page=orders"
           class="search-clear">
            Clear
        </a>

    </form>

    <!-- Category Table -->

    <div class="table-container">

        <table class="dashboard-table" >

            <thead>

                <tr>

                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Payment</th>
                    <th>Order Status</th>
                    <th>Shipment</th>
                    <th>Action</th>

                </tr>

            </thead>

            <tbody>

                <c:forEach items="${orders}" var="order">

                    <tr>
                        <td>#${order.orderId}</td>
                        <td>${order.customerName}</td>
                        <td>${order.orderDate}</td>
                        <td>Rs. ${order.grandTotal}</td>
                        <td><span class="status ${order.paymentStatus.toLowerCase()}">${order.paymentStatus}</span></td>
                        <td><span class="status ${order.orderStatus.toLowerCase()}">${order.orderStatus}</span></td>
                        <td><span class="status ${order.shipmentStatus.toLowerCase()}">${order.shipmentStatus}</span></td>
                        <td>
                            <div class="action-group">
                                <a href="admin?page=vieworder&id=${order.orderId}" class="edit-btn">
                                    View
                                </a>
                            </div>
                        </td>
                    </tr>

                </c:forEach>
                    
            <h2 style="text-align: center; color: red; padding-bottom: 15px;">${emptymessage}</h2>

            </tbody>

        </table>

    </div>

</section>