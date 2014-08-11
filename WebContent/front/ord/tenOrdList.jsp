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
	<table border='1' cellpadding='5' cellspacing='0' width='800'
		align="center">
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有承租資料 - tenOrdList.jsp</h3> <a
				href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp"> <img
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

				<td><img width="100" height="100"
					src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${ordVO.rent_no}&pic=pic1"></td>
				<td><a href="javascript:pressesA${s.index}()">${ordVO.ord_no    }</a></td>
				<td><a href="javascript:pressesB${s.index}()">${rentVO.rent_name}</a></td>
				<td>${ord_staMap[ordVO.ord_sta]}</td>
				<td>${tra_staMap[ordVO.tra_mode]}</td>
				<td>${ordVO.ten_date       }<br> ~ <br>
					${ordVO.exp_date       }
				</td>
				<td>${ordVO.ten_days       }天</td>
				<td>${ordVO.ot_days        }天</td>
				<td><a href="javascript:pressesC${s.index}()"><%=lesVO.getMname()%></a></td>
				<td align='left'>Mail : <a href="mailto:<%=lesVO.getMmail()%>"><%=lesVO.getMmail()%></a><br>
					Phone#: <font color='blue'><%=lesVO.getMcell()%></font></td>


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
					<button id="re_ord<%=count%>">續約</button>
					<div id="dialog-form1<%=count%>" title="續約[${ordVO.ord_no}]">
						<form method="post"
							action="<%=request.getContextPath()%>/front/ord/ord.do">
							<table border='1' bordercolor='#CCCCFF' align='center'>
								<tr>
									<td>(原)到期日</td>
									<td align='left'><input type="text" name="exp_date"
										id="exp_date<%=count%>" value="${ordVO.exp_date}"></td>
								</tr>
								<tr>
									<td>(新)到期日</td>
									<td align='left'><input type="text" name="nexp_date"
										id="nexp_date<%=count%>" id="nexp_date"></td>
								</tr>
								<tr>
									<td>延展天數</td>
									<td align='left'><input type="text" name="ext_days"
										id="ext_days<%=count%>" value="0" readonly='readonly'></td>
								</tr>
								<tr>
									<td>租金/天</td>
									<td align='left'><input type="text" name="unit_price"
										id="unit_price<%=count%>" value="${rentVO.unit_price}"
										readonly='readonly'></td>
								</tr>
								<tr>
									<td>需補差額</td>
									<td align='left'><input type="text" name="dif_price"
										id="dif_price<%=count%>" value="0" readonly='readonly'></td>
								</tr>
								<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
								<input type="hidden" name="action" value="renew">
								<input id="renew<%=count%>" type="submit" value="續約">
							</table>
							<script>
							$("#exp_date<%=count%>").datepicker({dateFormat : 'yy-mm-dd'});
							//讓(原)起始日固定
							$("#exp_date<%=count%>").datepicker("disable");
							
							$("#nexp_date<%=count%>").datepicker({
								dateFormat : 'yy-mm-dd',
								showOn : "button",
								buttonImage : "<%=request.getContextPath()%>/front/ord/images/calendar.gif",
												buttonImageOnly : true,
												numberOfMonths : 2,
												changeYear : true,
												changeMonth : true,
												beforeShow : function() {
													if ($.trim($("#exp_date<%=count%>").val()) != "") {
														var date = $("#exp_date<%=count%>").datepicker("getDate");
														//新的到期日必須大於原到期日
														date.setDate(date.getDate() + 1);
														var date_str = $.datepicker.formatDate("yy-mm-dd", date);
														$("#nexp_date<%=count%>").datepicker("option","defaultDate", date_str);
														$("#nexp_date<%=count%>").datepicker("option","minDate", date_str);
													}
												}
											});
							//修改到期日後 計算相差天數 與需補差價
							$("#nexp_date<%=count%>").change(
									function() {
										if ($.trim($("#exp_date<%=count%>").val()) != ""
												&& $.trim($("#nexp_date<%=count%>").val()) != "") {
											var date1 = $("#exp_date<%=count%>").datepicker("getDate");
											var date2 = $("#nexp_date<%=count%>").datepicker("getDate");
											var days = ((date2 - date1) / (24 * 60 * 60 * 1000));
											if (days < 0)
												days = 0;
											$("#ext_days<%=count%>").val(days);
										} else
											$("#ext_days<%=count%>").val(0);
										//計算差價
										var dif_price = $("#ext_days<%=count%>").val() * $("#unit_price<%=count%>").val();
										$("#dif_price<%=count%>").val(dif_price);

									});
							
							</script>

						</form>
					</div>
				</td>
				<td>
					<button id="cc_ord<%=count%>">取消</button>
					<div id="dialog-form2<%=count%>" title="取消訂單[${ordVO.ord_no}]">
						<p>請輸入取消訂單的原因.</p>
						<form method="post"
							action="<%=request.getContextPath()%>/front/ord/ord.do">
							<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
							<input type="hidden" name="action" value="cancel"> <input
								type="hidden" name="role" value="ten">
							<textarea name="ord_cc_cause" rows="4" cols="35" maxlength="100"></textarea>
							<input id="cancel<%=count%>" type="submit" value="取消">
						</form>
					</div>
				</td>
				<script>			
					//dialog for續約  - start
	 				$("#dialog-form1<%=count%>").dialog({
						autoOpen : false,
						height :350,
						width : 400,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									續約 : function() {
										$("#renew<%=count%>").click();
										},
									返回 : function() {
										$("#dialog-form1<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-form1<%=count%>").dialog("close");
							}
					});

					$("#re_ord<%=count%>").button().on("click", function() {
     					$("#dialog-form1<%=count%>").dialog( "open" );
  						$("#dialog-form1<%=count%>").find("[type=submit]").hide();});
					//dialog for續約  - end
									
					//dialog for取訂單  - start
		 			$("#dialog-form2<%=count%>").dialog({
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
										$("#dialog-form2<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-form2<%=count%>").dialog("close");
							}
						});

						$("#cc_ord<%=count%>").button().on("click", function() {
	     					$("#dialog-form2<%=count%>").dialog( "open" );
	  						$("#dialog-form2<%=count%>").find("[type=submit]").hide();});
						//dialog for刪除訂單  - end
											
						
						//依狀態讓按鈕失效
						var ord_sta = "${ordVO.ord_sta}";
						if(ord_sta == "W_APR"){ //1.訂單狀態為待核准
<%-- 							$("#cc_ord<%=count%>").show(); --%>
<%-- 							$("#cc_ord<%=count%>").hide(); --%>
							$("#re_ord<%=count%>").attr("disabled", true); 
							$("#cc_ord<%=count%>").attr("disabled", false);
							
						} else if (ord_sta == "W_SHIP"){//2.訂單狀態為待出貨
							
							$("#re_ord<%=count%>").attr("disabled", false);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "DTBT"){//3.訂單狀態為配送中
							
							$("#re_ord<%=count%>").attr("disabled", false);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "REC_COM"){//4.訂單狀態為收貨完成
							
							$("#re_ord<%=count%>").attr("disabled", false);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RENT_EXP"){//5.訂單狀態為租約到期
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RT"){//6.訂單狀態為回收中
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RT_COM"){//7.訂單狀態為回收完成
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "CLS"){//8.訂單狀態為結案
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "CC_ORD"){//9.訂單狀態為取消訂單
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "AB_CLS"){//10.訂單狀態為異常結案
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);
							
						}else if (ord_sta == "RE_ORD"){//11.訂單狀態為待續約
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", false);
							
						}else{
							
							$("#re_ord<%=count%>").attr("disabled", true);
							$("#cc_ord<%=count%>").attr("disabled", true);													
						}
					</script>
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
				//超連結至該出租人
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
			</script>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
