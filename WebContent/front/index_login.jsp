<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.color.js"></script>
<link href="css/justrent.css" rel="stylesheet">
<script src="js/justrent.js"></script>

<title>JustRent! - 萬物皆可租</title>

<script>
	$(document).ready(function() {
		$('#myLogin').modal('show'); //filters login show
	}); // end ready
	
	
</script>
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