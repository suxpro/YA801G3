<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ page import="back.member.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //MemberServlet.java(Concroller), �s�Jreq��empVO����
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�|����� - listOneMember.jsp</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='600'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�|����� - listOneMember.jsp</h3> <a href="<%=request.getContextPath()%>/back/member/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>�|���s��</th>
			<th>�|���b��</th>
			<th>�|���K�X</th>
			<th>�|���Ϥ�</th>
			<th>�|���m�W</th>
			<th>�|���ʧO</th>
			<th>�|�����</th>
			<th>�|���l��</th>
			<th>�a�Ͻs��</th>
			<th>�|���a�}</th>
			<th>�|������</th>
			<th>�|���b��l�B</th>
			<th>�|���H�W����</th>
			<th>�|������</th>
			<th>�|���������</th>
			<th>�|���[�J���</th>
			<th>�|���Ϥ��榡</th>
			<th>�|�������Ϥ�</th>
			<th>�|�������榡</th>
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