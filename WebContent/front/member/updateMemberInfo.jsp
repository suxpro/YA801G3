<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - 會員資料修改</title>

<style type="text/css">
#preview {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#preview2 {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {
	width: 85%;
}
</style>

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
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<ul class="nav nav-sidebar">
									<li class="active"><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
									<li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
									<li><a href="#"
										onclick="document.updateVIP.submit();">升級會員</a></li>
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
									<li><a
										href="<%=request.getContextPath()%>/front/remind/listAllRemind.jsp">歷史提醒記錄</a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>

			</div>


			<!-- Form -->
			<div class="col-md-offset-0">

				<form class="form-horizontal" id="memform" METHOD="post"
					ACTION="<%=request.getContextPath()%>/front/member/member.do"
					name="form1" enctype="multipart/form-data" role="form">
					<fieldset>
						<div id="legend">
							<legend>
								<h2>
									<b>會員資料修改</b>
								</h2>
							</legend>
						</div>


						<div class="col-md-5 col-md-offset-1">
							<!-- 排版 -->

							<!-- 會員編號 -->
							<!-- 									<div class="control-group  "> -->
							<!-- 										<label class="control-label" for="username">會員編號</label>  -->
							<%-- 										<label class="control-label col-xs-offset-1" id="username"><%=memberVO.getMno()%></label> --%>
							<!-- 									</div> -->

							<!-- 會員帳號 -->
							<div class="control-group  ">
								<label class="control-label" for="mid">會員帳號 </label> <label
									class="control-label col-xs-offset-1" id="mid">${memberVO.mid}</label>
							</div>

							<!-- 會員密碼 -->
							<div class="control-group  ">
								<label class="control-label" for="mpwd">會員密碼</label> <input
									type="password" id="mpwd" name="mpwd"
									value="<%=memberVO.getMpwd()%>" class="col-xs-offset-1"
									ruquired>
							</div>


							<!-- 會員姓名 -->
							<div class="control-group  ">
								<label class="control-label" for="mname">會員姓名</label> <input
									type="text" id="mname" name="mname"
									value="<%=memberVO.getMname()%>" class="col-xs-offset-1"
									ruquired>
							</div>

							<!-- 會員性別 -->
							<div class="control-group  ">
								<label class="control-label" for="msex">會員性別</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<c:if test="${memberVO.msex == 'M' }">
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=M checked class="col-xs-offset-1">&nbsp;男&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=F class="col-xs-offset-1">&nbsp;女
										</c:if>
								<c:if test="${memberVO.msex == 'F' }">
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=M class="col-xs-offset-1">&nbsp;男&nbsp;&nbsp;
            									&nbsp;<input type="radio" id="msex" name="msex"
										value=F checked class="col-xs-offset-1">&nbsp;女
										</c:if>
							</div>

							<!-- 會員手機 -->
							<div class="control-group  ">
								<label class="control-label" for="mcell">會員手機</label> <input
									type="text" id="mcell" name="mcell"
									value="<%=memberVO.getMcell()%>" class="col-xs-offset-1"
									ruquired />

							</div>

							<!-- 會員郵件 -->
							<div class="control-group ">
								<label class="control-label" for="mmail">會員郵件</label> <input
									type="email" id="mmail" name="mmail"
									value="<%=memberVO.getMmail()%>" class="col-xs-offset-1"
									ruquired />

							</div>

							<jsp:useBean id="locSvc" scope="page"
								class="back.loc.model.LocService" />

							<!-- 地區 -->
							<div class="control-group  ">
								<label class="control-label" for="locno">地區　　</label> <select
									size="1" name="locno" class="col-xs-offset-1">
									<c:forEach var="locVO" items="${locSvc.all}">
										<option value="${locVO.loc_no}"
											${(memberVO.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
									</c:forEach>
								</select>

							</div>

							<!-- 會員地址 -->
							<div class="control-group ">
								<label class="control-label" for="madrs">會員地址</label> <input
									type="text" id="madrs" name="madrs"
									value="<%=memberVO.getMadrs()%>" class="col-xs-offset-1"
									ruquired />

							</div>


						</div>
						<!-- 排版 -->
						<div class="col-md-offset-6 sidebar-offcanvas ">
							<!-- 圖片排版 -->

							<!-- 會員圖片 -->
							<div class="control-group">
								<label class="control-label" for="mpic">會員圖片</label>
								<div class="controls">
									<img id="mpic" width="80" height="80"
										src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
									<input type="file" id="mpic" name="mpic" />
								</div>
							</div>
							<br />
							<div class="control-group " style="width: 300px">
								<%-- 錯誤表列 --%>
								<c:if test="${not empty errorMsgs}">
									<div id="errorBox" class="alert alert-error">
										<a class="close" data-dismiss="alert" href="#">×</a>
										<ul class="errorBoxUl">
											<font class="bg-danger" color='red'>請修正以下錯誤 <c:forEach
													var="message" items="${errorMsgs}">
													<li class="bg-danger">${message.value}</li>
												</c:forEach>
											</font>
										</ul>

									</div>
								</c:if>
							</div>

						</div>
						<br />
						<div class="col-md-6 col-md-offset-2">
							<c:if test="${memberVO.mlev == 'V' }">
								<!-- 會員輪播圖片 -->
								<div class="control-group  ">
									<label class="control-label" for="mvpic">會員輪播圖片(<font color="red">請上傳一張1680*418廣告圖片</font>)</label>									
									<div class="controls">
									<c:if test="${memberVO.mvpic != null }">
										<img id="mvpic" width="600" height="200"
											src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
									</c:if>
										<input type="file" id="mvpic" name="mvpic" />
									</div>
									
								</div>
							</c:if>
						</div>
						<!-- 圖片排版 -->
						<br /> <br />
						<!-- Submit -->
						<div class="control-group col-xs-9 col-xs-offset-9">
							<div class="controls">
								<input type="hidden" name="action" value="updateInfo"> <input
									type="hidden" name="mno" value="<%=memberVO.getMno()%>">
								<input type="hidden" name="requestURL"
									value="<%=request.getAttribute("requestURL")%>">
								<!--原送出修改的來源網頁路徑,從request取出後,再送給Controller準備轉交之用-->
								<input type="hidden" name="whichPage"
									value="<%=request.getAttribute("whichPage")%>">
								<!--只用於:istAllEmp.jsp-->

								<!--  modal updateBtn-->
								<button type="button" class="btn btn-success"
									data-toggle="modal" data-target="#UpdateBtn">修改</button>

								<!-- 									<button class="btn btn-success">修改</button> -->
							</div>
						</div>

					</fieldset>
					<!-- modal updateMemberInfo-->
					<div class="modal fade bs-example-modal-sm" id="UpdateBtn"
						tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
						aria-hidden="true" data-toggle="false">
						<div class="modal-dialog modal-sm">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">
										<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
									</button>
									<h4 class="modal-title" id="myModalLabel">會員修改資料</h4>
								</div>
								<div class="modal-body">

									是否確定修改會員資料 <br /> <br />

									<button class="btn btn-danger btn-sm col-md-offset-7"
										data-dismiss="modal">取消</button>
									<button class="btn btn-success btn-sm col-md-offset-0">確定</button>
									<!-- 		<button class="btn btn-primary col-md-offset-9" >確定</button> -->

								</div>
							</div>
						</div>
					</div>



				</form>

			</div>

		</div>
	</div>


	<%@ include file="/front/footer.jsp"%>
</body>
</html>