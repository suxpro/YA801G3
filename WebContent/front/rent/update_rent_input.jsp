
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");
%>
<html>
<head>
<title>租物資料修改 - update_rent_input.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white' align='center'>

	<table border='1' cellpadding='5' cellspacing='0' width='600' align='center'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>租物資料修改 - update_rent_input.jsp</h3> 
				<a href="<%=request.getContextPath() %>/front/rent/listAllRent.jsp">
				<img src="<%=request.getContextPath() %>/front/rent/images/back1.gif" width="100" height="32" border="0">回租物管理清單</a>
			</td>
		</tr>
	</table>

	<h3>租物資料修改:</h3>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front/rent/rent.do" name="form1" enctype="multipart/form-data">
		<table border="0" align='center'>

<!-- 			<tr> -->
<!-- 				<td>租物編號:<font color=red><b>*</b></font></td> -->
<!-- 				<td> -->
<%-- 					<input type="text" name="rent_no" size="6" value="<%=rentVO.getRent_no()%>" /> --%>
<!-- 				</td> -->
<!-- 			</tr> -->

			<tr>
				<td>租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="text" name="rent_name" size="30"
					value="<%=rentVO.getRent_name()%>"/></td>
				<td><font color="red">${errorMsgs.rent_name}</font></td>
			</tr>
			<tr>
				<td valign="top">租物描述:<font color=red><b>*</b></font></td>
				<td><textarea name="rent_desc" maxlength="300" cols="40"
					rows="4" style="resize: none"><%=rentVO.getRent_desc()%></textarea></td>
				<td><font color="red">${errorMsgs.rent_desc}</font></td>
			</tr>			
<!-- 			<tr> -->
<!-- 				<td>出租會員(編號):<font color=red><b>*</b></font></td> -->
<!-- 				<td> -->
					<input type="hidden" name="les_no" size="6" value="<%=rentVO.getLes_no()%>" />
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td>租物狀態:<font color=red><b>*</b></font></td> -->
<!-- 				<td> -->
					<input type="hidden" name="rent_sta" size="8" value="<%=rentVO.getRent_sta()%>" />
<!-- 				</td> -->
<!-- 			</tr> -->
			<jsp:useBean id="tagSvc" scope="page"
				class="back.tag.model.TagService" />
			<tr>
				<td>租物分類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tag_no">
						<c:forEach var="tagVO" items="${tagSvc.all}">
							<option value="${tagVO.tag_no}"
								${(rentVO.tag_no==tagVO.tag_no)?'selected':'' }>${tagVO.tag_desc}
						</c:forEach>
				   </select>
			    </td>
			    <td><font color="red">${errorMsgs.tag_no}</font></td>
			</tr>
			<tr>
				<td>租物押金:<font color=red><b>*</b></font></td>
				<td><input type="text" name="rent_dps" size="8"
					value="<%=rentVO.getRent_dps()%>"/></td>
				<td><font color="red">${errorMsgs.rent_dps}</font></td>
			</tr>
			<tr>
				<td>租物價格/天:<font color=red><b>*</b></font></td>
				<td><input type="text" name="unit_price" size="8"
					value="<%=rentVO.getUnit_price()%>"/></td>
				<td><font color="red">${errorMsgs.unit_price}</font></td>
			</tr>
			<tr>
				<td>重整天數:<font color=red><b>*</b></font></td>
				<td><input type="text" name="reset_days" size="8"
					value="<%=rentVO.getReset_days()%>"/></td>
				<td><font color="red">${errorMsgs.reset_days}</font></td>
			</tr>			
			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />			
			<tr>
				<td>地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="loc_no">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(rentVO.loc_no==locVO.loc_no)?'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
				<td><font color="red">${errorMsgs.loc_no}</font></td>
			</tr>			
			<tr>
				<td>租物地址:<font color=red><b>*</b></font></td>
				<td><input type="text" name="rent_addr" size="55"
					value="<%=rentVO.getRent_addr()%>"/></td>
				<td><font color="red">${errorMsgs.rent_addr}</font></td>
			</tr>	
			<tr>	
			    <td>租物圖片(1):<font color=red><b>*</b></font></td>	
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic1">
				    <input type="file" name="pic1" /></td>
				<td><font color="red">${errorMsgs.pics}</font></td>
			</tr>
			<tr>
				<td>租物圖片(2):<font color=red><b>*</b></font></td>			
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic2">
				    <input type="file" name="pic2" /></td>
			</tr>
			<tr>
				<td>租物圖片(3):<font color=red><b>*</b></font></td>				
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic3">
				    <input type="file" name="pic3" /></td>
			</tr>
<!-- 			<tr>	 -->
<!-- 				<td>租物圖片(4):<font color=red><b>*</b></font></td>			 -->
<%-- 				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic4"></td> --%>
<!-- 				<td><input type="file" name="pic4" /></td> -->
<!-- 			</tr> -->
<!-- 			<tr>		 -->
<!-- 				<td>租物圖片(5):<font color=red><b>*</b></font></td>		 -->
<%-- 				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic5"></td> --%>
<!-- 				<td><input type="file" name="pic5" /></td> -->
<!-- 			</tr>						 -->
		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="rent_no" value="<%=rentVO.getRent_no()%>"> <input
			type="submit" value="送出修改">
	</FORM>

</body>
</html>
