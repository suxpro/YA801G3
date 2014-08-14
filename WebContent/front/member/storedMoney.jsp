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
<title>會員儲值 - storedMoney.jsp</title>

<style type="text/css">


#memform {width:90%;}


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
			<div class="panel-group" id="accordion">
<!-- 會員資料 -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          會員管理
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
        <li class="active"><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
        <li><a href="#" onclick="document.updateVIP.submit();">升級會員</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 租物管理  -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          租物管理
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物資料</a></li>
        <li><a href="<%=request.getContextPath()%>/front/rent/addRent.jsp">新增租物</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 承租管理 -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
         承租管理
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租資料</a></li>
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物清單</a></li>
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
        <li><a href="#">續租查詢</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  
  <!-- 出租管理  -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
          出租管理
        </a>
      </h4>
    </div>
    <div id="collapseFour" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">訂單核准</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 歷史租借查詢 -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">
          歷史租借查詢
        </a>
      </h4>
    </div>
  </div>

</div>
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
										<b>會員儲值</b>
									</h2>
								</legend>
							</div>

								<div class="col-md-4 col-md-offset-1">
									<!-- 排版 -->
									
									<!-- 會員帳戶餘額 -->
									<div id="textbox" class="control-group  ">
										<h4>									
										<label class="control-label" for="mbalance">請選擇要儲值的金額</label>
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
								<!-- 排版 -->
								
								<div class="col-md-5 col-md-offset-1">
									<!-- 排版 -->
									<!-- 會員儲值方式 -->
									<div id="textbox" class="control-group  ">
										<h4>									
										<label class="control-label" for="mbalance">請選擇要儲值的方式</label>
										</h4>
										
										<div class="col-xs-offset-1">		
<!-- 											<select size="1" name="" onchange="Action()"> -->
<!-- 													<option name="money" >請選擇方式</option> -->
<!-- 													<option value="atm" name="money" >匯款</option> -->
<!-- 													<option value="card" name="money" >信用卡</option> -->
<!-- 											</select> -->
											
											
<!-- 											<input type="radio" value="money" name="money" onclick = "show()">現金付款 -->
											<input type="radio" value="card" name="money" onclick = "showBank()">信用卡付款
											<input type="radio" value="atm" name="money" onclick ="showCard()">ATM
											
											<div style='display:none' id="atm">
												銀行代號：<input type="text" name="aNum"><br/>
												扣款代號：<input type="text" name="sA">
											</div>		
											<div style='display:none' id="card">
												信用卡號碼：<input type="text" name="cNum"><br/>
												到期年月：　<input type="text" name="mon">
											</div>
											
            							</div>		
										<br/>																		
										<br/>
									</div>																		
								</div>
								<!-- 排版 -->
							
							
							<br/>

							
									<!-- Submit -->
									<div class="control-group col-xs-9 col-xs-offset-9">
										<div class="controls">
											<input type="hidden" name="action" value="storedMoney">
											<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
											<button class="btn btn-success">確定</button>
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