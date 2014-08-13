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
	//未來要修改用這會員的MNO去查他出租的訂單
	OrdService ordSvc = new OrdService();
	List<OrdVO> list = ordSvc.getAll();
	
	pageContext.setAttribute("list", list);
	int count = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Refresh" content="30;URL=<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">
<title>出租清單管理 - lesOrdList.jsp</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body bgcolor='white' align='center'>
	<table border='1' cellpadding='5' cellspacing='0' width='800'
		align="center">
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有出租資料 - lesOrdList.jsp</h3> <a
				href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp"> <img
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

	<table border='1' bordercolor='#CCCCFF' align='center'>
		<tr>
			<th>租物圖片</th>
			<th>訂單編號</th>
			<th>租物名稱</th>
			<th>訂單狀態</th>
			<th>交易方式</th>
			<th>租期</th>
			<th>承租天數</th>
			<th>逾期天數</th>
			<th>承租會員</th>
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
					//查出承租者聯絡資料
					MemberService memberSVC = new MemberService();
					MemberVO tenVO = memberSVC.getOneMember(((OrdVO)pageContext.getAttribute("ordVO")).getTen_no());
					//pageContext.setAttribute("lesVO",lesVO);
			%>

			<tr align='center' valign='middle'>

				<td><img width="100" height="100"
					src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${ordVO.rent_no}&pic=pic1"></td>
				<td><a href="javascript:pressesA${s.index}()">${ordVO.ord_no    }</a></td>
				<td><a href="javascript:pressesB${s.index}()">${rentVO.rent_name}</a></td>
				<td>${ord_staMap[ordVO.ord_sta]}</td>
				<td>${tra_staMap[ordVO.tra_mode]}</td>
				<td>${ordVO.ten_date       }<br> ~ <br>
					${ordVO.exp_date       }</td>
				<td>${ordVO.ten_days       }天</td>
				<td>${ordVO.ot_days        }天</td>
				<td><a href="javascript:pressesC${s.index}()"><%=tenVO.getMname()%></a></td>
				<td align='left'>Mail : <a href="mailto:<%=tenVO.getMmail()%>"><%=tenVO.getMmail()%></a><br>
					Phone#: <font color='blue'><%=tenVO.getMcell()%></font></td>
				<td>
					<button id="app_ord<%=count%>" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span>核准</span>
					</button>
					<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do">
						<input type="hidden" name="ord_no" value="${ordVO.ord_no}"> 
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="sta" id="sta<%=count%>" value="W_SHIP">
						<input type="hidden" name="reqURL" value="/front/ord/lesOrdList.jsp">
						<input id="apply<%=count%>" type="submit" value="核准"> 
					</form>
				</td>
				<td>
					<button id="rt_com<%=count%>" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span>回收完成</span>
					</button>
					<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do">
						<input type="hidden" name="ord_no" value="${ordVO.ord_no}"> 
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="sta" id="sta<%=count%>" value="RT_COM">
						<input type="hidden" name="reqURL" value="/front/ord/lesOrdList.jsp">
						<input id="rt<%=count%>" type="submit" value="回收"> 
					</form>				
				</td>
				<td>
					<button id="close<%=count%>" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span>結案</span>
					</button>
					<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do">
						<input type="hidden" name="ord_no" value="${ordVO.ord_no}"> 
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="sta" id="sta<%=count%>" value="CLS">
						<input type="hidden" name="reqURL" value="/front/ord/lesOrdList.jsp">
						<input id="cls<%=count%>" type="submit" value="結案"> 
					</form>				
				</td>
				<td>
					<button id="cc_ord<%=count%>">取消</button>
					<div id="dialog-form<%=count%>" title="取消訂單[${ordVO.ord_no}]">
						<p>請輸入取消訂單的原因.</p>
						<form method="post"
							action="<%=request.getContextPath()%>/front/ord/ord.do">
							<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
							<input type="hidden" name="action" value="cancel">
							<input type="hidden" name="role" value="les">
							<textarea name="ord_cc_cause" rows="4" cols="35" maxlength="100"></textarea>
							<input id="cancel<%=count%>" type="submit" value="取消">
						</form>
					</div> <script>
						// 設定dialog
		 				$("#dialog-form<%=count%>").dialog({
						autoOpen : false,
						height : 300,
						width : 400,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									取消 : function() {
										$("#cancel<%=count%>").click();
										},
									返回 : function() {
										$("#dialog-form<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-form<%=count%>").dialog("close");
							}
						});
						
                        // cancel button click() 啟用 dialog
						$("#cc_ord<%=count%>").button().on("click", function() {
	     					$("#dialog-form<%=count%>").dialog("open");
	  						$("#dialog-form<%=count%>").find("[type=submit]").hide();});
                        
                        // 隱藏 核准 submit button
                        $("#apply<%=count%>").hide();
                        // apply button click() 啟用 submit
                        $("#app_ord<%=count%>").button().on("click", function() {
                        	$("#apply<%=count%>").click();});
                        
                        // 隱藏 回收 submit button
                        $("#rt<%=count%>").hide();
                        // retirn button click() 啟用 submit
                        $("#rt_com<%=count%>").button().on("click", function() {
                        	$("#rt<%=count%>").click();});
                        
                        // 隱藏 結案 submit button
                        $("#cls<%=count%>").hide();
                        // close button click() 啟用 submit
                        $("#close<%=count%>").button().on("click", function() {
                        	$("#cls<%=count%>").click();});
                      
						
						//依狀態讓按鈕失效
						var ord_sta = "${ordVO.ord_sta}";
						if(ord_sta == "W_APR"){ //1.訂單狀態為待核准
<%-- 							$("#cc_ord<%=count%>").show(); --%>
<%-- 							$("#cc_ord<%=count%>").hide(); --%>
							$("#app_ord<%=count%>").attr("disabled", false); 
							$("#cc_ord<%=count%>").attr("disabled", false);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							//下個狀態為待出貨
							$("#sta<%=count%>").val("W_SHIP");
							
						} else if (ord_sta == "W_SHIP"){//2.訂單狀態為待出貨
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							
// 						}else if (ord_sta == "DTBT"){//3.訂單狀態為配送中
							
<%-- 							$("#app_ord<%=count%>").attr("disabled", true); --%>
<%-- 							$("#cc_ord<%=count%>").attr("disabled", true); --%>
							
						}else if (ord_sta == "REC_COM"){//4.訂單狀態為收貨完成
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RENT_EXP"){//5.訂單狀態為租約到期
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", false);
							$("#close<%=count%>").attr("disabled", true);
							
// 						}else if (ord_sta == "RT"){//6.訂單狀態為回收中
							
<%-- 							$("#app_ord<%=count%>").attr("disabled", true); --%>
<%-- 							$("#cc_ord<%=count%>").attr("disabled", true); --%>
							
						}else if (ord_sta == "RT_COM"){//7.訂單狀態為回收完成
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", false);
							
						}else if (ord_sta == "CLS"){//8.訂單狀態為結案
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "CC_ORD"){//9.訂單狀態為取消訂單
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "AB_CLS"){//10.訂單狀態為異常結案
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RE_ORD"){//11.訂單狀態為待續約
							
							$("#app_ord<%=count%>").attr("disabled", false);
							$("#cc_ord<%=count%>").attr("disabled", false);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
							//下個狀態為原先的訂單狀態
							$("#sta<%=count%>").val("APP_RENEW");
							
						}else{
							
							$("#app_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							$("#rt_com<%=count%>").attr("disabled", true);
							$("#close<%=count%>").attr("disabled", true);
						}
						
					</script>
				</td>
			</tr>
			<script>
				//超連結至該訂單明細
     			function pressesA${s.index}(){
    	 			document.open("<%=request.getContextPath()%>/front/ord/ord.do?ord_no=${ordVO.ord_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
     			}
				//超連結至該租物
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
				//超連結至該承租人
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.ten_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
			</script>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
