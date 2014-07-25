<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.employee.model.*"%>

<%
	EmployeeService empSvc = new EmployeeService();
	List<EmployeeVO> list = empSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<h3 class="page-header">員工帳號管理</h3>

<!-- BootStrap -->
<!-- 新增員工按鈕 -->
<!-- Button trigger modal -->
<button class="btn btn-default btn-primary navbar-btn"
	data-toggle="modal" data-target="#addEmpModel">新增</button>

<!-- Modal -->
<div class="modal fade" id="addEmpModel" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<%@ include file="/back/employee/addEmp.jsp"%>
		</div>
	</div>
</div>


<!-- 修改員工按鈕 -->
<button class="btn btn-default btn-primary navbar-btn"
	data-toggle="modal">修改</button>

<!-- 刪除員工按鈕 -->
<button class="btn btn-default btn-primary navbar-btn"
	data-toggle="modal">刪除</button>

<!-- 搜尋員工 -->
<form class="navbar-form navbar-right" role="search">
	<div class="form-group">
		<input type="text" class="form-control" placeholder="Search">
	</div>
	<button type="submit" class="btn btn-default">搜尋</button>
</form>





<div class="table-responsive">
	<table class="table table-hover" style="white-space: nowrap;">
		<thead>
			<tr>
				<th>編號</th>
				<th>帳號</th>
				<th>姓名</th>
				<th>性別</th>
				<th>電話</th>
				<th>手機</th>
				<th>Email</th>
				<th>地址</th>
				<th>職位</th>
				<th>薪水</th>
				<th>到職日</th>
				<th>離職日</th>
				<th>緊急聯絡人</th>
				<th>聯絡人電話</th>
				<th>圖片</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="empVO" items="${list}">
				<tr>
					<td>${empVO.emp_no}</td>
					<td>${empVO.emp_id}</td>
					<td>${empVO.emp_name}</td>
					<td>${empVO.emp_sex}</td>
					<td>${empVO.emp_tel}</td>
					<td>${empVO.emp_cell}</td>
					<td>${empVO.emp_mail}</td>
					<td>${empVO.emp_addr}</td>
					<td>${empVO.emp_job}</td>
					<td>${empVO.emp_sal}</td>
					<td>${empVO.emp_tod}</td>
					<td>${empVO.emp_lod}</td>
					<td>${empVO.emp_ecp}</td>
					<td>${empVO.emp_ecell}</td>
					<td><img
						src="<%=request.getContextPath()%>/employee/employee.do?emp_no=${empVO.emp_no}"
						height="50" width="50" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


<button id="showEmp">SHOW EMP</button>
<!--     <button id="addEmp">新增</button> -->
<a href='<%=request.getContextPath()%>/back/employee/addEmp.jsp'>Add</a>
a new Emp.
<button id="updateEmp">修改</button>
<button id="toggle">Toggle</button>
<div id="emp">
	<%--        <%@ include file="employee/listAllEmp.jsp"%> --%>
</div>