<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | Admin Dashboard"/>
        <jsp:param name="cssFile" value="admindash"/>
    </jsp:include>

    <body>

        <header class="header">
            <div class="logo">
                <a href="home" style="text-decoration: none">
                    <img src="${pageContext.request.contextPath}/resources/logo.png" width="150" alt="Logo" />
                </a>
            </div>

            <!--navbar-->
            <nav class="navbar">
                <ul class="nav-links">
                    <li class="admin-name">
                        <span>${user.fullName}</span>
                    </li>

                    <li>
                        <a href="logout" class="header-btn logout-header">Logout</a>
                    </li>
                </ul>
            </nav>
        </header>


        <main class="dashboard-wrapper">

            <!-- Sidebar -->

            <aside class="dashboard-sidebar">

                <div class="sidebar-menu">

                    <a href="admin?page=dashboard"
                       class="sidebar-btn ${page == null || page == 'dashboard' ? 'active' : ''}">
                        Dashboard
                    </a>

                    <a href="admin?page=products"
                       class="sidebar-btn ${page == 'products' ? 'active' : ''}">
                        Products
                    </a>

                    <a href="admin?page=categories"
                       class="sidebar-btn ${page == 'categories' ? 'active' : ''}">
                        Categories
                    </a>

                    <a href="admin?page=orders"
                       class="sidebar-btn ${page == 'orders' ? 'active' : ''}">
                        Orders
                    </a>

                    <a href="admin?page=customers"
                       class="sidebar-btn ${page == 'customers' ? 'active' : ''}">
                        Customers
                    </a>

                    <a href="admin?page=reports"
                       class="sidebar-btn ${page == 'reports' ? 'active' : ''}">
                        Reports
                    </a>

                    <a href="logout" class="sidebar-btn logout-btn">
                        Logout
                    </a>

                </div>

            </aside>


            <!-- Main Content -->

            <section class="dashboard-content">

                <c:choose>

                    <c:when test="${page == null || page == 'dashboard'}">
                        <jsp:include page="./dash/overview.jsp"/>
                    </c:when>

                    <c:when test="${page == 'products'}">
                        <jsp:include page="./dash/products.jsp"/>
                    </c:when>
                    
                    <c:when test="${page == 'addproduct'}">
                        <jsp:include page="./dash/addproduct.jsp"/>
                    </c:when>
                    
                    <c:when test="${page == 'editProduct'}">
                        <jsp:include page="./dash/editproduct.jsp"/>
                    </c:when>

                    <c:when test="${page == 'categories'}">
                        <jsp:include page="./dash/categories.jsp"/>
                    </c:when>
                    
                    <c:when test="${page == 'addcategory'}">
                        <jsp:include page="./dash/addcategory.jsp"/>
                    </c:when>
                    
                    <c:when test="${page == 'editCategory'}">
                        <jsp:include page="./dash/editcategory.jsp"/>
                    </c:when>

                    <c:when test="${page == 'orders'}">
                        <jsp:include page="./dash/orders.jsp"/>
                    </c:when>

                    <c:when test="${page == 'vieworder'}">
                        <jsp:include page="./dash/vieworder.jsp"/>
                    </c:when>

                    <c:when test="${page == 'customers'}">
                        <jsp:include page="./dash/customers.jsp"/>
                    </c:when>

                    <c:when test="${page == 'viewcustomer'}">
                        <jsp:include page="./dash/viewcustomer.jsp"/>
                    </c:when>

                    <c:when test="${page == 'reports'}">
                        <jsp:include page="./dash/reports.jsp"/>
                    </c:when>

                    <c:when test="${page == 'settings'}">
                        <jsp:include page="./dash/settings.jsp"/>
                    </c:when>

                </c:choose>

            </section>

        </main>

        <jsp:include page="/templates/footer.jsp"/>

    </body>

</html>