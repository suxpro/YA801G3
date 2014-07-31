<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.que.model.*"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>

<%
	QueService queSvc = new QueService();
    List<QueVO> list = queSvc.getAll();
    pageContext.setAttribute("list",list);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有問題資料 - listAllQue.jsp</title>
</head>
<body bgcolor='white'>
<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td><h3>所有問題資料 - ListAllQue.jsp</h3>
		          <a href="<%=request.getContextPath() %>/front/que/select_page.jsp">
		          <img src="<%=request.getContextPath() %>/front/que/images/back1.gif" width="100" height="32" border="0">回首頁</a></td></tr></table>

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

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>問題編號</th>
		<th>租物編號</th>
		<th>發問會員</th>
		<th>問題狀態</th>
		<th>發問時間</th>
		<th>問題描述</th>
		<th>回答時間</th>
		<th>回答描述</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="queVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle'>
			<td>${queVO.que_no}</td>
			<td>${queVO.rent_no}</td>
			<td>${queVO.que_mem}</td>
			<td>${queVO.que_sta}</td>
			<td>${queVO.que_time}</td>
			<td>${queVO.que_desc}</td>
			<td>${queVO.ans_time}</td>
			<td>${queVO.ans_desc}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/que/que.do">
			     <input type="submit" value="回覆">
			     <input type="hidden" name="que_no" value="${queVO.que_no}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/que/que.do">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="que_no" value="${queVO.que_no}">
			    <input type="hidden" name="action"value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>
