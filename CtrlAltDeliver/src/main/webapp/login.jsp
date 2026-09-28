<%-- 
    Document   : login
    Created on : May 17, 2026, 10:16:10 AM
    Author     : Pranish
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <!--head via template-->
    <jsp:include page="/templates/head.jsp">
        <jsp:param name="title" value="CtrlAltDeliver| Login Page"/>
        <jsp:param name="cssFile" value="auth"/>
    </jsp:include>

    <!--header via template: no parameters here-->
    <jsp:include page="/templates/nav.jsp">
        <jsp:param name="one" value="Browse"/>
        <jsp:param name="onehref" value="products"/>

        <jsp:param name="two" value="My Cart"/>
        <jsp:param name="twohref" value="cart"/>

        <jsp:param name="three" value="About Us"/>
        <jsp:param name="threehref" value="aboutus"/>

        <jsp:param name="four" value="Sign Up"/>
        <jsp:param name="fourhref" value="register"/>
    </jsp:include>
    <body>


        <div class="container">
            <h2>User Login</h2>
            <p class="subtitle">Login to continue to your account</p>

            <form class="form" action="login" method="post">

                <div class="input-span">
                    <label for="email" class="label">Email</label>
                    <input type="email" name="email" id="email" required />
                </div>

                <div class="input-span">
                    <label for="password" class="label">Password</label>
                    <input type="password" name="password" id="password" required />
                </div>

                <p class="error"
                   style='display: ${not empty error ? "block" : "none"}'>
                    ${error}
                </p>

                <!--                <div class="text">
                                    <a href="#">Forgot password?</a>
                                </div>-->

                <input class="submit" type="submit" value="LOGIN" />

                <div class="text">
                    Don't have an account?
                    <a href="register">Sign up</a>
                </div>

            </form>
        </div>
        <jsp:include page="/templates/footer.jsp" />
    </body>
</html>
