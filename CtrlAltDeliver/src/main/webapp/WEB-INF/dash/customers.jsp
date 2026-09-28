<%-- 
    Document   : customers
    Created on : Jul 26, 2026, 11:01:14 AM
    Author     : Pranish
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section class="dashboard-section">

    <div class="page-header">
        <div>
            <h2>Manage Customers</h2>
            <p>${errormessage}</p>
        </div>
    </div>

    <p value="${error}"></p>

    <!-- Filters -->

    <form class="filter-bar" method="get" action="admin">

        <input type="hidden" name="page" value="customers">

        <input
            type="text"
            name="search"
            placeholder="Search by customer name or email..."
            value="${param.search}"
            class="search-input">

        <button class="search-clear">
            Search
        </button>

        <a href="admin?page=customers"
           class="search-clear">
            Clear
        </a>

    </form>

    <!-- Customer Table -->

    <div class="table-container">

        <table class="dashboard-table" >

            <thead>
                <tr>
                    <th>Customer</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Role</th>
                    <th>Total Orders</th>
                    <th>Joined</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach items="${customers}" var="customer">

                    <tr>

                        <td> <strong>${customer.fullName}</strong> </td>
                        <td>${customer.email}</td>
                        <td>${customer.phone}</td>
                        <td>${customer.role}</td>
                        <td>${customer.totalOrders}</td>
                        <td><fmt:formatDate value="${customer.createdAt}" pattern="dd MMM yyyy"/> </td>
                        <td>
                            <div class="action-group">
                                
                                <a href="admin?page=viewcustomer&id=${customer.userId}"
                                   class="edit-btn">
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