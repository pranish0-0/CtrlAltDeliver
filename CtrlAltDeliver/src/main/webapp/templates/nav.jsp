<%-- 
    Document   : header
    Created on : May 17, 2026, 10:26:26 AM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header">
    <div class="logo">
        <a href="home" style="text-decoration: none">
            <img src="${pageContext.request.contextPath}/resources/logo.png" width="150" alt="Logo" />
        </a>
    </div>

    <!-- Hamburger button — only visible on mobile -->
    <button class="nav-hamburger" id="navHamburger" aria-label="Toggle navigation" aria-expanded="false">
        <span class="bar"></span>
        <span class="bar"></span>
        <span class="bar"></span>
    </button>

    <!--navbar-->
    <nav class="navbar">
        <ul class="nav-links" id="navLinks">
            <li><a href="${pageContext.request.contextPath}/${param.onehref}">${param.one}</a></li>
            <li><a href="${pageContext.request.contextPath}/${param.twohref}">${param.two}</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/aboutus.html">About Us</a></li>
            <li><a href="${pageContext.request.contextPath}/${param.fourhref}">${param.four}</a></li>
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
        position: relative;
        z-index: 100;
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

    /* ── Hamburger — hidden on desktop ── */
    .nav-hamburger {
        display: none;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 5px;
        background: none;
        border: none;
        cursor: pointer;
        padding: 8px;
        z-index: 1001;
    }

    .nav-hamburger .bar {
        width: 25px;
        height: 2px;
        background: #333;
        border-radius: 2px;
        transition: all 0.3s ease;
        display: block;
    }

    /* Animated X when open */
    .nav-hamburger.open .bar:nth-child(1) { transform: translateY(7px) rotate(45deg); }
    .nav-hamburger.open .bar:nth-child(2) { opacity: 0; transform: scaleX(0); }
    .nav-hamburger.open .bar:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

    /* ── Desktop nav ── */
    .navbar {
        display: flex;
        align-items: center;
        gap: 14px;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 28px;
        margin: 0;
        padding: 0;
        list-style: none;
    }

    .nav-links li {
        display: flex;
        align-items: center;
    }

    .nav-links li a {
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

    .nav-links li a:hover {
        color: white;
        background: #58bc82;
    }

    /* ── Mobile breakpoint ── */
    @media (max-width: 768px) {

        .header {
            padding: 0 18px;
        }

        /* Show hamburger */
        .nav-hamburger {
            display: flex;
        }

        /* Navbar becomes a full-width slide-down drawer */
        .navbar {
            position: absolute;
            top: 80px; /* flush below the header */
            left: 0;
            width: 100%;
            background: #ffffff;
            box-shadow: 0 8px 24px rgba(0,0,0,0.10);
            z-index: 999;
            /* Hidden by default */
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.35s ease;
        }

        /* When open, expand to show all items */
        .navbar.open {
            max-height: 400px;
        }

        /* Stack links vertically */
        .nav-links {
            flex-direction: column;
            align-items: stretch;
            gap: 0;
            width: 100%;
            padding: 8px 0 16px;
        }

        .nav-links li {
            width: 100%;
        }

        .nav-links li a {
            display: block;
            width: 100%;
            padding: 14px 24px;
            font-size: 16px;
            border: none;
            border-bottom: 1px solid #f0f0f0;
            border-radius: 0;
            box-shadow: none;
            color: #333;
        }

        .nav-links li:last-child a {
            border-bottom: none;
        }

        .nav-links li a:hover {
            background: #f6fff9;
            color: #58bc82;
        }
    }
</style>

<script>
    (function () {
        const btn   = document.getElementById('navHamburger');
        const navbar = btn ? btn.closest('.header').querySelector('.navbar') : null;

        if (!btn || !navbar) return;

        btn.addEventListener('click', function () {
            const isOpen = navbar.classList.toggle('open');
            btn.classList.toggle('open', isOpen);
            btn.setAttribute('aria-expanded', isOpen);
        });

        /* Close drawer when a link is tapped */
        navbar.querySelectorAll('a').forEach(function (link) {
            link.addEventListener('click', function () {
                navbar.classList.remove('open');
                btn.classList.remove('open');
                btn.setAttribute('aria-expanded', 'false');
            });
        });
    })();
</script>