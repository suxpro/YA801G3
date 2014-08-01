<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="back.loc.model.*"%>
<%@ page import="java.util.*"%>
<%
//	OrdVO ordVO = (OrdVO) request.getAttribute("ordVO");
%>

<html>
<head>
<title>租物訂單新增 - addOrd.jsp</title>
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
					date.setDate(date.getDate() + 0);
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
									date.setDate(date.getDate() - 0);
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

	<table border='1' cellpadding='5' cellspacing='0' width='500'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>租物訂單新增 - addOrd.jsp</h3></td>
			<td><a href="<%=request.getContextPath()%>/front/ord/select_page.jsp">
			    <img src="<%=request.getContextPath()%>/front/ord/images/tomcat.gif" width="100" height="100" border="1"> 回首頁 </a></td>
		</tr>
	</table>

	<h4>
		問題資料:<font color=red><b>*</b></font>為必填欄位
	</h4>
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

			<jsp:useBean id="rentSvc" scope="page"
				class="front.rent.model.RentService" />
			<tr>
				<td>租物編號:<font color=red><b>*</b></font></td>
				<td><select size="1" name="rent_no">
						<c:forEach var="rentVO" items="${rentSvc.all}">
							<option value="${rentVO.rent_no}"
								${(param.rent_no==rentVO.rent_no)?'selected':'' }>${rentVO.rent_no}
						</c:forEach>
				</select></td>
			</tr>
			<!--  
			<tr>
				<td>租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_name" id="rent_name"
					value="${RentVO.name}" /></td>
			</tr>
-->
			<tr>
				<td>承租會員(編號):<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_no" size="6"
					value="${param.ten_no}" /></td>
			</tr>
			<tr>
				<td>訂單狀態:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ord_sta" size="10" value="待確認"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td>交易方式:<font color=red><b>*</b></font></td>
				<td><select size="1" id="tra_mode" name="tra_mode">
						<c:forEach var="tra" items="${tra_staMap.keySet()}">
							<option value="${tra}"
								${(param.tra_mode==tra)? 'selected': 0}>${tra_staMap[tra]}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>運費:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" id="freight" name="freight" size="6"
					value=0 readonly="readonly" /></td>
			</tr>
			<script>
				var freight = ${freight};		
				$("#tra_mode").change(function() {
					if ($("#tra_mode").val() == "FORWARDER")
						$("#freight").val(freight);
					else
						$("#freight").val(0);
				}).change();
			</script>

			<tr>
				<td>承租日期:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_date" id="ten_date"
					class="date" value="${param.ten_date}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>到期日期:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="exp_date" id="exp_date"
					class="date" value="${param.exp_date}" readonly="readonly" /></td>
			</tr>

			<tr>
				<td>承租天數:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ten_days" id="ten_days"
					value="${param.ten_days}" readonly="readonly" /></td>
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
										/ (24 * 60 * 60 * 1000))+1;
								if (days < 0)
									days = 0;
								$("#ten_days").val(days);
							} else
								$("#ten_days").val(0);
						});
			</script>
			<!--  
			<tr>
				<td>租金/天:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_total" id="rent_total"
					value="${RentVO.unit_price}" /></td>
			</tr>

			<tr>
				<td>租金總額:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_total" id="rent_total"
					value="${param.rent_total}" /></td>
			</tr>
			<tr>
				<td>逾期天數:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ot_days" id="ot_days" value="${param.ot_days}"/></td>
			</tr> 			
			<tr>
				<td>初始押金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="init_dps" id="init_dps" value="${param.init_dps}"/></td>
			</tr>

			<tr>
				<td>租物押金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="real_dps" id="real_dps"
					value="${param.real_dps}" /></td>
			</tr>
			<tr>
				<td>交易總額:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="tra_total" id="tra_total"
					value="${param.tra_total}" /></td>
			</tr>
 -->
			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />
			<tr>
				<td>收貨地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="loc_no">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(param.loc_no==locVO.loc_no)?'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>收貨地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rec_addr" size="45"
					value="${param.rec_addr}" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>
</html>
