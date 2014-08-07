
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%!
	//定義返回的日期格式
	static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	//去掉時間的毫秒數方法
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//格式化傳過來的時間就可以去掉毫秒數
		else
			return ""; 
	}
%>
<%
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");
%>
<html>
<head>
<title>租物資料 - listOneRent.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white' align='center'>

	<table border='1' cellpadding='5' cellspacing='0' width='600' align='center'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>租物資料 - listOneRent.jsp</h3> 
				<img src="<%=request.getContextPath() %>/back/rent/images/back1.gif" width="100" height="32" border="0">回租物管理清單
			</td>
		</tr>
	</table>

	<h3>租物資料:</h3>
	<%-- 錯誤表列 --%>
	<script>
	<c:if test="${not empty errorMsgs}">
		alert("${errorMsgs.alert}");
	</c:if>
	</script>
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font color='red'>請修正以下錯誤: -->
<!-- 			<ul> -->
<%-- 				<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 					<li>${message.value}</li> --%>
<%-- 				</c:forEach> --%>
<!-- 			</ul> -->
<!-- 		</font> -->
<%-- 	</c:if> --%>

		<table border='1' bordercolor='#CCCCFF' align='center'>

			<tr>
				<td valign="top">租物編號:<font color=red></font></td>
				<td><%=rentVO.getRent_no()%></td>
			</tr>
			<tr>
				<td valign="top">租物名稱:<font color=red></font></td>
				<td><%=rentVO.getRent_name()%></td>
			</tr>
			<tr>
				<td valign="top">租物描述:<font color=red></font></td>
				<td><textarea name="rent_desc" maxlength="300" cols="40"
					rows="4" style="resize: none"  readonly><%=rentVO.getRent_desc()%></textarea></td>

			</tr>			
			<tr>
				<td>出租會員(編號):<font color=red></font></td>
				<td><%=rentVO.getLes_no()%></td>
			</tr>
			<tr>
				<td>租物狀態:<font color=red></font></td>
				<td>${rent_staMap[rentVO.rent_sta]}</td>
			</tr>
			<tr>
				<td>租物分類:<font color=red></font></td>
				<td>${tag_staMap[rentVO.tag_no]}</td>
			</tr>
			<tr>
				<td>租物押金:<font color=red></font></td>
				<td><%=rentVO.getRent_dps()%>元</td>
			</tr>
			<tr>
				<td>租物價格/天:<font color=red></font></td>
				<td><%=rentVO.getUnit_price()%>元</td>
			</tr>
			<tr>
				<td>出貨/回收緩衝時間:<font color=red></font></td>
				<td><%=rentVO.getReset_days()%>天</td>
			</tr>						
			<tr>
				<td>地區:<font color=red></font></td>
				<td>${loc_staMap[rentVO.loc_no]}</td>
			</tr>			
			<tr>
				<td>租物地址:<font color=red></font></td>
				<td><%=rentVO.getRent_addr()%></td>
			</tr>	
			<tr>
				<td>最後狀態時間:<font color=red></font></td>			
				<td><%=getTimestampString(rentVO.getLast_sta_time())%></td>
			</tr>
			<tr>
				<td>最後上架時間:<font color=red></font></td>			
				<td><%=getTimestampString(rentVO.getLast_onshelf_time())%></td>
			</tr>
			<tr>
				<td>最後修改時間:<font color=red></font></td>			
				<td><%=getTimestampString(rentVO.getLast_mod_time())%></td>
			</tr>					
			<tr>	
			    <td>租物圖片(1):<font color=red></font></td>	
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
			</tr>
			<tr>
				<td>租物圖片(2):<font color=red></font></td>			
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic2"></td>
			</tr>
			<tr>
				<td>租物圖片(3):<font color=red></font></td>				
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic3"></td>
			</tr>
<!-- 			<tr>	 -->
<!-- 				<td>租物圖片(4):<font color=red></font></td>			 -->
<%-- 				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic4"></td> --%>
<!-- 				<td><input type="file" name="pic4" /></td> -->
<!-- 			</tr> -->
<!-- 			<tr>		 -->
<!-- 				<td>租物圖片(5):<font color=red></font></td>		 -->
<%-- 				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic5"></td> --%>
<!-- 				<td><input type="file" name="pic5" /></td> -->
<!-- 			</tr>						 -->
		</table>

</body>
</html>
