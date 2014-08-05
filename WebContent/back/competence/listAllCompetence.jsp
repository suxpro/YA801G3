<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.competence.model.*"%>
<%@ page import="back.employee.model.*"%>
<%@ page import="back.func.model.*"%>

<%
    CompetenceService comSvc = new CompetenceService();
    EmployeeService empSvc = new EmployeeService();
    FuncService funcSvc = new FuncService();
	List<CompetenceVO> list = comSvc.getAll();
	pageContext.setAttribute("comList", list);
    pageContext.setAttribute("comEmpSvc", empSvc);
    pageContext.setAttribute("comFuncSvc", funcSvc);
%>
<script>$.getScript("js/competence/listAllCompetence.js");</script>

<div class="container-fluid">
	<div class="row">
		<!-- 功能按鈕 -->
		<nav class="navbar navbar-default" role="navigation">
			<!-- 新增員工權限按鈕 -->
			<button class="btn btn-primary navbar-btn navbar-left"
				data-toggle="modal" data-target="#addComModel">新增</button>

			<!-- Modal -->
			<div class="modal fade" id="addComModel" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<%@ include file="/back/competence/addCom.jsp"%>
					</div>
				</div>
			</div>

			<!-- 刪除員工權限按鈕 -->
			<button class="btn btn-primary navbar-btn navbar-left"
				id="btnDelCom">刪除</button>

			<!-- 搜尋員工權限 -->
			<form id="formListAllComSearch" role="search" class="navbar-form navbar-right" value="<%=request.getContextPath()%>/competence/competence.do" enctype="multipart/form-data">
				<div class="form-group">
					<input type="text" id="inputListAllComSearch" class="form-control" placeholder="Search By 編號">
                    <input type="hidden" name="action" value="searchCom">
				</div>
				<button type="button" id="btnListAllComSubmit" class="btn btn-default">搜尋</button>
			</form>

			<!-- 分頁按鈕 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="liListAllComPage disabled"><a href="#" class="navbar-link">1</a></li>
				<c:forEach var="i" begin="2" end="${comList.size()/8+1}" step="1">
					<li class="liListAllComPage"><a href="#" class="navbar-link">${i}</a></li>
				</c:forEach>
			</ul>
		</nav>
	</div>
	<div class="row">
		<!-- 列表 -->
		<div class="table-responsive">
			<table id="listAllComTable" class="table table-hover"
				style="white-space: nowrap;">
				<thead>
					<tr>
						<th class="delComTd" style="display: none;" title="comDel">刪除</th>
						<th title="empNo">員工編號</th>
                        <th title="empName">員工編號</th>
						<th title="comNo">員工權限</th>
						<th title="comInfo">權限描述</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="comVO" items="${comList}" varStatus="status">
						<tr title="${status.count}">
							<td class="delComTd" style="display: none;">
								<button type="button"
									class="delComSubmit btn btn-danger btn-default btn-xs"
									value="<%=request.getContextPath()%>/competence/competence.do">
									<span class="glyphicon glyphicon-remove"></span>
								</button>
							</td>
                            <td>${comVO.emp_no}</td>
                            <td>${comEmpSvc.getOneEmp(comVO.emp_no).getEmp_name()}</td>
							<td>${comVO.func_no}</td>
                            <td>${comFuncSvc.getOneFunc(comVO.func_no).getFunc_desc()}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td class="updateComTd" style="display: none;">
							<button type="button" class="btn btn-primary btn-sm"
								id="updateComYes"
								value="<%=request.getContextPath()%>/competence/competence.do">
								<span class="glyphicon glyphicon-ok-sign"></span>確定
							</button>
						</td>
						<td class="updateComTd" style="display: none;">
							<button type="button" class="btn btn-default btn-sm"
								id="updateComNo">
								<span class="glyphicon glyphicon-remove-sign"></span>取消
							</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
