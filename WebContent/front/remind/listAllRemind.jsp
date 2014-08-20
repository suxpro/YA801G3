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
<title>JustRent! - �Ҧ��������</title>
</head>
<body >
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
									<li ><a
										href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">���v����O��</a></li>
									<li class="active"><a
										href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">���v�����O��</a></li>
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
							<b>���v�����O��</b>
						</h2>
					</legend>
				</div>

	<%-- ���~��C --%>
	<c:if test="${not empty errorMsgs}">
		<font color='red'>�Эץ��H�U���~:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message.value}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>

	<table class="table table-condensed ">
		<tr class="info">
			<!-- 			<th>�����s��</th> -->
			<th align="left">�����W��</th>
			<th align="left">�������</th>
			<th align="left">��������</th>
			<th align="left">�������e</th>

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
				<!--�N�ק諸���@���[�J����Ӥw-->
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