<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/dashboard_login.css" rel="stylesheet">
<title>JustRent!後端登入</title>
</head>
<body>
	<div class="container">
        <div style="position:fixed;left:-50px;bottom:-50px;z-index:1001;">
            <img src="<%=request.getContextPath()%>/back/img/JustRent_Logo.png" height="275" width="275" class="img-responsive"/>
        </div>
		<form class="form-signin" role="form"
			action="<%=request.getContextPath()%>/LoginHandler" method="post">
			<h2 class="form-signin-heading">員工登入:</h2>
			<input type="text" class="form-control" placeholder="請輸入帳號"
				name="accountBack" value="" required autofocus> <input
				type="password" class="form-control" placeholder="請輸入密碼"
				name="passwordBack" value="" required>
			<!--         <label class="checkbox"> -->
			<!--           <input type="checkbox" value="remember-me"> Remember me -->
			<!--         </label> -->
			<button class="btn btn-lg btn-primary btn-block" type="submit"
				value="OK">登入</button>
		</form>

		<%-- 錯誤表列 --%>
		<c:if test="${not empty dashboard_login_error}">
            ${dashboard_login_error}
        </c:if>

	</div>	<!-- /container -->
</body>
</html>