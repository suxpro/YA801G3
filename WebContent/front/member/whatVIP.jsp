<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script>

</script>
<style>
textarea {
	margin: 15px;
	width: 540px;
	height: 350px;
	overflow: auto;
	border: 0;
	font-size: 15px;
	line-height: 170%;
	font-family: Verdana, Arial, sans-serif;
}
</style>


<head>

</head>
<body>



	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">		
親愛的會員您好！升級為VIP黃金會員的特權如下：
		
 一、租物區商品 
 1.您的租物會與一般會員有所區別，將會擁有與眾不同的效果，讓瀏覽網站的租客能馬上為之一亮，大大提起承租的意願。
 2.您的租物順序將會優先於一般會員的排列方式，讓租客能最先瀏覽您的租物，大大增加承租的意願。

二、廣告輪播
 獲得個人租物廣告的權利(可上傳自己個人租物特別廣告)，並放置在本網站首頁上的輪播圖片中，將可以大大增加自己租物的曝光率，也能讓自己的商品時時讓人印象深刻，並且提高承租的意願。


		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">確定</button>
			</div>
		</div>
	</form>

</BODY>
</html>
