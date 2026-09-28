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
            <h2>Add New Product</h2>
            <p>Create a new product for your store.</p>
            <p value="${error}"></p>
        </div>


        <a href="admin?page=products" class="secondary-btn">
            ← Back to Products
        </a>
    </div>

    <div class="form-card">

        <form action="admin" method="post" enctype="multipart/form-data" class="product-form">

            <input type="hidden" name="action" value="addproduct">

            <div class="form-grid">

                <!-- Product Name -->
                <div class="form-group">
                    <label>Product Name</label>
                    <input type="text"
                           name="productName"
                           placeholder="Enter product name"
                           required>
                </div>

                <!-- Brand -->
                <div class="form-group">
                    <label>Brand</label>
                    <input type="text"
                           name="brand"
                           placeholder="Enter brand"
                           required>
                </div>

                <!-- Category -->
                <div class="form-group">
                    <label>Category</label>

                    <select name="categoryId" required>

                        <option value="">Select Category</option>

                        <c:forEach items="${categories}" var="category">

                            <option value="${category.categoryId}">
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
                           value="0">
                </div>

                <!-- Stock -->
                <div class="form-group">
                    <label>Stock Quantity</label>
                    <input type="number"
                           min="0"
                           name="stockQuantity"
                           required>
                </div>

                <!-- Image -->
                <div class="form-group">
                    <label>Product Image</label>
                    <input type="file"
                           name="image"
                           accept="image/*"
                           required>
                </div>

                <!-- Tag -->
                <div class="form-group">
                    <label>Tag</label>

                    <select name="tag">
                        <option value="">No Tag</option>
                        <option value="NEW">NEW</option>
                        <option value="BESTSELLER">BESTSELLER</option>
                        <option value="LIMITED">LIMITED</option>
                        <option value="DISCOUNT">DISCOUNT</option>
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
                    required></textarea>

            </div>

            <div class="form-actions">

                <button type="submit" class="primary-btn">
                    Add Product
                </button>

                <a href="admin?page=products" class="secondary-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</section>