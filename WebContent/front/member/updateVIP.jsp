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
<title>JustRent! - �ɯŷ|�� </title>

<style type="text/css">
#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {
	width: 94%;
}

#textbox {
	background-color: #FFFFE4;
	text-align: center;
}

#errorVIP{

width: 300px;
text-align:center;
}
</style>

<script>
	//�T�w�s�W���s
	$("#checkVIP").off();
	$("#checkVIP").on("submit", function(event) {

		// 	function() {
		// 		alert("�T�w�ɯŬ�VIP");
		// 		}
		// 	event.preventDefault();

		// 	// grab all form data
		// 	var formData = new FormData($(this)[0]);

		// 	console.log(formData);

		// 	$.ajax({
		// 		url : $(this).attr("value"),
		// 		type : "POST",
		// 		data : formData,
		// 		async : false,
		// 		cache : false,
		// 		contentType : false,
		// 		processData : false,
		// 		success : function(data) {
		// 			$("#addEmpModel").on("hidden.bs.modal", function(e) {
		// 				$("#listAllEmp").html(data);
		// 			}).modal("hide");
		// 		},
		// 		error : function() {
		// 			alert("�t�β��`!");
		// 		}
	});
</script>


<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
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
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          �|���޲z
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
        <li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
        <li class="active"><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- �����޲z  -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          �����޲z
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�������</a></li>
        <li><a href="<%=request.getContextPath()%>/front/rent/addRent.jsp">�s�W����</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- �ӯ��޲z -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
         �ӯ��޲z
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">�ӯ����</a></li>
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">�����M��</a></li>
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">�l�ܲM��</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  
  <!-- �X���޲z  -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
          �X���޲z
        </a>
      </h4>
    </div>
    <div id="collapseFour" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">�X���M��</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- ���v���ɬd�� -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">
          ���v���ɬd��
        </a>
      </h4>
    </div>
  </div>

</div>
			
			</div>

			<!-- Form -->
			<div class="col-md-offset-0">

				<form class="form-horizontal" id="memform" METHOD="post"
					ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do"
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
							<div class="col-xs-4 col-xs-offset-3">
								<!-- �ƪ� -->

								<!-- �|���b��l�B -->
								<div id="textbox" class="control-group  ">
									<h3>
										<label class="control-label" for="mbalance">&nbsp;&nbsp;�٧U
											JUSTRENT!</label>
									</h3>
									<br /> <label class="control-label" for="mbalance">&nbsp;&nbsp;3000
										NT �ä[VIP�|��</label> <a href="#" class="control-label" for="mbalance"
										data-toggle="modal" data-target="#VIP">VIP����n�B?</a> <input
										type="hidden" id="mbalance" name="vip" value="3000"
										class="col-xs-offset-1" /> <br /> <br />
								</div>
																           								
							</div>
							<!-- �ƪ� -->

							<!-- modal VIP-->
							<div class="modal fade" id="VIP" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">
												<span aria-hidden="true">&times;</span> <span
													class="sr-only">Close</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">VIP�S�ŷ|���O����?</h4>
										</div>
										<!-- agreement -->
										<div class="modal-body">
											<%@ include file="/front/member/whatVIP.jsp"%>
										</div>
									</div>
								</div>
							</div>

						</div>
						
						        <div id="errorVIP" class="col-xs-offset-3 ">
									<%-- ���~��C --%>
									<c:if test="${not empty errorMsgs}">
										<div class="alert alert-error">
                							<a class="close" data-dismiss="alert" href="#">��</a><p class="bg-danger"><font color='red'>${errorMsgs.mbalance}</font></p>
            							</div>
									</c:if>
								</div>
						
						<br />

						<!-- Submit -->
						<div class="control-group col-md-offset-9">
							<div class="controls">
								<input type="hidden" name="action" value="updateVIP"> 
								<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
								<input type="hidden" id="mlev" name="mlev" value=V >
									
						<!--  modal VIPBtn-->
						<button type="button"  class="btn btn-success" data-toggle="modal" data-target="#VIPBtn">�ɯŷ|��</button>

							</div>
						</div>
						
					
								<!-- modal VIP-->
	<div class="modal fade bs-example-modal-sm" id="VIPBtn" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">VIP �S�ŷ|�� </h4>
				</div>
				<div class="modal-body">

		�O�_�T�w���� VIP �S�ŷ|���C
		<br/>
		<br/>

		<button id="checkVIP" class="btn btn-danger btn-sm col-md-offset-7"  data-dismiss="modal">����</button>		
		<button id="checkVIP" class="btn btn-success btn-sm col-md-offset-0" >�T�w</button>

				</div>
			</div>
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