<%-- 
    Document   : reports
    Created on : Jul 26, 2026, 11:01:14 AM
    Author     : Pranish
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<section class="dashboard-section">

    <!-- Header -->
    <div class="page-header">
        <div>
            <h2>Reports</h2>
        </div>
    </div>

    <!-- Revenue + Pie -->
    <section class="overview-grid">

        <!-- Monthly Revenue -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Monthly Revenue</h3>
            </div>

            <div class="chart-container">
                <canvas id="revenueChart"></canvas>
            </div>

        </div>

        <!-- Order Status -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Order Status</h3>
            </div>

            <div class="pie-container">
                <canvas id="statusChart"></canvas>
            </div>

        </div>

    </section>

    <!-- Category + Recent Orders -->
    <section class="overview-grid">

        <!-- Category Sales -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Sales by Category</h3>
            </div>

            <div class="chart-container">
                <canvas id="categoryChart"></canvas>
            </div>

        </div>

    </section>

    <!-- Top Products -->
    <section class="overview-grid">

        <!-- Top Products -->
        <div class="dashboard-card">

            <div class="card-header">
                <h3>Top Selling Products</h3>
            </div>

            <div class="chart-container">
                <canvas id="productChart"></canvas>
            </div>

        </div>

    </section>

</section>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

//     Monthly Revenue
    new Chart(document.getElementById("revenueChart"), {
        type: "line",
        data: {
            labels: ${monthlyLabels},
            datasets: [{
                    label: "Revenue",
                    data: ${monthlyRevenue},
                    fill: true,
                    tension: .4,
                    borderWidth: 3
                }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {beginAtZero: true}
            }
        }

    });


//     Order Status
    new Chart(document.getElementById("statusChart"), {
        type: "pie",
        data: {
            labels: ["Pending", "Processing", "Delivered", "Cancelled"],
            datasets: [{
                    data: [${pendingOrders}, ${processingOrders}, ${completedOrders}, ${cancelledOrders}]
                }]
        },

        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: "bottom"
                }
            }
        }
        
    });

//     Category Sales
    new Chart(document.getElementById("categoryChart"), {
        type: "bar",
        data: {
            labels: ${categoryLabels},
            datasets: [{label: "Products Sold", data: ${categorySales}, borderWidth: 1}]
        },

        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }

    });

//     Top Products
    new Chart(document.getElementById("productChart"), {
        type: "bar",
        data: {
            labels: ${topProductLabels},
            datasets: [{label: "Units Sold", data: ${topProductSales}, borderWidth: 1}]
        },

        options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: "y",
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                x: {
                    beginAtZero: true
                }
            }
        }

    });
</script>
<style>
    /*OVERVIEW PAGE*/
    .overview-grid{
        display:grid;
        grid-template-columns:2fr 1fr;
        gap:24px;
        align-items:stretch;
    }

    .overview-grid .dashboard-card{
        display:flex;
        flex-direction:column;
    }

    /*KPI CARDS*/
    .stats-grid{
        display:grid;
        grid-template-columns:repeat(4,1fr);
        gap:20px;
    }

    .stat-card{
        background:#fff;
        border:1px solid var(--color-border);
        border-radius:20px;
        padding:22px;
        transition:.25s;
    }

    .stat-card:hover{
        transform:translateY(-4px);
        box-shadow:0 10px 28px rgba(0,0,0,.06);
    }

    .stat-card h4{
        font-size:15px;
        color:#777;
        margin-bottom:12px;
    }

    .stat-card span{
        display:block;
        font-size:32px;
        font-weight:700;
        color:var(--color-primary);
    }


    /*CHARTS*/
    .chart-container{
        position:relative;
        width:100%;
        height:300px;
    }

    .chart-container canvas{
        width:100% !important;
        height:100% !important;
    }

    .pie-container{
        position:relative;
        width:100%;
        height:300px;

        display:flex;
        justify-content:center;
        align-items:center;
    }

    .pie-container canvas{
        max-width:260px !important;
        max-height:260px !important;
    }

    /*TABLE*/
    .dashboard-table{
        width:100%;
        border-collapse:collapse;
    }

    .dashboard-table th{
        padding:14px;
        background:#f8f8f8;
        text-align:left;
        font-size:15px;
        font-weight:600;
    }

    .dashboard-table td{
        padding:14px;
        border-top:1px solid var(--color-border);
    }

    .dashboard-table tr:hover{
        background:#fafafa;
    }

    /*STATUS BADGES*/
    .status{
        padding:7px 14px;
        border-radius:30px;
        font-size:13px;
        font-weight:700;
    }

    .pending{
        background:#fff4d8;
        color:#b8860b;
    }

    .processing{
        background:#dfeeff;
        color:#2d7be5;
    }

    .delivered{
        background:#def7e7;
        color:#2b8c57;
    }

    .cancelled{
        background:#ffe5e5;
        color:#d84b4b;
    }

    /*QUICK ACTIONS*/
    .quick-actions{
        display:flex;
        flex-direction:column;
        gap:16px;
        margin-top:10px;
    }

    .action-btn{
        display:block;
        padding:15px;
        text-decoration:none;
        border-radius:14px;
        background:#fafafa;
        border:1px solid var(--color-border);
        color:var(--color-dark);
        font-weight:600;
        transition:.25s;
    }

    .action-btn:hover{
        background:var(--color-primary);
        border-color:var(--color-primary);
        color:#fff;
    }

    /*CARD HEADER*/
    .card-header{
        margin-bottom:18px;
    }

    .card-header h3{
        font-size:22px;
        color:var(--color-dark);
    }
    
    /*RESPONSIVE*/
    @media(max-width:1200px){
        .stats-grid{
            grid-template-columns:repeat(2,1fr);
        }
        .overview-grid{
            grid-template-columns:1fr;
        }
    }

    @media(max-width:768px){
        .stats-grid{
            grid-template-columns:1fr;
        }
        .dashboard-table{
            display:block;
            overflow-x:auto;
        }

        .chart-container{
            height:260px;
        }

        .pie-container{
            height:260px;
        }
    }

    @media(max-width:480px){
        .stat-card span{
            font-size:26px;
        }
        .dashboard-card{
            padding:18px;
        }
    }
</style>