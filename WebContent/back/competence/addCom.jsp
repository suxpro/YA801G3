<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
    <font color='red'>請修正以下錯誤:
    <ul>
        <c:forEach var="message" items="${errorMsgs}">
            <li>${message.value}</li>
        </c:forEach>
    </ul>
    </font>
</c:if>

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">新增員工</h4>
	</div>

    <form class="form-horizontal" role="form" id="addEmpForm" value="<%=request.getContextPath()%>/employee/employee.do" enctype="multipart/form-data">
<%--     <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/employee/employee.do" method="post" enctype="multipart/form-data"> --%>
		<div class="modal-body">
			<div class="form-group">
				<label for="addEmpAccount" class="col-md-2 control-label">帳號:</label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="addEmpAccount" name="addEmpAccount"
						placeholder="帳號" required="required" />
				</div>${errorMsgs.emp_id}
                <label for="addEmpPic" class="col-md-2 control-label">圖片上傳:</label>
				<div class="col-md-4">
					<input type="file" id="addEmpPic" name="addEmpPic">
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpPassword" class="col-md-2 control-label">密碼:</label>
				<div class="col-md-4">
					<input type="password" class="form-control" id="addEmpPassword" name="addEmpPassword"
						placeholder="密碼" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpName" class="col-md-2 control-label">姓名:</label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="addEmpName" name="addEmpName"
						placeholder="姓名" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 control-label">性別:</label> <label
					class="radio-inline"> <input type="radio"
					 name="addEmpSex" value="M" /> 男
				</label> <label class="radio-inline"> <input type="radio"
					 name="addEmpSex" value="F" /> 女
				</label>
			</div>
			<div class="form-group">
				<label for="addEmpTel" class="col-md-2 control-label">電話:</label>
				<div class="col-md-4">
					<input type="tel" class="form-control" id="addEmpTel" name="addEmpTel"
						placeholder="電話" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpCell" class="col-md-2 control-label">手機:</label>
				<div class="col-md-4">
					<input type="tel" class="form-control" id="addEmpCell" name="addEmpCell"
						placeholder="手機" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpEmail" class="col-md-2 control-label">Email:</label>
				<div class="col-md-4">
					<input type="email" class="form-control" id="addEmpEmail" name="addEmpEmail"
						placeholder="Email" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpAddress" class="col-md-2 control-label">地址:</label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="addEmpAddress" name="addEmpAddress"
						placeholder="地址" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpJob" class="col-md-2 control-label">職位</label>
				<div class="col-md-4">
					<select class="form-control" id="addEmpJob" name="addEmpJob">
						<option>administrator</option>
						<option>employee</option>
						<option>logistics</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpSal" class="col-md-2 control-label">薪水</label>
				<div class="col-md-4">
					<input type="number" class="form-control" id="addEmpSal" name="addEmpSal"
						value="22000" max="99999" min="22000" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpTOD" class="col-md-2 control-label">到職日</label>
				<div class="col-md-4">
					<input type="date" class="form-control" id="addEmpTOD" name="addEmpTOD" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpECP" class="col-md-2 control-label">緊急聯絡人</label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="addEmpECP" name="addEmpECP"
						placeholder="緊急聯絡人" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addEmpECell" class="col-md-2 control-label">緊急聯絡人電話</label>
				<div class="col-md-4">
					<input type="tel" class="form-control" id="addEmpECell" name="addEmpECell"
						placeholder="緊急聯絡人電話" required="required" />
				</div>
			</div>
			<div class="form-group modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="submit" class="btn btn-primary">確定</button>
                <input type="hidden" name="action" value="addEmp">
<%--            <button type="button" id="addEmp" class="addSubmit btn btn-primary" value="<%=request.getContextPath()%>/employee/employee.do">確定</button> --%>
			</div>
		</div>
	</form>
