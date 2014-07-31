<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = null;
	if (session.getAttribute("memberVO") != null) {
		memberVO = (MemberVO) session.getAttribute("memberVO");
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
			
		<!-- �n�J�� -->
			<c:if test="<%=memberVO != null%>">
			   <div class="navbar-collapse collapse navbar-right" >				
				 <ul class="nav navbar-nav ">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">�z�n, <%=memberVO.getMname()%> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                 <li class="dropdown-plus-title">
                                    <i class="glyphicon glyphicon-user"></i>		<%=memberVO.getMname()%>
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                                
                                <li><a href="#" onclick="document.updateMemInfo.submit();">�|����ƭק�</a>
                                	<FORM name="updateMemInfo" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                </li>
                                <li><a href="#">�|���x��</a></li>
                                <li><a href="#">�X���޲z</a></li>
                                <li><a href="#">�q��޲z</a></li>
                                <li><a href="#">���v���ɬd��</a></li>
                                <li><a href="#">�ɯŷ|��</a></li>
                                <li class="divider"></li>
              					<li class="dropdown-submenu">
                					<a tabindex="-1" href="#">���ȯ��Ѵ���</a>
                					<ul class="dropdown-menu">
                  						<li><a tabindex="-1" href="#">���\�X��(0)</a></li>
                  						<li><a href="#">���\�ӯ�(0)</a></li>
                  						<li><a href="#">�X���T�{(0)</a></li>
                  						<li><a href="#">�w���q��(0)</a></li>
                  						<li><a href="#">�X��Q&A(0)</a></li>
                  						<li><a href="#">�ӯ�Q&A(0)</a></li>
                  						<li><a href="#">�����q��(0)</a></li>
                  						<li><a href="#">���|�q��(0)</a></li>
                  						<li><a href="#">�X�f�q��(0)</a></li>
                  						<li><a href="#">�k���q��(0)</a></li>
                  						<li><a href="#">�����q��(0)</a></li>
                					</ul>
              					</li>
              					<li class="divider"></li>
                                <li>
                                	<li><a href="#" onclick="document.logoutMember.submit();"><i class="glyphicon glyphicon-off"></i> �n�X</a>
                                	<FORM name="logoutMember" METHOD="post" ACTION="<%=request.getContextPath()%>/front/login/LogoutHandler">
										<input type="hidden" name="action" value="logout">
									</FORM>
									</li>
								</li>
                                
                            </ul>
                        </li>
                    </ul>
                  </div>
				</c:if>
		<!-- �n�J�e -->
				<c:if test="${member == null}">
				<div class="navbar-collapse collapse navbar-form navbar-right" >
					<button class="btn btn-default" data-toggle="modal"	data-target="#myLogin">�n�J</button>
					<button class="btn btn-danger" data-toggle="modal"	data-target="#Agreement">���U</button>
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
					<h4 class="modal-title" id="myModalLabel">�|������</h4>
				</div>
				<!-- agreement -->
				<div class="modal-body">
					<%@ include file="/front/member/AgreementMember.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- �������� -->
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