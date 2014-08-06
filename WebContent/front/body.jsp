<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>

<%
	RentService rentSvc = new RentService();
    List<RentVO> list = rentSvc.getAll();
    pageContext.setAttribute("rentBodyList", list);
%>
<script>
	$.getScript("js/bodyRent/bodyRent.js");
</script>

<div class="container">
	<!-- MENU -->
	<nav class="animate">
		<h4>Menu</h4>
		<ul>
			<li class="active"><a href="#">全部租物</a></li>
			<li><a href="#">電腦、平板與周邊</a></li>
			<li><a href="#">相機、攝影與周邊</a></li>
			<li><a href="#">手機、配件與通訊</a></li>
			<li><a href="#">家電、影音視聽</a></li>
			<li><a href="#">居家、家具與園藝</a></li>
			<li><a href="#">運動、戶外與休閒</a></li>
			<li><a href="#">玩具、模型與公仔</a></li>
			<li><a href="#">其他</a></li>
		</ul>
	</nav>
	<div class="nav-controller">
		<span
			class="[ glyphicon glyphicon glyphicon-th-list ] controller-open"></span>
		<span class="[ glyphicon glyphicon-remove ] controller-close"></span>
	</div>


	<div class="row">
		<!-- 分頁 -->
		<div class="col-xs-4">
			<ul class="pagination pagination-sm">
				<li><a href="#">&laquo;</a></li>
				<li><a href="#">1</a></li>
				<li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li>
				<li><a href="#">&raquo;</a></li>
			</ul>
		</div>

		<!-- 搜尋 -->
		<div class="col-xs-4 col-xs-offset-1">
			<div class="span12">
				<form id="custom-search-form"
					class="form-search form-horizontal pull-left">
					<div class="input-append span12">
						<input type="text" class="search-query mac-style"
							placeholder="Search">
						<button type="submit" class="btn btn-default">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<!-- search -->
	</div>
	<!-- /.row -->

	<div class="row row-offcanvas row-offcanvas-light">
		<!-- SOS/熱門 -->
		<div class="col-xs-6 col-xs-3 sidebar-offcanvas navbar-right"
			id="sidebar" role="navigation">
			<div class="list-group">
				<a href="#" class="list-group-item active">即時SOS訊息</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">會員</a> <a
					href="<%=request.getContextPath()%>/front/prent/select_page.jsp"
					class="list-group-item">預租</a> <a
					href="<%=request.getContextPath()%>/front/remind/select_page.jsp"
					class="list-group-item">提醒</a> <a
					href="<%=request.getContextPath()%>/front/report/select_page.jsp"
					class="list-group-item">檢舉</a> <a
					href="<%=request.getContextPath()%>/front/trade/select_page.jsp"
					class="list-group-item">交易</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a>
			</div>

			<div class="list-group">
				<a href="#" class="list-group-item active">熱門訊息</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a>
			</div>
		</div>

		<!-- 商品 -->
		<div class="col-xs-12 col-xs-9">
			<div class="row">
				<div class='list-group gallery'>

					<c:forEach var="rentVO" items="${rentBodyList}" varStatus="status">
						<div id="${rentVO.rent_no}" class='divRentItem col-sm-4 col-xs-6 col-md-3 col-lg-3' value="<%=request.getContextPath()%>/front/rent/rent.do">
							<a class="thumbnail" rel="ligthbox" data-toggle="modal"
								data-target="#infoRentModel"> <img
								data-src="js/holder.js/450x450"
								src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
								<div class='text-right'>
									<small class='text-muted'>${rentVO.rent_name}</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
					</c:forEach>

				</div>
				<!-- list-group / end -->
			</div>
			<!-- row / end -->

		</div>

		<!-- Modal -->
		<div class="modal fade" id="infoRentModel" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div id="infoRentShow" class="modal-content">
				</div>
			</div>
		</div>
	</div>
</div>