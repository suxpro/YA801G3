<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%-- �����խ��A�m�߱ĥ� EL ���g�k���� --%>

<jsp:useBean id="empDAO" scope="page" class="forTest.EmpDAO" />
<jsp:useBean id="deptDAO" scope="page" class="forTest.DeptDAO" />


<html>
<head>
<title>�Ҧ����u���</title>
</head>
<body bgcolor='white'>
<b><font color=red>�����խ��A�m�߱ĥ� EL ���g�k����:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>�Ҧ����u���<br>
		    (listAllEmp_05_EL_Test_<font color=blue>href_openWin</font>.jsp)</h3>
		</td>
	</tr>
</table>

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>���u�s��</th>
		<th>���u�m�W</th>
		<th>¾��</th>
		<th>���Τ��</th>
		<th>�~��</th>
		<th>����</th>
		<th>����</th>
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
	                    ${deptVO.deptno}�i${deptVO.dname} - ${deptVO.loc}�j
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
