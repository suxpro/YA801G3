<!-- 小豬加,後端租物區index -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-3 col-md-2 sidebar">
			<ul class="nav nav-sidebar">
				<li class="active"><a class="aIndexRent" rel="rent" href="#">租物上架審核</a></li>
                <li><a class="aIndexRent" rel="temp1" href="#">租物記錄查詢</a></li>
			</ul>
		</div>

		<div id="listAllRent" class="col-md-10 col-md-offset-2 main">
				<%@ include file="/back/rent/waiting_onShelf_rent.jsp"%>
<!-- 此區加載點擊"租物區"後顯示的第一頁,也就是上面<li>的第一項 -->
		</div>
	</div>
</div>


