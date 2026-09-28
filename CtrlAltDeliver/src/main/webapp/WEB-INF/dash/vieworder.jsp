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

            <h2>Order #${order.orderId}</h2>

            <p>Order Details</p>

        </div>

        <a href="admin?page=orders" class="secondary-btn">

            ← Back to Orders

        </a>

    </div>



    <!-- Customer Information -->

    <div class="dashboard-card">

        <div class="card-header">

            <h3>Customer Information</h3>

        </div>

        <div class="detail-grid">

            <div>
                <label>Name</label>
                <p>${order.customerName}</p>
            </div>

            <div>
                <label>Email</label>
                <p>${order.customerEmail}</p>
            </div>

            <div>
                <label>Phone</label>
                <p>${order.customerPhone}</p>
            </div>

            <div>
                <label>Delivery Address</label>
                <p>${order.deliveryAddress}</p>
            </div>

        </div>

    </div>



    <!-- Order Information -->

    <div class="dashboard-card">

        <div class="card-header">

            <h3>Order Information</h3>

        </div>

        <form action="admin" method="post">

            <input type="hidden" name="action" value="updateorder">

            <input type="hidden"
                   name="orderId"
                   value="${order.orderId}">

            <div class="detail-grid">

                <div>

                    <label>Order Date</label>

                    <p>

                        <fmt:formatDate
                            value="${order.orderDate}"
                            pattern="dd MMM yyyy HH:mm"/>

                    </p>

                </div>

                <div>

                    <label>Payment Status</label>

                    <select name="paymentStatus">

                        <option value="Pending"
                                ${order.paymentStatus=='Pending'?'selected':''}>
                            Pending
                        </option>

                        <option value="Paid"
                                ${order.paymentStatus=='Paid'?'selected':''}>
                            Paid
                        </option>

                    </select>

                </div>

                <div>

                    <label>Order Status</label>

                    <select name="orderStatus">

                        <option value="Pending"
                                ${order.orderStatus=='Pending'?'selected':''}>
                            Pending
                        </option>

                        <option value="Processing"
                                ${order.orderStatus=='Processing'?'selected':''}>
                            Processing
                        </option>

                        <option value="Delivered"
                                ${order.orderStatus=='Delivered'?'selected':''}>
                            Delivered
                        </option>

                        <option value="Cancelled"
                                ${order.orderStatus=='Cancelled'?'selected':''}>
                            Cancelled
                        </option>

                    </select>

                </div>

                <div>

                    <label>Shipment Status</label>

                    <select name="shipmentStatus">

                        <option value="Pending"
                                ${order.shipmentStatus=='Pending'?'selected':''}>
                            Pending
                        </option>

                        <option value="Shipped"
                                ${order.shipmentStatus=='Shipped'?'selected':''}>
                            Shipped
                        </option>

                        <option value="Delivered"
                                ${order.shipmentStatus=='Delivered'?'selected':''}>
                            Delivered
                        </option>

                    </select>

                </div>

                <div>

                    <label>Grand Total</label>

                    <p>

                        Rs.

                        <fmt:formatNumber
                            value="${order.grandTotal}"
                            minFractionDigits="2"/>

                    </p>

                </div>

            </div>

            <div class="form-actions">

                <button class="primary-btn">

                    Save Changes

                </button>

            </div>

        </form>

    </div>



    <!-- Ordered Products -->

    <div class="dashboard-card">

        <div class="card-header">

            <h3>Products</h3>

        </div>

        <table class="dashboard-table">

            <thead>

                <tr>

                    <th>Image</th>
                    <th>Product</th>
                    <th>Price</th>
                    <th>Qty</th>
                    <th>Subtotal</th>

                </tr>

            </thead>

            <tbody>

                <c:forEach items="${orderItems}" var="item">

                    <tr>

                        <td>

                            <img
                                class="table-image"
                                src="${pageContext.request.contextPath}/${item.imagePath}">

                        </td>

                        <td>${item.productName}</td>

                        <td>

                            Rs.

                            <fmt:formatNumber
                                value="${item.unitPrice}"
                                minFractionDigits="2"/>

                        </td>

                        <td>${item.quantity}</td>

                        <td>

                            Rs.

                            <fmt:formatNumber
                                value="${item.subtotal}"
                                minFractionDigits="2"/>

                        </td>

                    </tr>

                </c:forEach>

            </tbody>

        </table>

    </div>

</section>

<style>
    /* ==========================================
VIEW ORDER
========================================== */

    .order-grid{
        display:grid;
        grid-template-columns:1fr 1fr;
        gap:24px;
    }

    .detail-grid{
        display:grid;
        grid-template-columns:repeat(2,1fr);
        gap:20px;
    }

    .detail-grid div{
        display:flex;
        flex-direction:column;
        gap:8px;
    }

    .detail-grid label{
        font-size:14px;
        font-weight:600;
        color:#888;
    }

    .detail-grid p{
        padding:12px 14px;
        border:1px solid var(--color-border);
        border-radius:12px;
        background:#fafafa;
        color:var(--color-dark);
        font-weight:500;
        min-height:48px;
        display:flex;
        align-items:center;
    }

    .detail-grid select{
        width:100%;
        padding:12px 14px;
        border:1px solid var(--color-border);
        border-radius:12px;
        background:white;
        font-size:15px;
        transition:.25s;
    }

    .detail-grid select:focus{
        outline:none;
        border-color:var(--color-primary);
    }

    .order-summary{
        margin-top:24px;
        display:flex;
        justify-content:flex-end;
    }

    .summary-card{
        width:320px;
        border:1px solid var(--color-border);
        border-radius:18px;
        padding:22px;
        background:#fafafa;
    }

    .summary-card h3{
        margin-bottom:18px;
        color:var(--color-dark);
    }

    .summary-row{
        display:flex;
        justify-content:space-between;
        margin-bottom:12px;
        font-size:15px;
    }

    .summary-row.total{
        margin-top:18px;
        padding-top:16px;
        border-top:2px solid var(--color-border);
        font-size:20px;
        font-weight:700;
        color:var(--color-primary);
    }

    .table-image{
        width:65px;
        height:65px;
        object-fit:cover;
        border-radius:12px;
        border:1px solid var(--color-border);
    }

    .dashboard-card{
        margin-bottom:24px;
    }

    .dashboard-table td{
        vertical-align:middle;
    }

    .form-actions{
        margin-top:24px;
        display:flex;
        justify-content:flex-end;
        gap:14px;
    }

    /* ===========================
       STATUS BADGES
    =========================== */

    .status{
        display:inline-block;
        padding:8px 14px;
        border-radius:20px;
        font-size:13px;
        font-weight:700;
    }

    .pending{
        background:#fff4d8;
        color:#b98300;
    }

    .processing{
        background:#ddeeff;
        color:#2876da;
    }

    .delivered{
        background:#ddf5e6;
        color:#2d8b57;
    }

    .cancelled{
        background:#ffe4e4;
        color:#d84d4d;
    }

    .shipped{
        background:#e6f4ff;
        color:#1d74d1;
    }

    .paid{
        background:#def6e8;
        color:#2d8b57;
    }

    /* ===========================
       RESPONSIVE
    =========================== */

    @media(max-width:992px){

        .order-grid{
            grid-template-columns:1fr;
        }

        .detail-grid{
            grid-template-columns:1fr;
        }

        .summary-card{
            width:100%;
        }

    }

    @media(max-width:768px){

        .dashboard-table{
            display:block;
            overflow-x:auto;
        }

        .form-actions{
            flex-direction:column;
        }

        .primary-btn,
        .secondary-btn{
            width:100%;
            text-align:center;
        }

    }
</style>