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
<title>�Ҧ��|����� - listAllMember_byDAO.jsp</title>
</head>
<body bgcolor='white'>
	<b><font color=red>�����m�߱ĥ� EL ���g�k����:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='800'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�Ҧ��|����� - listAllMember.jsp</h3> <a href="<%=request.getContextPath()%>/front/member/select_page.jsp"><img
					src="images/back1.gif" width="100" height="32" border="0">�^����</a>
			</td>
		</tr>
	</table>

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

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>�|���s��</th>
			<th>�|���b��</th>
<!-- 			<th>�|���K�X</th> -->
			<th>�|���Ϥ�</th>
			<th>�|���Ϥ��榡</th>
			<th>�|���m�W</th>
			<th>�|���ʧO</th>
			<th>�|�����</th>
			<th>�|���l��</th>
			<th>�a�Ͻs��</th>
			<th>�|���a�}</th>
			<th>�|������</th>
			<th>�|���|���b��l�B</th>
			<th>�|���H�W����</th>
			<th>�|������</th>
			<th>�|���������</th>
			<th>�|���[�J���</th>			
			<th>�|�������Ϥ�</th>
			<th>�|�������榡</th>


		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="memberVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle' ${(memberVO.mno==param.mno) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
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
						<input type="submit" value="�ק�"> <input type="hidden"	name="mno" value="${memberVO.mno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     		<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->	
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do">
						<input type="submit" value="�R��"> <input type="hidden"
							name="mno" value="${memberVO.mno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     		<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->	
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