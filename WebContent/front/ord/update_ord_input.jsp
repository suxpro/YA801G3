<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="back.loc.model.*"%>
<%
	OrdVO ordVO = (OrdVO) request.getAttribute("ordVO");    
	RentService rentSvc = new RentService();
    RentVO rentVO = rentSvc.getOneRent(ordVO.getRent_no());
    request.setAttribute("rentVO",rentVO);
%>
<html>
<head>
<title>訂單資料修改 - update_que_input.jsp</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
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
			defaultDate : +1,
			minDate : +1,
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
							defaultDate : +1,
							minDate : +1,
							numberOfMonths : 2,
							changeYear : true,
							changeMonth : true,
							onClose : function(selectedDate) {
								if ($.trim(selectedDate) != "") {
									var date = $("#exp_date").datepicker(
											"getDate");
									date.setDate(date.getDate() );
									var date_str = $.datepicker.formatDate(
											"yy-mm-dd", date);
									$("#ten_date").datepicker("option",
											"maxDate", date_str);
								}
							}
						});
	});
	//-------------------------------------------------------------------------------
</script>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>訂單資料編輯 - update_ord_input.jsp</h3> 
				<a href="<%=request.getContextPath() %>/front/ord/select_page.jsp">
				<img src="<%=request.getContextPath() %>/front/ord/images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front/ord/ord.do" name="form1">
		<table border="0">

			<tr>
				<td>訂單編號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ord_no" size="10"
					value="<%=ordVO.getOrd_no()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>租物編號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_no" size="10"
					value="<%=ordVO.getRent_no()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_name" 
					value="${rentVO.rent_name}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>承租會員(編號):<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_no" size="10"
					value="<%=ordVO.getTen_no()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>訂單狀態:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ord_sta" size="10"
					value="<%=ordVO.getOrd_sta()%>" readonly="readonly" /></td>
			</tr>			
			<tr>
				<td>交易方式:<font color=red><b>*</b></font></td>
				<td><select size="1" id="tra_mode" name="tra_mode">
						<c:forEach var="tra" items="${tra_staMap.keySet()}">
							<option value="${tra}"
								${(ordVO.tra_mode==tra)? 'selected': 0}>${tra_staMap[tra]}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>運費:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" id="freight" name="freight" size="10"
					value="0" class="tra_total" readonly="readonly" /></td>
			</tr>
			<script>
				var freight = ${freight};
				$("#tra_mode").change(function() {
					if ($("#tra_mode").val() == "FORWARDER")
						$("#freight").val(freight);
					else
						$("#freight").val(0);
					var tra_total = Number($("#freight").val()) + Number($("#rent_total").val()) + Number($("#init_dps").val());
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
				<td>承租天數:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_days" id="ten_days"
					value="${ordVO.ten_days}" readonly="readonly" /></td>
			</tr>
			<script>
				$(".date").change(
						function() {
							if ($.trim($("#ten_date").val()) != ""
									&& $.trim($("#exp_date").val()) != "") {
								var date1 = $("#ten_date")
										.datepicker("getDate");
								var date2 = $("#exp_date")
										.datepicker("getDate");
								var days = ((date2 - date1)
										/ (24 * 60 * 60 * 1000L))+1;
								if (days < 0)
									days = 0;
								$("#ten_days").val(days);
							} else
								$("#ten_days").val(0);
							var rent_total = $("#ten_days").val() * $("#unit_price").val();
							$("#rent_total").val(rent_total);
							var tra_total = Number($("#freight").val()) + Number($("#rent_total").val()) + Number($("#init_dps").val());
							$("#tra_total").val(tra_total);
							
						});			
			</script>
			<tr>
				<td>租金/天:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="unit_price" id="unit_price"
					value="${rentVO.unit_price}" readonly="readonly" /></td>
			</tr>			
			<tr>
				<td>租金總額:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_total" id="rent_total" class="tra_total"
					value="${ordVO.rent_total}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>租物押金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="init_dps" id="init_dps"
					value="${ordVO.init_dps}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>交易總額:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="tra_total" id="tra_total"
					value="${ordVO.tra_total}" readonly="readonly" /></td>
			</tr>
			<!--  
			<script>
			$(".tra_total").change(function() {
				var tra_total = Number($("#freight").val()) + Number($("#rent_total").val()) + Number($("#init_dps").val());
				$("#tra_total").val(tra_total);
			}).change();
			
			</script>
            -->
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
		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="ord_no" value="<%=ordVO.getOrd_no()%>"> <input
			type="submit" value="送出編輯">
	</FORM>

</body>
</html>
