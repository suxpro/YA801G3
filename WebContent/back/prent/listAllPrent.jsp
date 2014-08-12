<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.prerent.model.*"%>
<%
	
	PrentDAO dao = new PrentDAO();
	List<PrentVO> list = dao.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="rentSvc" scope="page"
	class="front.rent.model.RentService" />
<jsp:useBean id="memberSvc" scope="page"
	class="back.member.model.MemberService" />
<jsp:useBean id="ordSvc" scope="page" class="front.ord.model.OrdService" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>所有預租資料 - listAllPrent_byDAO.jsp</title>
</head>
<body bgcolor='white'>
	<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='800'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>所有預租資料 - listAllPrent_byDAO.jsp</h3> <a href="<%=request.getContextPath()%>/back/prent/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

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

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>預租編號</th>
			<th>租物編號</th>
			<th>承租者編號</th>
			<th>預租時間</th>
			<th>預租天數</th>
			<th>預租資料有效</th>
			<th>訂單編號</th>



		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="prentVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle' ${(prentVO.prent_no==param.prent_no) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
				<td>${prentVO.prent_no}</td>

				<td><c:forEach var="rentVO" items="${rentSvc.all}">
						<c:if test="${prentVO.rent_no==rentVO.rent_no}">
	                    ${rentVO.rent_no}【${rentVO.rent_name}】
                    </c:if>
					</c:forEach></td>

				<td><c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${prentVO.ten_no==memberVO.mno}">
	                    ${memberVO.mno}【${memberVO.mname}】
                    </c:if>
					</c:forEach></td>
				<td>${prentVO.prent_time}</td>
				<td>${prentVO.prent_days}</td>
				<td>${prentVO.prent_flag}</td>

				<td><c:forEach var="ordVO" items="${ordSvc.all}">
						<c:if test="${prentVO.ord_no==ordVO.ord_no}">
	                    ${ordVO.ord_no}【${ordVO.ord_sta}】
                    </c:if>
					</c:forEach></td>


				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/back/prent/prent.do">
						<input type="submit" value="修改"> <input type="hidden"
							name="prent_no" value="${prentVO.prent_no}"> <input
							type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
						<!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/back/prent/prent.do">
						<input type="submit" value="刪除"> <input type="hidden"
							name="prent_no" value="${prentVO.prent_no}"> <input
							type="hidden" name="requestURL"
							value="<%=request.getServletPath()%>">
						<!--送出本網頁的路徑給Controller-->
						<input type="hidden" name="whichPage" value="<%=whichPage%>">
						<!--送出當前是第幾頁給Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>