<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>會員資料修改 - updateMemberInfo.jsp</title>

<style type="text/css">
#preview{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
#preview2{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead2 {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}

#memform { 
margin: 0 auto; 
width:700px;
}

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>
</head>
<body> 
	
	<%@ include file="/front/header.file"%>
	
	<h3 align="center">會員資料修改</h3>
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

	<FORM id="memform" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">
			<tr>
				<td>會員編號</td>
				<td><%=memberVO.getMno()%></td>
			</tr>

			<tr>
				<td>會員帳號</td>
				<td><%=memberVO.getMid()%></td>
			</tr>


			<tr>
				<td>會員密碼:</td>
				<td><input type="password" name="mpwd" size="45"
					value="<%=(memberVO == null) ? "Aa1234d" : memberVO.getMpwd()%>" /></td>
				<td>${errorMsgs.mpwd}</td>
			</tr>
			<tr>
				<td>會員圖片</td>
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC"></td>
				<td><input type="file" name="mpic" /></td>
				<td>${errorMsgs.mpic}</td>
			</tr>
			<tr>
				<td>會員姓名:</td>
				<td><input type="TEXT" name="mname" size="45"
					value="<%=(memberVO == null) ? "跳跳虎" : memberVO.getMname()%>" /></td>
				<td>${errorMsgs.mname}</td>
			</tr>
			<tr>
				<td>會員性別:<font color=red><b>*</b></font></td>
				<td>男 <input type="radio" name="msex" value=M checked /> 女 <input
					type="radio" name="msex" value=F />
				</td>
				<td>${errorMsgs.msex}</td>
			</tr>
			<tr>
				<td>會員手機:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mcell" size="45"
					value="<%=(memberVO == null) ? "0911863655" : memberVO.getMcell()%>" /></td>
				<td>${errorMsgs.mcell}</td>
			</tr>
			<tr>
				<td>會員郵件:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mmail" size="45"
					value="<%=(memberVO == null) ? "ggininder@gmail.com" : memberVO
					.getMmail()%>" /></td>
				<td>${errorMsgs.mmail}</td>
			</tr>

			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />
			<tr>
				<td>地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="locno">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>


			<tr>
				<td>會員地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="madrs" size="45" value="<%=(memberVO == null) ? "桃園縣大溪鎮勝利路1號" : memberVO.getMadrs()%>" /></td>
				<td>${errorMsgs.madrs}</td>
			</tr>

		<c:if test="<%=memberVO.getMlev().equals('V')%>">
			<tr>
				<td>會員輪播圖片</td>
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC"></td>
				<td><input type="file" name="mvpic" /></td>
				<td>${errorMsgs.mvpic}</td>
			</tr>
		</c:if>
		</table>
		<br><input type="hidden" name="action" value="updateInfo"> 
			<input type="hidden" name="mno" value="<%=memberVO.getMno()%>"> 
			<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--原送出修改的來源網頁路徑,從request取出後,再送給Controller準備轉交之用-->
			<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
			<input type="submit" value="送出修改">
	</FORM>
	
	<%@ include file="/front/footer.file"%>
</body>
</html>