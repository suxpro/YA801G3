<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<html>
<head>
<title>配送資料查詢結果 - showShipList.jsp</title>
</head>
<body bgcolor='white'>

<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3><font color=red>複合查詢</font>配送資料查詢結果 - showShipList.jsp</h3>
		<a href="<%=request.getContextPath()%>/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
		</td>
	</tr>
</table>


<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>訂單編號</th>
		<th>租物編號</th>
		<th>租物名稱</th>
		<th>租物分類</th>
		<th>等待配送時間</th>
		<th>待出貨會員</th>
		<th>會員電話</th>
		<th>取貨地址</th>
		<th>待收貨會員</th>
		<th>會員電話</th>
		<th>送貨地址</th>
	</tr>
	<c:forEach var="shipVO" items="${shipList}">
		<tr align='center' valign='middle'>
			<td>${shipVO.ord_no}</td>
			<td>${shipVO.rent_no}</td>
			<td>${shipVO.rent_name}</td>
			<td>${tag_staMap[shipVO.tag_no]}</td>
			<td>${shipVO.start_time}</td>
			<td>${shipVO.rec_mem}</td>	
			<td>${shipVO.rec_cell}</td>
			<td>${shipVO.rec_addr}</td>
			<td>${shipVO.dest_mem}</td>
			<td>${shipVO.dest_cell}</td>
			<td>${shipVO.dest_addr}</td>		

		</tr>
	</c:forEach>
</table>
</body>
</html>
