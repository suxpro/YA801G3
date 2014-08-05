<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>升級會員 - updateVIP.jsp</title>

<style type="text/css">

#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {width:94%;}

#textbox { background-color:#FFFFE4; text-align:center;}

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

</head>
<body>

	<%@ include file="/front/header.file"%>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li class="active"><a href="#">會員管理</a></li>
					<li><a href="#">會員儲值</a></li>
					<li><a href="#">出租管理</a></li>
					<li><a href="#">訂單管理</a></li>
					<li><a href="#">歷史租借查詢</a></li>
					<li><a href="#">升級會員</a></li>
					<li class="divider"></li>
					<li class="dropdown-submenu"><a tabindex="-1" href="#">租務秘書提醒</a>
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
						</ul></li>

				</ul>
			</div>
			
			
			

			<div class="container">
				<div class="row-fluid">
					<form class="form-horizontal" id="memform" METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do"
						name="form1" enctype="multipart/form-data" role="form">
						<fieldset>
							<div id="legend">
								<legend class="">
									<h2>
										<b>升級會員</b>
									</h2>
								</legend>
							</div>

							<div class="row row-offcanvas row-offcanvas-light">
								<div class="col-xs-4 col-xs-offset-4">
									<!-- 排版 -->
									
									<!-- 會員帳戶餘額 -->
									<div id="textbox" class="control-group  ">
										<h3>									
										<label class="control-label" for="mbalance">&nbsp;&nbsp;贊助 JUSTRENT!</label>
										</h3>
										<br/>
										<label class="control-label" for="mbalance">&nbsp;&nbsp;3000 NT 永久VIP會員</label> 										
										<a href="#" class="control-label" for="mbalance">VIP有何好處?</a>  
										<input type="hidden" id="mbalance" name="mbalance" value="<%=memberVO.getMbalance() - 3000%>" class="col-xs-offset-1" />
										<br/>
										<br/>
									</div>
								</div>
								<!-- 排版 -->
							
							</div>
							<br/>
							<br/>
							
									<!-- Submit -->
									<div class="control-group col-xs-offset-8">
										<div class="controls">
											<input type="hidden" name="action" value="updateVIP">
											<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
											<input type="hidden" id="mlev" name="mlev" value=V class="col-xs-offset-1">
											<button class="btn btn-success">確定</button>
										</div>
									</div>



						</fieldset>
					</form>

				</div>
			</div>

		</div>
	</div>


	<%@ include file="/front/footer.file"%>
</body>
</html>