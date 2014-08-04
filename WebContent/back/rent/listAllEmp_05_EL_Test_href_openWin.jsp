<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%-- 此測試頁，練習採用 EL 的寫法取值 --%>

<jsp:useBean id="empDAO" scope="page" class="forTest.EmpDAO" />
<jsp:useBean id="deptDAO" scope="page" class="forTest.DeptDAO" />


<html>
<head>
<title>所有員工資料</title>
</head>
<body bgcolor='white'>
<b><font color=red>此測試頁，練習採用 EL 的寫法取值:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>所有員工資料<br>
		    (listAllEmp_05_EL_Test_<font color=blue>href_openWin</font>.jsp)</h3>
		</td>
	</tr>
</table>

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>員工編號</th>
		<th>員工姓名</th>
		<th>職位</th>
		<th>雇用日期</th>
		<th>薪水</th>
		<th>獎金</th>
		<th>部門</th>
	</tr>
 
	<c:forEach var="empVO" items="${empDAO.all}" varStatus="s">
		<tr align='center' valign='middle'>
			<td><A HREF="javascript:presses${s.index}()">${empVO.empno}</a></td>
			<td>${empVO.ename}</td>
			<td>${empVO.job}</td>
			<td>${empVO.hiredate}</td>
			<td>${empVO.sal}</td>
			<td>${empVO.comm}</td>			
			<td><c:forEach var="deptVO" items="${deptDAO.all}">
                    <c:if test="${empVO.deptno==deptVO.deptno}">
	                    ${deptVO.deptno}【${deptVO.dname} - ${deptVO.loc}】
                    </c:if>
                </c:forEach>
			</td>
		</tr>
        
        <script>
         function presses${s.index}(){
        	 document.open("test_emp.do?empno=${empVO.empno}&action=getOne_From05", "" ,"height=250,width=850,left=65,top=157,resizable=yes,scrollbars=yes");
         }
        </script>
	
	</c:forEach>
</table>
 

</body>
</html>
