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
<title>JustRent! - �|����ƭק�</title>

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

#memform {
	width: 85%;
}
</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
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

				<div class="panel-group" id="accordion">
					<!-- �|����� -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne"> �|���޲z </a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li class="active"><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
									<li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
									<li><a href="#"
										onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- �����޲z  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo"> �����޲z </a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�������</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/rent/addRent.jsp">�s�W����</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- �ӯ��޲z -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseThree"> �ӯ��޲z </a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/cart/cart.jsp">������</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">�ӯ��M��</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">�l�ܲM��</a></li>
								</ul>
							</div>
						</div>
					</div>


					<!-- �X���޲z  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFour"> �X���޲z </a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">�X���M��</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- ���v����  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFive"> ���v�O�� </a>
							</h4>
						</div>
						<div id="collapseFive" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">���v���ɰO��</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">���v����O��</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">���v�����O��</a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>

			</div>


			<!-- Form -->
			<div class="col-md-offset-0">

				<form class="form-horizontal" id="memform" METHOD="post"
					ACTION="<%=request.getContextPath()%>/front/member/member.do"
					name="form1" enctype="multipart/form-data" role="form">
					<fieldset>
						<div id="legend">
							<legend>
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
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=M checked class="col-xs-offset-1">&nbsp;�k&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=F class="col-xs-offset-1">&nbsp;�k
										</c:if>
								<c:if test="${memberVO.msex == 'F' }">
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=M class="col-xs-offset-1">&nbsp;�k&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=F checked class="col-xs-offset-1">&nbsp;�k
										</c:if>
							</div>

							<!-- �|����� -->
							<div class="control-group  ">
								<label class="control-label" for="mcell">�|�����</label> <input
									type="text" id="mcell" name="mcell"
									value="<%=memberVO.getMcell()%>" class="col-xs-offset-1"
									ruquired />

							</div>

							<!-- �|���l�� -->
							<div class="control-group ">
								<label class="control-label" for="mmail">�|���l��</label> <input
									type="email" id="mmail" name="mmail"
									value="<%=memberVO.getMmail()%>" class="col-xs-offset-1"
									ruquired />

							</div>

							<jsp:useBean id="locSvc" scope="page"
								class="back.loc.model.LocService" />

							<!-- �a�� -->
							<div class="control-group  ">
								<label class="control-label" for="locno">�a�ϡ@�@</label> <select
									size="1" name="locno" class="col-xs-offset-1">
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
									ruquired />

							</div>


						</div>
						<!-- �ƪ� -->
						<div class="col-md-offset-6 sidebar-offcanvas ">
							<!-- �Ϥ��ƪ� -->

							<!-- �|���Ϥ� -->
							<div class="control-group">
								<label class="control-label" for="mpic">�|���Ϥ�</label>
								<div class="controls">
									<img id="mpic" width="80" height="80"
										src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
									<input type="file" id="mpic" name="mpic" />
								</div>
							</div>
							<br />
							<div class="control-group " style="width: 300px">
								<%-- ���~��C --%>
								<c:if test="${not empty errorMsgs}">
									<div id="errorBox" class="alert alert-error">
										<a class="close" data-dismiss="alert" href="#">��</a>
										<ul class="errorBoxUl">
											<font class="bg-danger" color='red'>�Эץ��H�U���~ <c:forEach
													var="message" items="${errorMsgs}">
													<li class="bg-danger">${message.value}</li>
												</c:forEach>
											</font>
										</ul>

									</div>
								</c:if>
							</div>

						</div>
						<br />
						<div class="col-md-6 col-md-offset-2">
							<c:if test="${memberVO.mlev == 'V' }">
								<!-- �|�������Ϥ� -->
								<div class="control-group  ">
									<label class="control-label" for="mvpic">�|�������Ϥ�(<font color="red">�ФW�Ǥ@�i1680*418�s�i�Ϥ�</font>)</label>									
									<div class="controls">
									<c:if test="${memberVO.mvpic != null }">
										<img id="mvpic" width="600" height="200"
											src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
									</c:if>
										<input type="file" id="mvpic" name="mvpic" />
									</div>
									
								</div>
							</c:if>
						</div>
						<!-- �Ϥ��ƪ� -->
						<br /> <br />
						<!-- Submit -->
						<div class="control-group col-xs-9 col-xs-offset-9">
							<div class="controls">
								<input type="hidden" name="action" value="updateInfo"> <input
									type="hidden" name="mno" value="<%=memberVO.getMno()%>">
								<input type="hidden" name="requestURL"
									value="<%=request.getAttribute("requestURL")%>">
								<!--��e�X�ק諸�ӷ��������|,�qrequest���X��,�A�e��Controller�ǳ���椧��-->
								<input type="hidden" name="whichPage"
									value="<%=request.getAttribute("whichPage")%>">
								<!--�u�Ω�:istAllEmp.jsp-->

								<!--  modal updateBtn-->
								<button type="button" class="btn btn-success"
									data-toggle="modal" data-target="#UpdateBtn">�ק�</button>

								<!-- 									<button class="btn btn-success">�ק�</button> -->
							</div>
						</div>

					</fieldset>
					<!-- modal updateMemberInfo-->
					<div class="modal fade bs-example-modal-sm" id="UpdateBtn"
						tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
						aria-hidden="true" data-toggle="false">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">�|���ק���</h4>
								</div>
								<div class="modal-body">

									�O�_�T�w�ק�|����� <br /> <br />

									<button class="btn btn-danger btn-sm col-md-offset-7"
										data-dismiss="modal">����</button>
									<button class="btn btn-success btn-sm col-md-offset-0">�T�w</button>
									<!-- 		<button class="btn btn-primary col-md-offset-9" >�T�w</button> -->

								</div>
							</div>
						</div>
					</div>



				</form>

			</div>

		</div>
	</div>


	<%@ include file="/front/footer.jsp"%>
</body>
</html>