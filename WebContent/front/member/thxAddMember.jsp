<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

<title>JustRent! - 恭喜註冊完成</title>

<style>
#id_article {
	background-color: #FBFFD6;
	height: 300px;
	width:800px;
	PADDING-TOP: 40PX;
	PADDING-BOTTOM: 40PX;
	text-align:center;
	border-radius: 30px;
}
#title{
 	margin-top:85px; 
	font-size: 30px;
	font-family: Microsoft JhengHei, 標楷體, Comic Sans MS, 新細明體;
	font-weight: bold;
/* 	text-align:center; */
}
</style>
<%@ include file="/front/header.jsp" %>
</head>
<body>

<div class="container">

<div class="col-md-offset-2" id="id_article">

<div id="title">
會員已經註冊成功，已發送一則啟動信至電子信箱，
<br/><br/>
啟動後以帳號密碼登入JustRent!將享有完整會員功能。
</div>

</div>

<br/>
<br/>
</div>

<%@ include file="/front/footer.jsp" %>

</body>
</html>

