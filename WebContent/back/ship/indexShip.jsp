<!-- 小豬加,後端物流區index -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-3 col-md-2 sidebar">
			<ul class="nav nav-sidebar">
				<li class="active"><a class="aIndexShip" rel="ship" href="#">待配送資料查詢</a></li>
			</ul>
		</div>

		<div id="listAllShip" class="col-md-10 col-md-offset-2 main">
				<%@ include file="/back/ship/queryShipList.jsp"%>
<!-- 此區加載點擊"物流區"後顯示的第一頁,也就是上面<li>的第一項 -->
		</div>
		<div id="listAllShipResult" class="col-md-10 col-md-offset-2 main">
                <%@ include file="/back/ship/showShipList.jsp"%>
<!-- 此區加載點擊"物流區"後顯示的第一頁,也就是上面<li>的第一項 -->
        </div>
	</div>
</div>


