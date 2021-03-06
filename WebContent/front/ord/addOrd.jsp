<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.ord.model.*"%>
<%
	//取得租物資料
	String rent_no = (String) request.getParameter("rent_no");
	//取得來源地址
	String requestURL = (String) request.getParameter("requestURL");
	//String rent_no ="R10001";
	RentService rentSVC = new RentService();
	RentVO rentVO = rentSVC.getOneRent(rent_no);
	request.setAttribute("rentVO", rentVO);
	//取得承租會員資料(取得登入帳號)
	MemberService memberSVC = new MemberService();
// 	MemberVO memberVO = memberSVC.getOneMember("M10001"); 
	MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
	//承接錯誤回傳的ordVO
	OrdVO ordVO = (OrdVO) request.getAttribute("ordVO");
	if (ordVO == null) {
		ordVO = new OrdVO();
		ordVO.setLoc_no(memberVO.getLocno());
		ordVO.setRec_addr(memberVO.getMadrs());
		pageContext.setAttribute("ordVO", ordVO);
	}
%>
<html>
<head>
<title>JustRent! - 結帳 </title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	//----日期處理-----------------------------------------------------------------------
	$(function() {
		$("#ten_date").datepicker({
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "<%=request.getContextPath()%>/front/ord/images/calendar.gif",
			buttonImageOnly : true,
			defaultDate : +<%=rentVO.getReset_days() %>,
			minDate : +<%=rentVO.getReset_days() %>,
			numberOfMonths : 2,
			changeYear : true,
			changeMonth : true,
			onClose : function(selectedDate) {
				if ($.trim(selectedDate) != "") {
					var date = $("#ten_date").datepicker("getDate");
					date.setDate(date.getDate() );
					var date_str = $.datepicker.formatDate("yy-mm-dd", date);
					$("#exp_date").datepicker("option", "minDate", date_str);
				}
			}
		});
		$("#exp_date").datepicker({
			dateFormat : 'yy-mm-dd',
			showOn : "button",
			buttonImage : "<%=request.getContextPath()%>/front/ord/images/calendar.gif",
							buttonImageOnly : true,
							defaultDate : +<%=rentVO.getReset_days() %>,
							minDate : +<%=rentVO.getReset_days() %>,
							numberOfMonths : 2,
							changeYear : true,
							changeMonth : true,
							onClose : function(selectedDate) {
								if ($.trim(selectedDate) != "") {
									var date = $("#exp_date").datepicker(
											"getDate");
									date.setDate(date.getDate());
									var date_str = $.datepicker.formatDate(
											"yy-mm-dd", date);
									$("#ten_date").datepicker("option",
											"maxDate", date_str);
								}
							}
						});
	})
	//-------------------------------------------------------------------------------

	//超連結至會員儲值頁面
    function presses(){
    	document.open("<%=request.getContextPath()%>/front/member/memberStored.do?mno=<%=memberVO.getMno()%>&action=getOne_For_Update", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
    }
	
</script>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>


<body >
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
    <div id="collapseOne" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
        <li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
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
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物車</a></li>
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租清單</a></li>
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
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
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">出租清單</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 歷史紀錄  -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          歷史記錄
        </a>
      </h4>
    </div>
    <div id="collapseFive" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借記錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
        </ul>
      </div>
    </div>
  </div>

</div>
			</div>

			<div class="col-md-10 col-md-offset-0">
				<div id="legend">
					<legend class="">
						<h2>
							<b>結帳</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0">

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font color='red'>請修正以下錯誤:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message.value}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>

	<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do" name="form1">
		<table class="table table-condensed " cellspacing="10">


			<input type="hidden" name="rent_no" size="10" value="<%=rentVO.getRent_no()%>" readonly="readonly" />
			<input type="hidden" name="les_no" size="6" value="<%=rentVO.getLes_no()%>" readonly="readonly" />
			<tr class="success">
				<td>租物名稱:<font color=red></font></td>
				<td><input type="TEXT" name="rent_name" value="<%=rentVO.getRent_name()%>" readonly="readonly" /></td>
			</tr>
			<!-- 			<tr> -->
			<!-- 				<td>承租會員(編號):<font color=red><b>*</b></font></td> -->
			<!-- 				<td> -->
			<input type="hidden" name="ten_no" size="6" value="<%=memberVO.getMno()%>" readonly="readonly" />
			<!-- 				</td> -->
			<!-- 			</tr> -->

			<tr>
				<td>交易方式:<font color=red><b>*</b></font></td>
				<td><select size="1" id="tra_mode" name="tra_mode">
						<c:forEach var="tra" items="${tra_staMap.keySet()}">
							<option value="${tra}" ${(ordVO.tra_mode==tra)? 'selected':''}>${tra_staMap[tra]}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>運費:<font color=red></font></td>
				<td><input type="TEXT" id="freight" name="freight" size="10"
					value="0" readonly="readonly" />元</td>
			</tr>
			<script>
				var freight = ${freight};
				
				$("#tra_mode").change(
						function() {
							if ($("#tra_mode").val() == "FORWARDER")
								$("#freight").val(freight);
							else
								$("#freight").val(0);
							var tra_total = Number($("#freight").val())
									+ Number($("#rent_total").val())
									+ Number($("#init_dps").val());
							$("#tra_total").val(tra_total);

						}).change();
			</script>

			<tr>
				<td>承租日期:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_date" id="ten_date"
					class="date" value="${ordVO.ten_date}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>到期日期:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="exp_date" id="exp_date"
					class="date" value="${ordVO.exp_date}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>承租天數:<font color=red></font></td>
				<td><input type="TEXT" name="ten_days" id="ten_days"
					value="${ordVO.ten_days}" readonly="readonly" />天</td>
			</tr>
			<script>
				$(".date")
						.change(
								function() {
									if ($.trim($("#ten_date").val()) != ""
											&& $.trim($("#exp_date").val()) != "") {
										var date1 = $("#ten_date").datepicker(
												"getDate");
										var date2 = $("#exp_date").datepicker(
												"getDate");
										var days = ((date2 - date1) / (24 * 60 * 60 * 1000)) + 1;
										if (days < 0)
											days = 0;
										$("#ten_days").val(days);
									} else
										$("#ten_days").val(0);
									
									var rent_total = $("#ten_days").val()
											* $("#unit_price").val();
									$("#rent_total").val(rent_total);
									var tra_total = Number($("#freight").val())
											+ Number($("#rent_total").val())
											+ Number($("#init_dps").val());
									$("#tra_total").val(tra_total);

								});
			</script>
			<tr>
				<td>租金/天:<font color=red></font></td>
				<td><input type="TEXT" name="unit_price" id="unit_price"
					value="<%=rentVO.getUnit_price()%>" readonly="readonly" />元</td>
			</tr>
			<tr>
				<td>租金總額:<font color=red></font></td>
				<td><input type="TEXT" name="rent_total" id="rent_total"
					value="${ordVO.rent_total}" readonly="readonly" />元</td>
			</tr>
			<tr>
				<td>租物押金:<font color=red></font></td>
				<td><input type="TEXT" name="init_dps" id="init_dps"
					value="<%=rentVO.getRent_dps()%>" readonly="readonly" />元</td>
			</tr>
			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />
			<tr>
				<td>收貨地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="loc_no">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(ordVO.loc_no==locVO.loc_no)?'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>收貨地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rec_addr" size="45"
					value="${ordVO.rec_addr}" /></td>
			</tr>
			<tr>
				<td valign="top">費用總金額:<font color=red></font></td>
				<td><label style="color:red" >   =   運費 + 租金總額(租金*承租天數) + 租物押金 </label><br>
					<input type="TEXT" name="tra_total" id="tra_total"
					value="${ordVO.tra_total}" style="color:red"  readonly="readonly" />元 <br>
					<a href="#" onclick="document.storedMoney.submit();">餘額不足?  前往會員儲值</a></td>
<!-- 					<a href="javascript:presses()">餘額不足?  前往會員儲值</a></td> -->
				<%-- 					value="${ordVO.tra_total}" readonly="readonly" /></td> --%>
			</tr>
		</table>
		<br><input type="hidden" name="action" value="insert"> 
			<input type="hidden" name="ord_no" value="<%=ordVO.getOrd_no()%>">
			<input type="hidden" name="requestURL" value="<%=requestURL %>">
			<button type="submit" class="btn btn-primary">結帳</button>
	</FORM>
</div>
</div>
</div>
</div>

	<%@ include file="/front/footer.jsp"%>
</body>
</html>
