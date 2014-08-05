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
		<h4 class="modal-title" id="myModalLabel">新增員工權限</h4>
	</div>

    <form class="form-horizontal" role="form" id="addComForm" value="<%=request.getContextPath()%>/competence/competence.do" enctype="multipart/form-data">
		<div class="modal-body">
			<div class="form-group">
				<label for="addComEmpNo" class="col-md-2 control-label">員工編號:</label>
                <div class="col-md-4">
                    <select class="form-control" id="addComEmpNo" name="addComEmpNo">
                        <c:forEach var="comEmp" items="${comEmpSvc.getAll()}" varStatus="status">
                            <option>${comEmp.getEmp_no()}</option>
                        </c:forEach>
                    </select>
                </div>
			</div>
            <div class="form-group">
                <label for="addComFuncNo" class="col-md-2 control-label">權限編號:</label>
                <div class="col-md-4">
                    <select class="form-control" id="addComFuncNo" name="addComFuncNo">
                        <c:forEach var="comFunc" items="${comFuncSvc.getAll()}" varStatus="status">
                            <option>${comFunc.getFunc_no()}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
			<div class="form-group modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="submit" class="btn btn-primary">確定</button>
                <input type="hidden" name="action" value="addCom">
			</div>
		</div>
	</form>
