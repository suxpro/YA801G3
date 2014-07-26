
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.que.model.*"%>
<%
	QueVO queVO = (QueVO) request.getAttribute("queVO");
	String[][] staAry = { { "IN_ASK", "發問中" },
			{ "COM_REPLY", "回覆完成 " }, { "CC_ASK", "刪除發問" } };
%>
<html>
<head>
<title>問題資料修改 - update_que_input.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>問題資料修改 - update_que_input.jsp</h3> <a href="select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>
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

	<FORM METHOD="post" ACTION="que.do" name="form1">
		<table border="0">

			<tr>
				<td>租物編號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_no" size="45"
					value="<%=queVO.getRent_no()%>" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>發問會員(編號):<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="que_mem" size="45"
					value="<%=queVO.getQue_mem()%>" readonly="readonly" /></td>
			</tr>
			<!--			
			<tr>
				<td>問題狀態:<font color=red><b>*</b></font></td>
				<td><select size="1" name="que_sta">
						<c:forEach var="sta" items="<%=staAry%>" varStatus="s">
							<option value="${sta[0]}"
								${(queVO.que_sta==sta[0])? 'selected':'' }>${sta[1]}
						</c:forEach>
				</select></td>
			</tr>
-->
			<tr>
				<%
					java.sql.Timestamp date_SQL = new java.sql.Timestamp(
							System.currentTimeMillis());
				%>
				<td>發問時間:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="que_time" size="20"
					value="<%=(queVO == null) ? date_SQL : queVO.getQue_time()%>"
					readonly="readonly" /></td>
			</tr>
			<tr>
				<td valign="top">問題描述:<font color=red><b>*</b></font></td>
				<!--  
				<td><input type="TEXT" name="que_desc" size="100"
					value="<%=queVO.getQue_desc()%>" readonly="readonly"/></td>
				-->
				<td><textarea name="que_desc" maxlength="100" cols="35"
						rows="5" style="resize: none" readonly="readonly"><%=queVO.getQue_desc()%></textarea></td>
			</tr>

			<tr>
				<%
					java.sql.Timestamp date_SQL2 = new java.sql.Timestamp(
							System.currentTimeMillis());
				%>
				<td>回答時間:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="ans_time" size="20"
					value="<%=(queVO == null || queVO.getAns_time() == null) ? date_SQL2
					: queVO.getAns_time()%>" /></td>
			</tr>
			<tr>
				<td valign="top">回答描述:<font color=red><b>*</b></font></td>
				<!-- 
				<td><input type="TEXT" name="ans_desc" size="100"
					value="<%=(queVO == null || queVO.getAns_desc() == null) ? ""
					: queVO.getAns_desc()%>" /></td>
				-->
				<td><textarea name="ans_desc" maxlength="100" cols="35" rows="5" 
				style="resize: none"><%=(queVO == null || queVO.getAns_desc() == null) ? "" : 
					queVO.getAns_desc()%></textarea></td>
			</tr>
		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="que_no" value="<%=queVO.getQue_no()%>"> <input
			type="submit" value="送出回覆">
	</FORM>

</body>
</html>
