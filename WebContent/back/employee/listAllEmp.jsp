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
<script>
	$.getScript("js/employee/listAllEmp.js");
</script>
<div class="container-fluid">
	<div class="row">
		<!-- 功能按鈕 -->
		<nav class="navbar navbar-default" role="navigation">
			<!-- 新增員工按鈕 -->
			<button class="btn btn-primary navbar-btn navbar-left"
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
			<button class="btn btn-primary navbar-btn navbar-left"
				id="updateEmpBtn">修改</button>

			<!-- 刪除員工按鈕 -->
			<button class="btn btn-primary navbar-btn navbar-left"
				id="delEmpBtn">刪除</button>

			<!-- 搜尋員工 -->
			<form class="navbar-form navbar-right" role="search">
				<div class="form-group">
					<input type="text" class="form-control" placeholder="Search 員工編號">
				</div>
				<button type="submit" class="btn btn-default">搜尋</button>
			</form>

			<!-- 分頁按鈕 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="liListAllEmpPage disabled"><a href="#" class="navbar-link">1</a></li>
				<c:forEach var="i" begin="2" end="${list.size()/5+1}" step="1">
					<li class="liListAllEmpPage"><a href="#" class="navbar-link">${i}</a></li>
				</c:forEach>
			</ul>
		</nav>
	</div>
	<div class="row">
		<!-- 列表 -->
		<div class="table-responsive">
			<table id="listAllEmpTable" class="table table-hover"
				style="white-space: nowrap;">
				<thead>
					<tr>
						<th class="delEmpTd" style="display: none;" title="empDel">刪除</th>
						<th title="empNo">編號</th>
						<th title="empId">帳號</th>
						<th title="empName">姓名</th>
						<th title="empSex">性別</th>
						<th title="empTel">電話</th>
						<th title="empCell">手機</th>
						<th title="empMail">Email</th>
						<th title="empAddr">地址</th>
						<th title="empJob">職位</th>
						<th title="empSal">薪水</th>
						<th title="empTod">到職日</th>
						<th title="empEcp">緊急聯絡人</th>
						<th title="empEcell">聯絡人電話</th>
						<th title="empPic">圖片</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="empVO" items="${list}" varStatus="status">
						<tr title="${status.count}">
							<td class="delEmpTd" style="display: none;">
								<button type="button"
									class="delEmpSubmit btn btn-danger btn-default btn-xs"
									value="<%=request.getContextPath()%>/employee/employee.do">
									<span class="glyphicon glyphicon-remove"></span>
								</button>
							</td>
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
							<td>${empVO.emp_ecp}</td>
							<td>${empVO.emp_ecell}</td>
							<td><img
								src="<%=request.getContextPath()%>/employee/employee.do?emp_no=${empVO.emp_no}"
								height="50" width="50" /></td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td class="updateEmpTd" style="display: none;">
							<button type="button" class="btn btn-primary btn-sm"
								id="updateEmpYes"
								value="<%=request.getContextPath()%>/employee/employee.do">
								<span class="glyphicon glyphicon-ok-sign"></span>確定
							</button>
						</td>
						<td class="updateEmpTd" style="display: none;">
							<button type="button" class="btn btn-default btn-sm"
								id="updateEmpNo">
								<span class="glyphicon glyphicon-remove-sign"></span>取消
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
