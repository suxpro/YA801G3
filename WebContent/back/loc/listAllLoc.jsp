<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.loc.model.*"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>

<%
    LocService locSvc = new LocService();
    List<LocVO> list = locSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有地區資料 - listAllLoc.jsp</title>
</head>
<body bgcolor='white'>
<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td><h3>所有地區資料 - ListAllLoc.jsp</h3>
		          <a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></td></tr></table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li>${message}</li>
		</c:forEach>
	</ul>
	</font>
</c:if>

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>地區編號</th>
		<th>地區敘述</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="locVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle'>
			<td>${locVO.loc_no}</td>
			<td>${locVO.loc_desc}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/loc/loc.do">
			     <input type="submit" value="修改">
			     <input type="hidden" name="loc_no" value="${locVO.loc_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/loc/loc.do">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="loc_no" value="${locVO.loc_no}">
			    <input type="hidden" name="action"value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
