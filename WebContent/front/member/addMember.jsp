<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>
<%
	MemberVO memberVOadd = (MemberVO) request.getAttribute("memberVOadd");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - 萬物皆可租</title>

<style type="text/css">
#preview{width:100px;height:100px;border:0px solid #000;overflow:hidden;}
#imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
#preview2{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
#imghead2 {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}

#memform {width:90%;}

</style>

<script type="text/javascript">

function submitForm(){ 
	form1.mid.value = "TIDER";
	form1.mpwd.value = "111111";
	form1.mname.value = "饅頭人";
	form1.msex.value = "M";
	form1.mcell.value = "0911863655";
	form1.mmail.value = "tider1@gmail.com";
	form1.locno.value = "L10004";
	form1.madrs.value = "桃園縣中壢市中大路300-1號";
	}

</script>

</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/front/js/jquery-2.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>
<body >

	<%@ include file="/front/header.jsp"%>

			<div class="container">
				<div class="row-fluid">
					<form class="form-horizontal" id="memform" METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/member/member.do"
						name="form1" enctype="multipart/form-data" role="form">
						<fieldset>
							<div id="legend">
								<legend class="">
									<h2>
										<b>註冊會員</b>
									</h2>
								</legend>
							</div>

							<div class="row row-offcanvas row-offcanvas-light">
								<div class="col-xs-4 col-xs-offset-2">
									<!-- 排版 -->

									<!-- 會員帳號 -->
									<div class="control-group  ">
										<label class="control-label" for="mid">會員帳號 </label> 
										<input type="text" id="mid" name="mid" value="<%=(memberVOadd == null) ? "" : memberVOadd.getMid()%>" class="col-xs-offset-1 " maxlength="10"  required />
										
									</div>

									<!-- 會員密碼 -->
									<div class="control-group  ">
										<label class="control-label" for="mpwd">會員密碼</label> <input
											type="password" id="mpwd" name="mpwd"
											value="<%=(memberVOadd == null) ? "" : memberVOadd.getMpwd()%>" class="col-xs-offset-1" required />
									</div>


									<!-- 會員姓名 -->
									<div class="control-group  ">
										<label class="control-label" for="mname">會員姓名</label> <input
											type="text" id="mname" name="mname"
											value="<%=(memberVOadd == null) ? "" : memberVOadd.getMname()%>" class="col-xs-offset-1" required />
									</div>

									<!-- 會員性別 -->
									<div class="control-group  ">
										<label class="control-label" for="msex">會員性別</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<c:if test="${memberVOadd.msex == null }">				
            											&nbsp;<input type="radio" id="msex" name="msex" value=M class="col-xs-offset-1">&nbsp;男&nbsp;&nbsp;
            											&nbsp;<input type="radio" id="msex" name="msex" value=F	class="col-xs-offset-1">&nbsp;女
												</c:if>												
												<c:if test="${memberVOadd.msex == 'M' }">
            											&nbsp;<input type="radio" id="msex" name="msex" value=M	checked class="col-xs-offset-1">&nbsp;男&nbsp;&nbsp;
            											&nbsp;<input type="radio" id="msex" name="msex" value=F	class="col-xs-offset-1">&nbsp;女
												</c:if>
												<c:if test="${memberVOadd.msex == 'F' }">
            											&nbsp;<input type="radio" id="msex" name="msex" value=M class="col-xs-offset-1">&nbsp;男&nbsp;&nbsp;
            											&nbsp;<input type="radio" id="msex" name="msex" value=F	checked class="col-xs-offset-1">&nbsp;女
												</c:if>									
									</div>

									<!-- 會員手機 -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">會員手機</label> <input
											type="text" id="mcell" name="mcell"
											value="<%=(memberVOadd == null) ? "" : memberVOadd.getMcell()%>" class="col-xs-offset-1" required />

									</div>

									<!-- 會員郵件 -->
									<div class="control-group ">
										<label class="control-label" for="mmail">會員郵件</label> 
										<input type="email" id="mmail" name="mmail"	value="<%=(memberVOadd == null) ? "" : memberVOadd.getMmail()%>" class="col-xs-offset-1" required />

									</div>

									<jsp:useBean id="locSvc" scope="page"
										class="back.loc.model.LocService" />

									<!-- 地區 -->
									<div class="control-group  ">
										<label class="control-label" for="password_confirm">地區&nbsp;</label>
										<select size="1" name="locno" class="col-xs-offset-2">
											<c:forEach var="locVO" items="${locSvc.all}">
												<option value="${locVO.loc_no}"
													${(memberVOadd.locno==locVO.loc_no)? 'selected':'' }>${locVO.loc_desc}
											</c:forEach>
										</select>

									</div>

									<!-- 會員地址 -->
									<div class="control-group ">
										<label class="control-label" for="madrs">會員地址</label> 
										<input type="text" id="madrs" name="madrs" value="<%=(memberVOadd == null) ? "" : memberVOadd.getMadrs()%>" class="col-xs-offset-1" required />

									</div>


								</div>
								<!-- 排版 -->
								<div class="col-md-offset-8 sidebar-offcanvas ">
									<!-- 圖片排版 -->

									<!-- 會員圖片 -->
									<div class="control-group">
										<label class="control-label" for="mpic">會員圖片</label>
										<div class="controls" >
											<div id="preview">
												<img id="imghead" width="100" height="100" src="" border="0">
											</div>								
											<input type="file" id="mpic" name="mpic" onchange="previewImage(this)" />
										</div>
									</div>					

								</div>
								<!-- 圖片排版 -->
								
								<div class=" col-xs-offset-6 sidebar-offcanvas " style="width:300px">
									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
									<div id="errorBox" class="alert alert-error">
									<a class="close" data-dismiss="alert" href="#">×</a>										
										<ul class="errorBoxUl">
											<font class="bg-danger" color='red'>請修正以下錯誤
												<c:forEach var="message" items="${errorMsgs}">
													<li class="bg-danger">${message.value}</li>												
												</c:forEach>
											</font>
										</ul>
										
									</div>
									</c:if>
								</div>
							

							</div>

							<br>
							<br>
							<!-- Submit -->
							<div class="control-group col-md-10 col-md-offset-10">
								<div class="controls">
									<input type="hidden" name="action" value="insert">
									<input type="hidden" name="mverification" value="<%=(memberVOadd == null) ? "N" : memberVOadd.getMverification()%>" />
									<input type="hidden" name="mbalance" value="<%=(memberVOadd == null) ? "0" : memberVOadd.getMbalance()%>" />
									<input type="hidden" name="mlev" value="<%=(memberVOadd == null) ? "G" : memberVOadd.getMlev()%>" />
									<input type="hidden" name="millegal" value="<%=(memberVOadd == null) ? "0" : memberVOadd.getMillegal()%>" />
									<input type="hidden" name="massess" value="<%=(memberVOadd == null) ? "0" : memberVOadd.getMassess()%>" />
									<input type="hidden" name="mverification" value="<%=(memberVOadd == null) ? "N" : memberVOadd.getMverification()%>" />
													
									<button class="btn btn-danger">註冊</button>
								</div>
							</div>

						</fieldset>
					</form>

				</div>
			</div>
			
			<input type="image" src="images/7065_key.png" id="submit_Btn" onClick="submitForm();" />


	<%@ include file="/front/footer.jsp"%>

</body>
</html>

