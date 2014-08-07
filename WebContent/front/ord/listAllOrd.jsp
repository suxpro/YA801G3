<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="back.loc.model.*"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>
<%
	OrdService ordSvc = new OrdService();
	List<OrdVO> list = ordSvc.getAll();
	pageContext.setAttribute("list", list);
	int count = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有訂單資料 - listAllOrd.jsp</title>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

</head>
<body bgcolor='white' align = "center">
	<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='1900' align = "center">
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有訂單資料 - ListAllOrd.jsp</h3> 
			<a href="<%=request.getContextPath() %>/front/ord/select_page.jsp">
			<img src="<%=request.getContextPath() %>/front/ord/images/back1.gif" width="100" height="32" border="0">回首頁</a></td>
		</tr>
	</table>

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

	<table border='1' bordercolor='#CCCCFF' width='800'>
		<tr>
			<th>定單編號</th>
			<th>租物編號</th>
			<th>承租會員</th>
			<th>訂單狀態</th>
			<th>交易方式</th>

			<th>運費</th>
			<th>承租日期</th>
			<th>到期日期</th>
			<th>承租天數</th>
			<th>租金總額</th>

			<th>逾期天數</th>
			<th>初始押金</th>
			<th>實際押金</th>
			<th>交易總額</th>
			<th>收貨地區</th>

			<th>收貨地址</th>
			<th>出租方評價</th>
			<th>出租方評價內容</th>
			<th>承租方評價</th>
			<th>承租方評價</th>

			<th>待核准時間</th>
			<th>待出貨時間</th>
			<th>配送中時間</th>
			<th>收貨完成時間</th>
			<th>租約到期時間</th>

			<th>回收中時間</th>
			<th>回收完成時間</th>
			<th>結案時間</th>
			<th>取消訂單時間</th>
			<th>訂單取消原因</th>

		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<% count++;%>
			
			<tr align='center' valign='middle'>

				<td>${ordVO.ord_no         }</td>
				<td>${ordVO.rent_no        }</td>
				<td>${ordVO.ten_no         }</td>
				<td>${ordVO.ord_sta        }</td>
				<td>${ordVO.tra_mode       }</td>

				<td>${ordVO.freight        }</td>
				<td>${ordVO.ten_date       }</td>
				<td>${ordVO.exp_date       }</td>
				<td>${ordVO.ten_days       }</td>
				<td>${ordVO.rent_total     }</td>

				<td>${ordVO.ot_days        }</td>
				<td>${ordVO.init_dps       }</td>
				<td>${ordVO.real_dps       }</td>
				<td>${ordVO.tra_total      }</td>
				<td>${ordVO.loc_no         }</td>

				<td>${ordVO.rec_addr       }</td>
				<td>${ordVO.les_ases       }</td>
				<td>${ordVO.les_ases_ct    }</td>
				<td>${ordVO.ten_ases       }</td>
				<td>${ordVO.ten_ases_ct    }</td>

				<td>${ordVO.w_apr_time     }</td>
				<td>${ordVO.w_ship_time    }</td>
				<td>${ordVO.dtbt_time      }</td>
				<td>${ordVO.rec_com_time   }</td>
				<td>${ordVO.rent_exp_time  }</td>

				<td>${ordVO.rt_time        }</td>
				<td>${ordVO.rt_com_time    }</td>
				<td>${ordVO.cls_time       }</td>
				<td>${ordVO.cc_ord_time    }</td>
				<td>${ordVO.ord_cc_cause   }</td>

<!-- 				<td> -->
<!-- 					<FORM METHOD="post" -->
<%-- 						ACTION="<%=request.getContextPath() %>/front/ord/ord.do"> --%>
<!-- 						<input type="submit" value="編輯"> <input type="hidden" -->
<%-- 							name="ord_no" value="${ordVO.ord_no}"> <input --%>
<!-- 							type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 					</FORM> -->
<!-- 				</td> -->
				<td>
					<!--
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/ord/ord.do">
						<input type="submit" value="刪除"> <input type="hidden"
							name="ord_no" value="${ordVO.ord_no}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
					-->

					<button id="cc_ord<%=count%>" width="20px" height="20px">Cancel</button>
					<div id="dialog-form<%=count%>" title="取消訂單[${ordVO.ord_no}]">
						<p>請輸入取消訂單的原因.</p>
						<form method="post"
							action="<%=request.getContextPath() %>/front/ord/ord.do">
							<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
							<input type="hidden" name="action" value="delete">
							<textarea name="ord_cc_cause" rows="4" cols="35" maxlength="100"></textarea>
							<input id="cancel<%=count%>" type="submit" value="取消訂單">
						</form>
					</div> <script>
		 				$("#dialog-form<%=count%>").dialog({
						autoOpen : false,
						height : 300,
						width : 400,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									Delete : function() {
										$("#cancel<%=count%>").click();
										},
									Cancel : function() {
										$("#dialog-form<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-form<%=count%>").dialog("close");
							}
						});

						$("#cc_ord<%=count%>").button().on("click", function() {
	     					$("#dialog-form<%=count%>").dialog( "open" );
	  						$("#dialog-form<%=count%>").find("[type=submit]").hide();
						});
					</script>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
