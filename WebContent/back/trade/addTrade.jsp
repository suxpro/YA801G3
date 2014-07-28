<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.trade.model.*"%>
<%
	TradeVO tradeVO = (TradeVO) request.getAttribute("tradeVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�����Ʒs�W - addTrade.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�����Ʒs�W - addTrade.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/back/trade/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">�^����</a></td>
		</tr>

		<h3>������:</h3>
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

		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/trade/trade.do" name="form1" enctype="multipart/form-data">
			<table border="0">
				<jsp:useBean id="MemberSvc" scope="page"
					class="back.member.model.MemberService" />

				<tr>
					<td>�|���s��:<font color=red><b>*</b></font></td>
					<td><select size="1" name="mno">
							<c:forEach var="memberVO" items="${MemberSvc.all}">
								<option value="${memberVO.mno}"
									${(tradeVO.mno==memberVO.mno)? 'selected':'' }>${memberVO.mno}
							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<td>�|�����ıb��:</td>
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
					<td>������:</td>
					<td bgcolor="#CCCCFF"><input class="cal-TextBox"
						onFocus="this.blur()" size="9" readonly type="text" name="tdate"
						value="<%=(tradeVO == null) ? date_SQL : tradeVO.getTdate()%>">
						<a class="so-BtnLink" href="javascript:calClick();return false;"
						onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
						onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
						onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','tdate','BTN_date');return false;">
							<img align="middle" border="0" name="BTN_date"
							src="images/btn_date_up.gif" width="22" height="17" alt="�}�l���">
					</a></td>
					<td>${errorMsgs.tdate}</td>
				</tr>

				<tr>
					<td>�|�����Ĭ������A:<font color=red><b>*</b></font></td>
					<td><select size="1" name="tstas">
							<option value="�����פJ" selected>�����פJ</option>
							<option value="�����ץX">�����ץX</option>
							<option value="�I�Ʀ��J">�I�Ʀ��J</option>
							<option value="�I�Ƥ�X">�I�Ƥ�X</option>
							<option value="�I�ưh��">�I�ưh��</option>
							<option value="�I�ƹO�����J">�I�ƹO�����J</option>
							<option value="�I�ƹO����X">�I�ƹO����X</option>
					</select></td>
				</tr>
				<tr>
					<td>������B:<font color=red><b>*</b></font></td>
					<td><input type="TEXT" name="tfunds" size="45"
						value="<%=(tradeVO == null) ? "10000" : tradeVO.getTfunds()%>" /></td>
					<td>${errorMsgs.tfunds}</td>
				</tr>

				<tr>
					<td>�״ڽT�{:<font color=red><b>*</b></font></td>
					<td><select size="1" name="tin">
							<option value="Y">�w�״�</option>
							<option value="N" selected>���״�</option>
					</select></td>
				</tr>


			</table>
			<br> <input type="hidden" name="action" value="insert">
			<input type="submit" value="�e�X�s�W">
		</FORM>

	</table>
</body>
</html>