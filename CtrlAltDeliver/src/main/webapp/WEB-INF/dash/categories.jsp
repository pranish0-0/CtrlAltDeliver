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
            <h2>Manage Categories</h2>
            <p>${errormessage}</p>
        </div>

        <a href="admin?page=addcategory" class="secondary-btn">
            + Add Category
        </a>
    </div>
    
    <p value="${error}"></p>

    <!-- Filters -->

    <form class="filter-bar" method="get" action="admin">

        <input type="hidden" name="page" value="categories">

        <input
            type="text"
            name="search"
            placeholder="Search category..."
            value="${param.search}"
            class="search-input">

        <button class="search-clear">
            Search
        </button>
        
        <a href="admin?page=categories"
           class="search-clear">
            Clear
        </a>

    </form>

    <!-- Category Table -->

    <div class="table-container">

        <table class="dashboard-table" >

            <thead>
                <tr>
                    <th>Image</th>
                    <th>Category</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>
            </thead>

            <tbody style="overflow-y: auto; max-height: 87dvh;">

                <c:forEach items="${categories}" var="category">

                    <tr>

                        <td>
                            <img class="table-image" src="${pageContext.request.contextPath}/${category.image}" alt="${category.categoryName}">
                        </td>

                        <td>${category.categoryName}</td>
                        <td>${category.description}</td>

                        <td>
                            <div class="action-group">

                                <a href="${pageContext.request.contextPath}/admin?page=editCategory&id=${category.categoryId}"  
                                   class="edit-btn" 
                                   style="text-decoration: none; cursor: pointer;" >Edit</a>
                                            
                                <form action="${pageContext.request.contextPath}/admin" method="post">
                                    <!--${category.categoryId}-->
                                    <input type="hidden" name="categoryId" value="${category.categoryId}" />
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