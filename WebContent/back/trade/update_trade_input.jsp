<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="back.trade.model.*"%>
<%
	TradeVO tradeVO = (TradeVO) request.getAttribute("tradeVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>會員資料修改 - update_trade_input.jsp</title>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>會員資料修改 - update_trade_input.jsp</h3> <a href="<%=request.getContextPath()%>/back/trade/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/trade/trade.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">
			<jsp:useBean id="MemberSvc" scope="page"
				class="back.member.model.MemberService" />

			<tr>
				<td>交易編號:<font color=red><b>*</b></font></td>
				<td><%=tradeVO.getTno()%></td>
			</tr>

			<tr>
				<td>會員名稱:<font color=red><b>*</b></font></td>
				<td><select size="1" name="mno">
						<c:forEach var="memberVO" items="${MemberSvc.all}">
							<option value="${memberVO.mno}"
								${(tradeVO.mno==memberVO.mno)? 'selected':'' }>${memberVO.mname}
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>會員金融帳號:</td>
				<td><input type="TEXT" name="tmid" size="45"
					value="<%=(tradeVO == null) ? "1452159612587532" : tradeVO
					.getTmid()%>" /></td>
				<td>${errorMsgs.tmid}</td>
			</tr>

			<tr>
				<%
					java.sql.Date date_SQL = new java.sql.Date(
							System.currentTimeMillis());
				%>
				<td>交易日期:</td>
				<td bgcolor="#CCCCFF"><input class="cal-TextBox"
					onFocus="this.blur()" size="9" readonly type="text" name="tdate"
					value="<%=(tradeVO == null) ? date_SQL : tradeVO.getTdate()%>">
					<a class="so-BtnLink" href="javascript:calClick();return false;"
					onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
					onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
					onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','tdate','BTN_date');return false;">
						<img align="middle" border="0" name="BTN_date"
						src="images/btn_date_up.gif" width="22" height="17" alt="開始日期">
				</a></td>
				<td>${errorMsgs.tdate}</td>
			</tr>

			<tr>
				<td>會員金融紀錄狀態:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tstas">
						<option value="金錢匯入" selected>金錢匯入</option>
						<option value="金錢匯出">金錢匯出</option>
						<option value="點數收入">點數收入</option>
						<option value="點數支出">點數支出</option>
						<option value="點數退還">點數退還</option>
						<option value="點數逾期收入">點數逾期收入</option>
						<option value="點數逾期支出">點數逾期支出</option>
				</select></td>
			</tr>
			<tr>
				<td>交易金額:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="tfunds" size="45"
					value="<%=(tradeVO == null) ? "10000" : tradeVO.getTfunds()%>" /></td>
				<td>${errorMsgs.tfunds}</td>
			</tr>

			<tr>
				<td>匯款確認:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tin">
						<option value="Y">已匯款</option>
						<option value="N" selected>未匯款</option>
				</select></td>
			</tr>



		</table>
		<br> <input type="hidden" name="action" value="update"> 
			 <input type="hidden" name="tno" value="<%=tradeVO.getTno()%>"> 
			 <input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--原送出修改的來源網頁路徑,從request取出後,再送給Controller準備轉交之用-->
			 <input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
			 <input type="submit" value="送出修改">
	</FORM>
			
</body>
</html>