<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="back.loc.model.*"%>

<%
	//取的session上的會員資料
	MemberVO tenVO = (MemberVO)session.getAttribute("memberVO");
    String ten_no = tenVO.getMno();
	//用這會員的MNO去查他承租的訂單
	OrdService ordSvc = new OrdService();
	List<OrdVO> list = ordSvc.getAllByMno("ten", ten_no);
	pageContext.setAttribute("list", list);
	int count = 0;
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
.tableScroll{ 
overflow:auto; 
} 
</style>

<!-- <meta http-equiv="Refresh" -->
<%-- 	content="30;URL=<%=request.getContextPath()%>/front/ord/tenOrdList.jsp"> --%>

<title>JustRent! - 承租管理 </title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

</head>
<body >
	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">
		
					<!-- SideBar -->
			<div class="col-md-2 sidebar">
			<div class="panel-group" id="accordion">
<!-- 會員資料 -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          會員管理
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
        <li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
        <li><a href="#" onclick="document.updateVIP.submit();">升級會員</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 租物管理  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          租物管理
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物資料</a></li>
        <li><a href="<%=request.getContextPath()%>/front/rent/addRent.jsp">新增租物</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 承租管理 -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
         承租管理
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物車</a></li>
        <li class="active"><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租清單</a></li>
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  
  <!-- 出租管理  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
          出租管理
        </a>
      </h4>
    </div>
    <div id="collapseFour" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">出租清單</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- 歷史紀錄  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          歷史紀錄
        </a>
      </h4>
    </div>
    <div id="collapseFive" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借紀錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易紀錄</a></li>
        </ul>
      </div>
    </div>
  </div>

</div>
			</div>
					<div class="col-md-10 col-md-offset-0">
				<div id="legend">
					<legend class="">
						<h2>
							<b>承租清單</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0 tableScroll">

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

	<table class="table table-hover " style="white-space: nowrap;">
		<tr class="info">
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
				
				//計算現在時間與租約開始時間的差距
				//開始承租時間的毫秒數
				java.util.Date tenTime = (java.util.Date)((OrdVO)pageContext.getAttribute("ordVO")).getTen_date();
				long len1 = tenTime.getTime();
				//現在時間的毫秒數
				long len2 = System.currentTimeMillis();
				//將時間差轉為天的單位
				double dif_days = (double) (len1 - len2) / (24*60*60*1000);				

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

				<td>
					<button class="btn btn-primary" id="re_ord<%=count%>">續約</button>
					<div id="dialog-formA<%=count%>" title="續約[${ordVO.ord_no}]">
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
					<button class="btn btn-primary" id="rec_com<%=count%>" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span>收貨完成</span>
					</button>
					<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do">
						<input type="hidden" name="ord_no" value="${ordVO.ord_no}"> 
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="sta" value="REC_COM">
						<input type="hidden" name="reqURL" value="/front/ord/tenOrdList.jsp">
						<input id="receive<%=count%>" type="submit" value="收貨"> 
					</form>				
				</td>
				<td>
					<button class="btn btn-primary" id="les_ases<%=count%>"
						class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
						role="button" aria-disabled="false">
						<span>評價</span>
					</button>
					<div id="dialog-formB<%=count%>" title="給予出租會員評價">
						
						<form method="post" action="<%=request.getContextPath()%>/front/ord/ord.do">
							<label>評價等級:</label>
							&nbsp;<input type="radio" name="ases" value=2>&nbsp;特優
							&nbsp;<input type="radio" name="ases" value=1>&nbsp;良好
							&nbsp;<input type="radio" name="ases" value=0>&nbsp;普通
							&nbsp;<input type="radio" name="ases" value=-1>&nbsp;極差<br>
                            <h4>輸入此次交易的意見.</h4>
							<textarea name="ases_ct" rows="4" cols="35" maxlength="100"></textarea>
							<input type="hidden" name="ord_no" value="${ordVO.ord_no}">
							<input type="hidden" name="action" value="update_ases"> 
							<input type="hidden" name="role" value="ten"> 
							<input type="hidden" name="reqURL" value="/front/ord/tenOrdList.jsp">
							<input id="ases<%=count%>" type="submit">
						</form>
					</div>


					<button id="cc_ord<%=count%>" class="btn btn-primary">取消</button>
					<div id="dialog-formC<%=count%>" title="取消訂單[${ordVO.ord_no}]">
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
	 				$("#dialog-formA<%=count%>").dialog({
						autoOpen : false,
						height :300,
						width : 400,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									續約 : function() {
										$("#renew<%=count%>").click();
										},
									返回 : function() {
										$("#dialog-formA<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-formA<%=count%>").dialog("close");
							}
					});

					$("#re_ord<%=count%>").button().on("click", function() {
     					$("#dialog-formA<%=count%>").dialog( "open" );
  						$("#dialog-formA<%=count%>").find("[type=submit]").hide();});
					//dialog for續約  - end
					
					// 隱藏  收貨 按鈕
                    $("#receive<%=count%>").hide();
                    // 收貨完成  click() 啟用 submit
                    $("#rec_com<%=count%>").button().on("click", function() {
                        	$("#receive<%=count%>").click();});
					
					//dialog for評價  - start
		 			$("#dialog-formB<%=count%>").dialog({
						autoOpen : false,
						height : 340,
						width : 420,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									送出 : function() {
										$("#ases<%=count%>").click();
										},
									返回 : function() {
										$("#dialog-formB<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-formB<%=count%>").dialog("close");
							}
						});

						$("#les_ases<%=count%>").button().on("click", function() {
	     					$("#dialog-formB<%=count%>").dialog("open");
	  						$("#dialog-formB<%=count%>").find("[type=submit]").hide();});
					//dialog for評價  - end                  
                              
					//dialog for取消訂單  - start
		 			$("#dialog-formC<%=count%>").dialog({
						autoOpen : false,
						height : 300,
						width : 400,
						modal : true,
						closeOnEscpe : true,
						buttons : {
									刪除 : function() {
										$("#cancel<%=count%>").click();
										},
									返回 : function() {
										$("#dialog-formC<%=count%>").dialog("close");
										}
									},
						close : function() {
							$("#dialog-formC<%=count%>").dialog("close");
							}
						});

						$("#cc_ord<%=count%>").button().on("click", function() {
	     					$("#dialog-formC<%=count%>").dialog( "open" );
	  						$("#dialog-formC<%=count%>").find("[type=submit]").hide();});
					//dialog for取消訂單  - end
											
						
						//依狀態讓按鈕失效
						var ord_sta = "${ordVO.ord_sta}";
						if(ord_sta == "W_APR"){ //1.訂單狀態為待核准
<%-- 							$("#cc_ord<%=count%>").show(); --%>
<%-- 							$("#cc_ord<%=count%>").hide(); --%>
<%-- 							$("#re_ord<%=count%>").attr("disabled", true);  --%>
<%-- 							$("#cc_ord<%=count%>").attr("disabled", false); --%>
<%-- 							$("#rec_com<%=count%>").attr("disabled", true); --%>
<%-- 							$("#les_ases<%=count%>").attr("disabled", true); --%>

							$("#re_ord<%=count%>").hide(); 
							$("#cc_ord<%=count%>").show();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
							
						} else if (ord_sta == "W_SHIP"){//2.訂單狀態為待出貨
							
							$("#re_ord<%=count%>").show();
							$("#cc_ord<%=count%>").hide();
							
							//如果離租約開始日 還沒達到 reset_days的天數差距 不能可以提早收到貨
							var reset_days = parseFloat(${rentVO.reset_days});
							var dif_days = Math.round(parseFloat(<%=dif_days %>) * 100) / 100;
//  							alert("reset_days: " + reset_days + " dif_days: " + dif_days ); 							
 							if (reset_days >= dif_days ){
								$("#rec_com<%=count%>").show();
 							} else {
								$("#rec_com<%=count%>").hide();		
 							}
 							
							$("#les_ases<%=count%>").hide();
							
// 						}else if (ord_sta == "DTBT"){//3.訂單狀態為配送中
							
<%-- 							$("#re_ord<%=count%>").attr("disabled", false); --%>
<%-- 							$("#cc_ord<%=count%>").attr("disabled", true); --%>
							
							
						}else if (ord_sta == "REC_COM"){//4.訂單狀態為收貨完成
							
							$("#re_ord<%=count%>").show();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").show();
							
						}else if (ord_sta == "RENT_EXP"){//5.訂單狀態為租約到期
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").show();
							
// 						}else if (ord_sta == "RT"){//6.訂單狀態為回收中
							
<%-- 							$("#re_ord<%=count%>").attr("disabled", true); --%>
<%-- 							$("#cc_ord<%=count%>").attr("disabled", true); --%>
							
						}else if (ord_sta == "RT_COM"){//7.訂單狀態為回收完成
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").show();
							
						}else if (ord_sta == "CLS"){//8.訂單狀態為結案
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
							
						}else if (ord_sta == "CC_ORD"){//9.訂單狀態為取消訂單
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
							
						}else if (ord_sta == "AB_CLS"){//10.訂單狀態為異常結案
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
							
						}else if (ord_sta == "RE_ORD"){//11.訂單狀態為待續約
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").show();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
							
						}else{
							
							$("#re_ord<%=count%>").hide();
							$("#cc_ord<%=count%>").hide();
							$("#rec_com<%=count%>").hide();
							$("#les_ases<%=count%>").hide();
						}
					</script>
			</tr>
			<script>
				//超連結至該訂單明細
     			function pressesA${s.index}(){
    	 			document.open("<%=request.getContextPath()%>/front/ord/ord.do?ord_no=${ordVO.ord_no}&action=getOne_For_Display", "" ,"height=450,width=500,left=65,top=100,resizable=yes,scrollbars=yes");
     			}
				//超連結至該租物
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=500,width=500,left=65,top=60,resizable=yes,scrollbars=yes");
         		}
				//超連結至該出租人
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
			</script>
		</c:forEach>		
	</table>
	
	<%@ include file="page2.file"%>

</div>
</div>
</div>
	<%@ include file="/front/footer.jsp"%>
</body>
</html>
