<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - �U���ҥi��</title>

<style type="text/css">
#preview{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
#preview2{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead2 {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}

form { 
margin: 0 auto; 
width:600px;
}

</style>

</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>
<body bgcolor='white'>

	<%@ include file="/front/header.file"%>

	<h3 align="center">���U�|��:</h3>
	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font color='red'>�Эץ��H�U���~:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message.value}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">

			<tr>
				<td><font color=red><b>*</b></font>�|���b��:</td>
				<td><input type="TEXT" name="mid" size="45"
					value="<%=(memberVO == null) ? "hayaha" : memberVO.getMid()%>" /></td><td>${errorMsgs.mid}</td>
			</tr>

			<tr>
				<td><font color=red><b>*</b></font>�|���K�X:</td>
				<td><input type="password" name="mpwd" size="45"
					value="<%=(memberVO == null) ? "Aa12345" : memberVO.getMpwd()%>" /></td><td>${errorMsgs.mpwd}</td>
			</tr>
			<tr>
				<td><font color=red><b>*</b></font>�|���Ϥ�:</td>
				<td><input type="file" name="mpic" onchange="previewImage(this)" /></td>
				<td id="preview">
   					 <img id="imghead" width=100 height=100 border=0 src=''>
				</td>
				<td>${errorMsgs.mpic}</td>
			</tr>
			<tr>
				<td><font color=red><b>*</b></font>�|���m�W:</td>
				<td><input type="TEXT" name="mname" size="45"
					value="<%=(memberVO == null) ? "������" : memberVO.getMname()%>" /></td><td>${errorMsgs.mname}</td>
			</tr>
			<tr>
				<td><font color=red><b>*</b></font>�|���ʧO:</td>
				<td>�k<input type="radio" name="msex" value=M checked /> �k<input
					type="radio" name="msex" value=F />
				</td><td>${errorMsgs.msex}</td>
			</tr>
			<tr>
				<td><font color=red><b>*</b></font>�|�����:</td>
				<td><input type="TEXT" name="mcell" size="45"
					value="<%=(memberVO == null) ? "0911863655" : memberVO.getMcell()%>" /></td><td>${errorMsgs.mcell}</td>
			</tr>
			<tr>
				<td><font color=red><b>*</b></font>�|���l��:</td>
				<td><input type="TEXT" name="mmail" size="45"
					value="<%=(memberVO == null) ? "ggininder@gmail.com" : memberVO
					.getMmail()%>" /></td><td>${errorMsgs.mmail}</td>
			</tr>

			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />
			<tr>
				<td><font color=red><b>*</b></font>�a��:</td>
				<td><select size="1" name="locno">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>


			<tr>
				<td><font color=red><b>*</b></font>�|���a�}:</td>
				<td><input type="TEXT" name="madrs" size="45"
					value="<%=(memberVO == null) ? "��鿤�j����ӧQ��1��" : memberVO.getMadrs()%>" /></td><td>${errorMsgs.madrs}</td>
			</tr>
			
			<tr>
				<td><input type="hidden" name="mverification" size="1"
					value="<%=(memberVO == null) ? "N" : memberVO.getMverification()%>" /></td>
			</tr>		
			<tr>
				<td><input type="hidden" name="mbalance" size="1"
					value="<%=(memberVO == null) ? "0" : memberVO.getMbalance()%>" /></td>
			</tr>
			
			<tr>
				<td><input type="hidden" name="mlev" size="1"
					value="<%=(memberVO == null) ? "G" : memberVO.getMlev()%>" /></td>
			</tr>

			<tr>
				<td><input type="hidden" name="millegal" size="1"
					value="<%=(memberVO == null) ? "0" : memberVO.getMillegal()%>" /></td>
			</tr>

			<tr>
				<td><input type="hidden" name="massess" size="1"
					value="<%=(memberVO == null) ? "0" : memberVO.getMassess()%>" /></td>
			</tr>
			<tr>
				<td><input type="hidden" name="mverification" size="1"
					value="<%=(memberVO == null) ? "N" : memberVO.getMverification()%>" /></td>
			</tr>
			

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="���U">
	</FORM>

	<%@ include file="/front/footer.jsp"%>

</body>
</html>