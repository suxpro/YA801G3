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

#memform {width:85%;}  

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

</head>
<body>

	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

<!-- SideBar -->
			<div class="col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
					<li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
					<li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
					<li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�����޲z</a></li>
					<li><a href="#">�X���޲z</a></li>
					<li><a href="#">�q��޲z</a></li>
					<li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">���v���ɬd��</a></li>
				</ul>
			</div>
			
						
<!-- Form -->
			<div class="col-md-offset-0">
			
					<form class="form-horizontal" id="memform" METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do"
						name="form1" enctype="multipart/form-data" role="form">
						<fieldset>
							<div id="legend">
								<legend >
									<h2>
										<b>�|����ƭק�</b>
									</h2>
								</legend>
							</div>

							
								<div class="col-md-5 col-md-offset-1">
									<!-- �ƪ� -->

									<!-- �|���s�� -->
<!-- 									<div class="control-group  "> -->
<!-- 										<label class="control-label" for="username">�|���s��</label>  -->
<%-- 										<label class="control-label col-xs-offset-1" id="username"><%=memberVO.getMno()%></label> --%>
<!-- 									</div> -->

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
										<label class="control-label" for="locno">�a�ϡ@�@</label>
										<select size="1" name="locno" class="col-xs-offset-1">
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
								<div class="col-md-offset-7 sidebar-offcanvas ">
									<!-- �Ϥ��ƪ� -->

									<!-- �|���Ϥ� -->
									<div class="control-group ">
										<label class="control-label" for="mpic">�|���Ϥ�</label>
										<div class="controls">
											<img id="mpic" width="80" height="80"
												src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
											<input type="file" id="mpic" name="mpic" />
										</div>
									</div>
									<c:if test="${memberVO.mlev == 'V' }">
										<!-- �|�������Ϥ� -->
										<div class="control-group  ">
											<label class="control-label" for="password_confirm">�|�������Ϥ�</label>
											<div class="controls">
												<img id="mvpic" width="80" height="80"
													src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
												<input type="file" id="mvpic" name="mvpic"  />
											</div>
										</div>
									</c:if>
									 								

								</div>
								<!-- �Ϥ��ƪ� -->
								<br>
								<div class="col-xs-offset-0 sidebar-offcanvas">
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
																					
							<br>
							<!-- Submit -->
							<div class="control-group col-xs-9 col-xs-offset-9">
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


	<%@ include file="/front/footer.jsp"%>
</body>
</html>