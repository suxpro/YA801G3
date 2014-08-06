<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�ɯŷ|�� - updateVIP.jsp</title>

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
					<li class="active"><a href="#">�|���޲z</a></li>
					<li><a href="#">�|���x��</a></li>
					<li><a href="#">�X���޲z</a></li>
					<li><a href="#">�q��޲z</a></li>
					<li><a href="#">���v���ɬd��</a></li>
					<li><a href="#">�ɯŷ|��</a></li>
					<li class="divider"></li>
					<li class="dropdown-submenu"><a tabindex="-1" href="#">���ȯ��Ѵ���</a>
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
										<b>�ɯŷ|��</b>
									</h2>
								</legend>
							</div>

							<div class="row row-offcanvas row-offcanvas-light">
								<div class="col-xs-4 col-xs-offset-4">
									<!-- �ƪ� -->
									
									<!-- �|���b��l�B -->
									<div id="textbox" class="control-group  ">
										<h3>									
										<label class="control-label" for="mbalance">&nbsp;&nbsp;�٧U JUSTRENT!</label>
										</h3>
										<br/>
										<label class="control-label" for="mbalance">&nbsp;&nbsp;3000 NT �ä[VIP�|��</label> 										
										<a href="#" class="control-label" for="mbalance">VIP����n�B?</a>  
										<input type="hidden" id="mbalance" name="mbalance" value="<%=memberVO.getMbalance() - 3000%>" class="col-xs-offset-1" />
										<br/>
										<br/>
									</div>
								</div>
								<!-- �ƪ� -->
							
							</div>
							<br/>
							<br/>
							
									<!-- Submit -->
									<div class="control-group col-xs-offset-8">
										<div class="controls">
											<input type="hidden" name="action" value="updateVIP">
											<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
											<input type="hidden" id="mlev" name="mlev" value=V class="col-xs-offset-1">
											<button class="btn btn-success">�T�w</button>
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