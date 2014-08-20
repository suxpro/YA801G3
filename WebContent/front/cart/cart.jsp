<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>
<%!//定義返回的日期格式
	static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");//定義返回的日期格式

	//去掉時間的毫秒數方法
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//格式化傳過來的時間就可以去掉毫秒數
		else
			return "";
	}%>
<%
	RentService rentSVC = new RentService();
	//List<RentVO> list = rentSvc.getAll();
	//pageContext.setAttribute("list", list);
	MemberService memberSVC = new MemberService();
	
	Vector<String> rentList = (Vector<String>)session.getAttribute("rentList");
	if(rentList == null){
		rentList = new Vector<String>();  
// 		rentList.add("R10001");
		session.setAttribute("rentList",rentList);
	}
//     session.invalidate();
    
	int count = 0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%-- <meta http-equiv="Refresh" content="30;URL=<%=request.getContextPath()%>/front/cart/cart.jsp"> --%>
<title>JustRent! - 租物車</title>
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
<body>
	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

			<!-- SideBar -->
			<div class="col-md-2 sidebar">
				<div class="panel-group" id="accordion">
					<!-- 會員資料 -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne"> 會員管理 </a>
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
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo"> 租物管理 </a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物資料</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/rent/addRent.jsp">新增租物</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- 承租管理 -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseThree"> 承租管理 </a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li class="active"><a
										href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物車</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租清單</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
								</ul>
							</div>
						</div>
					</div>


					<!-- 出租管理  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFour"> 出租管理 </a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">出租清單</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- 歷史紀錄  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFive"> 歷史記錄 </a>
							</h4>
						</div>
						<div id="collapseFive" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借記錄</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
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
							<b>租物車</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0">

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

					<table class="table table-condensed ">
						<tr class="danger">
							<th style="text-align: center">租物圖片</th>
							<th style="text-align: center">租物名稱</th>
							<th style="text-align: center">出租者</th>
							<th style="text-align: center">租物狀態</th>
							<th style="text-align: center">租物押金</th>
							<th style="text-align: center">租物價格/天</th>
							<th style="text-align: center">出貨/回收緩衝</th>
							<th style="text-align: center">地區</th>
							<!-- 			<th>租物地址</th> -->

						</tr>

						<%@ include file="page1.file"%>
						<c:forEach var="rent_no" items="${rentList}" varStatus="s">
							<%
								RentVO rentVO = rentSVC.getOneRent((String)pageContext.getAttribute("rent_no"));
									pageContext.setAttribute("rentVO",rentVO);
									
									MemberVO memberVO = memberSVC.getOneMember(rentVO.getLes_no());
									pageContext.setAttribute("memberVO",memberVO);
									 count++;
							%>

							<tr>
								<td style="text-align: center" rowspan="2"><img width="100"
									height="100"
									src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
								<td style="text-align: center"><a
									href="javascript:pressesA${s.index}()">${rentVO.rent_name}</a></td>
								<td style="text-align: center"><a
									href="javascript:pressesB${s.index}()">${memberVO.mname}</a></td>
								<td style="text-align: center">${rent_staMap[rentVO.rent_sta]}</td>
								<td style="text-align: center">${rentVO.rent_dps         }元</td>
								<td style="text-align: center">${rentVO.unit_price       }元</td>
								<td style="text-align: center">${rentVO.reset_days       }天</td>
								<td style="text-align: center">${loc_staMap[rentVO.loc_no]}</td>
								<%-- 				<td>${rentVO.rent_addr        }</td> --%>

								<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
								<%-- 						.getAttribute("rentVO")).getLast_sta_time())%></td> --%>
								<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
								<%-- 						.getAttribute("rentVO")).getLast_onshelf_time())%></td> --%>
								<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
								<%-- 						.getAttribute("rentVO")).getLast_mod_time())%></td> --%>
							</tr>
							<tr>
								<td colspan="8" style="border-top: none;"  align="left">
									<table>
										<tr>
											<td>
												<FORM method="post"
													action="<%=request.getContextPath()%>/front/ord/addOrd.jsp">
													<button type="submit" class="btn btn-primary"
														id="add_ord<%=count%>">前往結帳</button>
													<input type="hidden" name="rent_no"
														value="${rentVO.rent_no}"> <input type="hidden"
														name="action" value="getOne_For_Update"> <input
														type="hidden" name="requestURL"
														value="/front/cart/cart.jsp">
												</FORM> <script>
					var rent_sta = "${rentVO.rent_sta}";
					if(rent_sta == "W_RENT"){ 
						$("#add_ord<%=count%>").attr("disabled", false);							
					} else {
						$("#add_ord<%=count%>").attr("disabled", true); 
					}
					</script>
											</td>
											<td>
												<FORM method="post"
													action="<%=request.getContextPath()%>/front/cart/cart.do">
													<button type="submit" class="btn btn-primary">移除</button>
													<input type="hidden" name="del" value="${s.index}">
													<input type="hidden" name="action" value="delete">
												</FORM>

											</td>
										</tr>
									</table>
								</td>
							</tr>

							<script>
				//超連結至該租物
         		function pressesA${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=600,width=600,left=65,top=50,resizable=yes,scrollbars=yes");
         		}
				//超連結至該出租人
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=600,width=600,left=65,top=50,resizable=yes,scrollbars=yes");
         		}
         		
        	</script>
						</c:forEach>
					</table>
					<%@ include file="page2.file"%>
				</div>
			</div>
		</div>
		</div>
		<%@ include file="/front/footer.jsp"%>
</body>
</html>
