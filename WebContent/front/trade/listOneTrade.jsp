<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.trade.model.*"%>
<%
	TradeVO tradeVO = (TradeVO) request.getAttribute("tradeVO"); //TradeServlet.java(Concroller), 存入req的empVO物件
%>
<jsp:useBean id="memberSvc" scope="page"
	class="front.member.model.MemberService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>交易資料 - listOneTrade.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>會員資料 - listOneMember.jsp</h3> <a href="<%=request.getContextPath()%>/front/trade/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>交易紀錄編號</th>
			<th>會員編號</th>
			<th>會員金融帳號</th>
			<th>交易時間</th>
			<th>會員金融紀錄狀態</th>
			<th>交易金額</th>
			<th>匯款確認</th>
		</tr>
		<tr align='center' valign='middle'>
			<td>${tradeVO.tno}</td>
				<td><c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${tradeVO.mno==memberVO.mno}">
	                    ${memberVO.mno}【${memberVO.mname}】
                    </c:if>
					</c:forEach></td>
			<td>${tradeVO.tmid}</td>
			<td>${tradeVO.tdate}</td>
			<td>${tradeVO.tstas}</td>
			<td>${tradeVO.tfunds}</td>
			<td>${tradeVO.tin}</td>		

		</tr>
	</table>
</body>
</html>