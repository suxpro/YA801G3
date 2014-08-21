
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="back.tag.model.*"%>
<%@ page import="back.loc.model.*"%>
<%
	//取得新增租物的會員資料(取得登入帳號)
	MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
	//承接錯誤回傳的rentVO
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");;
	if (rentVO == null) {
		rentVO = new RentVO();
		rentVO.setLoc_no(memberVO.getLocno());
		rentVO.setRent_addr(memberVO.getMadrs());
		pageContext.setAttribute("rentVO", rentVO);
	}
%>
<html>
<head> 
<title>JustRent! - 新增租物</title>
<style type="text/css">
.preview{width:100px;height:100px;float:right;border:1px solid #000;overflow:hidden;display:none}
.imghead{filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
</style>
<script type="text/javascript">
function previewImage(file,divNo,imgNo)
{
  var MAXWIDTH  = 100;
  var MAXHEIGHT = 100;
  var div = document.getElementById(divNo);
  if (file.files && file.files[0])
  {
	  div.style.display = "block";
    div.innerHTML = '<img id='+ imgNo + '>';
    var img = document.getElementById(imgNo);
    img.onload = function(){
      var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
      img.width = rect.width;
      img.height = rect.height;
      img.style.marginLeft = rect.left+'px';
      img.style.marginTop = rect.top+'px';
    }
    var reader = new FileReader();
    reader.onload = function(evt){img.src = evt.target.result;}
    reader.readAsDataURL(file.files[0]);
  }
  else
  {
	  div.style.display = "none";
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    div.innerHTML = '<img id=imghead>';
    var img = document.getElementById('imghead');
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;margin-left:"+rect.left+"px;"+sFilter+src+"\"'></div>";
  }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;
        
        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}

//神奇小按鈕
function addRent(){ 
	form1.rent_name.value = "艾澤拉斯酷炫美式重機";
	form1.rent_desc.value = "傳奇機車設計達人 Paul Jr. 與兩組精挑細選的機車專家合作，將源自於《魔獸世界》兩大陣營的設計靈感落實為真實的體驗，讓你可以親身體驗遊戲中拉風的奔馳感。";	
	
	form1.rent_dps.value = "1000";
	form1.unit_price.value = "100";
	form1.reset_days.value = "1";

	}

</script>  
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
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
<div id="popupcalendar" class="text"></div>

<body >

<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

	<%-- 錯誤表列 --%>
	
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<font color='red'>請修正以下錯誤: -->
<!-- 			<ul> -->
<%-- 				<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 					<li>${message.value}</li> --%>
<%-- 				</c:forEach> --%>
<!-- 			</ul> -->
<!-- 		</font> -->
<%-- 	</c:if> --%>

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
        <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">租物資料</a></li>
        <li class="active"><a href="<%=request.getContextPath()%>/front/rent/addRent.jsp">新增租物</a></li>
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
    <div id="collapseFive" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">歷史租借記錄</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">歷史交易記錄</a></li>
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
							<b>新增租物</b>
						</h2>
					</legend>
				</div>
<div class="col-md-12 col-md-offset-0">
	
	<form method="post" action="<%=request.getContextPath() %>/front/rent/rent.do" name="form1" enctype="multipart/form-data">
		<table class="table table-bordered " cellpadding='5' cellspacing='5' border="0" >
			<tr>
				<td align="right">租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_name" size="30"
					value="${rentVO.rent_name}" />
				<span><font color="red">${errorMsgs.rent_name}</font></span></td>
			</tr>
			<tr>
				<td valign="top" align="right">租物描述:<font color=red><b>*</b></font></td>
				<td><textarea name="rent_desc" maxlength="300" cols="40"
					rows="4" style="resize: none">${rentVO.rent_desc}</textarea>
				<span><font color="red">${errorMsgs.rent_desc}</font></span></td>
									
				<input type="hidden" name="les_no" size="6" value="${memberVO.mno}" />
			</tr>
			<jsp:useBean id="tagSvc" scope="page"
				class="back.tag.model.TagService" />
			<tr>
				<td align="right">租物分類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tag_no">
						<c:forEach var="tagVO" items="${tagSvc.all}">
							<option value="${tagVO.tag_no}"
								${(rentVO.tag_no==tagVO.tag_no)?'selected':''}>${tagVO.tag_desc}
						</c:forEach>
				   </select>			    
			   	<span><font color="red">${errorMsgs.tag_no}</font></span></td>
			</tr>
			<tr>
				<td align="right">租物押金:<font color=red><b>*</b></font></td>
				<td><input type="number" name="rent_dps" size="10"
					value="${rentVO.rent_dps}" /> 元
				<span><font color="red">${errorMsgs.rent_dps}</font></span></td>
			</tr>
			<tr>
				<td align="right">每日租金:<font color=red><b>*</b></font></td>
				<td><input type="number" name="unit_price" size="10"
					value="${rentVO.unit_price}" /> 元
				<span><font color="red">${errorMsgs.unit_price}</font></span></td>
			</tr>
			<tr>
				<td align="right">出貨/回收緩衝:<font color=red><b>*</b></font></td>
				<td><input type="number" name="reset_days" size="3"
					value="${rentVO.reset_days}" /> 天
				<span><font color="red">${errorMsgs.reset_days}</font></span></td>
			</tr>
			
			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />						
			<tr>
				<td align="right">地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="loc_no">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(rentVO.loc_no==locVO.loc_no)?'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select>
				<span><font color="red">${errorMsgs.loc_no}</font></span></td>
			</tr>
			<tr>
				<td align="right">租物地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_addr" size="40"
					value="${rentVO.rent_addr}" /> 
				<span><font color="red">${errorMsgs.rent_addr}</font></span></td>
			</tr>
			<tr>
				<td valign="top" align="right">租物圖片(1):<font color=red><b>*</b></font></td>
				<td>
					<div id="div1" class="preview">
    					<img id="img1" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic1" onchange="previewImage(this,'div1','img1')"/>
				
				<span><font color="red">${errorMsgs.pics}</font></span></td>
				
			</tr>
			<tr>
				<td valign="top" align="right">租物圖片(2):<font color=red><b>*</b></font></td>
				<td>
				     <div id="div2" class="preview">
    					<img id="img2" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic2" onchange="previewImage(this,'div2','img2')"/>
				</td>
			</tr>
			<tr>
				<td valign="top" align="right">租物圖片(3):<font color=red><b>*</b></font></td>
				<td>
					<div id="div3" class="preview">
    					<img id="img3" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic3" onchange="previewImage(this,'div3','img3')"/>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td valign="top" align="right">租物圖片(4):<font color=red><b>*</b></font></td> -->
<!-- 				<td> -->
<!-- 					<div id="div4" class="preview"> -->
<!--     					<img id="img4" width=100 height=100 border=0 src='' class="imghead"> -->
<!-- 					</div> -->
<!-- 					<input type="file" name="pic4" onchange="previewImage(this,'div4','img4')"/> -->
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 			<tr> -->
<!-- 				<td valign="top" align="right">租物圖片(5):<font color=red><b>*</b></font></td> -->
<!-- 				<td> -->
<!-- 					<div id="div5" class="preview"> -->
<!--     					<img id="img5" width=100 height=100 border=0 src='' class="imghead"> -->
<!-- 					</div> -->
<!-- 					<input type="file" name="pic5" onchange="previewImage(this,'div5','img5')"/> -->
<!-- 				</td> -->
<!-- 			</tr>			 -->
		</table>
		<br> <input type="hidden" name="action" value="insert" > 
		<button type="submit" class="col-xs-offset-9 btn btn-primary">送出新增</button>
	</FORM>
</div>

</div>
		</div>
	</div>
	<input type="image" src="images/17998_key.png" id="submit_Btn" onClick="addRent();" />
<%@ include file="/front/footer.jsp"%>
</body>

</html>
