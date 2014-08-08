<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="back.loc.model.*"%>

<%
//	MemberVO tenVO = (MemberVO)session.getAttribute("memberVO");
//	String ten_no = tenVO.getMno();
	//未來要修改用這會員的MNO去查他承租的訂單
	OrdService ordSvc = new OrdService();
	List<OrdVO> list = ordSvc.getAll();
	
	pageContext.setAttribute("list", list);
	int count = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>承租清單管理 - tenOrdList.jsp</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body bgcolor='white' align='center'>
	<table border='1' cellpadding='5' cellspacing='0' width='800' align="center">
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有承租資料 - tenOrdList.jsp</h3> <a
				href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">
					<img
					src="<%=request.getContextPath()%>/front/ord/images/back1.gif"
					width="100" height="32" border="0">回首頁
			</a></td>
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

	<%-- 一般提示 --%>
 	<c:if test="${not empty alertMsgs}">
 		<script>alert("${alertMsgs.alert}");</script>
 	</c:if>
 	
	<table border='1' bordercolor='#CCCCFF'  align='center'>
		<tr>
			<th>訂單編號</th>
			<th>租物圖片</th>
			<th>租物名稱</th>
			<th>訂單狀態</th>
			<th>交易方式</th>
			<th>租期</th>
<!-- 			<th>承租日期</th> -->
<!-- 			<th>到期日期</th> -->
			<th>承租天數</th>
			<th>逾期天數</th>
			<th>出租會員</th>
			<th>聯絡方式</th>

		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
			<%
				count++;
			    RentService rentSVC = new RentService();
    			RentVO rentVO = rentSVC.getOneRent(((OrdVO)pageContext.getAttribute("ordVO")).getRent_no());
				pageContext.setAttribute("rentVO",rentVO);
				//查出出租者聯絡資料
				MemberService memberSVC = new MemberService();
				MemberVO lesVO = memberSVC.getOneMember(rentVO.getLes_no());
				//pageContext.setAttribute("lesVO",lesVO);
			%>

			<tr align='center' valign='middle'>

				<td>${ordVO.ord_no         }</td>
				<td><img width="100" height="100" src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${ordVO.rent_no}&pic=pic1"></td>	
				<td><a href="javascript:pressesA${s.index}()">${rentVO.rent_name}</a></td>
				<td>${ord_staMap[ordVO.ord_sta]}</td>
				<td>${tra_staMap[ordVO.tra_mode]}</td>
				<td>${ordVO.ten_date       }<br>
				             ~              <br>
				    ${ordVO.exp_date       }</td>
				<td>${ordVO.ten_days       }天</td>
				<td>${ordVO.ot_days        }天</td>
				<td><a href="javascript:pressesB${s.index}()"><%=lesVO.getMname() %></a></td>
				<td align='left'>
					Mail : <%=lesVO.getMmail() %><br>
				    phone: <%=lesVO.getMcell() %></td>
								
				
<%-- 				<td>${ordVO.freight        }</td> --%>
<%-- 				<td>${ordVO.rent_total     }</td> --%>
<%-- 				<td>${ordVO.ten_no         }</td> --%>
<%-- 				<td>${ordVO.init_dps       }</td> --%>
<%-- 				<td>${ordVO.real_dps       }</td> --%>
<%-- 				<td>${ordVO.tra_total      }</td> --%>
<%-- 				<td>${ordVO.loc_no         }</td> --%>
<%-- 				<td>${ordVO.rec_addr       }</td> --%>
<%-- 				<td>${ordVO.les_ases       }</td> --%>
<%-- 				<td>${ordVO.les_ases_ct    }</td> --%>
<%-- 				<td>${ordVO.ten_ases       }</td> --%>
<%-- 				<td>${ordVO.ten_ases_ct    }</td> --%>
<%-- 				<td>${ordVO.w_apr_time     }</td> --%>
<%-- 				<td>${ordVO.w_ship_time    }</td> --%>
<%-- 				<td>${ordVO.dtbt_time      }</td> --%>
<%-- 				<td>${ordVO.rec_com_time   }</td> --%>
<%-- 				<td>${ordVO.rent_exp_time  }</td> --%>
<%-- 				<td>${ordVO.rt_time        }</td> --%>
<%-- 				<td>${ordVO.rt_com_time    }</td> --%>
<%-- 				<td>${ordVO.cls_time       }</td> --%>
<%-- 				<td>${ordVO.cc_ord_time    }</td> --%>
<%-- 				<td>${ordVO.ord_cc_cause   }</td> --%>

<!-- 								<td> -->
<!-- 									<FORM METHOD="post" -->
<%-- 										ACTION="<%=request.getContextPath() %>/front/ord/ord.do"> --%>
<!-- 										<input type="submit" value="編輯"> <input type="hidden" -->
<%-- 											name="ord_no" value="${ordVO.ord_no}"> <input --%>
<!-- 											type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 									</FORM> -->
<!-- 								</td> -->
				<td>
					
<!-- 					<FORM METHOD="post" -->
<%-- 						ACTION="<%=request.getContextPath()%>/ord/ord.do"> --%>
<!-- 						<input type="submit" value="刪除"> <input type="hidden" -->
<%-- 							name="ord_no" value="${ordVO.ord_no}"> <input --%>
<!-- 							type="hidden" name="action" value="delete"> -->
<!-- 					</FORM> -->
					

					<button id="cc_ord<%=count%>" >刪除訂單</button>
					<div id="dialog-form<%=count%>" title="取消訂單[${ordVO.ord_no}]">
						<p>請輸入取消訂單的原因.</p>
						<form method="post"
							action="<%=request.getContextPath()%>/front/ord/ord.do">
							<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
							<input type="hidden" name="action" value="delete">
							<textarea name="ord_cc_cause" rows="4" cols="35" maxlength="100"></textarea>
							<input id="cancel<%=count%>" type="submit" value="取消訂單">
						</form>
					</div> 
					<script>
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
	  						$("#dialog-form<%=count%>").find("[type=submit]").hide();});
					</script>
				</td>
			</tr>
			<script>
				//超連結至該租物
         		function pressesA${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
				//超連結至該出租人
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
         		
			</script>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
