<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Com Prent: Home</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>Com Prent: Home</h3> <font color=red>( MVC )</font></td>
		</tr>
	</table>

	<p>This is the Home page for Com Prent: Home</p>

	<h3>��Ƭd��:</h3>
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

	<ul>
		<li><a href='<%=request.getContextPath()%>/front/prent/listAllPrent.jsp'>List</a> all Trades<font
			color=blue>(byDAO).</font></li>
		<br>
		<br>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/prent/prent.do">
				<b>��J�w���s�� (�pP10001):</b> 
				<input type="text" name="prent_no"> 
				<input type="submit" value="�e�X"><font color=blue>${errorMsgs.prent_no}</font> 
				<input type="hidden" name="action"
					value="getOne_For_Display">
			</FORM>
		</li>


		<jsp:useBean id="dao" scope="page" class="front.prerent.model.PrentDAO" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/prent/prent.do">
				<b>��ܹw���s��:</b> <select size="1" name="prent_no">
					<c:forEach var="prentVO" items="${dao.all}">
						<option value="${prentVO.prent_no}">${prentVO.prent_no}
					</c:forEach>
				</select> <input type="submit" value="�e�X"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/prent/prent.do">
				<b>��ܷ|���s��:</b> <select size="1" name="prent_no">
					<c:forEach var="prentVO" items="${dao.all}">
						<option value="${prentVO.prent_no}">${prentVO.ten_no}
					</c:forEach>
				</select> <input type="submit" value="�e�X"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>
	</ul>

	<h3>�|���޲z</h3>

	<ul>
		<li><a href='<%=request.getContextPath()%>/front/prent/addPrent.jsp'>Add</a> a new Prent.</li>
	</ul>


</body>
</html>