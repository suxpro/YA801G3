<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.report.model.*"%>
<%
	ReportVO reportVO = (ReportVO) request.getAttribute("reportVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>���|��ƭק� - update_report_input.jsp</title>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>���|��ƭק� - update_report_input.jsp</h3> <a href="<%=request.getContextPath()%>/front/report/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>
	<h3>��ƭק�:</h3>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/report/report.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">
			<jsp:useBean id="MemberSvc" scope="page"
				class="front.member.model.MemberService" />

			<tr>
				<td>���|�s��:<font color=red><b>*</b></font></td>
				<td><%=reportVO.getRno()%></td>
			</tr>

			<tr>
				<td>���|�H:<font color=red><b>*</b></font></td>
				<td><select size="1" name="rm_p">
						<c:forEach var="memberVO" items="${MemberSvc.all}">
							<option value="${memberVO.mno}"
								${(reportVO.rm_p==memberVO.mno)? 'selected':'' }>${memberVO.mname}
						</c:forEach>
				</select></td>
			</tr>

			<jsp:useBean id="rentSvc" scope="page"
				class="front.rent.model.RentService" />
			<tr>
				<td>�Q���|��:<font color=red><b>*</b></font></td>
				<td><select size="1" name="rr_no">
						<c:forEach var="rentVO" items="${rentSvc.all}">
							<option value="${rentVO.rent_no}"
								${(reportVO.rr_no==rentVO.rent_no)? 'selected':'' }>${rentVO.rent_name}
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>�Q���|�H:<font color=red><b>*</b></font></td>
				<td><select size="1" name="rm_byp">
						<c:forEach var="memberVO" items="${MemberSvc.all}">
							<option value="${memberVO.mno}"
								${(reportVO.rm_byp==memberVO.mno)? 'selected':'' }>${memberVO.mname}
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<%
					java.sql.Date date_SQL = new java.sql.Date(
							System.currentTimeMillis());
				%>
				<td>���|�ɶ�:</td>
				<td bgcolor="#CCCCFF"><input class="cal-TextBox"
					onFocus="this.blur()" size="9" readonly type="text" name="rtime"
					value="<%=(reportVO == null) ? date_SQL : reportVO.getRtime()%>">
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
				<td>���|��]:</td>
				<td><input type="TEXT" name="rcuz" size="45"
					value="<%=(reportVO == null) ? "�~�[�l�a" : reportVO.getRcuz()%>" /></td>
				<td>${errorMsgs.rcuz}</td>
			</tr>

			<jsp:useBean id="EmployeeSvc" scope="page"
				class="back.employee.model.EmployeeService" />
			<tr>
				<td>�f�֭��u:<font color=red><b>*</b></font></td>
				<td><select size="1" name="re_chk">
						<c:forEach var="employeeVO" items="${EmployeeSvc.all}">
							<option value="${employeeVO.emp_no}"
								${(reportVO.re_chk==employeeVO.emp_no)? 'selected':'' }>${employeeVO.emp_name}
						</c:forEach>
				</select></td>
			</tr>

			<tr>
				<td>�f�ֵ��G:<font color=red><b>*</b></font></td>
				<td><select size="1" name="rsol">
						<option value="Y">���|���\</option>
						<option value="N" selected>���|����</option>
				</select></td>
			</tr>

			<tr>
				<td>���|�ɶ�:</td>
				<td bgcolor="#CCCCFF"><input class="cal-TextBox"
					onFocus="this.blur()" size="9" readonly type="text" name="rsolt"
					value="<%=(reportVO == null) ? date_SQL : reportVO.getRsolt()%>">
					<a class="so-BtnLink" href="javascript:calClick();return false;"
					onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
					onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
					onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','rsolt','BTN_date');return false;">
						<img align="middle" border="0" name="BTN_date"
						src="images/btn_date_up.gif" width="22" height="17" alt="�}�l���">
				</a></td>
				<td>${errorMsgs.rsolt}</td>
			</tr>

			<tr>
				<td>���G�y�z:</td>
				<td><input type="TEXT" name="rsold" size="45"
					value="<%=(reportVO == null) ? "���|���ѡC" : reportVO.getRsold()%>" /></td>
				<td>${errorMsgs. rsold}</td>
			</tr>


		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="rno" value="<%=reportVO.getRno()%>"> 
			<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--��e�X�ק諸�ӷ��������|,�qrequest���X��,�A�e��Controller�ǳ���椧��-->
			<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
			<input
			type="submit" value="�e�X�ק�">
	</FORM>

</body>
</html>