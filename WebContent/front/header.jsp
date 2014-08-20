<%@page import="front.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>

<%
	MemberService memberSvc = new MemberService();

pageContext.setAttribute("memberSvcMoney", memberSvc);

//隨機輪播圖片
MemberDAO dao = new MemberDAO();
List<MemberVO> list2 = dao.getAll();
pageContext.setAttribute("list2", list2);

List<MemberVO> listVIP = new ArrayList<MemberVO>();
for(MemberVO memberVIP : list2){	
	if("V".equals(memberVIP.getMlev())){
		listVIP.add(memberVIP);
	}
}
int randomNum = (int)Math.floor(Math.random() * listVIP.size());

String randomAd1 = listVIP.get(randomNum).getMno();
String randomAd2 = listVIP.get((randomNum+1)%listVIP.size()).getMno();
String randomAd3 = listVIP.get((randomNum+2)%listVIP.size()).getMno();
String randomAd4 = listVIP.get((randomNum+3)%listVIP.size()).getMno();
String randomAd5 = listVIP.get((randomNum+4)%listVIP.size()).getMno();

byte[] randomMVPIC1 = listVIP.get((randomNum)%listVIP.size()).getMvpic();
byte[] randomMVPIC2 = listVIP.get((randomNum+1)%listVIP.size()).getMvpic();
byte[] randomMVPIC3 = listVIP.get((randomNum+2)%listVIP.size()).getMvpic();
byte[] randomMVPIC4 = listVIP.get((randomNum+3)%listVIP.size()).getMvpic();
byte[] randomMVPIC5 = listVIP.get((randomNum+4)%listVIP.size()).getMvpic();

String randomName1 = listVIP.get(randomNum).getMname();
String randomName2 = listVIP.get((randomNum+1)%listVIP.size()).getMname();
String randomName3 = listVIP.get((randomNum+2)%listVIP.size()).getMname();
String randomName4 = listVIP.get((randomNum+3)%listVIP.size()).getMname();
String randomName5 = listVIP.get((randomNum+4)%listVIP.size()).getMname();

// randomNum 19 
// (randomNum+1)%listVIP.size() 20 0
// (randomNum+2)%listVIP.size() 21 1
// (randomNum+3)%listVIP.size()
// (randomNum+4)%listVIP.size()
%>

<script>
    $.getScript("<%=request.getContextPath()%>/front/js/remind/remind.js");

	$(document)
			.ready(
					function() {
						// ad();

						function ad() {
							$
									.ajax({
										type : "POST",
										url : $("#controllerAD").data("ad"),
										contentType : "application/x-www-form-urlencoded; charset=UTF-8",
										data : {
											action : "controllerAD",
										},
										dataType : "json",
										success : function(jsonData) {
											//			var jsonArray = [];
											for ( var key in jsonData) {
												console.log(key + ' is '
														+ jsonData[key]);
												//				jsonArray.push(jsonData[key]);
												// 				$("#remindMain .remindList a:contains("+key+")").find("font").text(jsonData[key]);
											}
											//			$("#remindMain .remindList").each(function( index ){
											//				$(this).find("font").text(jsonArray[index]);
											//			});
										},
										error : function() {
											console.log("尚未登入!");
										}
									});

						}

					}); // end ready
</script>

<style>
#money {
	color: white;
	padding-top: 14px;
}
</style>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!-- <html> -->
<!-- <head> -->

<!-- <title></title> -->
<!-- </head> -->
<!-- <body> -->


	<!-- header -->
	<div class="navbar navbar-inverse navbar-static-top" role="navigation" id="divHeadTitle"
	 data-isLogin=<c:choose>
					   <c:when test="${memberVO != null}">yes</c:when>
					   <c:otherwise>no</c:otherwise>
			      </c:choose>>
			      
		<div class="container">
			<div class="navbar-header">
				<!-- Brand -->
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/front/index.jsp"><img
					width="100" height="100"
					src="<%=request.getContextPath()%>/front/img/JustRent_Logo8.png"
					width="130px"> </a>
			</div>

			<!-- 登入後 -->
			<c:if test="${memberVO != null}">
				<div class="navbar-collapse collapse navbar-right">
					<!-- 餘額 -->
					<label class="nav navbar-nav " id="money"><strong><i
							class="fa fa-usd"></i>&nbsp;${memberSvcMoney.getOneMember(memberVO.mno).getMbalance() }</strong></label>

					<!-- 評價 -->
					<label class="nav navbar-nav " id="money">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><i
							class="fa fa-thumbs-up"></i>&nbsp;${memberSvcMoney.getOneMember(memberVO.mno).getMassess() }&nbsp;</strong></label>

					<ul class="nav navbar-nav ">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><font id="headerNames">租務</font> <font
								id="remindCountNum" class="badge">0</font>&nbsp;<b class="caret"></b></a>
							<ul id="remindMain" class="dropdown-menu dropdown-menu-right" data-action="<%=request.getContextPath()%>/ScheduleServlet">
								<li class="dropdown-plus-title"><i
									class="fa fa-bell-o fa-spin"></i> 租務秘書提醒 <b
									class="pull-right glyphicon glyphicon-chevron-up"></b></li>
								<li class="remindList"><a id="SCES_RENT" href="#">
										成功出租&nbsp;<font class="badge pull-right">0</font>
								</a></li>
								<li class="remindList"><a id="SCES_TEN" href="#"> 成功承租<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="CF_RENT" href="#"> 出租確認<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="PRENT" href="#"> 預約通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="NTC_SHIP" href="#"> 出貨通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="NTC_LEASE" href="#"> 租期通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="NTC_RETR" href="#"> 歸還通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="ANN_BRENT" href="#"> 求租公告<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="LM_QA" href="#"> Q&A留言<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="ASES" href="#"> 評價通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="OT" href="#"> 逾期通知<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="CC_ORD" href="#"> 取消訂單<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="SELL_PASS" href="#"> 上架通過<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a id="SELL_NO_PASS" href="#">上架不通過<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a href="#"> 訂單結案<font
										class="badge pull-right">0</font></a></li>
								<li class="remindList"><a href="#"> 追蹤提醒<font
										class="badge pull-right">0</font></a></li>

							</ul></li>
					</ul>
					<ul class="nav navbar-nav ">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><img width="20" height="20"
								src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">&nbsp;
								<font id="headerNames">${memberVO.mname}</font> <b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li class="dropdown-plus-title"><i
									class="fa fa-user fa-spin"></i> ${memberVO.mname} <b
									class="pull-right glyphicon glyphicon-chevron-up"></b></li>

								<li><a href="#" onclick="document.MemInfo.submit();">會員管理</a>

								</li>

								<FORM name="MemInfo" METHOD="post"
									ACTION="<%=request.getContextPath()%>/front/member/member.do">
									<input type="hidden" name="mno" value="${memberVO.mno}">
									<input type="hidden" name="action"
										value="getOne_MemberInfo_Display">
								</FORM>

								<FORM name="storedMoney" METHOD="post"
									ACTION="<%=request.getContextPath()%>/front/member/memberStored.do">
									<input type="hidden" name="mno" value="${memberVO.mno}">
									<input type="hidden" name="action" value="getOne_For_Update">
								</FORM>

								<FORM name="updateVIP" METHOD="post"
									ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
									<input type="hidden" name="mno" value="${memberVO.mno}">
									<input type="hidden" name="action" value="getOne_For_Update">
								</FORM>


								<li><a
									href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物管理</a></li>
								<li><a
									href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">承租管理</a></li>
								<li><a
									href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">出租管理</a></li>
								<li><a
									href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史記錄</a></li>


								<li class="divider"></li>
								<li>
								<li><a href="#" onclick="document.logoutMember.submit();"><i
										class="glyphicon glyphicon-off"></i> 登出</a>
									<FORM name="logoutMember" METHOD="post"
										ACTION="<%=request.getContextPath()%>/front/login/LogoutHandler">
										<input type="hidden" name="action" value="logout">
									</FORM></li></li>

					</ul>
					</li>
					</ul>
				</div>
			</c:if>
			<!-- 登入前 -->
			<c:if test="${memberVO == null}">
				<div class="navbar-collapse collapse navbar-form navbar-right">
					<button class="btn btn-default" data-toggle="modal"
						data-target="#myLogin">登入</button>
					<button class="btn btn-danger" data-toggle="modal"
						data-target="#Agreement">註冊</button>
				</div>
				<!--/.navbar-collapse -->
			</c:if>


		</div>
	</div>

	<!-- modal login-->
	<div class="modal fade" id="myLogin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">JustRent!</h4>
				</div>
				<!-- login -->
				<div class="modal-body">
					<%@ include file="/front/login/login.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- modal agreement-->
	<div class="modal fade" id="Agreement" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">會員條款</h4>
				</div>
				<!-- agreement -->
				<div class="modal-body">
					<%@ include file="/front/member/AgreementMember.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- 首頁輪播 -->
	<div id="controllerAD" class="container"
		data-ad="<%=request.getContextPath()%>/front/member/member.do">
		<div class="row">
			<!-- The carousel -->
			<div id="transition-timer-carousel"
				class="carousel slide transition-timer-carousel"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#transition-timer-carousel" data-slide-to="0"
						class="active"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="1"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="2"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="3"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="4"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
<!-- 第一張輪播圖 -->
					<div class="item active">
					<c:if test="<%=randomMVPIC1 == null%>">										
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd3%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName3%></h3>
						</div>
					
					</c:if>
					<c:if test="<%=randomMVPIC1 != null%>">				
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd1%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName1%></h3>
						</div>
					</c:if>	

					</div>
<!-- 第二張輪播圖 -->
					<div class="item">
					<c:if test="<%=randomMVPIC2 == null%>">										
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd5%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName5%></h3>
						</div>
					</c:if>
					<c:if test="<%=randomMVPIC2 != null%>">
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd2%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName2%></h3>
						</div>
					</c:if>
						

					</div>
<!-- 第三張輪播圖 -->
					<div class="item">
					<c:if test="<%=randomMVPIC3 == null%>">										
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd2%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName2%></h3>
						</div>					
					</c:if>
					<c:if test="<%=randomMVPIC3 != null%>">
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd3%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName3%></h3>
						</div>					
					</c:if>	

					</div>
<!-- 第四張輪播圖 -->
					<div class="item">
					<c:if test="<%=randomMVPIC4 == null%>">										
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd5%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName5%></h3>
						</div>
					</c:if>	
					<c:if test="<%=randomMVPIC4 != null%>">				
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd4%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName4%></h3>
						</div>					
					</c:if>	

					</div>
<!-- 第五張輪播圖 -->
					<div class="item">
					<c:if test="<%=randomMVPIC5 == null%>">										
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd1%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName1%></h3>
						</div>
					</c:if>
					<c:if test="<%=randomMVPIC5 != null%>">
						<img src="<%=request.getContextPath()%>/front/member/member.do?mno=<%=randomAd5%>&pic=MEM_VPIC" />
						<div class="flex-caption col-md-offset-10">
							<h3><%=randomName5%></h3>
						</div>					
					</c:if>	

					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#transition-timer-carousel"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span>
				</a> <a class="right carousel-control" href="#transition-timer-carousel"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span>
				</a>

				<!-- Timer "progress bar" -->
				<hr class="transition-timer-carousel-progress-bar animate" />
			</div>
		</div>
	</div>


<!-- </BODY> -->
<!-- </html> -->
