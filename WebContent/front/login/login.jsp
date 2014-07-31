<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<title>Login</title>
</head>
<body>

	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/login/LoginHandler"
		id="login">
		<div class="form-group">
		<br>
			<label class="col-sm-3 control-label">Account</label>
			<div class="col-sm-7">
				<input NAME="mid" type="text" class="form-control" placeholder="Account" required>
			</div>
		</div>
		<div class="form-group">
			<label class="col-xs-3 control-label">Password</label>
			<div class="col-xs-7">
				<input NAME="mpwd" type="password" class="form-control pwd" placeholder="Password" required>								
			</div>		
            <button class="btn btn-default reveal" id="seepwd" type="button"><i class="glyphicon glyphicon-eye-open"></i></button>		
		</div>
		<br>
		<br>				
		<div class="form-group">
			<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">¨ú®ø</button>
					<button type="SUBMIT" class="btn btn-primary">½T©w</button>		
			</div>
		</div>
	</form>

</BODY>
</html>