<%-- 
    Document   : products
    Created on : May 20, 2026, 10:20:49 AM
    Author     : Pranish
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">
    <!--head via template-->
    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | ${pageTitle}"/>
        <jsp:param name="cssFile" value="products"/>
    </jsp:include>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css">

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

        <div class="page-wrapper">

            <%-- Page header --%>
            <div class="page-header">
                <h1 class="page-title">All Products</h1>
                <p class="page-subtitle">
                    Showing ${((currentPage - 1) * 12) + 1} - ${((currentPage - 1) * 12) + products.size()} of ${totalCount} products
                </p>
            </div>

            <div class="toolbar" style="">
                <form method="get" action="${pageContext.request.contextPath}/products" class="filter-label">

                    <div style="margin-bottom: 10px; width: 100%">
                        <input class="search-input" type="search" placeholder="Search" name="search" value="${search}" />

                        <select name="sort" class="sort-select">
                            <option value="name">A-Z</option>
                            <option value="price-asc">Low to High</option>
                            <option value="price-desc">High to Low</option>
                        </select>
                    </div>

                    <div>

                        <select name="brand" class="filter-select">
                            <option value="">All Brands</option>
                            <c:forEach var="b" items="${brands}">
                                <option value="${b}" ${b == brand ? 'selected' : ''}>
                                    ${b}
                                </option>
                            </c:forEach>
                        </select>

                        <select name="category" class="filter-select">
                            <option value="">All Categories</option>
                            <c:forEach var="c" items="${categories}">
                                <option value="${c}" ${c == category ? 'selected' : ''}>
                                    ${c}
                                </option>
                            </c:forEach>
                        </select>


                        <button class="search-clear" type="submit">Apply</button>
                        <a class="search-clear" href='${pageContext.request.contextPath}/products'>Clear</a>
                    </div>

                </form>
            </div>

            <div class="product-grid" >
                

                <c:forEach var="p" items="${products}">

                    <%-- Pre-compute values needed for rendering --%>
                    <c:set var="discountedPrice"
                           value="${p.discountPercent > 0
                                    ? p.price * (1 - p.discountPercent / 100)
                                    : p.price}"/>

                    <div class="product-card ${p.inStock ? '' : 'out-of-stock'}">

                        <%-- Card image area --%>
                        <div class="card-image">

                            <%-- Badge — only when a tag exists --%>
                            <c:if test="${not empty p.tag}">
                                <c:choose>
                                    <c:when test="${p.tag eq 'DISCOUNT'}">
                                        <span class="card-badge badge-sale">Sale</span>
                                    </c:when>
                                    <c:when test="${p.tag eq 'NEW'}">
                                        <span class="card-badge badge-new">New</span>
                                    </c:when>
                                    <c:when test="${p.tag eq 'BESTSELLER'}">
                                        <span class="card-badge badge-hot">Hot</span>
                                    </c:when>
                                    <c:when test="${p.tag eq 'LIMITED'}">
                                        <span class="card-badge badge-limited">Limited</span>
                                    </c:when>
                                </c:choose>
                            </c:if>

                            <c:if test="${not p.inStock}">
                                <span class="card-badge badge-oos">Out of Stock</span>
                            </c:if>

                            <c:choose>
                                <c:when test="${not empty p.imagePath}">
                                    <a style="text-decoration: none" href="${pageContext.request.contextPath}/product?id=${p.productId}">
                                        <img class="card-img"
                                         src="${p.imagePath}"
                                         alt="${p.name}"
                                         loading="lazy"/>
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="card-img-placeholder">
                                        <span>IMG</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="card-body">
                            <a style="text-decoration: none" href="${pageContext.request.contextPath}/product?id=${p.productId}">
                                <span class="card-brand"><c:out value="${p.brand}"/></span>
                                <h3 class="card-name"><c:out value="${p.name}"/></h3>

                                <c:if test="${not empty p.categoryName}">
                                    <span class="card-category">
                                        <c:out value="${p.categoryName}"/>
                                    </span>
                                </c:if>
                            </a>
                        </div>

                        <div class="card-footer">
                            <div class="card-price-group">
                                <span class="card-price">
                                    <fmt:formatNumber value="${discountedPrice}"
                                                      type="currency"
                                                      currencySymbol="Rs. "
                                                      maxFractionDigits="0"/>
                                </span>
                                <c:if test="${p.discountPercent > 0}">
                                    <span class="card-price-old">
                                        <fmt:formatNumber value="${p.price}"
                                                          type="currency"
                                                          currencySymbol="Rs. "
                                                          maxFractionDigits="0"/>
                                    </span>
                                    <span class="card-discount-pct">
                                        -<fmt:formatNumber value="${p.discountPercent}"
                                                          maxFractionDigits="0"/>%
                                    </span>
                                </c:if>
                            </div>
                                
                            <form action="${pageContext.request.contextPath}/products" method="post">
                                <input type="hidden" 
                                       name="productId" 
                                       value="${p.productId}">

                                <input type="hidden" 
                                       name="action" 
                                       value="addToCartBtn">
                                <button type="submit" class="btn-add-cart">Add To Cart</button>
                            </form>
                            
                        </div>

                    </div>
                </c:forEach>

                <%-- Empty state --%>
                <div class="empty-state"  style="display: ${products.size() > 0 ? 'none' : 'block'};">
                    <h3>No products found</h3>
                    <p>Try adjusting your search or filters.</p>
                    <button class="search-clear"><a href='${pageContext.request.contextPath}/products' style="text-decoration: none; color:grey;">Clear filters</a></button>
                </div>

            </div>

            <div class="pagination">

                <%-- Previous --%>
                <form method="get" action="${pageContext.request.contextPath}/products" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage - 1}" />
                    <input type="hidden" name="search" value="${search}" />
                    <input type="hidden" name="brand" value="${brand}" />
                    <input type="hidden" name="category" value="${category}" />
                    <input type="hidden" name="sort" value="${sort}" />

                    <button class="page-btn arrow"
                            ${currentPage <= 1 ? 'disabled' : ''}>
                        ‹
                    </button>
                </form>

                <%-- Page numbers --%>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <form method="get" action="${pageContext.request.contextPath}/products" style="display:inline;">

                        <input type="hidden" name="page" value="${i}" />
                        <input type="hidden" name="search" value="${search}" />
                        <input type="hidden" name="brand" value="${brand}" />
                        <input type="hidden" name="category" value="${category}" />
                        <input type="hidden" name="sort" value="${sort}" />

                        <button class="page-btn ${i == currentPage ? 'active' : ''}">
                            ${i}
                        </button>
                    </form>
                </c:forEach>

                <%-- Next --%>
                <form method="get" action="${pageContext.request.contextPath}/products" style="display:inline;">
                    <input type="hidden" name="page" value="${currentPage + 1}" />
                    <input type="hidden" name="search" value="${search}" />
                    <input type="hidden" name="brand" value="${brand}" />
                    <input type="hidden" name="category" value="${category}" />
                    <input type="hidden" name="sort" value="${sort}" />

                    <button class="page-btn arrow"
                            ${currentPage >= totalPages ? 'disabled' : ''}>
                        ›
                    </button>
                </form>

            </div>

        </div>

        <jsp:include page="/templates/footer.jsp"/>

    </body>
</html>