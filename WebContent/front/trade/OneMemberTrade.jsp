<%@page import="front.trade.model.TradeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.trade.model.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>

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
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	String mno = memberVO.getMno();

	TradeService tradeSvc = new TradeService();
	List<TradeVO> list = tradeSvc.getOneMemberTrade(mno);

	pageContext.setAttribute("list", list);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<style>
.tableScroll {
	overflow: auto;
}
</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<head>
<title>JustRent! - 歷史交易查詢</title>
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
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物車</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租資料</a></li>									
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
						<div id="collapseFive" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借記錄</a></li>
									<li class="active"><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
									<li><a href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>

			<!-- Form -->
			<div class="col-md-10 col-md-offset-0 tableScroll">

				<div id="legend">
					<legend class="">
						<h2>
							<b>歷史交易記錄</b>
						</h2>
					</legend>
				</div>

				<table class="table table-condensed " >
					<tr class="info" >
						<th>交易記錄編號</th>
						<!-- 			<th>會員編號</th> -->
						<!-- 			<th>會員金融帳號</th> -->
						<th>交易時間</th>
						<th>會員金融記錄狀態</th>
						<th>交易金額</th>
						<!-- 			<th>匯款確認</th> -->


					</tr>
					<%@ include file="page1.file"%>
					<c:forEach var="tradeVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">

						<tr>

							<td>${tradeVO.tno}</td>
							<%-- 				<td>${tradeVO.mno} --%>
							<%-- 					<c:forEach var="memberVO" items="${memberSvc.all}"> --%>
							<%-- 						<c:if test="${tradeVO.mno==memberVO.mno}"> --%>
							<%-- 	                    	${memberVO.mno}【${memberVO.mname}】 --%>
							<%--                     	</c:if> --%>
							<%-- 					</c:forEach> --%>
							<!-- 				</td> -->
							<%-- 				<td>${tradeVO.tmid}</td> --%>

							<%
								String tdate = getTimestampString(((TradeVO) pageContext
											.getAttribute("tradeVO")).getTdate());
									String tdate_D = "";
									String tdate_T = "";
									if (tdate != "") {
										tdate_D = tdate.substring(0, 10);
										tdate_T = tdate.substring(11, 19);
									}
							%>

							<td><%=tdate_D%><br><%=tdate_T%></td>
							<td>${tradeVO.tstas}</td>
							<td>${tradeVO.tfunds}</td>
							<%-- 				<td>${tradeVO.tin}</td> --%>



						</tr>
					</c:forEach>
				</table>
				<%@ include file="page2.file"%>
			</div>

		</div>
	</div>

	<br />
	<br />
	<br />
	<br />

	<%@ include file="/front/footer.jsp"%>

</body>
</html>