<%-- 
    Document   : register
    Created on : May 17, 2026, 10:16:15 AM
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

    <body>
        <!--header via template: no parameters here-->
        <jsp:include page="/templates/nav.jsp">
            <jsp:param name="one" value="Browse"/>
            <jsp:param name="onehref" value="products"/>

            <jsp:param name="two" value="My Cart"/>
            <jsp:param name="twohref" value="cart"/>

            <jsp:param name="three" value="About Us"/>
            <jsp:param name="threehref" value="aboutus"/>

            <jsp:param name="four" value="Log In"/>
            <jsp:param name="fourhref" value="login"/>
        </jsp:include>

        <div class="container">
            <h2>Create Account</h2>
            <p class="subtitle">Signup now and get full access</p>


            <form action="register" method="post" class="form">
                <div class="flex">
                    <div class="input-span">
                        <label class="label">First Name</label>
                        <input type="text" name="firstName" value="${empty erFname ? param.firstName:''}"  required />
                    </div>

                    <div class="input-span">
                        <label class="label">Last Name</label>
                        <input type="text" name="lastName" value="${empty erLname ? param.lastName:''}"  required />
                    </div>
                </div>

                <div class="input-span">
                    <label class="label">Email</label>
                    <input type="email" name="email" value="${empty erMail ? param.email:''}" required />
                </div>
                <div class="input-span">
                    <label class="label">Phone</label>
                    <input type="phone" name="phone" value="${empty erPhone ? param.phone:''}" required />
                </div>

                <div class="input-span">
                    <label class="label">Password</label>
                    <input type="password" name="password" required />
                </div>

                <div class="input-span">
                    <label class="label">Confirm Password</label>
                    <input type="password" name="cpassword" required />
                </div>

                <input class="submit" type="submit" value="REGISTER" />

                <p class="error"
                   style='display: ${not empty error ? "block" : "none"}'>
                    ${error}
                </p>

                <div class="text">
                    Already have an account?
                    <a href="login">Sign in</a>
                </div>

            </form>
        </div>
        <jsp:include page="/templates/footer.jsp" />
    </body>
</html>
