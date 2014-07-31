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
<title>�|����ƭק� - updateMemberInfo.jsp</title>

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
	
	<h3 align="center">�|����ƭק�</h3>
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

	<FORM id="memform" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">
			<tr>
				<td>�|���s��</td>
				<td><%=memberVO.getMno()%></td>
			</tr>

			<tr>
				<td>�|���b��</td>
				<td><%=memberVO.getMid()%></td>
			</tr>


			<tr>
				<td>�|���K�X:</td>
				<td><input type="password" name="mpwd" size="45"
					value="<%=(memberVO == null) ? "Aa1234d" : memberVO.getMpwd()%>" /></td>
				<td>${errorMsgs.mpwd}</td>
			</tr>
			<tr>
				<td>�|���Ϥ�</td>
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC"></td>
				<td><input type="file" name="mpic" /></td>
				<td>${errorMsgs.mpic}</td>
			</tr>
			<tr>
				<td>�|���m�W:</td>
				<td><input type="TEXT" name="mname" size="45"
					value="<%=(memberVO == null) ? "������" : memberVO.getMname()%>" /></td>
				<td>${errorMsgs.mname}</td>
			</tr>
			<tr>
				<td>�|���ʧO:<font color=red><b>*</b></font></td>
				<td>�k <input type="radio" name="msex" value=M checked /> �k <input
					type="radio" name="msex" value=F />
				</td>
				<td>${errorMsgs.msex}</td>
			</tr>
			<tr>
				<td>�|�����:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mcell" size="45"
					value="<%=(memberVO == null) ? "0911863655" : memberVO.getMcell()%>" /></td>
				<td>${errorMsgs.mcell}</td>
			</tr>
			<tr>
				<td>�|���l��:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mmail" size="45"
					value="<%=(memberVO == null) ? "ggininder@gmail.com" : memberVO
					.getMmail()%>" /></td>
				<td>${errorMsgs.mmail}</td>
			</tr>

			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />
			<tr>
				<td>�a��:<font color=red><b>*</b></font></td>
				<td><select size="1" name="locno">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>


			<tr>
				<td>�|���a�}:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="madrs" size="45" value="<%=(memberVO == null) ? "��鿤�j����ӧQ��1��" : memberVO.getMadrs()%>" /></td>
				<td>${errorMsgs.madrs}</td>
			</tr>

		<c:if test="<%=memberVO.getMlev().equals('V')%>">
			<tr>
				<td>�|�������Ϥ�</td>
				<td><img width="80" height="80"
					src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC"></td>
				<td><input type="file" name="mvpic" /></td>
				<td>${errorMsgs.mvpic}</td>
			</tr>
		</c:if>
		</table>
		<br><input type="hidden" name="action" value="updateInfo"> 
			<input type="hidden" name="mno" value="<%=memberVO.getMno()%>"> 
			<input type="hidden" name="requestURL" value="<%=request.getAttribute("requestURL")%>"><!--��e�X�ק諸�ӷ��������|,�qrequest���X��,�A�e��Controller�ǳ���椧��-->
			<input type="hidden" name="whichPage" value="<%=request.getAttribute("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
			<input type="submit" value="�e�X�ק�">
	</FORM>
	
	<%@ include file="/front/footer.file"%>
</body>
</html>