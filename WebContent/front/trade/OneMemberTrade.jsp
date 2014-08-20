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

<%!//�w�q��^������榡
	static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");//�w�q��^������榡

	//�h���ɶ����@��Ƥ�k
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//�榡�ƶǹL�Ӫ��ɶ��N�i�H�h���@���
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
<title>JustRent! - ���v����d��</title>
</head>
<body>
	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

			<!-- SideBar -->
			<div class="col-md-2 sidebar">
				<div class="panel-group" id="accordion">
					<!-- �|����� -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne"> �|���޲z </a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
									<li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
									<li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- �����޲z  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo"> �����޲z </a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�������</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/rent/addRent.jsp">�s�W����</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- �ӯ��޲z -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseThree"> �ӯ��޲z </a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/cart/cart.jsp">������</a></li>
									<li><a
										href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">�ӯ����</a></li>									
									<li><a
										href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">�l�ܲM��</a></li>
								</ul>
							</div>
						</div>
					</div>


					<!-- �X���޲z  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFour"> �X���޲z </a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">�X���M��</a></li>
								</ul>
							</div>
						</div>
					</div>

					<!-- ���v����  -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseFive"> ���v�O�� </a>
							</h4>
						</div>
						<div id="collapseFive" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li><a
										href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">���v���ɰO��</a></li>
									<li class="active"><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">���v����O��</a></li>
									<li><a href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">���v�����O��</a></li>
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
							<b>���v����O��</b>
						</h2>
					</legend>
				</div>

				<table class="table table-condensed " >
					<tr class="info" >
						<th>����O���s��</th>
						<!-- 			<th>�|���s��</th> -->
						<!-- 			<th>�|�����ıb��</th> -->
						<th>����ɶ�</th>
						<th>�|�����İO�����A</th>
						<th>������B</th>
						<!-- 			<th>�״ڽT�{</th> -->


					</tr>
					<%@ include file="page1.file"%>
					<c:forEach var="tradeVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">

						<tr>

							<td>${tradeVO.tno}</td>
							<%-- 				<td>${tradeVO.mno} --%>
							<%-- 					<c:forEach var="memberVO" items="${memberSvc.all}"> --%>
							<%-- 						<c:if test="${tradeVO.mno==memberVO.mno}"> --%>
							<%-- 	                    	${memberVO.mno}�i${memberVO.mname}�j --%>
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