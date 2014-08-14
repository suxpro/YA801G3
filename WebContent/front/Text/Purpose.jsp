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



	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">				
提供一個簡單易用的線上租賃平台，可以將家中暫時沒有使用的物品，藉由平台的功能，出租於有短暫使用需求的人； 
另一方面，讓有一次性需求的人可藉此平台完成短期租賃的目的來達到成本節約的效益，服務平台本身來說，可從租賃行為中收取服務的手續費與網站上張貼廣告的業外收益，來維持平台營運與獲利，達到互惠互利的多贏局面。



		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">確定</button>
			</div>
		</div>
	</form>

</BODY>
</html>
