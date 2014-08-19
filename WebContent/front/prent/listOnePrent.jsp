<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.prerent.model.*"%>
<%
	PrentVO prentVO = (PrentVO) request.getAttribute("prentVO");
%>
<jsp:useBean id="rentSvc" scope="page"
	class="front.rent.model.RentService" />
<jsp:useBean id="memberSvc" scope="page"
	class="front.member.model.MemberService" />
<jsp:useBean id="ordSvc" scope="page"
	class="front.ord.model.OrdService" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>�w����� - listOnePrent.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�w����� - listOnePrent.jsp</h3> <a href="<%=request.getContextPath()%>/front/prent/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>

	<table class="table table-hover " border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>�w���s��</th>
			<th>�����s��</th>
			<th>�ӯ��̽s��</th>
			<th>�w���ɶ�</th>
			<th>�w���Ѽ�</th>
			<th>�w����Ʀ���</th>
			<th>�q��s��</th>
		</tr>
		<tr align='center' valign='middle'>
			<td>${prentVO.prent_no}</td>
				
				<td><c:forEach var="rentVO" items="${rentSvc.all}">
						<c:if test="${prentVO.rent_no==rentVO.rent_no}">
	                    ${rentVO.rent_no}�i${rentVO.rent_name}�j
                    </c:if>
					</c:forEach></td>
					
				<td><c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${prentVO.ten_no==memberVO.mno}">
	                    ${memberVO.mno}�i${memberVO.mname}�j
                    </c:if>
					</c:forEach></td>
				<td>${prentVO.prent_time}</td>
				<td>${prentVO.prent_days}</td>
				<td>${prentVO.prent_flag}</td>
				
				<td><c:forEach var="ordVO" items="${ordSvc.all}">
						<c:if test="${prentVO.ord_no==ordVO.ord_no}">
	                    ${ordVO.ord_no}�i${ordVO.ord_sta}�j
                    </c:if>
					</c:forEach></td>

		</tr>
	</table>
</body>
</html>