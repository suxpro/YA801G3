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

<title>������Ƨ�s - update_remind_input.jsp</title>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>������Ƨ�s - update_remind_input.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/front/remind/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">�^����</a></td>
		</tr>

		<h3>������:</h3>
		<%-- ���~��C --%>
		<c:if test="${not empty errorMsgs}">
			<font color='red'>�Эץ��H�U���~:
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
					<td>�����s��:<font color=red><b>*</b></font></td>
					<td><%=remindVO.getRno()%></td>
				</tr>

				<jsp:useBean id="MemberSvc" scope="page"
					class="front.member.model.MemberService" />

				<tr>
					<td>�|���s��:<font color=red><b>*</b></font></td>
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
					<td>�����s��:</td>
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
					<td>�����ɶ�:</td>
					<td bgcolor="#CCCCFF"><input class="cal-TextBox"
						onFocus="this.blur()" size="9" readonly type="text" name="rtime"
						value="<%=(remindVO == null) ? date_SQL : remindVO.getRtime()%>">
						<a class="so-BtnLink" href="javascript:calClick();return false;"
						onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
						onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
						onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','rtime','BTN_date');return false;">
							<img align="middle" border="0" name="BTN_date"
							src="images/btn_date_up.gif" width="22" height="17" alt="�}�l���">
					</a></td>
					<td>${errorMsgs.rtime}</td>
				</tr>

				<tr>
					<td>�������A:<font color=red><b>*</b></font></td>
					<td><select size="1" name="rstas">
							<option value="���\�X��" selected>���\�X��</option>
							<option value="���\�ӯ�">���\�ӯ�</option>
							<option value="�X���T�{">�X���T�{</option>
							<option value="�w��">�w��</option>
							<option value="�X�f�q��">�X�f�q��</option>
							<option value="�����q��">�����q��</option>
							<option value="�k�ٳq��">�k�ٳq��</option>
							<option value="�D�����i">�D�����i</option>
							<option value="Q&A�d��">Q&A�d��</option>
							<option value="����">����</option>
							<option value="�O���q��">�O���q��</option>
					</select></td>
				</tr>

				<tr>
					<td>�������G:<font color=red><b>*</b></font></td>
					<td><select size="1" name="rflag">
							<option value="Y">�����T�{</option>
							<option value="N" selected>�������T�{</option>
					</select></td>
				</tr>

			</table>
			<br> <input type="hidden" name="action" value="update">
			<input type="hidden" name="rno" value="<%=remindVO.getRno()%>">
			<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--��e�X�ק諸�ӷ��������|,�qrequest���X��,�A�e��Controller�ǳ���椧��-->
			<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
			<input type="submit" value="�e�X�ק�">
		</FORM>
					
	</table>
</body>
</html>