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
<title>�|���x�� - storedMoney.jsp</title>

<style type="text/css">


#memform {width:94%;}


</style>

<script type="text/javascript">

	function show(){
 		document.getElementById("atm").style.display="none";
 		document.getElementById("card").style.display="none";
 	}

 	function showBank(){
 		document.getElementById("atm").style.display="none";
 		document.getElementById("card").style.display="";
 	}
 	function showCard(){
 		document.getElementById("atm").style.display="";
 		document.getElementById("card").style.display="none";
 	}
 	
	function Action(){
		document.getElementsByName("money")[0].onclick=show;
		document.getElementsByName("money")[1].onclick=showBank;
		document.getElementsByName("money")[2].onclick=showCard;
	}

</script>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>


</head>
<body>

	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">
		
<!-- SideBar -->
			<div class="col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="#" onclick="document.updateMemInfo.submit();">�|����ƭק�</a></li>
					<li class="active"><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
					<li><a href="#">�X���޲z</a></li>
					<li><a href="#">�q��޲z</a></li>
					<li><a href="#">���v���ɬd��</a></li>
					<li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
				</ul>
			</div>
			
<!-- Form -->
			<div class="col-md-offset-0">
				
					<form class="form-horizontal" id="memform" METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/memberStored.do"
						name="form1" enctype="multipart/form-data" role="form">
						<fieldset>
							<div id="legend">
								<legend class="">
									<h2>
										<b>�|���x��</b>
									</h2>
								</legend>
							</div>

								<div class="col-md-4">
									<!-- �ƪ� -->
									
									<!-- �|���b��l�B -->
									<div id="textbox" class="control-group  ">
										<h4>									
										<label class="control-label" for="mbalance">�п�ܭn�x�Ȫ����B</label>
										</h4>
										
										<div class="col-xs-offset-2">		
            									<input type="radio" id="mbalance" name="cash" value="500" checked >
            									&nbsp;&nbsp;$&nbsp;500 NT<br/>
            									<input type="radio" id="mbalance" name="cash" value="1000"	>
            									&nbsp;&nbsp;$&nbsp;1000 NT<br/>
            									<input type="radio" id="mbalance" name="cash" value="2000"	>
            									&nbsp;&nbsp;$&nbsp;2000 NT<br/>
            									<input type="radio" id="mbalance" name="cash" value="3000"	>
            									&nbsp;&nbsp;$&nbsp;3000 NT<br/>
            									<input type="radio" id="mbalance" name="cash" value="5000"	>
            									&nbsp;&nbsp;$&nbsp;5000 NT<br/>
            									<input type="radio" id="mbalance" name="cash" value="10000"	>
            									&nbsp;&nbsp;$&nbsp;10000 NT<br/>
            							</div>		
										<br/>																		
										<br/>
									</div>																		
								</div>
								<!-- �ƪ� -->
								
								<div class="col-md-4">
									<!-- �ƪ� -->
									<!-- �|���x�Ȥ覡 -->
									<div id="textbox" class="control-group  ">
										<h4>									
										<label class="control-label" for="mbalance">�п�ܭn�x�Ȫ��覡</label>
										</h4>
										
										<div class="col-xs-offset-1">		
											<select size="1" name="" onchange="Action()">
													<option name="money" >�п�ܤ覡</option>
													<option value="atm" name="money" >�״�</option>
													<option value="card" name="money" >�H�Υd</option>
											</select>
											
											<br/>
											<input type="radio" value="money" name="money" onclick = "show()">�{���I��
											<input type="radio" value="card" name="money" onclick = "showBank()">�H�Υd�I��
											<input type="radio" value="atm" name="money" onclick ="showCard()">ATM
											
											<div style='display:none' id="atm">
												�Ȧ�N���G�@<input type="text" name="aNum">
												���ڥN���G<input type="text" name="sA">
											</div>		
											<div style='display:none' id="card">
												�H�Υd���X�G<input type="text" name="cNum">
												����~��G<input type="text" name="mon">
											</div>
											
            							</div>		
										<br/>																		
										<br/>
									</div>																		
								</div>
								<!-- �ƪ� -->
							
							
							<br/>

							
									<!-- Submit -->
									<div class="control-group col-xs-8 col-xs-offset-8">
										<div class="controls">
											<input type="hidden" name="action" value="storedMoney">
											<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
											<button class="btn btn-success">�T�w</button>
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