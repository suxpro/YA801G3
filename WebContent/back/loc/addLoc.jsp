<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="back.loc.model.*"%>

<html>
<head>
<title>�a�ϸ�Ʒs�W - addLoc.jsp</title></head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='500'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>�a�ϸ�Ʒs�W - addLoc.jsp</h3></td>
			<td><a href="select_page.jsp"><img src="images/tomcat.gif"	width="100" height="100" border="1"> �^���� </a></td></tr></table>

<h4>�a�ϸ��:<font color=red><b>*</b></font>���������</h4>
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

<FORM METHOD="post" ACTION="loc.do" name="form1">
<table border="0">

	<tr>
		<td>�a�ϱԭz:<font color=red><b>*</b></font></td>
		<td><input type="TEXT" name="loc_desc" size="45" 
			 value="${param.loc_desc}"/></td><td>${errorMsgs.loc_desc}</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�e�X�s�W"></FORM>
</body>

</html>
