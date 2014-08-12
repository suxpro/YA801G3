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
					<li class="active"><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
					<li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
					<li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
					<li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�����޲z</a></li>
					<li><a href="#">�X���޲z</a></li>
					<li><a href="#">�q��޲z</a></li>
					<li><a href="#">���v���ɬd��</a></li>
				</ul>
			</div>
			
						
<!-- Form -->
			<div class="col-md-offset-0">
						<fieldset>
							<div id="legend">
								<legend >
									<h2>
										<b>�|�����</b>
									</h2>
								</legend>
							</div>

							
								<div class="col-md-5 col-md-offset-1">
									<!-- �ƪ� -->

									<!-- �|���b�� -->
									<div class="control-group  ">
										<label class="control-label" for="mid">�|���b�� </label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mid}</label>
									</div>


									<!-- �|���m�W -->
									<div class="control-group  ">
										<label class="control-label" for="mname">�|���m�W</label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mname}</label>
									</div>

									<!-- �|���ʧO -->
									<div class="control-group  ">
										<label class="control-label" for="msex">�|���ʧO</label> 
										<label class="control-label col-xs-offset-1" id="msex">${mem_staMap[memberVO.msex]}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="mlev">�|������</label> 
										<label class="control-label col-xs-offset-1" id="mlev">${mem_staMap[memberVO.mlev]}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="massess">�|������</label> 
										<label class="control-label col-xs-offset-1" id="massess">${memberVO.massess}</label>
									</div>

									<!-- �|���H�W���� -->
									<div class="control-group  ">
										<label class="control-label" for="millegal">�H�W����</label> 
										<label class="control-label col-xs-offset-1" id="millegal">${memberVO.millegal}</label>
									</div>

									<!-- �|����� -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">�|�����</label>
										<label class="control-label col-xs-offset-1" id="mcell">${memberVO.mcell}</label>

									</div>

									<!-- �|���l�� -->
									<div class="control-group ">
										<label class="control-label" for="mmail">�|���l��</label> 
										<label class="control-label col-xs-offset-1" id="mmail">${memberVO.mmail}</label>
									</div>

									<!-- �a�� -->
									<div class="control-group  ">
										<label class="control-label" for="locno">�a�ϡ@�@</label>
										<label class="control-label col-xs-offset-1" id="locno">${loc_staMap[memberVO.locno]}</label>
									</div>

									<!-- �|���a�} -->
									<div class="control-group ">
										<label class="control-label" for="madrs">�|���a�}</label> 
										<label class="control-label col-xs-offset-1" id="madrs">${memberVO.madrs}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="mverification">�|������</label> 
										<label class="control-label col-xs-offset-1" id="mverification">${mem_staMap[memberVO.mverification]}</label>
									</div>
									
									<!-- �|���[�J��� -->
									<div class="control-group  ">
										<label class="control-label" for="mdate">�[�J���</label> 
										<label class="control-label col-xs-offset-1" id="mdate">${memberVO.mdate}</label>
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
										</div>
									</div>
									<c:if test="${memberVO.mlev == 'V' }">
										<!-- �|�������Ϥ� -->
										<div class="control-group  ">
											<label class="control-label" for="password_confirm">�|�������Ϥ�</label>
											<div class="controls">
												<img id="mvpic" width="80" height="80"
													src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
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
							<br>
							
							<div class="control-group col-md-8 col-md-offset-8">
								
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-warning">�ɯŷ|��</button>
									
								</FORM>
								
								<br/>
															
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/member.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-success">�ק���</button>
								</FORM>
								
								
							</div>
					
							
						</fieldset>
				
			</div>

		</div>
	</div>


	<%@ include file="/front/footer.jsp"%>
</body>
</html>