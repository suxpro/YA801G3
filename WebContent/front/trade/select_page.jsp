<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Com Trade: Home</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>Com Trade: Home</h3> <font color=red>( MVC )</font></td>
		</tr>
	</table>

	<p>This is the Home page for Com Trade: Home</p>

	<h3>資料查詢:</h3>
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

	<ul>
		<li><a href='<%=request.getContextPath()%>/front/trade/listAllTrade.jsp'>List</a> all Trades<font
			color=blue>(byDAO).</font></li>
		<br>
		<br>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/trade/trade.do">
				<b>輸入交易記錄編號 (如T10001):</b> <input type="text" name="tno"> <input
					type="submit" value="送出"><font color=blue>${errorMsgs.tno}</font> <input type="hidden" name="action"
					value="getOne_For_Display">
			</FORM>
		</li>


		<jsp:useBean id="dao" scope="page" class="front.trade.model.TradeDAO" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/trade/trade.do">
				<b>選擇交易記錄編號:</b> <select size="1" name="tno">
					<c:forEach var="tradeVO" items="${dao.all}">
						<option value="${tradeVO.tno}">${tradeVO.tno}
					</c:forEach>
				</select> <input type="submit" value="送出"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/trade/trade.do">
				<b>選擇會員姓名:</b> <select size="1" name="tno">
					<c:forEach var="tradeVO" items="${dao.all}">
						<option value="${tradeVO.tno}">${tradeVO.mno}
					</c:forEach>
				</select> <input type="submit" value="送出"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>
	</ul>

	<h3>會員管理</h3>

	<ul>
		<li><a href='<%=request.getContextPath()%>/front/trade/addTrade.jsp'>Add</a> a new Trade.</li>
	</ul>


</body>
</html>