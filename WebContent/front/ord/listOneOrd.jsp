<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.ord.model.*"%>
<%
	OrdVO ordVO = (OrdVO) request.getAttribute("ordVO");
	//取得租物資料
	String rent_no = ordVO.getRent_no();
	RentService rentSVC = new RentService();
	RentVO rentVO = rentSVC.getOneRent(rent_no);
	request.setAttribute("rentVO", rentVO);
	//取得承租會員資料(取得登入帳號)
	// 	MemberService memberSVC = new MemberService();
	// 	MemberVO memberVO = memberSVC.getOneMember("M10001");
%>
<html>
<head>
<title>訂單明細資料 - cartToOrd.jsp</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script>
	
</script>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body align='center' bgcolor='white'>


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
	<h3>訂單明細資料:</h3>
	<table border="1" class="table table-bordered" align='center' cellspacing="10">

		<tr>
			<td>租物名稱:<font color=red></font></td>
			<td>${rentVO.rent_name}</td>
		</tr>
		<tr>
			<td>交易方式:<font color=red></font></td>
			<td>${tra_staMap[ordVO.tra_mode]}</td>
		</tr>
		<tr>
			<td>運費:<font color=red></font></td>
			<td>${ordVO.freight}元</td>
		</tr>
		<tr>
			<td>承租日期:<font color=red></font></td>
			<td><input type="TEXT" name="ten_date" id="ten_date"
				class="date" value="${ordVO.ten_date}" readonly="readonly" /></td>
		</tr>
		<tr>
			<td>到期日期:<font color=red></font></td>
			<td><input type="TEXT" name="exp_date" id="exp_date"
				class="date" value="${ordVO.exp_date}" readonly="readonly" /></td>
		</tr>
		<tr>
			<td>承租天數:<font color=red></font></td>
			<td>${ordVO.ten_days}天</td>
		</tr>
		<tr>
			<td>租金/天:<font color=red></font></td>
			<td>${rentVO.unit_price}元</td>
		</tr>
		<tr>
			<td>租金總額:<font color=red></font></td>
			<td>${ordVO.rent_total}元</td>
		</tr>
		<tr>
			<td>租物押金:<font color=red></font></td>
			<td>${rentVO.rent_dps}元</td>
		</tr>
		<tr>
			<td>租物所在地區:<font color=red></font></td>
			<td>${loc_staMap[rentVO.loc_no]}</td>
		</tr>
		<tr>
			<td>租物所在地址:<font color=red></font></td>
			<td>${ordVO.rec_addr}</td>
		</tr>
		<tr>
			<td valign="top">費用總金額:<font color=red></font></td>
			<td><label style="color: red"> = 運費 + 租金總額(租金*承租天數) +
					租物押金 </label><br> <input type="TEXT" name="tra_total" id="tra_total"
				value="${ordVO.tra_total}" style="color: red" readonly="readonly" />元
			</td>
		</tr>
	</table>

</body>
</html>
