<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.remind.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.rent.model.*"%>

<%
	MemberVO memberVO = (MemberVO) session.getAttribute("memberVO");
	String mno = memberVO.getMno();
	RemindDAO daoRemind = new RemindDAO();
	List<RemindVO> list = daoRemind.getAllByMno(mno);
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
<title>JustRent! - 所有提醒資料</title>
</head>
<body >
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
									<li ><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
									<li class="active"><a
										href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>
		<div class="col-md-10 col-md-offset-0 tableScroll">

				<div id="legend">
					<legend class="">
						<h2>
							<b>歷史提醒記錄</b>
						</h2>
					</legend>
				</div>

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

	<table class="table table-condensed ">
		<tr class="info">
			<!-- 			<th>提醒編號</th> -->
			<th align="left">租物名稱</th>
			<th align="left">提醒日期</th>
			<th align="left">提醒分類</th>
			<th align="left">提醒內容</th>

		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="remindVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<%
				RentService rentSVC = new RentService();
					RentVO rentVO = new RentVO();
					rentVO = rentSVC.getOneRent2(((RemindVO) pageContext
							.getAttribute("remindVO")).getRtno());
// 					System.out.println(((RemindVO) pageContext
// 							.getAttribute("remindVO")).getRtno());
// 					System.out.println(rentVO.getRent_name());
			%>
			<tr align='center' valign='middle'
				${(remindVO.rno==param.rno) ? 'bgcolor=#CCCCFF':''}>
				<!--將修改的那一筆加入對比色而已-->
				<%-- 				<td>${remindVO.rno}</td>				 --%>
				<td align="left"><%=rentVO.getRent_name()%></td>
				<td align="left">${remindVO.rtime}</td>
				<td align="left">${remindVO.rstas}</td>
				<td align="left">${remindVO.rdes}</td>

			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>
</div>
</div>
</div>

	<%@ include file="/front/footer.jsp"%>
</body>
</html>