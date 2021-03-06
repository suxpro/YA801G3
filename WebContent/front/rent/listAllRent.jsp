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
<style>
.tableScroll {
	overflow: auto;
}
</style>
<head>
<!-- <meta http-equiv="Refresh" -->
<%-- 	content="30;URL=<%=request.getContextPath()%>/front/rent/listAllRent.jsp"> --%>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css"
	rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script
	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

<title>JustRent - 租物管理清單</title>
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
						<div id="collapseTwo" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li class="active"><a
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
									<li><a href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
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
							<b>租物資料</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0 tableScroll">


					<table class="table table-condensed " style="white-space: nowrap;">
						<tr class="success">
							<th style="text-align: center">圖片</th>
							<th style="text-align: center">租物名稱</th>
							<!-- 			<th width='100px'>租物狀態</th> -->
							<th style="text-align: center">租物分類</th>
							<th style="text-align: center">租物押金</th>
							<th style="text-align: center">租物價格/天</th>
							<th style="text-align: center">出貨/回收緩衝</th>
							<!-- 			<th>地區編號</th> -->
							<!-- 			<th>租物地址</th> -->
							<th style="text-align: center">租物狀態</th>
							<!-- 							<th>最後狀態時間</th> -->
							<th style="text-align: center">最後上架時間</th>
							<th style="text-align: center">最後修改時間</th>
						</tr>
						<%@ include file="page1.file"%>
						<c:forEach var="rentVO" items="${list}" begin="<%=pageIndex%>"
							end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">
							<%
								String last_sta_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_sta_time());
												  String last_sta_time_D = "";
												  String last_sta_time_T = "";
												  if(last_sta_time != ""){
													  last_sta_time_D = last_sta_time.substring(0, 10);
													  last_sta_time_T = last_sta_time.substring(11, 19);
												  }
												  
												  String last_onshelf_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_onshelf_time());
												  String last_onshelf_time_D = "";
												  String last_onshelf_time_T = "";
												  if(last_onshelf_time != ""){
													  last_onshelf_time_D = last_onshelf_time.substring(0, 10);
													  last_onshelf_time_T = last_onshelf_time.substring(11, 19);
												  }
												  
												  String last_mod_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_mod_time());
												  String last_mod_time_D = "";
												  String last_mod_time_T = "";
												  if(last_mod_time != ""){
													  last_mod_time_D = last_mod_time.substring(0, 10);
													  last_mod_time_T = last_mod_time.substring(11, 19);
												  }
							%>
							<tr>
								<td style="text-align: center" rowspan="2"><img width="100"
									height="100"
									src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
								<td style="text-align: center"><a
									href="javascript:pressesA${s.index}()">${rentVO.rent_name}</a></td>
								<%-- 				<td width='100px'>${rentVO.rent_desc        }</td> --%>
								<td style="text-align: center">${tag_staMap[rentVO.tag_no]}</td>
								<td style="text-align: center">${rentVO.rent_dps         }元</td>
								<td style="text-align: center">${rentVO.unit_price       }元</td>
								<td style="text-align: center">${rentVO.reset_days       }天</td>
								<%-- 				<td>${loc_staMap[rentVO.loc_no]}</td> --%>
								<%-- 				<td>${rentVO.rent_addr        }</td> --%>
								<%--  				<td>${rentVO.last_sta_time}</td> --%>
								<%-- 				<td>${rentVO.last_onshelf_time}</td> --%>
								<%-- 				<td>${rentVO.last_mod_time    }</td> --%>
								<td style="text-align: center">${rent_staMap[rentVO.rent_sta]}</td>
								<%-- 								<td><%=last_sta_time_D %><br> --%>
								<%-- 								    <%=last_sta_time_T %></td> --%>
								<td style="text-align: center" rowspan="2"><%=last_onshelf_time_D%><br>
									<%=last_onshelf_time_T%></td>
								<td style="text-align: center" rowspan="2"><%=last_mod_time_D%><br>
									<%=last_mod_time_T%></td>
							</tr>
							<tr>
								<td colspan="8" style="border-top: none;">
									<table>
										<tr>
											<td>
												<FORM METHOD="post"
													ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
													<button type="submit" class="btn btn-primary">編輯</button>
													<input type="hidden" name="rent_no"
														value="${rentVO.rent_no}"> <input type="hidden"
														name="action" value="getOne_For_Update">
												</FORM>
											</td>
											<td>
												<FORM METHOD="post"
													ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
													<button type="submit" class="btn btn-primary">下架</button>
													<input type="hidden" name="rent_no"
														value="${rentVO.rent_no}"> <input type="hidden"
														name="action" value="delete">
												</FORM>
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<script>
							//超連結至該租物
			         		function pressesA${s.index}(){
			        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=550,width=560,left=65,top=60,resizable=yes,scrollbars=yes");
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
