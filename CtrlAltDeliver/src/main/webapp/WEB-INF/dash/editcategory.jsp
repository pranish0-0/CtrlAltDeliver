<%-- 
    Document   : editcategory
    Created on : Jul 31, 2026
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<section class="dashboard-section">

    <!-- Page Header -->

    <div class="page-header">

        <div>
            <h2>Edit Category</h2>
            <p>${error}</p>
        </div>

        <a href="admin?page=categories" class="secondary-btn">
            ← Back to Categories
        </a>

    </div>


    <!-- Edit Form -->

    <div class="form-card">

        <form action="admin" method="post" class="product-form">

            <input type="hidden" name="action" value="updatecategory">
            <input type="hidden" name="categoryId" value="${category.categoryId}">

            <div class="img-container"
                 style="height:auto; margin:0 auto;">

                <img
                    src="${pageContext.request.contextPath}/${category.image}"
                    alt="${category.categoryName}"
                    style="
                    width:20dvw;
                    height:30dvh;
                    padding:15px 0;
                    max-width:90%;
                    max-height:90%;
                    object-fit:contain;
                    border:2px solid var(--color-border);
                    border-radius:5%;
                    box-shadow:0 14px 30px rgba(0,0,0,.08);
                    ">

            </div>

            <div class="form-grid">

                <!-- Category Name -->
                <div class="form-group">

                    <label>Category Name</label>

                    <input
                        type="text"
                        name="categoryName"
                        placeholder="Enter category name"
                        value="${category.categoryName}"
                        required>

                </div>

            </div>


            <!-- Description -->

            <div class="form-group full-width">

                <label>Description</label>

                <textarea
                    name="description"
                    rows="8"
                    placeholder="Enter category description..."
                    required>${category.description}</textarea>

            </div>


            <!-- Form Actions -->

            <div class="form-actions">

                <button type="submit" class="primary-btn">
                    Update Category
                </button>

                <a href="admin?page=categories" class="secondary-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</section>