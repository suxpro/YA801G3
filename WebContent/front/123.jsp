<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - 萬物皆可租</title>

</head>
<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<body >
<!-- Single button -->
<div class="btn-group">
  <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
    Action <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <li><a href="#">Action</a></li>
    <li><a href="#">Another action</a></li>
    <li><a href="#">Something else here</a></li>
    <li class="divider"></li>
    <li><a href="#">Separated link</a></li>
  </ul>
</div>


</body>
</html>