<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">

    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver | Dashboard"/>
        <jsp:param name="cssFile" value="userdash"/>
    </jsp:include>

    <body>

        <jsp:include page="/templates/nav.jsp">
            <jsp:param name="one" value="Browse"/>
            <jsp:param name="onehref" value="products"/>

            <jsp:param name="two" value="My Cart"/>
            <jsp:param name="twohref" value="cart"/>

            <jsp:param name="three" value="About Us"/>
            <jsp:param name="threehref" value="aboutus"/>

            <jsp:param name="four" value="Logout"/>
            <jsp:param name="fourhref" value="logout"/>
        </jsp:include>

        <main class="dashboard-wrapper" style="border:1px solid var(--color-border);">

            <aside class="dashboard-sidebar">
                <div class="sidebar-menu">

                    <a href="userdashboard?page=myorders" class="sidebar-btn  ${param.page == null || param.page == 'myorders' ? 'active' : ''}">My Orders</a>
                    <a href="userdashboard?page=manageacc" class="sidebar-btn ${ param.page == 'manageacc' ? 'active' : ''}">Manage Account</a>
                    <a href="userdashboard?page=currentorders" class="sidebar-btn ${ param.page == 'currentorders' ? 'active' : ''}">Current Orders</a>
                    <a href="logout" class="sidebar-btn logout-btn">Logout</a>
                    <!--<p>${param.page}</p>-->

                </div>
            </aside>

            <%-- Main Content --%>
            <section class="dashboard-content">
                <!--/ include main content here /-->
                <c:choose>
                    <c:when test="${page == 'myorders'}">
                        <jsp:include page="./dash/myorders.jsp"/>
                    </c:when>

                    <c:when test="${page == 'currentorders'}">
                        <jsp:include page="./dash/currentorders.jsp"/>
                    </c:when>

                    <c:when test="${page == 'manageacc'}">
                        <jsp:include page="./dash/manageacc.jsp"/>
                    </c:when>
                </c:choose>
            </section>

        </main>

        <jsp:include page="/templates/footer.jsp"/>

    </body>
</html>