<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.ord.model.*"%>

<%
MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
String mno  = memberVO.getMno();

OrdService ordSvc = new OrdService();
List<OrdVO> list = ordSvc.getAllOrdByMember(mno);

pageContext.setAttribute("list", list);

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<head>
<title>所有訂單by會員資料 - AllOrdByMember</title>
</head>
<body bgcolor='white'>
	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

<!-- SideBar -->
			<div class="col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
					<li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
					<li><a href="#" onclick="document.updateVIP.submit();">升級會員</a></li>
					<li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物管理</a></li>
					<li><a href="#">出租管理</a></li>
					<li><a href="#">訂單管理</a></li>
					<li class="active"><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借查詢</a></li>
				</ul>
			</div>
			
<!-- Form -->
			<div class="col-md-offset-0">

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
						<th>承租評價</th>
						<th>承租評價內容</th>
						<th>出租會員</th>
						<th>出租評價</th>
						<th>出租評價內容</th>


					</tr>
					<%@ include file="page1.file"%>
					<c:forEach var="ordVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
						<%
				    RentService rentSVC = new RentService();
			    			RentVO rentVO = rentSVC.getOneRent(((OrdVO)pageContext.getAttribute("ordVO")).getRent_no());
					pageContext.setAttribute("rentVO",rentVO);
					//查出承租者聯絡資料
					MemberService memberSVC = new MemberService();
					MemberVO tenVO = memberSVC.getOneMember(((OrdVO)pageContext.getAttribute("ordVO")).getTen_no());
					MemberVO tenVOxx = memberSVC.getOneMember(((OrdVO)pageContext.getAttribute("ordVO")).getLes_no());
// 					pageContext.setAttribute("lesVO",lesVO);
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
							<td><a href="javascript:pressesC${s.index}()"><%=tenVO.getMname()%></a></td>
							<td>${ordVO.les_ases       }</td>
							<td>${ordVO.les_ases_ct    }</td>
							<td><a href="javascript:pressesD${s.index}()"><%=tenVOxx.getMname()%></a></td>
							<td>${ordVO.ten_ases       }</td>
							<td>${ordVO.ten_ases_ct    }</td>



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
         		//超連結至該出租人
         		function pressesD${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
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