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
<title>�|����ƭק� - updateMemberInfo.jsp</title>

<style type="text/css">
#preview {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#preview2 {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {width:94%;}

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
										<b>�|����ƭק�</b>
									</h2>
								</legend>
							</div>

							<div class="row row-offcanvas row-offcanvas-light">
								<div class="col-xs-4 col-xs-offset-2">
									<!-- �ƪ� -->

									<!-- �|���s�� -->
									<div class="control-group  ">
										<label class="control-label" for="username">�|���s��</label> <label
											class="control-label col-xs-offset-1" id="username"><%=memberVO.getMno()%></label>
									</div>

									<!-- �|���b�� -->
									<div class="control-group  ">
										<label class="control-label" for="mid">�|���b�� </label> <label
											class="control-label col-xs-offset-1" id="mid">${memberVO.mid}</label>
									</div>

									<!-- �|���K�X -->
									<div class="control-group  ">
										<label class="control-label" for="mpwd">�|���K�X</label> <input
											type="password" id="mpwd" name="mpwd"
											value="<%=memberVO.getMpwd()%>" class="col-xs-offset-1"
											ruquired>
									</div>


									<!-- �|���m�W -->
									<div class="control-group  ">
										<label class="control-label" for="mname">�|���m�W</label> <input
											type="text" id="mname" name="mname"
											value="<%=memberVO.getMname()%>" class="col-xs-offset-1"
											ruquired>
									</div>

									<!-- �|���ʧO -->
									<div class="control-group  ">
										<label class="control-label" for="msex">�|���ʧO</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${memberVO.msex == 'M' }">
            									&nbsp;<input type="radio" id="msex" name="msex" value=M	checked class="col-xs-offset-1">&nbsp;�k&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex" value=F	class="col-xs-offset-1">&nbsp;�k
										</c:if>
										<c:if test="${memberVO.msex == 'F' }">
            									&nbsp;<input type="radio" id="msex" name="msex" value=M class="col-xs-offset-1">&nbsp;�k&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex" value=F	checked class="col-xs-offset-1">&nbsp;�k
										</c:if>
									</div>

									<!-- �|����� -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">�|�����</label> <input
											type="text" id="mcell" name="mcell"
											value="<%=memberVO.getMcell()%>" class="col-xs-offset-1"
											ruquired>

									</div>

									<!-- �|���l�� -->
									<div class="control-group ">
										<label class="control-label" for="mmail">�|���l��</label> <input
											type="email" id="mmail" name="mmail"
											value="<%=memberVO.getMmail()%>" class="col-xs-offset-1">

									</div>

									<jsp:useBean id="locSvc" scope="page"
										class="back.loc.model.LocService" />

									<!-- �a�� -->
									<div class="control-group  ">
										<label class="control-label" for="password_confirm">�a��</label>
										<select size="1" name="locno" class="col-xs-offset-2">
											<c:forEach var="locVO" items="${locSvc.all}">
												<option value="${locVO.loc_no}"
													${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
											</c:forEach>
										</select>

									</div>

									<!-- �|���a�} -->
									<div class="control-group ">
										<label class="control-label" for="madrs">�|���a�}</label> <input
											type="text" id="madrs" name="madrs"
											value="<%=memberVO.getMadrs()%>" class="col-xs-offset-1"
											ruquired="ruquired">

									</div>


								</div>
								<!-- �ƪ� -->
								<div class="col-xs-offset-0 sidebar-offcanvas ">
									<!-- �Ϥ��ƪ� -->

									<!-- �|���Ϥ� -->
									<div class="control-group ">
										<label class="control-label" for="mpic">�|���Ϥ�</label>
										<div class="controls">
											<img id="mpic" width="80" height="80"
												src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
											<input type="file" id="mpic" name="mpic"
												class="col-xs-offset-6" />
										</div>
									</div>
									<c:if test="${memberVO.mlev == 'V' }">
										<!-- �|�������Ϥ� -->
										<div class="control-group  ">
											<label class="control-label" for="password_confirm">�|�������Ϥ�</label>
											<div class="controls">
												<img id="mvpic" width="80" height="80"
													src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
												<input type="file" id="mvpic" name="mvpic"
													class="col-xs-offset-6" />
											</div>
										</div>
									</c:if>
									 								

								</div>
								<!-- �Ϥ��ƪ� -->
								
								<div class=" col-xs-offset-0 sidebar-offcanvas">
									<%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
										<font color='red'>�Эץ��H�U���~:
											<ul>
												<c:forEach var="message" items="${errorMsgs}">
													<li>${message.value}</li>
												</c:forEach>
											</ul>
										</font>
									</c:if>
								</div>
							

							</div>

							<br>
							<br>
							<!-- Submit -->
							<div class="control-group col-xs-8 col-xs-offset-8">
								<div class="controls">
									<input type="hidden" name="action" value="updateInfo">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>">	<!--��e�X�ק諸�ӷ��������|,�qrequest���X��,�A�e��Controller�ǳ���椧��-->
									<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>"> <!--�u�Ω�:istAllEmp.jsp-->
									
									<button class="btn btn-success">�ק�</button>
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