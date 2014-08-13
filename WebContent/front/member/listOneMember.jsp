<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>�|����� - MemberInfo</title>

<style type="text/css">
#preview {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#preview2 {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {
	width: 85%;
}
</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

</head>
<body>

	<table border='1' bordercolor='#CCCCFF' width='100%'>
		<tr>
			<th>�|���b��</th>
			<th>�|���m�W</th>
			<th>�|���ʧO</th>
			<th>�|������</th>
			<th>�|������</th>
			<th>�H�W����</th>
			<th>�|���l��</th>
			<th>�a��</th>
			<th>�|������</th>
			<th>�[�J���</th>
			<th>�|���Ϥ�</th>

			

		</tr>
		<tr align='center' valign='middle'>
			<td>${memberVO.mid}</td>
			<td>${memberVO.mname}</td>
			<td>${mem_staMap[memberVO.msex]}</td>
			<td>${mem_staMap[memberVO.mlev]}</td>
			<td>${memberVO.massess}</td>
			<td>${memberVO.millegal}</td>
			<td>${memberVO.mmail}</td>
			<td>${loc_staMap[memberVO.locno]}</td>
			<td>${mem_staMap[memberVO.mverification]}</td>
			<td>${memberVO.mdate}</td>
			<td><img id="mpic" width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC"></td>

		</tr>
	</table>


</body>
</html>