<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.remind.model.*"%>
<%
	RemindVO remindVO = (RemindVO) request.getAttribute("remindVO");
%>
<jsp:useBean id="rentSvc" scope="page"
	class="front.rent.model.RentService" />
<jsp:useBean id="memberSvc" scope="page"
	class="front.member.model.MemberService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>������� - listOneRemind.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�|����� - listOneMember.jsp</h3> <a href="<%=request.getContextPath()%>/front/remind/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>�����s��</th>
			<th>�|���s��</th>
			<th>�����s��</th>
			<th>�����ɶ�</th>
			<th>�������A</th>
			<th>�������e</th>
			<th>�������G</th>
		</tr>
		<tr align='center' valign='middle'>
							<td>${remindVO.rno}</td>
				<td><c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${remindVO.mno==memberVO.mno}">
	                    ${memberVO.mno}�i${memberVO.mname}�j
                    </c:if>
					</c:forEach></td>
				
				<td><c:forEach var="rentVO" items="${rentSvc.all}">
						<c:if test="${remindVO.rtno==rentVO.rent_no}">
	                    ${rentVO.rent_no}�i${rentVO.rent_name}�j
                    </c:if>
					</c:forEach></td>

				<td>${remindVO.rtime}</td>
				<td>${remindVO.rstas}</td>
				<td>${remindVO.rdes}</td>
				<td>${remindVO.rflag}</td>


		</tr>
	</table>
</body>
</html>