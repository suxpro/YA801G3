<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.report.model.*"%>
<%
	ReportVO reportVO = (ReportVO) request.getAttribute("reportVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>
<jsp:useBean id="rentSvc" scope="page"
	class="front.rent.model.RentService" />
<jsp:useBean id="memberSvc" scope="page"
	class="back.member.model.MemberService" />
<jsp:useBean id="empSvc" scope="page"
	class="back.employee.model.EmployeeService" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>���|��� - listOneReport.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>���|��� - listOneReport.jsp</h3> <a href="<%=request.getContextPath()%>/back/report/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>���|�s��</th>
			<th>���|�H</th>
			<th>�Q���|��</th>
			<th>�Q���|�H</th>
			<th>���|�ɶ�</th>
			<th>���|��]</th>
			<th>�f�֭��u</th>
			<th>�f�ֵ��G</th>
			<th>�f�֮ɶ�</th>
			<th>���G�y�z</th>
		</tr>
		<tr align='center' valign='middle'>
			<td>${reportVO.rno}</td>

			<td><c:forEach var="memberVO" items="${memberSvc.all}">
					<c:if test="${reportVO.rm_p==memberVO.mno}">
	                    ${memberVO.mno}�i${memberVO.mname}�j
                    </c:if>
				</c:forEach></td>

			<td><c:forEach var="rentVO" items="${rentSvc.all}">
					<c:if test="${reportVO.rr_no==rentVO.rent_no}">
	                    ${rentVO.rent_no}�i${rentVO.rent_name}�j
                    </c:if>
				</c:forEach></td>

			<td><c:forEach var="memberVO" items="${memberSvc.all}">
					<c:if test="${reportVO.rm_byp==memberVO.mno}">
	                    ${memberVO.mno}�i${memberVO.mname}�j
                    </c:if>
				</c:forEach></td>

			<td>${reportVO.rtime}</td>
			<td>${reportVO.rcuz}</td>

			<td><c:forEach var="employeeVO" items="${empSvc.all}">
					<c:if test="${reportVO.re_chk==employeeVO.emp_no}">
	                    ${employeeVO.emp_no}�i${employeeVO.emp_name}�j
                    </c:if>
				</c:forEach></td>

			<td>${reportVO.rsol}</td>
			<td>${reportVO.rsolt}</td>
			<td>${reportVO.rsold}</td>

		</tr>
	</table>
</body>
</html>