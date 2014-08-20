<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.remind.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.rent.model.*"%>

<%
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	String mno = memberVO.getMno();
	RemindDAO dao = new RemindDAO();
	List<RemindVO> list = dao.getAllByMno(mno);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有提醒資料 - listAllRemind_byDAO.jsp</title>
</head>
<body bgcolor='white'>

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

	<table border='1' bordercolor='#CCCCFF'>
		<tr>
			<!-- 			<th>提醒編號</th> -->
			<th align="left">租物名稱</th>
			<th align="left">提醒日期</th>
			<th align="left">提醒分類</th>
			<th align="left">提醒內容</th>

		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="remindVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<%
				RentService rentSVC = new RentService();
					RentVO rentVO = new RentVO();
					rentVO = rentSVC.getOneRent2(((RemindVO) pageContext
							.getAttribute("remindVO")).getRtno());
// 					System.out.println(((RemindVO) pageContext
// 							.getAttribute("remindVO")).getRtno());
// 					System.out.println(rentVO.getRent_name());
			%>
			<tr align='center' valign='middle'
				${(remindVO.rno==param.rno) ? 'bgcolor=#CCCCFF':''}>
				<!--將修改的那一筆加入對比色而已-->
				<%-- 				<td>${remindVO.rno}</td>				 --%>
				<td align="left"><%=rentVO.getRent_name()%></td>
				<td align="left">${remindVO.rtime}</td>
				<td align="left">${remindVO.rstas}</td>
				<td align="left">${remindVO.rdes}</td>

			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>