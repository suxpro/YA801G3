<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Com Report: Home</title>
</head>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>Com Report: Home</h3> <font color=red>( MVC )</font></td>
		</tr>
	</table>

	<p>This is the Home page for Com Report: Home</p>

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
		<li><a href='<%=request.getContextPath()%>/back/report/listAllReport.jsp'>List</a> all Reports<font
			color=blue>(byDAO).</font></li>
		<br>
		<br>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/report/report.do">
				<b>��J���|�s�� (�pH10001):</b> <input type="text" name="rno"> <input
					type="submit" value="�e�X"><font color=blue>${errorMsgs.rno}</font> <input type="hidden" name="action"
					value="getOne_For_Display">
			</FORM>
		</li>


		<jsp:useBean id="dao" scope="page" class="back.report.model.ReportDAO" />


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/report/report.do">
				<b>������|�s��:</b> <select size="1" name="rno">
					<c:forEach var="reportVO" items="${dao.all}">
						<option value="${reportVO.rno}">${reportVO.rno}
					</c:forEach>
				</select> <input type="submit" value="�e�X"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>


		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/report/report.do">
				<b>������|�H:</b> <select size="1" name="rno">
					<c:forEach var="reportVO" items="${dao.all}">
						<option value="${reportVO.rno}">${reportVO.rm_p}
					</c:forEach>
				</select> <input type="submit" value="�e�X"> <input type="hidden"
					name="action" value="getOne_For_Display">
			</FORM>
		</li>
	</ul>

	<h3>�|���޲z</h3>

	<ul>
		<li><a href='<%=request.getContextPath()%>/back/report/addReport.jsp'>Add</a> a new Report.</li>
	</ul>


</body>
</html>