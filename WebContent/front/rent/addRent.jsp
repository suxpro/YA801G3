
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="back.tag.model.*"%>
<%@ page import="back.loc.model.*"%>
<%
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");
	String[][] staAry = { { "W_RENT", "待出租" }, { "A_RENT", "已出租" },
			{ "IN_REP", "檢舉中" }, { "W_CHECK", "待審核" },
			{ "C_RENT", "已下架" } };
%>

<html>
<head>
<title>租物新增 - addRent.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='500'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>租物新增 - addRent.jsp</h3></td>
			<td><a href="select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1"> 回首頁 </a></td>
		</tr>
	</table>

	<h4>
		租物資料:<font color=red><b>*</b></font>為必填欄位
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

	<FORM METHOD="post" ACTION="rent.do" name="form1" enctype="multipart/form-data">
		<table border="0">

			<tr>
				<td>租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_name" size="30"
					value="${rentVO.rent_name}" /></td>
			</tr>
			<tr>
				<td valign="top">租物描述:<font color=red><b>*</b></font></td>
				<!--  
				<td><input type="TEXT" name="rent_desc" size="100"
					value="${rentVO.rent_desc}" /></td>
				-->
				<td><textarea name="rent_desc" maxlength="100" cols="40"
					rows="3" style="resize: none">${rentVO.rent_desc}</textarea></td>
			</tr>
			<tr>
				<td>出租人:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="les_no" size="6"
					value="${rentVO.les_no}" /></td>
			</tr>
			<tr>
				<td>租物狀態:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_sta" size="10" value="待審核"
					readonly="readonly" /></td>
			</tr>

			<jsp:useBean id="tagSvc" scope="page"
				class="back.tag.model.TagService" />

			<tr>
				<td>租物分類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tag_no">
						<c:forEach var="tagVO" items="${tagSvc.all}">
							<option value="${tagVO.tag_no}"
								${(rentVO.tag_no==tagVO.tag_no)?'selected':''}>${tagVO.tag_desc}
						</c:forEach>
				   </select>
			   </td>
			</tr>
			<tr>
				<td>租物押金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_dps" size="10"
					value="${rentVO.rent_dps}" /></td>
			</tr>
			<tr>
				<td>每日租金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="unit_price" size="10"
					value="${rentVO.unit_price}" /></td>
			</tr>
			<tr>
				<td>重整天數:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="reset_days" size="3"
					value="${rentVO.reset_days}" /></td>
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
			</tr>
			<tr>
				<td>租物地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_addr" size="45"
					value="${rentVO.rent_addr}" /></td>
			</tr>
			
			<tr>
				<td>租物圖片(1):<font color=red><b>*</b></font></td>
				<td><input type="file" name="pic1" /></td>
			</tr>
			<tr>
				<td>租物圖片(2):<font color=red><b>*</b></font></td>
				<td><input type="file" name="pic2" /></td>
			</tr>
			<tr>
				<td>租物圖片(3):<font color=red><b>*</b></font></td>
				<td><input type="file" name="pic3" /></td>
			</tr>
			<tr>
				<td>租物圖片(4):<font color=red><b>*</b></font></td>
				<td><input type="file" name="pic4" /></td>
			</tr>
			<tr>
				<td>租物圖片(5):<font color=red><b>*</b></font></td>
				<td><input type="file" name="pic5" /></td>
			</tr>			
			

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

</html>
