<%-- 
    Document   : home
    Created on : May 17, 2026, 12:35:34 PM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

    <!--head via template-->
    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | Home"/>
        <jsp:param name="cssFile" value="home"/>
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


        <!-- Greeting SECTION -->
        <section class="greeting" style='display: ${not empty user ? "block" : "none"}'>
            <div class="container">
                <p class="subtitle">
                    Welcome back,
                </p>
                <h1 class="title"><i>
                        <span style="color: var(--color-primary);">${sessionScope.user.fullName}</span>
                    </i>
                </h1>
            </div>
        </section>

        <!--HERO SLIDER--> 
        <section class="hero">
            <div class="slideshow-container">

                <!-- Full-width images with number and caption text -->
                <div class="mySlides fade">
                    <a href="#">
                        <img src="${pageContext.request.contextPath}/resources/slider/one.png" style="width:100%">
                    </a>
                </div>

                <div class="mySlides fade">
                    <a href="#">
                        <img src="${pageContext.request.contextPath}/resources/slider/two.png" style="width:100%">
                    </a>
                </div>

                <div class="mySlides fade">
                    <a href="#">
                        <img src="${pageContext.request.contextPath}/resources/newsletter.jpeg" style="width:100%">
                    </a>
                </div>

                <!-- Next and previous buttons -->
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
            <br>

            <!-- The dots/circles -->
            <div style="text-align:center">
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
            </div>
        </section><!-- /hero-section -->

        <!--Featured Section-->
        <section class="featured">
            <h1>Featured Products</h1>
            <h3><span>Check Out What's Trending Now</span></h3>

            <div class="featured_options">
                <a href="${pageContext.request.contextPath}/home?action=bestseller" class="filter-btn ${param.action == 'bestseller' ? 'active' : ''}">Best Seller</a>
                <a href="${pageContext.request.contextPath}/home?action=new" class="filter-btn ${param.action == 'new' ? 'active' : ''}">New Arrivals</a>
                <a href="${pageContext.request.contextPath}/home?action=discount" class="filter-btn ${param.action == 'discount' ? 'active' : ''}">Discounted</a>
                <a href="${pageContext.request.contextPath}/home?action=limited" class="filter-btn ${param.action == 'limited' ? 'active' : ''}">Limited</a>
            </div>

            <div class="ProductsContainer">
                <div style="display: flex">
                    <c:forEach var="product" items="${products}">
                        <div class="productCard">
                            <!-- Product Image -->
                            <a 
                                style="text-decoration: none; color: black" 
                                href="${pageContext.request.contextPath}/product?id=${product.productId}">
                                <div class="productImage" >
                                    <img src="${product.imagePath}" alt="${product.name}">
                                </div>
                            </a>

                            <!-- Product Info -->
                            <div class="product-info">
                                <p class="product-brand" style="color: var(--color-dark); margin-bottom: 0;">${product.brand}</p>

                                <a 
                                    style="text-decoration: none; color: black" 
                                    href="${pageContext.request.contextPath}/product?id=${product.productId}">
                                    <h2 class="product-name">${product.name}</h2>
                                    <!--<p class="product-description">${product.description}</p>-->
                                </a>

                                <div class="product-bottom">

                                    <c:choose>
                                        <c:when test="${product.discountPercent > 0}">
                                            <div class="product-price">
                                                <s> Rs.
                                                    <fmt:formatNumber value="${product.price}" 
                                                                      type="number" 
                                                                      minFractionDigits="2" 
                                                                      maxFractionDigits="2"/>
                                                </s>
                                            </div>
                                            <div class="product-price" style="font-size:20px;font-weight: 800; color: var(--color-primary); padding-top: 22px;">Rs.
                                                <fmt:formatNumber value="${product.effectivePrice}" 
                                                                  type="number" 
                                                                  minFractionDigits="2" 
                                                                  maxFractionDigits="2"/>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="product-price" style="font-size:20px;font-weight: 800; color: var(--color-primary); padding: 22px">
                                                Rs.
                                                <fmt:formatNumber value="${product.price}" 
                                                                  type="number" 
                                                                  minFractionDigits="2" 
                                                                  maxFractionDigits="2"/>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <form action="${pageContext.request.contextPath}/home" method="post">
                                        <input type="hidden" 
                                               name="productId" 
                                               value="${product.productId}">

                                        <input type="hidden" 
                                               name="action" 
                                               value="addToCartBtn">
                                        <button type="submit" class="addToCartBtn" ${product.stockQuantity == 0 ? 'disabled' : ''}>Add To Cart</button>
                                        
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
        <br/>
        <br/>
        <!--Categories-->
        <section class="featured" >
            <h1>Categories</h1>
            <h3><span>Browse by Category</span></h3>
            <div>
                <div class="CategoryContainer">
                    <c:forEach var="category" items="${categories}">
                        <!--<span style="display: none"> ${category.categoryId}</span>-->
                        <a href="${pageContext.request.contextPath}/products?categoryId=${category.categoryId}" style="text-decoration: none; color: black;">
                            <div class="productCard">
                                <!-- Product Image -->
                                <div class="productImage" style="border-radius: 50% 50%;">
                                    <img src="${category.image}" alt="${category.categoryName}">
                                </div>

                                <!-- Product Info -->
                                <div class="product-info" style="text-align: center">
                                    <h2 class="product-name">${category.categoryName}</h2>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </section>

        <jsp:include page="/templates/footer.jsp" />
    </body>
    <script>
        let slideIndex = 1;
        showSlides(slideIndex);

        // Next/previous controls
        function plusSlides(n) {
            showSlides(slideIndex += n);
        }

        // Thumbnail image controls
        function currentSlide(n) {
            showSlides(slideIndex = n);
        }

        function showSlides(n) {
            let i;
            let slides = document.getElementsByClassName("mySlides");
            let dots = document.getElementsByClassName("dot");
            if (n > slides.length) {
                slideIndex = 1;
            }
            if (n < 1) {
                slideIndex = slides.length;
            }
            for (i = 0; i < slides.length; i++) {
                slides[i].style.display = "none";
            }
            for (i = 0; i < dots.length; i++) {
                dots[i].className = dots[i].className.replace(" dactive", "");
            }
            slides[slideIndex - 1].style.display = "block";
            dots[slideIndex - 1].className += " dactive";
        }
    </script>
</html>