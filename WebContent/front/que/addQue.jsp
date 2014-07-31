<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.que.model.*"%>
<%
	QueVO queVO = (QueVO) request.getAttribute("queVO");
%>

<html>
<head>
<title>租物問題新增 - addQue.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='500'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>租物問題新增 - addQue.jsp</h3></td>
			<td><a href="<%=request.getContextPath() %>/front/que/select_page.jsp">
			<img src="<%=request.getContextPath() %>/front/que/images/tomcat.gif"
					width="100" height="100" border="1"> 回首頁 </a></td>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front/que/que.do" name="form1">
		<table border="0">

			<tr>
				<td>租物編號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_no" size="45"
					value="${param.rent_no}" /></td>
			</tr>
			<tr>
				<td>發問會員(編號):<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="que_mem" size="45"
					value="${param.que_mem}" /></td>
			</tr>
			<tr>
				<td>問題狀態:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="que_sta" size="10" value="發問中"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<%
					java.sql.Timestamp date_SQL = new java.sql.Timestamp(
							System.currentTimeMillis());
				%>
				<td>發問時間:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="que_time" size="20"
					value="<%=(queVO == null) ? date_SQL : queVO.getQue_time()%>"></td>
			</tr>
			<tr>
				<td valign="top">問題描述:<font color=red><b>*</b></font></td>
				<td><textarea name="que_desc" maxlength="100" cols="35"
						rows="5" style="resize: none">${param.que_desc}</textarea></td>
			</tr>
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

</html>
