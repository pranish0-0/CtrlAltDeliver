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
            <h2>Edit Product</h2>
            <p value="${error}"></p>
        </div>


        <a href="admin?page=products" class="secondary-btn">
            ← Back to Products
        </a>
    </div>

    <div class="form-card">

        <form action="admin" method="post" class="product-form">

            <input type="hidden" name="action" value="updateproduct">
            <input type="hidden" name="productId" value="${product.productId}">

            <div class="img-container" style="
                 height: auto;
                 margin: 0 auto;
                 ">
                <img
                    src="${pageContext.request.contextPath}/${product.imagePath}"
                    alt="${product.name}"
                    style="
                    width: 20dvw;
                    height: 30dvh;
                    padding: 15px 0;
                    max-width: 90%;
                    max-height: 90%;
                    object-fit: contain;
                    border: 2px solid var(--color-border);
                    border-radius: 5%;
                    box-shadow: 0 14px 30px rgba(0,0,0,0.08);
                    ">
            </div>


            <div class="form-grid">


                <!-- Product Name -->
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text"
                           name="productName"
                           placeholder="Enter product name"
                           value="${product.name}"
                           required>
                </div>

                <!-- Brand -->
                <div class="form-group">
                    <label>Brand</label>
                    <input type="text"
                           name="brand"
                           placeholder="Enter brand"
                           value="${product.brand}"
                           required>
                </div>

                <!-- Category -->
                <div class="form-group">
                    <label>Category</label>

                    <select name="categoryId" required>

                        <option value="">Select Category</option>

                        <c:forEach items="${categories}" var="category">

                            <option value="${category.categoryId}"
                                    ${category.categoryId == product.categoryId ? 'selected' : ''}>
                                ${category.categoryName}
                            </option>

                        </c:forEach>

                    </select>

                </div>

                <!-- Price -->
                <div class="form-group">
                    <label>Price</label>
                    <input type="number"
                           min="0"
                           name="price"
                           value="${product.price}"
                           required>
                </div>


                <!-- Discount -->
                <div class="form-group">
                    <label>Discount (%)</label>
                    <input type="number"
                           name="discount"
                           min="0"
                           max="100"
                           step="1"
                           value="${product.discountPercent}">
                </div>

                <!-- Stock -->
                <div class="form-group">
                    <label>Stock Quantity</label>
                    <input type="number"
                           min="0"
                           name="stockQuantity"
                           value="${product.stockQuantity}"
                           required>
                </div>

                <!-- Tag -->
                <div class="form-group">
                    <label>Tag</label>

                    <select name="tag">
                        <option value="" ${empty product.tag ? 'selected' : ''}>No Tag</option>

                        <option value="NEW"
                                ${product.tag == 'NEW' ? 'selected' : ''}>
                            NEW
                        </option>

                        <option value="BESTSELLER"
                                ${product.tag == 'BESTSELLER' ? 'selected' : ''}>
                            BESTSELLER
                        </option>

                        <option value="LIMITED"
                                ${product.tag == 'LIMITED' ? 'selected' : ''}>
                            LIMITED
                        </option>

                        <option value="DISCOUNT"
                                ${product.tag == 'DISCOUNT' ? 'selected' : ''}>
                            DISCOUNT
                        </option>
                    </select>
                </div>

            </div>

            <!-- Description -->

            <div class="form-group full-width">

                <label>Description</label>

                <textarea
                    name="description"
                    rows="8"
                    placeholder="Write product description..."
                    required>${product.description}</textarea>

            </div>

            <div class="form-actions">

                <button type="submit" class="primary-btn">
                    Update Product
                </button>

                <a href="admin?page=products" class="secondary-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</section>