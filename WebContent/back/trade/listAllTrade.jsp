<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.trade.model.*"%>

<%
	TradeDAO dao = new TradeDAO();
	List<TradeVO> list = dao.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="memberSvc" scope="page"
	class="back.member.model.MemberService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>�Ҧ������� - listAllTrade_byDAO.jsp</title>
</head>
<body bgcolor='white'>
	<b><font color=red>�����m�߱ĥ� EL ���g�k����:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='800'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�Ҧ������� - listAllTrade.jsp</h3> <a href="<%=request.getContextPath()%>/back/trade/select_page.jsp"><img
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
			<th>��������s��</th>
			<th>�|���s��</th>
			<th>�|�����ıb��</th>
			<th>����ɶ�</th>
			<th>�|�����Ĭ������A</th>
			<th>������B</th>
			<th>�״ڽT�{</th>
	


		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="tradeVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle' ${(tradeVO.tno==param.tno) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
				<td>${tradeVO.tno}</td>
				<td><c:forEach var="memberVO" items="${memberSvc.all}">
						<c:if test="${tradeVO.mno==memberVO.mno}">
	                    ${memberVO.mno}�i${memberVO.mname}�j
                    </c:if>
					</c:forEach></td>
				<td>${tradeVO.tmid}</td>
				<td>${tradeVO.tdate}</td>
				<td>${tradeVO.tstas}</td>
				<td>${tradeVO.tfunds}</td>
				<td>${tradeVO.tin}</td>

				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/back/trade/trade.do">
						<input type="submit" value="�ק�"> 
						<input type="hidden" name="tno" value="${tradeVO.tno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			    	    <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/back/trade/trade.do">
						<input type="submit" value="�R��"> 
						<input type="hidden" name="tno" value="${tradeVO.tno}"> 
						<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     		<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>