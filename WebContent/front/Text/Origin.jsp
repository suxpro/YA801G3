<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script>

</script>



<head>

</head>
<body>



	<form class="form-horizontal introText" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">		
目前台灣租借物品風氣相較於國外的相關服務缺欠許多，常常只是因為需要使用一段時間或者是一次性的使用，而為此購買商品著實浪費空間與成本。
倘若家中用不到的物品提供租賃，藉此可以清理家中雜物，更可以獲得額外的收入。
而這時候如果有人能在網路提供租借平台，讓雙方都能達成目的，甚至是在緊急需要求救時，附近的人能及時幫助需要的人，造成雙贏的立場，何樂而不為之。



		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">確定</button>
			</div>
		</div>
	</form>

</BODY>
</html>
