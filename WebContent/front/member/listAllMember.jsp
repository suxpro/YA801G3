<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>

<%
	MemberDAO dao = new MemberDAO();
	List<MemberVO> list = dao.getAll();
	pageContext.setAttribute("list", list);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有會員資料 - listAllMember_byDAO.jsp</title>
</head>
<body bgcolor='white'>
	<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='800'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>所有會員資料 - listAllMember.jsp</h3> <a href="<%=request.getContextPath()%>/front/member/select_page.jsp"><img
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
			<th>會員編號</th>
			<th>會員帳號</th>
<!-- 			<th>會員密碼</th> -->
			<th>會員圖片</th>
			<th>會員圖片格式</th>
			<th>會員姓名</th>
			<th>會員性別</th>
			<th>會員手機</th>
			<th>會員郵件</th>
			<th>地區編號</th>
			<th>會員地址</th>
			<th>會員等級</th>
			<th>會員會員帳戶餘額</th>
			<th>會員違規次數</th>
			<th>會員評價</th>
			<th>會員驗證欄位</th>
			<th>會員加入日期</th>			
			<th>會員輪播圖片</th>
			<th>會員輪播格式</th>


		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle' ${(memberVO.mno==param.mno) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
				<td>${memberVO.mno}</td>
				<td>${memberVO.mid}</td>
<%-- 				<td>${memberVO.mpwd}</td> --%>
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC"></td>
				<!--  <td>${memberVO.mpic}</td>-->
				<td>${memberVO.mpic_info}</td>
				<td>${memberVO.mname}</td>
				<td>${mem_staMap[memberVO.msex]}</td>
				<td>${memberVO.mcell}</td>
				<td>${memberVO.mmail}</td>
				<td>${loc_staMap[memberVO.locno]}</td>
				<td>${memberVO.madrs}</td>
				<td>${mem_staMap[memberVO.mlev]}</td>
				<td>${memberVO.mbalance}</td>
				<td>${memberVO.millegal}</td>
				<td>${memberVO.massess}</td>
				<td>${mem_staMap[memberVO.mverification]}</td>
				<td>${memberVO.mdate}</td>
				
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC"></td>
				<!-- <td>${memberVO.mvpic}</td> -->
				<td>${memberVO.mvpic_info}</td>

				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do">
						<input type="submit" value="修改"> <input type="hidden"	name="mno" value="${memberVO.mno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     		<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->	
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do">
						<input type="submit" value="刪除"> <input type="hidden"
							name="mno" value="${memberVO.mno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     		<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->	
							<input type="hidden"
							name="action" value="delete">
					</FORM>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>