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
<title>�|����Ʒs�W - addMember.jsp</title>

<style type="text/css">
#preview{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
#preview2{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead2 {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
</style>

</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>�|����Ʒs�W - addMember.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/front/member/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">�^����</a></td>
		</tr>
	</table>

	<h3>��Ʒ|��:</h3>
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
				<td>�|���b��:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mid" size="45"
					value="<%=(memberVO == null) ? "hayaha" : memberVO.getMid()%>" /></td><td>${errorMsgs.mid}</td>
			</tr>

			<tr>
				<td>�|���K�X:<font color=red><b>*</b></font></td>
				<td><input type="password" name="mpwd" size="45"
					value="<%=(memberVO == null) ? "Aa12345" : memberVO.getMpwd()%>" /></td><td>${errorMsgs.mpwd}</td>
			</tr>
			<tr>
				<td>�|���Ϥ�:</td>
				<td><input type="file" name="mpic" onchange="previewImage(this)" /></td>
				<td id="preview">
   					 <img id="imghead" width=100 height=100 border=0 src=''>
				</td>
				<td>${errorMsgs.mpic}</td>
			</tr>
			<tr>
				<td>�|���m�W:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mname" size="45"
					value="<%=(memberVO == null) ? "������" : memberVO.getMname()%>" /></td><td>${errorMsgs.mname}</td>
			</tr>
			<tr>
				<td>�|���ʧO:<font color=red><b>*</b></font></td>
				<td>�k<input type="radio" name="msex" value=M checked /> �k<input
					type="radio" name="msex" value=F />
				</td><td>${errorMsgs.msex}</td>
			</tr>
			<tr>
				<td>�|�����:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mcell" size="45"
					value="<%=(memberVO == null) ? "0911863655" : memberVO.getMcell()%>" /></td><td>${errorMsgs.mcell}</td>
			</tr>
			<tr>
				<td>�|���l��:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mmail" size="45"
					value="<%=(memberVO == null) ? "ggininder@gmail.com" : memberVO
					.getMmail()%>" /></td><td>${errorMsgs.mmail}</td>
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
				</select></td><td>${errorMsgs.locno}</td>
			</tr>


			<tr>
				<td>�|���a�}:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="madrs" size="45"
					value="<%=(memberVO == null) ? "��鿤�j����ӧQ��1��" : memberVO.getMadrs()%>" /></td><td>${errorMsgs.madrs}</td>
			</tr>

			<tr>
				<td>�|������:<font color=red><b>*</b></font></td>
				<td><select size="1" name="mlev">
						<option value="G" selected>�@��|��</option>
						<option value="V">VIP�|��</option>
						<option value="S">���v�|��</option>
				</select></td><td>${errorMsgs.mlev}</td>
			</tr>

			<tr>
				<td>�|���b��l�B:</td>
				<td><input type="TEXT" name="mbalance" size="45"
					value="<%=(memberVO == null) ? "10000" : memberVO.getMbalance()%>" /></td><td>${errorMsgs.mbalance}</td>
			</tr>

			<tr>
				<td>�|���H�W����:</td>
				<td><input type="TEXT" name="millegal" size="45"
					value="<%=(memberVO == null) ? "5" : memberVO.getMillegal()%>" /></td><td>${errorMsgs.millegal}</td>
			</tr>

			<tr>
				<td>�|������:</td>
				<td><input type="TEXT" name="massess" size="45"
					value="<%=(memberVO == null) ? "50" : memberVO.getMassess()%>" /></td><td>${errorMsgs.massess}</td>
			</tr>

			<tr>
				<td>�|���������:<font color=red><b>*</b></font></td>
				<td><select size="1" name="mverification">
						<option value="Y" selected>�w����</option>
						<option value="N">������</option>
				</select></td><td>${errorMsgs.mverification}</td>
			</tr>
			<tr>
				<%
					java.sql.Date date_SQL = new java.sql.Date(
							System.currentTimeMillis());
				%>
				<td>�[�J���:</td>
				<td bgcolor="#CCCCFF"><input class="cal-TextBox"
					onFocus="this.blur()" size="9" readonly type="text" name="mdate"
					value="<%=(memberVO == null) ? date_SQL : memberVO.getMdate()%>">
					<a class="so-BtnLink" href="javascript:calClick();return false;"
					onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
					onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
					onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','mdate','BTN_date');return false;">
						<img align="middle" border="0" name="BTN_date"
						src="images/btn_date_up.gif" width="22" height="17" alt="�}�l���">
				</a></td><td>${errorMsgs.mdate}</td>
			</tr>

			<tr>
				<td>�����Ϥ�</td>
				<td><input type="file" name="mvpic" onchange="previewImage2(this)" /></td>
				<td id="preview2">
   					 <img id="imghead2" width=100 height=100 border=0 src=''>
				</td>
				<td>${errorMsgs.mvpic}</td>
			</tr>

			

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="�e�X�s�W">
	</FORM>

</body>
</html>