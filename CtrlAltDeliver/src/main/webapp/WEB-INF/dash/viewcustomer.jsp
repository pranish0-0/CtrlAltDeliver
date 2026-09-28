<%-- 
    Document   : vieworder
    Created on : Jul 28, 2026, 11:31:12 AM
    Author     : Pranish
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="dashboard-section">

    <div class="page-header">

        <div>
            <h2>Customer Details</h2>
            <p>View customer profile and purchase history.</p>
        </div>

        <a href="admin?page=customers" class="secondary-btn">
            ← Back to Customers
        </a>

    </div>

    <!-- CUSTOMER PROFILE -->
    <div class="dashboard-card">

        <div class="customer-profile">

            <div class="customer-image">
                <img src="${pageContext.request.contextPath}/${customer.profileImage}" alt="${customer.fullName}">
            </div>

            <div class="customer-info">

                <h2>${customer.fullName}</h2>
                <span class="role-badge">
                    ${customer.role}
                </span>

            </div>

        </div>

    </div>

    <!-- DETAILS -->
    <div class="details-grid">

        <!-- Contact -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Contact Information</h3>
            </div>

            <table class="info-table">

                <tr>
                    <th>Email</th>
                    <td>${customer.email}</td>
                </tr>

                <tr>
                    <th>Phone</th>
                    <td>${customer.phone}</td>
                </tr>

                <tr>
                    <th>Address</th>
                    <td>${customer.address}</td>
                </tr>

            </table>

        </div>

        <!-- Account -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Account Information</h3>
            </div>

            <table class="info-table">

                <tr>
                    <th>User ID</th>
                    <td>#${customer.userId}</td>
                </tr>

                <tr>
                    <th>Joined</th>
                    <td>
                        <fmt:formatDate
                            value="${customer.createdAt}"
                            pattern="dd MMM yyyy"/>
                    </td>
                </tr>

                <tr>
                    <th>Total Orders</th>
                    <td>${customer.totalOrders}</td>
                </tr>

            </table>

        </div>

    </div>

    <!-- RECENT ORDERS -->
    <div class="dashboard-card">

        <div class="card-header">
            <h3>Order History</h3>
        </div>

        <table class="dashboard-table">

            <thead>

                <tr>
                    <th>Order ID</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Payment</th>
                    <th>Status</th>
                    <th></th>
                </tr>

            </thead>

            <tbody>

                <c:forEach items="${customerOrders}" var="order">

                    <tr>

                        <td>#${order.orderId}</td>

                        <td>
                            <fmt:formatDate
                                value="${order.orderDate}"
                                pattern="dd MMM yyyy"/>
                        </td>

                        <td>
                            Rs.
                            <fmt:formatNumber
                                value="${order.grandTotal}"
                                type="number"
                                minFractionDigits="2"/>
                        </td>

                        <td>${order.paymentStatus}</td>

                        <td>

                            <span class="status ${order.orderStatus.toLowerCase()}">

                                ${order.orderStatus}

                            </span>

                        </td>

                        <td>

                            <a class="edit-btn"
                               href="admin?page=vieworder&id=${order.orderId}">

                                View Order

                            </a>

                        </td>

                    </tr>

                </c:forEach>

            </tbody>

        </table>

    </div>

</section>
<style>
    /*CUSTOMER PROFILE*/
    .customer-profile{
        display:flex;
        align-items:center;
        gap:28px;
    }

    .customer-image img{
        width:140px;
        height:140px;
        object-fit:cover;
        border-radius:50%;
        border:4px solid var(--color-border);
    }

    .customer-info{
        display:flex;
        flex-direction:column;
        gap:12px;
    }

    .customer-info h2{
        font-size:30px;
        color:var(--color-dark);
    }

    .role-badge{
        width:fit-content;
        padding:8px 18px;
        border-radius:20px;
        background:var(--color-primary);
        color:white;
        font-size:14px;
        font-weight:600;
    }
     
    /*DETAILS GRID*/
    .details-grid{
        display:grid;
        grid-template-columns:1fr 1fr;
        gap:24px;
    }

    /*INFORMATION TABLE*/
    .info-table{
        width:100%;
        border-collapse:collapse;
    }

    .info-table tr{
        border-bottom:1px solid var(--color-border);
    }

    .info-table th{
        width:170px;
        text-align:left;
        padding:16px 10px;
        color:#777;
        font-weight:600;
    }

    .info-table td{
        padding:16px 10px;
        color:var(--color-dark);
    }
       
    /*ORDER TABLE*/
    .dashboard-table{
        width:100%;
        border-collapse:collapse;
    }

    .dashboard-table th{
        background:#f8f8f8;
        text-align:left;
        padding:14px;
        font-size:15px;
    }

    .dashboard-table td{
        padding:15px 14px;
        border-top:1px solid var(--color-border);
    }

    .dashboard-table tr:hover{
        background:#fafafa;
    }
    
    /*STATUS BADGES*/
    .status{
        display:inline-block;
        padding:7px 14px;
        border-radius:20px;
        font-size:13px;
        font-weight:700;
    }

    .pending{
        background:#fff4d8;
        color:#b98300;
    }

    .processing{
        background:#dfeeff;
        color:#2876da;
    }

    .delivered{
        background:#def6e8;
        color:#2d8b57;
    }

    .cancelled{
        background:#ffe3e3;
        color:#d84d4d;
    }

    /*RESPONSIVE*/
    @media(max-width:900px){

        .customer-profile{
            flex-direction:column;
            text-align:center;
        }

        .customer-info{
            align-items:center;
        }

        .details-grid{
            grid-template-columns:1fr;
        }

    }

    @media(max-width:768px){

        .dashboard-table{
            display:block;
            overflow-x:auto;
        }

        .customer-image img{
            width:120px;
            height:120px;
        }

        .customer-info h2{
            font-size:24px;
        }

    }
</style>