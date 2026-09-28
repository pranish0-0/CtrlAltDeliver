<%-- 
    Document   : header
    Created on : May 17, 2026, 10:26:26 AM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header">
    <div class="logo" >
        <a href="home" style="text-decoration: none">
            <img src="${pageContext.request.contextPath}/resources/logo.png" width="150" alt="Logo" />
        </a>
    </div>
    <!--navbar-->
    <nav class="navbar">
        <ul>
            <li><a href="${param.onehref}">${param.one}</a></li>
            <li><a href="${param.twohref}">${param.two}</a></li>
            <li><a href="${param.threehref}">${param.three}</a></li>
            <li><a href="${param.fourhref}">${param.four}</a></li>
        </ul>
    </nav>
</header>

<style>

    * {
        box-sizing: border-box;
    }

    .header {

        width: 100%;
        height: 80px;

        padding: 0 40px;

        display: flex;
        align-items: center;
        justify-content: space-between;

        background: #ffffff;

        border-bottom: 1px solid #e5e5e5;

        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }

    .logo-link {
        display: flex;
        align-items: center;
        text-decoration: none;
    }

    .logo {
        width: 160px;
        height: auto;
        display: block;
    }

    .navbar {
        display: flex;
        align-items: center;
        gap: 14px;
    }

    .navbar ul {
        display: flex;
        align-items: center;
        gap: 28px;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .navbar ul li {
        display: flex;
        align-items: center;
    }

    .navbar ul li a {
        text-decoration: none;
        color: #666;
        font-size: 15px;
        font-weight: 600;
        border: 1px solid #58bc82;
        border-radius: 20px;
        padding: 10px 18px;
        transition: 0.3s ease;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .navbar ul li a .active , .navbar ul li a:hover {
        color: white;
        background: #58bc82;
    }

    
</style>