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
	<!-- header -->
	<div class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- Brand -->
				<!--<a class="navbar-brand" href="#">JustRent!</a>-->
				<!-- <img src="img/JustRent_Logo6.png"> -->
				<a class="navbar-brand" href="<%=request.getContextPath()%>/front/index.jsp"><img width="75" height="70"
					src="img/JustRent_Logo7.png" width="130px"> </a>
			</div>
			<div class="navbar-collapse collapse navbar-form navbar-right">
				<button class="btn btn-default" data-toggle="modal" data-target="#myLogin">登入</button>
				<button class="btn btn-danger" data-toggle="modal" data-target="#Agreement">註冊</button>
			</div>
			<!--/.navbar-collapse -->
		</div>
	</div>

	<!-- modal login-->
	<div class="modal fade" id="myLogin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">JustRent!</h4>
				</div>
				<!-- login -->
				<div class="modal-body">
					<%@ include file="/front/login/login.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- modal agreement-->
	<div class="modal fade" id="Agreement" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">會員條款</h4>
				</div>
				<!-- agreement -->
				<div class="modal-body">
					<%@ include file="/front/member/AgreementMember.jsp"%>
				</div>
			</div>
		</div>
	</div>


	<!-- 首頁輪播 -->
	<div class="container">
		<div class="row">
			<!-- The carousel -->
			<div id="transition-timer-carousel"
				class="carousel slide transition-timer-carousel"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#transition-timer-carousel" data-slide-to="0"
						class="active"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="1"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="2"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="3"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="4"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item active">
						<img src="img/1.png" />
					</div>

					<div class="item">
						<img src="img/2.png" />
					</div>

					<div class="item">
						<img src="img/3.png" />
					</div>

					<div class="item">
						<img src="img/4.png" />
					</div>

					<div class="item">
						<img src="img/6.jpg" />
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#transition-timer-carousel"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span>
				</a> <a class="right carousel-control" href="#transition-timer-carousel"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span>
				</a>

				<!-- Timer "progress bar" -->
				<hr class="transition-timer-carousel-progress-bar animate" />
			</div>
		</div>
	</div>

	<!-- 租物區 -->
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
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->

						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->

						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
						<div class='col-sm-4 col-xs-6 col-md-3 col-lg-3'>
							<a class="thumbnail fancybox" rel="ligthbox"
								href="img/things/34669_PE124756_S3.JPG"> <img
								class="img-responsive" alt=""
								src="img/things/34669_PE124756_S3.JPG" />
								<div class='text-right'>
									<small class='text-muted'>Image Title</small>
								</div> <!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->


					</div>
					<!-- list-group / end -->
				</div>
				<!-- row / end -->

			</div>

		</div>
	</div>



	<!-- 這是footer -->
	<div class="container">
		<!-- Example row of columns -->
		<div class="row">
			<div class="col-xs-3">
				<h2>關於目的</h2>
				<p>提供租借平台，讓雙方都能達成目的，甚至是在緊急需要求救時，附近的人能及時幫助需要的人，造成雙贏的立場。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">更多 &raquo;</a>
				</p>

			</div>
			<div class="col-xs-3">
				<h2>租物規則</h2>
				<p>隨著出租物性質不同，合約內容和租借方式也會有差異，如出租人有特別的交易方式，請詳閱後再決定。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">更多 &raquo;</a>
				</p>

			</div>
			<div class="col-xs-3">
				<h2>常見問題</h2>
				<p>整理大多數會員常見遇到的各類問題，可詳閱後再行租物。</p>
				<p>
					<a class="btn btn-default" href="#" role="button">更多 &raquo;</a>
				</p>
			</div>
			<div class="col-xs-3">
				<h2>關於我們</h2>
				<p>320桃園縣中壢市中大路300號</p>
				<p>justrent@gmail.com</p>
				<p>
					<a class="btn btn-default" href="#" role="button">更多 &raquo;</a>
				</p>
			</div>
		</div>

		<hr>

		<footer> <a id="back-to-top" href="#"
			class="btn btn-primary btn-lg back-to-top" role="button"
			title="Click to return on the top page" data-toggle="tooltip"
			data-placement="left"><span
			class="glyphicon glyphicon-chevron-up"></span></a>
		<p>
			&copy; 2014 <strong>JustRent!</strong>. All Rights Reserved.
		</p>
		</footer>
	</div>
	<!-- /container -->
</body>
</html>