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

<style>
.tableScroll{ 
overflow:auto; 
}

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>
<head>
<title>JustRent! - 歷史租借查詢</title>
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
  <div class="panel panel-default">
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
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
         承租管理
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物車</a></li>
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租清單</a></li>       
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  
  <!-- 出租管理  -->
  <div class="panel panel-default">
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
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          歷史記錄
        </a>
      </h4>
    </div>
    <div id="collapseFive" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li class="active"><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借記錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
        </ul>
      </div>
    </div>
  </div>

</div>
			</div>

			<!-- Form -->
			<div class="col-md-10 col-md-offset-0">

			<div id="legend">
					<legend class="">
						<h2>
							<b>歷史租借紀錄</b>
						</h2>
					</legend>
				</div>
			
			<div class="col-md-12 col-md-offset-0 tableScroll">
			
				<table class="table table-condensed" style="white-space: nowrap;"  >
					<tr class="info">
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

						<tr>

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
    	 			document.open("<%=request.getContextPath()%>/front/ord/ord.do?ord_no=${ordVO.ord_no}&action=getOne_For_Display", "" ,"height=600,width=600,left=65,top=15,resizable=yes,scrollbars=yes");
     			}
				//超連結至該租物
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=600,width=600,left=65,top=15,resizable=yes,scrollbars=yes");
         		}
				//超連結至該承租人
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.ten_no}&action=getOne_For_Display", "" ,"height=300,width=800,left=65,top=15,resizable=yes,scrollbars=yes");
         		}
         		//超連結至該出租人
         		function pressesD${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.les_no}&action=getOne_For_Display", "" ,"height=300,width=800,left=65,top=15,resizable=yes,scrollbars=yes");
         		}
			</script>
					</c:forEach>
				</table>
				
			</div>
				<%@ include file="page2.file"%>
			</div>

		</div>
	</div>
	
	<br/><br/><br/><br/>
	
	<%@ include file="/front/footer.jsp"%>
		
</body>
</html>
