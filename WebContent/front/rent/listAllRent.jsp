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
	MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
    String mno = memberVO.getMno();
	RentService rentSvc = new RentService();
	List<RentVO> list = rentSvc.getAllByMno(mno);
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Refresh"
	content="30;URL=<%=request.getContextPath()%>/front/rent/listAllRent.jsp">

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

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

<title>JustRent - 租物管理清單 </title>
</head>
<body>

	<%@ include file="/front/header.jsp"%>


	<div class="container">
		<div class="row">
		
			<%-- 訊息提示 --%>
			<c:if test="${not empty errorMsgs}">
				<script>
					alert("${errorMsgs.alert}");
				</script>
			</c:if>


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
    <div id="collapseTwo" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li class="active"><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物資料</a></li>
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
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租資料</a></li>
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">租物清單</a></li>
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">追蹤清單</a></li>
        <li><a href="#">續租查詢</a></li>
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
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">訂單核准</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 歷史租借查詢 -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">
          歷史租借查詢
        </a>
      </h4>
    </div>
  </div>

</div>
			</div>

			<div class="col-md-10 col-md-offset-0">
				<div id="legend">
					<legend class="">
						<h2>
							<b>租物資料</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0">


					<table border='1' bordercolor='#CCCCFF' style="white-space: nowrap">
						<tr align='center' valign='middle'>
							<th>圖片</th>
							<th>租物名稱</th>
							<th>租物狀態</th>
							<!-- 			<th width='100px'>租物狀態</th> -->
							<th>租物分類</th>
							<th>租物押金</th>
							<th>租物價格/天</th>
							<th>出貨/回收緩衝</th>
							<!-- 			<th>地區編號</th> -->
							<!-- 			<th>租物地址</th> -->
							<th>最後狀態時間</th>
							<th>最後上架時間</th>
							<th>最後修改時間</th>
						</tr>
						<%@ include file="page1.file"%>
						<c:forEach var="rentVO" items="${list}" begin="<%=pageIndex%>"
							end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
							<tr align='center' valign='middle'>
								<td><img width="100" height="100"
									src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
								<td><a href="javascript:pressesA${s.index}()">${rentVO.rent_name}</a></td>
								<%-- 				<td width='100px'>${rentVO.rent_desc        }</td> --%>
								<td>${rent_staMap[rentVO.rent_sta]}</td>
								<td>${tag_staMap[rentVO.tag_no]}</td>
								<td>${rentVO.rent_dps         }元</td>
								<td>${rentVO.unit_price       }元</td>
								<td>${rentVO.reset_days       }天</td>
								<%-- 				<td>${loc_staMap[rentVO.loc_no]}</td> --%>
								<%-- 				<td>${rentVO.rent_addr        }</td> --%>
								<%--  				<td>${rentVO.last_sta_time}</td> --%>
								<%-- 				<td>${rentVO.last_onshelf_time}</td> --%>
								<%-- 				<td>${rentVO.last_mod_time    }</td> --%>
								<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO")).getLast_sta_time())%></td>
								<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO")).getLast_onshelf_time())%></td>
								<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO")).getLast_mod_time())%></td>

								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
										<input type="submit" value="編輯"> <input type="hidden"
											name="rent_no" value="${rentVO.rent_no}"> <input
											type="hidden" name="action" value="getOne_For_Update">
									</FORM>
								</td>
								<td>
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
										<input type="submit" value="下架"> <input type="hidden"
											name="rent_no" value="${rentVO.rent_no}"> <input
											type="hidden" name="action" value="delete">
									</FORM>
								</td>
							</tr>
							<script>
							//超連結至該租物
			         		function pressesA${s.index}(){
			        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
			         		}
							</script>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<%@ include file="page2.file"%>

	</div>



	<%@ include file="/front/footer.jsp"%>

</body>
</html>
