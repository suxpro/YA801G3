<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/justrent.css" rel="stylesheet">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.color.js"></script>
<script src="js/justrent.js"></script>

<title>JustRent! - �U���ҥi��</title>

</head>
<body>
	<%@ include file="/front/header.file"%>

	<!-- ������ -->
	<div class="container">
		<!-- MENU -->
		<nav class="animate">
		<h4>Menu</h4>
		<ul>
			<li class="active"><a href="#">��������</a></li>
			<li><a href="#">�q���B���O�P�P��</a></li>
			<li><a href="#">�۾��B��v�P�P��</a></li>
			<li><a href="#">����B�t��P�q�T</a></li>
			<li><a href="#">�a�q�B�v����ť</a></li>
			<li><a href="#">�~�a�B�a��P����</a></li>
			<li><a href="#">�B�ʡB��~�P��</a></li>
			<li><a href="#">����B�ҫ��P���J</a></li>
			<li><a href="#">��L</a></li>
		</ul>
		</nav>
		<div class="nav-controller">
			<span
				class="[ glyphicon glyphicon glyphicon-th-list ] controller-open"></span>
			<span class="[ glyphicon glyphicon-remove ] controller-close"></span>
		</div>


		<div class="row">
			<!-- ���� -->
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

			<!-- �j�M -->
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
			<!-- SOS/���� -->
			<div class="col-xs-6 col-xs-3 sidebar-offcanvas navbar-right"
				id="sidebar" role="navigation">
				<div class="list-group">
					<a href="#" class="list-group-item active">�Y��SOS�T��</a> <a
						href="<%=request.getContextPath()%>/front/member/select_page.jsp"
						class="list-group-item">�|��</a> <a
						href="<%=request.getContextPath()%>/front/prent/select_page.jsp"
						class="list-group-item">�w��</a> <a
						href="<%=request.getContextPath()%>/front/remind/select_page.jsp"
						class="list-group-item">����</a> <a
						href="<%=request.getContextPath()%>/front/report/select_page.jsp"
						class="list-group-item">���|</a> <a
						href="<%=request.getContextPath()%>/front/trade/select_page.jsp"
						class="list-group-item">���</a> <a
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
					<a href="#" class="list-group-item active">�����T��</a> <a href="#"
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

			<!-- �ӫ~ -->
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

	<%@ include file="/front/footer.file"%>
	
</body>
</html>