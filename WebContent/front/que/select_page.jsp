<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><title>Rent Que: Home</title></head>
<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>Rent Que: Home</h3>	<font color=red>( MVC )</font></td></tr></table>

<p>This is the Home page for Rent Que: Home</p>

<h3>資料查詢:</h3>

<ul>
  <li><a href='<%=request.getContextPath() %>/front/que/listAllQue.jsp'>List</a> all Que. </li> <br>
</ul>


<h3>租物問題查詢</h3>

<ul>
  <li><a href='<%=request.getContextPath() %>/front/que/addQue.jsp'>Add</a> a new Que.</li>
</ul>

</body>

</html>
