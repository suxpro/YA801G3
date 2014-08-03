<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JustRent!後端</title>
<link rel="stylesheet"
	href="css/bootstrap.min.css">
<link href="css/dashboard.css" rel="stylesheet">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/dashboard.js"></script>

</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">JustRent!後端</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#" class="manage" rel="employee">員工管理</a></li>
					<li><a href="#" class="manage" rel="member">會員管理</a></li>
					<li><a href="#" class="manage" rel="rent">租物管理</a></li>
					<li><a href="#" class="manage" rel="trade">物流管理</a></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div id="indexMain">
        <%@ include file="/back/employee/indexEmp.jsp"%>
    </div>
</body>
</html>