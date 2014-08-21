<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/justrent.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="jquery-ui-1.11.0.custom/jquery-ui.css" rel="stylesheet">
<link href="css/bootstrap-magnify.min.css" rel="stylesheet">
<script src="js/jquery-2.1.1.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="jquery-ui-1.11.0.custom/jquery-ui.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.color.js"></script>
<script src="js/justrent.js"></script>
<script src="js/jquery.tinyMap-2.8.4.js"></script>
<script src="js/bootstrap-magnify.min.js"></script>

<title>JustRent! - 萬物皆可租</title>


</head>
<body>
<div id="wrapper">


	<%@ include file="/front/header.jsp"%>

	<!-- 租物區 -->
    <%@ include file="/front/body.jsp"%>

	<%@ include file="/front/footer.jsp"%>
</div>	
</body>
</html>