<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.report.model.*"%>
<%
	ReportVO reportVO = (ReportVO) request.getAttribute("reportVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
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
<title>檢舉資料 - listOneReport.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>檢舉資料 - listOneReport.jsp</h3> <a href="<%=request.getContextPath()%>/back/report/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>檢舉編號</th>
			<th>檢舉人</th>
			<th>被檢舉物</th>
			<th>被檢舉人</th>
			<th>檢舉時間</th>
			<th>檢舉原因</th>
			<th>審核員工</th>
			<th>審核結果</th>
			<th>審核時間</th>
			<th>結果描述</th>
		</tr>
		<tr align='center' valign='middle'>
			<td>${reportVO.rno}</td>

			<td><c:forEach var="memberVO" items="${memberSvc.all}">
					<c:if test="${reportVO.rm_p==memberVO.mno}">
	                    ${memberVO.mno}【${memberVO.mname}】
                    </c:if>
				</c:forEach></td>

			<td><c:forEach var="rentVO" items="${rentSvc.all}">
					<c:if test="${reportVO.rr_no==rentVO.rent_no}">
	                    ${rentVO.rent_no}【${rentVO.rent_name}】
                    </c:if>
				</c:forEach></td>

			<td><c:forEach var="memberVO" items="${memberSvc.all}">
					<c:if test="${reportVO.rm_byp==memberVO.mno}">
	                    ${memberVO.mno}【${memberVO.mname}】
                    </c:if>
				</c:forEach></td>

			<td>${reportVO.rtime}</td>
			<td>${reportVO.rcuz}</td>

			<td><c:forEach var="employeeVO" items="${empSvc.all}">
					<c:if test="${reportVO.re_chk==employeeVO.emp_no}">
	                    ${employeeVO.emp_no}【${employeeVO.emp_name}】
                    </c:if>
				</c:forEach></td>

			<td>${reportVO.rsol}</td>
			<td>${reportVO.rsolt}</td>
			<td>${reportVO.rsold}</td>

		</tr>
	</table>
</body>
</html>