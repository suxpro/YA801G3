<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.remind.model.*"%>
<%
	RemindVO remindVO = (RemindVO) request.getAttribute("remindVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>提醒資料更新 - update_remind_input.jsp</title>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>提醒資料更新 - update_remind_input.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/front/remind/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">回首頁</a></td>
		</tr>

		<h3>交易資料:</h3>
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

		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/remind/remind.do" name="form1"
			enctype="multipart/form-data">
			<table border="0">
				<tr>
					<td>提醒編號:<font color=red><b>*</b></font></td>
					<td><%=remindVO.getRno()%></td>
				</tr>

				<jsp:useBean id="MemberSvc" scope="page"
					class="front.member.model.MemberService" />

				<tr>
					<td>會員編號:<font color=red><b>*</b></font></td>
					<td><select size="1" name="mno">
							<c:forEach var="memberVO" items="${MemberSvc.all}">
								<option value="${memberVO.mno}"
									${(remindVO.mno==memberVO.mno)? 'selected':'' }>${memberVO.mno}
							</c:forEach>
					</select></td>
				</tr>
				<jsp:useBean id="RentSvc" scope="page"
					class="front.rent.model.RentService" />

				<tr>
					<td>租物編號:</td>
					<td><select size="1" name="rtno">
							<c:forEach var="rentVO" items="${RentSvc.all}">
								<option value="${rentVO.rent_no}"
									${(remindVO.rtno==rentVO.rent_no)? 'selected':'' }>${rentVO.rent_no}
							</c:forEach>
					</select></td>
				</tr>

				<tr>
					<%
						java.sql.Date date_SQL = new java.sql.Date(
								System.currentTimeMillis());
					%>
					<td>提醒時間:</td>
					<td bgcolor="#CCCCFF"><input class="cal-TextBox"
						onFocus="this.blur()" size="9" readonly type="text" name="rtime"
						value="<%=(remindVO == null) ? date_SQL : remindVO.getRtime()%>">
						<a class="so-BtnLink" href="javascript:calClick();return false;"
						onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
						onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
						onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','rtime','BTN_date');return false;">
							<img align="middle" border="0" name="BTN_date"
							src="images/btn_date_up.gif" width="22" height="17" alt="開始日期">
					</a></td>
					<td>${errorMsgs.rtime}</td>
				</tr>

				<tr>
					<td>提醒狀態:<font color=red><b>*</b></font></td>
					<td><select size="1" name="rstas">
							<option value="成功出租" selected>成功出租</option>
							<option value="成功承租">成功承租</option>
							<option value="出租確認">出租確認</option>
							<option value="預約">預約</option>
							<option value="出貨通知">出貨通知</option>
							<option value="租期通知">租期通知</option>
							<option value="歸還通知">歸還通知</option>
							<option value="求租公告">求租公告</option>
							<option value="Q&A留言">Q&A留言</option>
							<option value="評價">評價</option>
							<option value="逾期通知">逾期通知</option>
					</select></td>
				</tr>

				<tr>
					<td>提醒結果:<font color=red><b>*</b></font></td>
					<td><select size="1" name="rflag">
							<option value="Y">提醒確認</option>
							<option value="N" selected>提醒未確認</option>
					</select></td>
				</tr>

			</table>
			<br> <input type="hidden" name="action" value="update">
			<input type="hidden" name="rno" value="<%=remindVO.getRno()%>">
			<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--原送出修改的來源網頁路徑,從request取出後,再送給Controller準備轉交之用-->
			<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
			<input type="submit" value="送出修改">
		</FORM>
					
	</table>
</body>
</html>