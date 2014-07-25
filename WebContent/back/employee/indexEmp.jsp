<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-3 col-md-2 sidebar">
			<ul class="nav nav-sidebar">
				<li class="active"><a href="#">員工帳號管理</a></li>
				<li><a href="#">員工權限管理</a></li>
			</ul>
		</div>

		<div class="col-md-10 col-md-offset-2 main">
				<%@ include file="/back/employee/listAllEmp.jsp"%>
		</div>
	</div>
</div>


