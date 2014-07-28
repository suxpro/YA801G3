<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.prerent.model.*"%>
<%
	PrentVO prentVO = (PrentVO) request.getAttribute("prentVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>預租資料新增 - addPrent.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>預租資料新增 - addPrent.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/front/prent/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">回首頁</a></td>
		</tr>

		<h3>預租資料:</h3>
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

		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/prent/prent.do" name="form1"
			enctype="multipart/form-data">
			<table border="0">

				<jsp:useBean id="RentSvc" scope="page"
					class="front.rent.model.RentService" />

				<tr>
					<td>租物編號:</td>
					<td><select size="1" name="rent_no">
							<c:forEach var="rentVO" items="${RentSvc.all}">
								<option value="${rentVO.rent_no}"
									${(prentVO.rent_no==rentVO.rent_no)? 'selected':'' }>${rentVO.rent_no}
							</c:forEach>
					</select></td>
					<td>${errorMsgs.rent_no}</td>
				</tr>

				<jsp:useBean id="MemberSvc" scope="page"
					class="front.member.model.MemberService" />

				<tr>
					<td>承租者:<font color=red><b>*</b></font></td>
					<td><select size="1" name="ten_no">
							<c:forEach var="memberVO" items="${MemberSvc.all}">
								<option value="${memberVO.mno}"
									${(prentVO.ten_no==memberVO.mno)? 'selected':'' }>${memberVO.mno}
							</c:forEach>
					</select></td>
					<td>${errorMsgs.ten_no}</td>
				</tr>

				<tr>
					<%
						java.sql.Date date_SQL = new java.sql.Date(
								System.currentTimeMillis());
					%>
					<td>預租日期:</td>
					<td bgcolor="#CCCCFF"><input class="cal-TextBox"
						onFocus="this.blur()" size="9" readonly type="text"
						name="prent_time"
						value="<%=(prentVO == null) ? date_SQL : prentVO.getPrent_time()%>">
						<a class="so-BtnLink" href="javascript:calClick();return false;"
						onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
						onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
						onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','prent_time','BTN_date');return false;">
							<img align="middle" border="0" name="BTN_date"
							src="images/btn_date_up.gif" width="22" height="17" alt="開始日期">
					</a></td>
					<td>${errorMsgs.prent_time}</td>
				</tr>

				<tr>
					<td>預租天數:<font color=red><b>*</b></font></td>
					<td><input type="TEXT" name="prent_days" size="45"
						value="<%=(prentVO == null) ? "3" : prentVO.getPrent_days()%>" /></td>
						<td>${errorMsgs.prent_days}</td>
				</tr>

				<tr>
					<td>預租資料有效:<font color=red><b>*</b></font></td>
					<td><select size="1" name="prent_flag">
							<option value="Y">預租成功</option>
							<option value="N" selected>預租失敗</option>
					</select></td>
				</tr>

				<jsp:useBean id="OrdSvc" scope="page"
					class="com.ord.model.OrdService" />

				<tr>
					<td>訂單編號:</td>
					<td><select size="1" name="ord_no">
							<c:forEach var="ordVO" items="${OrdSvc.all}">
								<option value="${ordVO.ord_no}"
									${(prentVO.ord_no==ordVO.ord_no)? 'selected':'' }>${ordVO.ord_no}
							</c:forEach>
					</select></td>
				</tr>


			</table>
			<br> <input type="hidden" name="action" value="insert">
			<input type="submit" value="送出新增">
		</FORM>

	</table>
</body>
</html>