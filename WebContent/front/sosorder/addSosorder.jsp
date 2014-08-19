<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

function sosForm(){ 
    addSosForm.addSosName.value = "三項之力";
    addSosForm.addSosPay.value = "3703";
    addSosForm.addSosDays.value = "1";
    addSosForm.addSosDesc.value = "閃耀劍+黃雙刀+小冰錘";
};
</script>
<%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!--     <font color='red'>請修正以下錯誤: -->
<!--     <ul> -->
<%--         <c:forEach var="message" items="${errorMsgs}"> --%>
<%--             <li>${message.value}</li> --%>
<%--         </c:forEach> --%>
<!--     </ul> -->
<!--     </font> -->
<%-- </c:if> --%>

	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal">
			<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
		</button>
		<h4 class="modal-title" id="myModalLabel">新增SOS租物</h4>
	</div>

    <form class="form-horizontal" role="form" id="addSosForm" name="addSosForm" data-action="<%=request.getContextPath()%>/front/sosorder/sosorder.do" enctype="multipart/form-data">
		<div class="modal-body">
			<div class="form-group">
				<label for="addSosName" class="col-md-2 control-label">租物名稱:</label>
				<div class="col-md-4">
					<input type="text" class="form-control" id="addSosName" name="addSosName"
						placeholder="租物名稱" required="required" />
				</div>
<%-- 				${errorMsgs.emp_id} --%>
                <label for="addSosPic" class="col-md-2 control-label">上傳圖片:</label>
				<div class="col-md-4">
					<input type="file" id="addSosPic" name="addSosPic">
				</div>
			</div>
			<div class="form-group">
				<label for="addSosPay" class="col-md-2 control-label">租物總額:</label>
				<div class="col-md-4">
                    <input type="number" class="form-control" id="addSosPay" name="addSosPay"
                        value="100" max="99999" min="1" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addSosDays" class="col-md-2 control-label">欲租天數:</label>
				<div class="col-md-4">
					<input type="number" class="form-control" id="addSosDays" name="addSosDays"
						value="1" max="365" min="1" required="required" />
				</div>
			</div>
			<div class="form-group">
				<label for="addSosDesc" class="col-md-2 control-label">租物描述:</label>
				<div class="col-md-4">
					<textarea rows="3" cols="20" class="form-control" id="addSosDesc" name="addSosDesc"
						placeholder="租物描述" required="required" ></textarea>
				</div>
			</div>
			<div class="form-group modal-footer">
                <img src="img/7065_key.png" onClick="sosForm()" />
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="submit" class="btn btn-primary">確定</button>
                <input type="hidden" name="action" value="addSos">
			</div>
		</div>
	</form>
