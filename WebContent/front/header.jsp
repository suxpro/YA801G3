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
<script>
    $.getScript("js/remind/remind.js");
</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">租務 <front class="badge">14</front><b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                 <li class="dropdown-plus-title">
                                    <i class="glyphicon glyphicon-envelope"></i>		租務秘書提醒
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                                
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;成功出租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">0</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;成功承租&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">0</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;出租確認&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">0</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;預約通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">4</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;出租Q&A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">0</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;承租Q&A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">3</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;評價通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">1</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;檢舉通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">3</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;出貨通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">2</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;歸期通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">0</front></a></li>
                  						<li><a href="#">&nbsp;&nbsp;&nbsp;租期通知&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<front class="badge">2</front></a></li>                                                                
                                
                            </ul>
                        </li>
                 </ul>			
				 <ul class="nav navbar-nav ">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <%=memberVOxx.getMname()%> <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                 <li class="dropdown-plus-title">
                                    <i class="glyphicon glyphicon-user"></i>		<%=memberVOxx.getMname()%>
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                                
                                <li><a href="#" onclick="document.updateMemInfo.submit();">會員資料修改</a>
                                	<FORM name="updateMemInfo" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                </li>
                                <li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a>
                                	<FORM name="storedMoney" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/memberStored.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                
                                </li>
                                <li><a href="#">出租管理</a></li>
                                <li><a href="#">訂單管理</a></li>
                                <li><a href="#">歷史租借查詢</a></li>
                                <li><a href="#" onclick="document.updateVIP.submit();">升級會員</a>
                                	<FORM name="updateVIP" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                </li>

              					<li class="divider"></li>
                                <li>
                                	<li><a href="#" onclick="document.logoutMember.submit();"><i class="glyphicon glyphicon-off"></i> 登出</a>
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
		<!-- 登入前 -->
				<c:if test="${memberVO == null}">
				<div class="navbar-collapse collapse navbar-form navbar-right" >
					<button class="btn btn-default" data-toggle="modal"	data-target="#myLogin">登入</button>
					<button class="btn btn-danger" data-toggle="modal"	data-target="#Agreement">註冊</button>
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