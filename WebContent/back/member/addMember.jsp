<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>會員資料新增 - addMember.jsp</title>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>
<body bgcolor='white'>
	<table border='1' cellpadding='5' cellspacing='0' width='400'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td>
				<h3>會員資料新增 - addMember.jsp</h3>
			</td>
			<td><a href="<%=request.getContextPath()%>/back/member/select_page.jsp"><img src="images/tomcat.gif"
					width="100" height="100" border="1">回首頁</a></td>
		</tr>
	</table>

	<h3>資料會員:</h3>
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/back/member/member.do" name="form1"
		enctype="multipart/form-data">
		<table border="0">

			<tr>
				<td>會員帳號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mid" size="45"
					value="<%=(memberVO == null) ? "hayaha" : memberVO.getMid()%>" /></td><td>${errorMsgs.mid}</td>
			</tr>

			<tr>
				<td>會員密碼:<font color=red><b>*</b></font></td>
				<td><input type="password" name="mpwd" size="45"
					value="<%=(memberVO == null) ? "Aa12345" : memberVO.getMpwd()%>" /></td><td>${errorMsgs.mpwd}</td>
			</tr>
			<tr>
				<td>會員圖片:</td>
				<td><input type="file" name="mpic" /></td><td>${errorMsgs.mpic}</td>
			</tr>
			<tr>
				<td>會員姓名:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mname" size="45"
					value="<%=(memberVO == null) ? "跳跳虎" : memberVO.getMname()%>" /></td><td>${errorMsgs.mname}</td>
			</tr>
			<tr>
				<td>會員性別:<font color=red><b>*</b></font></td>
				<td>男<input type="radio" name="msex" value=M checked /> 女<input
					type="radio" name="msex" value=F />
				</td><td>${errorMsgs.msex}</td>
			</tr>
			<tr>
				<td>會員手機:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mcell" size="45"
					value="<%=(memberVO == null) ? "0911863655" : memberVO.getMcell()%>" /></td><td>${errorMsgs.mcell}</td>
			</tr>
			<tr>
				<td>會員郵件:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="mmail" size="45"
					value="<%=(memberVO == null) ? "ggininder@gmail.com" : memberVO
					.getMmail()%>" /></td><td>${errorMsgs.mmail}</td>
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
				</select></td><td>${errorMsgs.locno}</td>
			</tr>


			<tr>
				<td>會員地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="madrs" size="45"
					value="<%=(memberVO == null) ? "桃園縣大溪鎮勝利路1號" : memberVO.getMadrs()%>" /></td><td>${errorMsgs.madrs}</td>
			</tr>

			<tr>
				<td>會員等級:<font color=red><b>*</b></font></td>
				<td><select size="1" name="mlev">
						<option value="G" selected>一般會員</option>
						<option value="V">VIP會員</option>
						<option value="S">停權會員</option>
				</select></td><td>${errorMsgs.mlev}</td>
			</tr>

			<tr>
				<td>會員帳戶餘額:</td>
				<td><input type="TEXT" name="mbalance" size="45"
					value="<%=(memberVO == null) ? "10000" : memberVO.getMbalance()%>" /></td><td>${errorMsgs.mbalance}</td>
			</tr>

			<tr>
				<td>會員違規次數:</td>
				<td><input type="TEXT" name="millegal" size="45"
					value="<%=(memberVO == null) ? "5" : memberVO.getMillegal()%>" /></td><td>${errorMsgs.millegal}</td>
			</tr>

			<tr>
				<td>會員評價:</td>
				<td><input type="TEXT" name="massess" size="45"
					value="<%=(memberVO == null) ? "50" : memberVO.getMassess()%>" /></td><td>${errorMsgs.massess}</td>
			</tr>

			<tr>
				<td>會員驗證欄位:<font color=red><b>*</b></font></td>
				<td><select size="1" name="mverification">
						<option value="Y" selected>已驗證</option>
						<option value="N">未驗證</option>
				</select></td><td>${errorMsgs.mverification}</td>
			</tr>
			<tr>
				<%
					java.sql.Date date_SQL = new java.sql.Date(
							System.currentTimeMillis());
				%>
				<td>加入日期:</td>
				<td bgcolor="#CCCCFF"><input class="cal-TextBox"
					onFocus="this.blur()" size="9" readonly type="text" name="mdate"
					value="<%=(memberVO == null) ? date_SQL : memberVO.getMdate()%>">
					<a class="so-BtnLink" href="javascript:calClick();return false;"
					onmouseover="calSwapImg('BTN_date', 'img_Date_OVER',true);"
					onmouseout="calSwapImg('BTN_date', 'img_Date_UP',true);"
					onclick="calSwapImg('BTN_date', 'img_Date_DOWN');showCalendar('form1','mdate','BTN_date');return false;">
						<img align="middle" border="0" name="BTN_date"
						src="images/btn_date_up.gif" width="22" height="17" alt="開始日期">
				</a></td><td>${errorMsgs.mdate}</td>
			</tr>

			<tr>
				<td>會員圖片格式:</td>
				<td><input type="TEXT" name="mpic_info" size="45"
					value="<%=(memberVO == null) ? "PNG" : memberVO.getMpic_info()%>" /></td><td>${errorMsgs.mpic_info}</td>
			</tr>
			
			<tr>
				<td>會員輪播圖片</td>
				<td><input type="file" name="mvpic" /></td><td>${errorMsgs.mvpic}</td>
			</tr>

			<tr>
				<td>會員輪播格式:</td>
				<td><input type="TEXT" name="mvpic_info" size="45"
					value="<%=(memberVO == null) ? "PNG" : memberVO.getMvpic_info()%>" /></td><td>${errorMsgs.mvpic_info}</td>
			</tr>

			

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>

</body>
</html>