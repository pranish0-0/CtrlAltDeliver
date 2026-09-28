<%-- 
    Document   : myorders
    Created on : Jul 18, 2026, 9:15:25 PM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="dashboard-header">
    <h1>Manage Account</h1>
    <p style="color: red; margin: 10px 0 0 10px;">${cookie.message.value }</p>
</div>

<div class="manage-account">

    <!-- Profile Card -->
    <div class="account-card">

        <div class="card-title">
            <h2>Personal Information</h2>
        </div>

        <form action="${pageContext.request.contextPath}/userdashboard" method="post" enctype="multipart/form-data">
            
            <div class="profile-section" >
                

                <div class="profile-left">

                    <img
                        src="${empty user.profileImage ? 'resources/profile/default.webp' : user.profileImage}"
                        class="profile-avatar"
                        alt="Profile Picture">
                    

                    <div class="profile-buttons" >

                        <label class="save-btn upload-btn">
                            Change Photo
                            <input
                                type="file"
                                name="profileImage"
                                accept="image/*"
                                hidden>
                        </label>

                        <button
                            type="submit"
                            name="action"
                            value="removephoto"
                            class="secondary-btn"
                            ${empty user.profileImage ? "disabled" : ""}>
                            Remove Photo
                        </button>

                    </div>

                </div>

                <div class="profile-right">

                    <div class="form-grid" >

                        <div class="form-group">
                            <label>Full Name</label>
                            <input
                                type="text"
                                name="fullname"
                                value="${user.fullName}">
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <input
                                type="email"
                                name="email"
                                value="${user.email}">
                        </div>

                        <div class="form-group">
                            <label>Phone Number</label>
                            <input
                                type="text"
                                name="phone"
                                value="${user.phone}">
                        </div>
                    </div>

                    <button class="save-btn">
                        Save Changes
                    </button>

                </div>

            </div>

    </div>
               
     <!-- Address Card -->
    <div class="account-card">

        <div class="card-title">
            <h2>Shipping Address</h2><br>
            <p class="current-address">
                Current Address:
                ${empty user.address ? "No address saved." : user.address}
            </p>
        </div>
            
            <div class="form-grid">

                <div class="form-group" style="grid-column:1/-1;">
                    <label>Street Address</label>
                    <input
                        type="text"
                        name="streetAddress"
                        value="${empty user.address ? "" : street}"
                        placeholder="">
                </div>

                <div class="form-group">
                    <label>City</label>
                    <input
                        type="text"
                        name="city"
                        value="${empty user.address ? "" : city}"
                        placeholder="Pokhara, Kathmandu, Chitwan">
                </div>

                <div class="form-group">
                    <label>Postal Code</label>
                    <input
                        type="text"
                        name="postalCode"
                        value="${empty user.address ? "" : postal}"
                        placeholder="33700, 44600, 44200">
                </div>
                

            </div>

            <input required type="hidden" name="action" value="change">
            <button class="save-btn">Save Changes</button>

        </form>

    </div>

    <!-- Password -->

    <div class="account-card">

        <div class="card-title">
            <h2>Change Password</h2>
        </div>

        <form action="${pageContext.request.contextPath}/userdashboard" method="post">

            <div class="form-group">
                <label>Current Password</label>
                <input required type="password" name="currentPassword">
            </div>

            <div class="form-group">
                <label>New Password</label>
                <input required type="password" name="newPassword">
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input required type="password" name="confirmPassword">
            </div>
            
            
            <input required type="hidden" name="action" value="changepassword">
            <button class="save-btn">Change Password</button>

        </form>

    </div>

    <!-- Summary -->

    <div class="account-card">

        <div class="card-title">
            <h2>Account Summary</h2>
        </div>

        <div class="summary-grid">

            <div class="summary-item">
                <span>User ID</span>
                <strong>#${user.userId}</strong>
            </div>

            <div class="summary-item">
                <span>Total Orders</span>
                <strong>${totalOrders}</strong>
            </div>

            <div class="summary-item">
                <span>Account Status</span>
                <strong>Active</strong>
            </div>

        </div>

    </div>

</div>
            
<style>
    .manage-account{
    display:flex;
    flex-direction:column;
    gap:24px;
    padding:25px;
}

.account-card{
    background:var(--color-surface);
    border:1px solid var(--color-border);
    border-radius:18px;
    padding:25px;
}

.card-title{
    margin-bottom:20px;
}

.card-title h2{
    font-size:1.25rem;
    color:var(--color-text);
}

.profile-section{
    display:flex;
    gap:35px;
    align-items:flex-start;
}

.profile-left{
    width:220px;
    display:flex;
    flex-direction:column;
    align-items:center;
}
.profile-right{
    flex:1;
}

.form-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(250px,1fr));
    gap:20px;
    width:100%;
}

.form-group{
    display:flex;
    flex-direction:column;
}


.form-group label{
    color:var(--color-text-secondary);
    font-size:.9rem;
    margin: 5px 0;
}

.form-group input{
    padding:13px 16px;
    border:1px solid var(--color-border);
    border-radius:10px;
    background:var(--color-bg);
    color:var(--color-text);
    outline:none;
    transition:.25s;
}

.form-group input:focus{
    border-color:var(--color-primary);
    box-shadow:0 0 0 3px rgba(255,140,0,.15);
}

.save-btn{
    margin-top:25px;
    padding:13px 28px;
    border:none;
    border-radius:10px;
    cursor:pointer;
    background:var(--color-primary);
    color:#fff;
    font-weight:600;
    transition:.25s;
}

.save-btn:hover{
    transform:translateY(-2px);
}

.summary-grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
    gap:20px;
}

.summary-item{
    background:var(--color-bg);
    border:1px solid var(--color-border);
    border-radius:12px;
    padding:20px;
}

.summary-item span{
    display:block;
    color:var(--color-text-secondary);
    margin-bottom:8px;
    font-size:.9rem;
}

.summary-item strong{
    font-size:1.15rem;
    color:var(--color-text);
}

.profile-buttons{
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 100%;
}

.upload-btn{
    font-size: 12px;
    cursor:pointer;
    display:inline-flex;
    align-items:center;
    justify-content:center;
    margin: 10px 0;
}
.upload-btn input{
    display:none;
}
.secondary-btn{
    padding:12px 22px;
    border:1px solid var(--color-border);
    background:transparent;
    color:var(--color-text);
    border-radius:10px;
    cursor:pointer;
    font-weight:600;
    transition:.25s;
}

.secondary-btn:hover{
    background:#c62828;
    border-color:#c62828;
    color:#fff;
}

.current-address{
    margin-top:8px;
    color:var(--color-text-secondary);
    font-size:.95rem;
}

</style>