<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ page import="back.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //MemberServlet.java(Concroller), 存入req的empVO物件
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>會員資料 - listOneMember.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>會員資料 - listOneMember.jsp</h3> <a href="<%=request.getContextPath()%>/back/member/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>會員編號</th>
			<th>會員帳號</th>
			<th>會員密碼</th>
			<th>會員圖片</th>
			<th>會員姓名</th>
			<th>會員性別</th>
			<th>會員手機</th>
			<th>會員郵件</th>
			<th>地區編號</th>
			<th>會員地址</th>
			<th>會員等級</th>
			<th>會員帳戶餘額</th>
			<th>會員違規次數</th>
			<th>會員評價</th>
			<th>會員驗證欄位</th>
			<th>會員加入日期</th>
			<th>會員圖片格式</th>
			<th>會員輪播圖片</th>
			<th>會員輪播格式</th>
		</tr>
		<tr align='center' valign='middle'>
			<td><%=memberVO.getMno()%></td>
			<td><%=memberVO.getMid()%></td>
			<td><%=memberVO.getMpwd()%></td>
			<td><img src="<%=request.getContextPath()%>/back/member/member.do?mno=${memberVO.mno}"></td>
			<!-- <td><%=memberVO.getMpic()%></td> -->
			<td><%=memberVO.getMname()%></td>
			<td><%=memberVO.getMsex()%></td>
			<td><%=memberVO.getMcell()%></td>
			<td><%=memberVO.getMmail()%></td>
			<td><%=memberVO.getLocno()%></td>
			<td><%=memberVO.getMadrs()%></td>
			<td><%=memberVO.getMlev()%></td>
			<td><%=memberVO.getMbalance()%></td>
			<td><%=memberVO.getMillegal()%></td>
			<td><%=memberVO.getMassess()%></td>
			<td><%=memberVO.getMverification()%></td>
			<td><%=memberVO.getMdate()%></td>
			<td><%=memberVO.getMpic_info()%></td>
			<td><img src="<%=request.getContextPath()%>/back/member/member.do?mno=${memberVO.mno}"></td>
			<!-- <td><%=memberVO.getMvpic()%></td> -->
			<td><%=memberVO.getMvpic_info()%></td>
		</tr>
	</table>
</body>
</html>