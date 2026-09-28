<%-- 
    Document   : producrview
    Created on : May 19, 2026, 2:21:46 AM
    Author     : Pranish
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <!--head via template-->
    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | ${pageTitle}"/>
        <jsp:param name="cssFile" value="productview"/>
    </jsp:include>

    <body>

        <!--header via template-->
        <jsp:include page="/templates/nav.jsp">
            <jsp:param name="one" value="Browse"/>
            <jsp:param name="onehref" value="products"/>

            <jsp:param name="two" value="My Cart"/>
            <jsp:param name="twohref" value="cart"/>

            <jsp:param name="three" value="About Us"/>
            <jsp:param name="threehref" value="aboutus"/>

            <jsp:param name="four" value="${not empty user ? 'My Profile' : 'Log In'}"/>
            <jsp:param name="fourhref" value="${not empty user ? 'userdashboard' : 'login'}" />
        </jsp:include>

        <div class="breadcrumb">
            <a href="home">Home</a>
            <span class="category">/</span>
            <a href="#">${category.categoryName}</a>
            <span class="product">/</span>
            <span>${product.name}</span>
        </div>

        <main class="product-page" style='display : "flex"}'>

            <!-- Left Side-->
            <div class="image-wrapper">

                <div class="image-main" id="mainImage">
                    <span class="badge-new" style='display: ${not empty product.tag ? "block" : "none"}'>${product.tag}</span>

                    <span class="badge-sale" style='display: ${empty product.discountPercent ? "block" : "none"}'>${product.discountPercent}</span>


                    <div class="image-placeholder">
                        <img src='${product.imagePath}' alt='${product.name}'/>
                    </div>
                </div>

                <!-- Thumbnails -->
                <div class="thumbnail-row" role="list">
                    <c:forEach var="image" items="${productImages}">
                        <div style="display: 'flex'" class="thumb active" role="listitem">
                            <img src="${image.imagePath}" alt="${product.name}" />
                        </div>
                    </c:forEach>
                </div>

            </div>

            <!-- ── Right -->
            <div class="product-info">

                <span class="brand-label">${product.brand}</span>
                <h1 class="product-name">${product.name}</h1>
                <div class="price-row">
                        <span class="price-current">Rs.
                            <fmt:formatNumber value="${product.effectivePrice}" 
                                              type="number" 
                                              minFractionDigits="2" 
                                              maxFractionDigits="2"/>
                        </span>
                    <c:if test="${product.discountPercent > 0}">
                        <span class="price-old">Rs.
                            <fmt:formatNumber value="${product.price}" 
                                              type="number" 
                                              minFractionDigits="2" 
                                              maxFractionDigits="2"/>
                        </span>
                        <span class="price-tag">Save ${product.discountPercent}%</span>
                    </c:if>
                </div>

                <div class="stock-row">
                    <span class="stock-dot"></span>
                    <span class="stock-text">
                        <strong>${product.stockQuantity} left</strong> -- in stock
                    </span>
                </div>

                <div class="field-group">
                    <label class="field-label">Description</label>
                    <p class="product-desc">${product.description}</p>
                </div>
                
                <form action="${pageContext.request.contextPath}/product?id=${product.productId}" method="post">
                    <input type="hidden" 
                           name="productId" 
                           value="${product.productId}">

                    <input type="hidden" 
                           name="action" 
                           value="addToCartBtn">
                    <button type="submit" class="filter-btn" ${product.stockQuantity == 0 ? 'disabled' : ''}>Add To Cart</button>
                    <!--<p>${empty cartmessage ? "Item_Added_To_Cart!" : cartmessage }</p>-->
                    <p style="padding-top: 20px; color: green; opacity: 0.5; font-weight: 500;">${empty cookie.cartmessage.value ? "" : cookie.cartmessage.value}</p>
                </form>

<!--                <div>
                    <button class="filter-btn " type="button">
                        Add to Cart
                    </button>
                </div>-->

            </div>
        </main>
        <jsp:include page="/templates/footer.jsp" />
    </body>
</html>