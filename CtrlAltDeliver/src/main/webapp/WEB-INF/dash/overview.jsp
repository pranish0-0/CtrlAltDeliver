<%-- 
    Document   : dashboard
    Created on : Jul 26, 2026, 11:01:14 AM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="dashboard-page">

    <div class="page-header">
        <div>
            <h2>Dashboard Overview</h2>
        </div>
    </div>

    <!-- Statistics -->

    <section class="stats-grid">

        <div class="stat-card">
            <h4>Total Products</h4>
            <span>${totalProducts}</span>
        </div>

        <div class="stat-card">
            <h4>Total Customers</h4>
            <span>${totalCustomers}</span>
        </div>

        <div class="stat-card">
            <h4>Total Orders</h4>
            <span>${totalOrders}</span>
        </div>

        <div class="stat-card">
            <h4>Total Revenue</h4>
            <span>Rs. ${totalRevenue}</span>
        </div>

        <div class="stat-card">
            <h4>Pending Orders</h4>
            <span>${pendingOrders}</span>
        </div>

        <div class="stat-card">
            <h4>Completed Orders</h4>
            <span>${completedOrders}</span>
        </div>

        <div class="stat-card">
            <h4>Low Stock Products</h4>
            <span>${lowStockProducts}</span>
        </div>

        <div class="stat-card">
            <h4>Categories</h4>
            <span>${totalCategories}</span>
        </div>

    </section>

    <!-- Bottom Section -->

    <section class="dashboard-grid">

        <!-- Recent Orders -->

        <div class="dashboard-card">

            <div class="card-header">
                <h3>Recent Orders</h3>
            </div>

            <table class="dashboard-table">

                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Order Date</th>
                        <th>Total</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${recentOrders}" var="order">

                    <tr>
                        <td>#${order.orderId}</td>
                        <td>${order.customerName}</td>
                        <td>
                            
                            <fmt:formatDate value="${order.orderDate}"
                                            pattern="dd MMM yyyy"/>
                        </td>
                        <td>
                            Rs.
                            <fmt:formatNumber value="${order.grandTotal}" 
                                              type="number" 
                                              minFractionDigits="2" 
                                              maxFractionDigits="2"/>
                        </td>
                        <td>
                            <span class="status ${order.orderStatus.toLowerCase()}">
                                ${order.orderStatus}
                            </span>
                        </td>
                    </tr>

                    </c:forEach>
                    </tbody>

            </table>

        </div>

        <!-- Quick Actions -->

        <div class="dashboard-card">

            <div class="card-header">
                <h3>Quick Actions</h3>
            </div>

            <div class="quick-actions">

                <a href="admin?page=products" class="action-btn">
                    Manage Products
                </a>

                <a href="admin?page=categories" class="action-btn">
                    Manage Categories
                </a>

                <a href="admin?page=orders" class="action-btn">
                    View Orders
                </a>

                <a href="admin?page=customers" class="action-btn">
                    Manage Customers
                </a>

            </div>

        </div>

    </section>

</div>