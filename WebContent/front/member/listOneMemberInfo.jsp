<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
// 	MemberService MemberSvc = new MemberService();
 	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)

// 	MemberVO memberVO = MemberSvc.getOneMember(memberVOxx.getMno());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - 會員資料</title>

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

#memform {width:85%;}

#vipPic{
width:120px;
height:120px;
background-color:#FEFFE5;
  position: relative;
  left: -17px;
  top: 20px;
  text-align:center;
  box-shadow:1px 1px 1px 1px rgba(20%,20%,40%,0.1);
  border-radius: 10px;
  
}
#vipPicLabel {
color: black;
font-weight: bold;

}  

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
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
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          會員管理
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li class="active"><a href="#" onclick="document.MemInfo.submit();">會員資料</a></li>
        <li><a href="#" onclick="document.storedMoney.submit();">會員儲值</a></li>
        <li><a href="#" onclick="document.updateVIP.submit();">升級會員</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- 租物管理  -->
  <div class="panel panel-success">
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
  <div class="panel panel-success">
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
  <div class="panel panel-success">
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
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          歷史紀錄
        </a>
      </h4>
    </div>
    <div id="collapseFive" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借紀錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易紀錄</a></li>
        </ul>
      </div>
    </div>
  </div>

</div>
			</div>
			
						
<!-- Form -->
			<div class="col-md-offset-0">
						<fieldset>
							<div id="legend">
								<legend >
									<h2>
										<b>會員資料</b>
									</h2>
								</legend>
							</div>

							
								<div class="col-md-5 col-md-offset-1">
									<!-- 排版 -->

									<!-- 會員帳號 -->
									<div class="control-group  ">
										<label class="control-label" for="mid">會員帳號 </label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mid}</label>
									</div>


									<!-- 會員姓名 -->
									<div class="control-group  ">
										<label class="control-label" for="mname">會員姓名</label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mname}</label>
									</div>
									
									<!-- 會員餘額 -->
									<div class="control-group  ">
										<label class="control-label" for="mname">會員餘額</label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mbalance}</label>
									</div>

									<!-- 會員性別 -->
									<div class="control-group  ">
										<label class="control-label" for="msex">會員性別</label> 
										<label class="control-label col-xs-offset-1" id="msex">${mem_staMap[memberVO.msex]}</label>
									</div>
									
									<!-- 會員等級 -->
									<div class="control-group  ">
										<label class="control-label" for="mlev">會員等級</label> 
										<label class="control-label col-xs-offset-1" id="mlev">${mem_staMap[memberVO.mlev]}</label>
									</div>
									
									<!-- 會員評價 -->
									<div class="control-group  ">
										<label class="control-label" for="massess">會員評價</label> 
										<label class="control-label col-xs-offset-1" id="massess">${memberVO.massess}</label>
									</div>

									<!-- 會員違規次數 -->
									<div class="control-group  ">
										<label class="control-label" for="millegal">違規次數</label> 
										<label class="control-label col-xs-offset-1" id="millegal">${memberVO.millegal}</label>
									</div>

									<!-- 會員手機 -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">會員手機</label>
										<label class="control-label col-xs-offset-1" id="mcell">${memberVO.mcell}</label>

									</div>

									<!-- 會員郵件 -->
									<div class="control-group ">
										<label class="control-label" for="mmail">會員郵件</label> 
										<label class="control-label col-xs-offset-1" id="mmail">${memberVO.mmail}</label>
									</div>

									<!-- 地區 -->
									<div class="control-group  ">
										<label class="control-label" for="locno">地區　　</label>
										<label class="control-label col-xs-offset-1" id="locno">${loc_staMap[memberVO.locno]}</label>
									</div>

									<!-- 會員地址 -->
									<div class="control-group ">
										<label class="control-label" for="madrs">會員地址</label> 
										<label class="control-label col-xs-offset-1" id="madrs">${memberVO.madrs}</label>
									</div>
									
									<!-- 會員驗證 -->
									<div class="control-group  ">
										<label class="control-label" for="mverification">會員驗證</label> 
										<label class="control-label col-xs-offset-1" id="mverification">${mem_staMap[memberVO.mverification]}</label>
									</div>
									
									<!-- 會員加入日期 -->
									<div class="control-group  ">
										<label class="control-label" for="mdate">加入日期</label> 
										<label class="control-label col-xs-offset-1" id="mdate">${memberVO.mdate}</label>
									</div>


								</div>
								<!-- 排版 -->
								<div class="col-md-offset-7 sidebar-offcanvas ">
									<!-- 圖片排版 -->

									<!-- 會員圖片 -->
									<div class="control-group ">
										<label class="control-label" for="mpic">會員圖片</label>
										<div class="controls">
											<img id="mpic" width="80" height="80"
												src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
										</div>
									</div>

									 								

								</div>
								<!-- 圖片排版 -->
								<br>
								<div class="col-md-6 col-md-offset-2">
									<c:if test="${memberVO.mlev == 'V' }">
										<!-- 會員輪播圖片 -->
										<div id="vipPic" class="control-group  ">
											<label id="vipPicLabel" class="control-label" for="password_confirm">會員輪播圖片</label>
											<div class="controls">
												<img id="mvpic" width="600" height="200"
													src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
											</div>
										</div>
										<br/><br/><br/><br/><br/><br/>
									</c:if>									
								</div>
																					
							<br>
							<br>

							
							<div class="control-group col-md-8 col-md-offset-8">
								<c:if test="${memberVO.mlev != 'V' }">
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-warning">升級會員</button>
									
								</FORM>
								</c:if>
								
								<br/>
															
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/member.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-success">修改資料</button>
								</FORM>
								
								
							</div>
					
							
						</fieldset>
				
			</div>

		</div>
	</div>


	<%@ include file="/front/footer.jsp"%>
</body>
</html>