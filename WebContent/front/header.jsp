<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVOxx = null;
	if (session.getAttribute("memberVO") != null) {
		memberVOxx = (MemberVO) session.getAttribute("memberVO");
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<title></title>
</head>
<body>
	<!-- header -->
	<div class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<!-- Brand -->
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/front/index.jsp"><img
					width="75" height="70"
					src="<%=request.getContextPath()%>/front/img/JustRent_Logo7.png"
					width="130px"> </a>
			</div>
			
		<!-- 登入後 -->
			<c:if test="<%=memberVOxx != null%>">
			   <div class="navbar-collapse collapse navbar-right" >				
				 <ul class="nav navbar-nav ">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">您好, <%=memberVOxx.getMname()%> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                 <li class="dropdown-plus-title">
                                    <%=memberVOxx.getMname()%>
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                                <li><a href="#">會員資料修改</a></li>
                                <li><a href="#">會員儲值</a></li>
                                <li><a href="#">出租管理</a></li>
                                <li><a href="#">訂單管理</a></li>
                                <li><a href="#">歷史租借查詢</a></li>
                                <li><a href="#">升級會員</a></li>
                                <li class="divider"></li>
              					<li class="dropdown-submenu">
                					<a tabindex="-1" href="#">租務秘書提醒</a>
                					<ul class="dropdown-menu">
                  						<li><a tabindex="-1" href="#">成功出租(0)</a></li>
                  						<li><a href="#">成功承租(0)</a></li>
                  						<li><a href="#">出租確認(0)</a></li>
                  						<li><a href="#">預約通知(0)</a></li>
                  						<li><a href="#">出租Q&A(0)</a></li>
                  						<li><a href="#">承租Q&A(0)</a></li>
                  						<li><a href="#">評價通知(0)</a></li>
                  						<li><a href="#">檢舉通知(0)</a></li>
                  						<li><a href="#">出貨通知(0)</a></li>
                  						<li><a href="#">歸期通知(0)</a></li>
                  						<li><a href="#">租期通知(0)</a></li>
                					</ul>
              					</li>
                                <li class="divider"></li>
                                <li><a href="#"><i class="glyphicon glyphicon-off"></i> 登出</a></li>
                            </ul>
                        </li>
                    </ul>
                  </div>
				</c:if>
		<!-- 登入前 -->
				<c:if test="${memberVO == null}">
				<div class="navbar-collapse collapse navbar-form navbar-right" >
					<button class="btn btn-default" data-toggle="modal"
						data-target="#myLogin">登入</button>
					<button class="btn btn-danger" data-toggle="modal"
						data-target="#Agreement">註冊</button>
				</div><!--/.navbar-collapse -->
				</c:if>
			
			
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
						<img src="<%=request.getContextPath()%>/front/img/1.png" />
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/2.png" />
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/3.png" />
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/4.png" />
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/6.jpg" />
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

</BODY>
</html>