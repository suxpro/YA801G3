<!-- 小豬加,後端會員區index -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-3 col-md-2 sidebar">
			<ul class="nav nav-sidebar">
				<li class="active"><a class="aIndexMem" rel="member" href="#">會員帳號管理</a></li>
                <li><a class="aIndexMem" rel="temp1" href="#">交易記錄查詢</a></li>
			</ul>
		</div>

		<div id="listAllMem" class="col-md-10 col-md-offset-2 main">
				<%@ include file="/back/member/listAllMember.jsp"%>
<!-- 此區加載點擊"會員區"後顯示的第一頁,也就是上面<li>的第一項 -->
		</div>
	</div>
</div>


