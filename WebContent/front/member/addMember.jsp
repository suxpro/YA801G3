<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - �U���ҥi��</title>

<style type="text/css">
#preview{width:100px;height:100px;border:0px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
#preview2{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead2 {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}

#memform {width:90%;}

</style>

</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>
<body >

	<%@ include file="/front/header.jsp"%>

			<div class="container">
				<div class="row-fluid">
					<form class="form-horizontal" id="memform" METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do"
						name="form1" enctype="multipart/form-data" role="form">
						<fieldset>
							<div id="legend">
								<legend class="">
									<h2>
										<b>���U�|��</b>
									</h2>
								</legend>
							</div>

							<div class="row row-offcanvas row-offcanvas-light">
								<div class="col-xs-4 col-xs-offset-2">
									<!-- �ƪ� -->

									<!-- �|���b�� -->
									<div class="control-group  ">
										<label class="control-label" for="mid">�|���b�� </label> 
										<input type="text" id="mid" name="mid" value="<%=(memberVO == null) ? "" : memberVO.getMid()%>" class="col-xs-offset-1" ruquired/>
									</div>

									<!-- �|���K�X -->
									<div class="control-group  ">
										<label class="control-label" for="mpwd">�|���K�X</label> <input
											type="password" id="mpwd" name="mpwd"
											value="<%=(memberVO == null) ? "" : memberVO.getMpwd()%>" class="col-xs-offset-1"
											ruquired/>
									</div>


									<!-- �|���m�W -->
									<div class="control-group  ">
										<label class="control-label" for="mname">�|���m�W</label> <input
											type="text" id="mname" name="mname"
											value="<%=(memberVO == null) ? "" : memberVO.getMname()%>" class="col-xs-offset-1"
											ruquired/>
									</div>

									<!-- �|���ʧO -->
									<div class="control-group  ">
										<label class="control-label" for="msex">�|���ʧO</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										
            									&nbsp;<input type="radio" id="msex" name="msex" value=M	class="col-xs-offset-1">&nbsp;�k&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex" value=F	class="col-xs-offset-1">&nbsp;�k
										
									
									</div>

									<!-- �|����� -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">�|�����</label> <input
											type="text" id="mcell" name="mcell"
											value="<%=(memberVO == null) ? "" : memberVO.getMcell()%>" class="col-xs-offset-1"
											ruquired/>

									</div>

									<!-- �|���l�� -->
									<div class="control-group ">
										<label class="control-label" for="mmail">�|���l��</label> 
										<input type="email" id="mmail" name="mmail"	value="<%=(memberVO == null) ? "" : memberVO.getMmail()%>" class="col-xs-offset-1" required />

									</div>

									<jsp:useBean id="locSvc" scope="page"
										class="back.loc.model.LocService" />

									<!-- �a�� -->
									<div class="control-group  ">
										<label class="control-label" for="password_confirm">�a��&nbsp;</label>
										<select size="1" name="locno" class="col-xs-offset-2">
											<c:forEach var="locVO" items="${locSvc.all}">
												<option value="${locVO.loc_no}"
													${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
											</c:forEach>
										</select>

									</div>

									<!-- �|���a�} -->
									<div class="control-group ">
										<label class="control-label" for="madrs">�|���a�}</label> 
										<input type="text" id="madrs" name="madrs" value="<%=(memberVO == null) ? "" : memberVO.getMadrs()%>" class="col-xs-offset-1" ruquired="ruquired"/>

									</div>


								</div>
								<!-- �ƪ� -->
								<div class="col-md-offset-8 sidebar-offcanvas ">
									<!-- �Ϥ��ƪ� -->

									<!-- �|���Ϥ� -->
									<div class="control-group">
										<label class="control-label" for="mpic">�|���Ϥ�</label>
										<div class="controls" >
											<div id="preview">
												<img id="imghead" width="100" height="100" src="" border="0">
											</div>								
											<input type="file" id="mpic" name="mpic" onchange="previewImage(this)" />
										</div>
									</div>					

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
							<div class="control-group col-md-10 col-md-offset-10">
								<div class="controls">
									<input type="hidden" name="action" value="insert">
									<input type="hidden" name="mverification" value="<%=(memberVO == null) ? "N" : memberVO.getMverification()%>" />
									<input type="hidden" name="mbalance" value="<%=(memberVO == null) ? "0" : memberVO.getMbalance()%>" />
									<input type="hidden" name="mlev" value="<%=(memberVO == null) ? "G" : memberVO.getMlev()%>" />
									<input type="hidden" name="millegal" value="<%=(memberVO == null) ? "0" : memberVO.getMillegal()%>" />
									<input type="hidden" name="massess" value="<%=(memberVO == null) ? "0" : memberVO.getMassess()%>" />
									<input type="hidden" name="mverification" value="<%=(memberVO == null) ? "N" : memberVO.getMverification()%>" />
													
									<button class="btn btn-danger">���U</button>
								</div>
							</div>

						</fieldset>
					</form>

				</div>
			</div>


	<%@ include file="/front/footer.jsp"%>

</body>
</html>