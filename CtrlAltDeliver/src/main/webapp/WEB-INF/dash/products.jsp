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
            <h2>Manage Products</h2>
            <p>${errormessage}</p>
        </div>

        <a href="admin?page=addproduct" class="secondary-btn">
            + Add Product
        </a>
    </div>

    <p value="${error}"></p>

    <!-- Filters -->

    <form class="filter-bar" method="get" action="admin">

        <input type="hidden" name="page" value="products">

        <input
            type="text"
            name="search"
            placeholder="Search product..."
            value="${param.search}"
            class="search-input">

        <select name="category" class="filter-select">

            <option value="">All Categories</option>

            <c:forEach items="${categories}" var="category">

                <option value="${category.categoryId}"
                        ${param.category == category.categoryId ? 'selected' : ''}>
                    ${category.categoryName}
                </option>

            </c:forEach>

        </select>

        <button class="search-clear">
            Search
        </button>
        
        <a href="admin?page=products"
           class="search-clear">
            Clear
        </a>

    </form>

    <!-- Product Table -->

    <div class="table-container">

        <table class="dashboard-table" >

            <thead>
                <tr>
                    <th>Image</th>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Brand</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody style="overflow-y: auto; max-height: 87dvh;">

            <c:forEach items="${products}" var="product">
                    
                <tr>
                

                    <td>
                        <img class="table-image" src="${pageContext.request.contextPath}/${product.imagePath}" alt="${product.name}">
                    </td>

                    <td>${product.name}</td>

                    <td>${product.categoryName}</td>

                    <td>${product.brand}</td>

                    <td>
                        Rs.
                        ${product.price}
                    </td>

                    <td>
                        <span class="${product.stockQuantity <= 5 ? 'stock-low' : 'stock-good'}">
                            ${product.stockQuantity}
                        </span>
                    </td>

                    <td>
                        <div class="action-group">

                            <a href="${pageContext.request.contextPath}/admin?page=editProduct&id=${product.productId}"  
                               class="edit-btn" 
                               style="text-decoration: none; cursor: pointer;" >Edit</a>

                            <form action="${pageContext.request.contextPath}/admin" method="post">
                                <!--${product.productId}-->
                                <input type="hidden" name="productId" value="${product.productId}" />
                                <!--                                    <button class="edit-btn" type="submit" name="action" value="editItem" 
                                                                            style="text-decoration: none; cursor: pointer;" >Edit</button>-->
                                <button class="delete-btn" type="submit" name="action" value="removeItem" 
                                        style="text-decoration: none; cursor: pointer;" >Delete</button>
                            </form>

                        </div>

                    </td>

                </tr>

            </c:forEach>
                
            <h2 style="text-align: center; color: red; padding-bottom: 15px;">${emptymessage}</h2>

            </tbody>

        </table>

    </div>

</section>