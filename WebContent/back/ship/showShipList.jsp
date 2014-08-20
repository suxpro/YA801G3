<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.ship.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%!//定義返回的日期格式
	static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");//定義返回的日期格式

	//去掉時間的毫秒數方法
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//格式化傳過來的時間就可以去掉毫秒數
		else
			return "";
	}%>
<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>配送資料查詢結果 - showShipList.jsp</title> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->

<table class="table table-hover">
	<tr class="info">
		<th style ="text-align:center">訂單編號</th>
		<th style ="text-align:center">租物編號</th>
		<th style ="text-align:center">租物名稱</th>
		<th style ="text-align:center">租物分類</th>
		<th style ="text-align:center">等待配送時間</th>
		<th style ="text-align:center">待出貨會員</th>
		<th style ="text-align:center">會員電話</th>
		<th style ="text-align:center">取貨地址</th>
		<th style ="text-align:center">待收貨會員</th>
		<th style ="text-align:center">會員電話</th>
		<th style ="text-align:center">送貨地址</th>
	</tr>
	<c:forEach var="shipVO" items="${shipList}">
								<%
								String start_time = getTimestampString(((ShipVO) pageContext.getAttribute("shipVO")).getStart_time());
												  String start_time_D = "";
												  String start_time_T = "";
												  if(start_time != ""){
													  start_time_D = start_time.substring(0, 10);
													  start_time_T = start_time.substring(11, 19);
												  }
												  
							%>
		<tr align='center' valign='middle'>
			<td style ="text-align:center">${shipVO.ord_no}</td>
			<td style ="text-align:center">${shipVO.rent_no}</td>
			<td style ="text-align:center">${shipVO.rent_name}</td>
			<td style ="text-align:center">${tag_staMap[shipVO.tag_no]}</td>
			<td style="text-align: center">
			<%=start_time_D%><br><%=start_time_T%></td>
			<td style ="text-align:center">${shipVO.rec_mem}</td>	
			<td style ="text-align:center">${shipVO.rec_cell}</td>
			<td style ="text-align:center">${shipVO.rec_addr}</td>
			<td style ="text-align:center">${shipVO.dest_mem}</td>
			<td style ="text-align:center">${shipVO.dest_cell}</td>
			<td style ="text-align:center">${shipVO.dest_addr}</td>		

		</tr>
	</c:forEach>
</table>

<!-- </body> -->
<!-- </html> -->
