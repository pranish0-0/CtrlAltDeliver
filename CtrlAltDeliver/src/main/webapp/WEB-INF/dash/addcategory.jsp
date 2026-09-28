<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<section class="dashboard-section">

    <div class="page-header">

        <div>
            <h2>Add New Category</h2>
            <p>Create a new product category.</p>
            <p>${error}</p>
        </div>

        <a href="admin?page=categories" class="secondary-btn">
            ← Back to Categories
        </a>

    </div>

    <div class="form-card">

        <form action="admin"
              method="post"
              enctype="multipart/form-data"
              class="product-form">

            <input type="hidden"
                   name="action"
                   value="addcategory">

            <div class="form-grid">

                <!-- Category Name -->

                <div class="form-group">

                    <label>Category Name</label>

                    <input
                        type="text"
                        name="categoryName"
                        placeholder="Enter category name"
                        required>

                </div>


                <!-- Category Image -->

                <div class="form-group">

                    <label>Category Image</label>

                    <input
                        type="file"
                        name="image"
                        accept="image/*"
                        required>

                </div>

            </div>


            <!-- Description -->

            <div class="form-group full-width">

                <label>Description</label>

                <textarea
                    name="description"
                    rows="8"
                    placeholder="Write category description..."
                    required></textarea>

            </div>


            <div class="form-actions">

                <button type="submit"
                        class="primary-btn">
                    Add Category
                </button>

                <a href="admin?page=categories"
                   class="secondary-btn">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</section>