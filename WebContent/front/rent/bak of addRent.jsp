
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="back.tag.model.*"%>
<%@ page import="back.loc.model.*"%>
<%
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");
%>

<html>
<head>
<title>租物新增 - addRent.jsp</title>
<style type="text/css">
.preview{width:100px;height:100px;border:1px solid #000;overflow:hidden;}
.imghead {filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);}
</style>
<script type="text/javascript">
function previewImage(file,divNo,imgNo)
{
  var MAXWIDTH  = 100;
  var MAXHEIGHT = 100;
  var div = document.getElementById(divNo);
  if (file.files && file.files[0])
  {
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
</script>  
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

<body bgcolor='white'>

	<table border='1' cellpadding='5' cellspacing='0' width='500'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>租物新增 - addRent.jsp</h3></td>
			<td><a href="<%=request.getContextPath() %>/front/rent/select_page.jsp">
			   <img src="<%=request.getContextPath() %>/front/rent/images/tomcat.gif" width="100" height="100" border="1"> 回首頁 </a></td>
		</tr>
	</table>
	<h4>
		租物資料:<font color=red><b>*</b></font>為必填欄位
	</h4>
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font color='red'>請修正以下錯誤:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message.value}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>
	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front/rent/rent.do" name="form1" enctype="multipart/form-data">
		<table border="0">
			<tr>
				<td>租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_name" size="30"
					value="${rentVO.rent_name}" /></td>
			</tr>
			<tr>
				<td valign="top">租物描述:<font color=red><b>*</b></font></td>
				<td><textarea name="rent_desc" maxlength="100" cols="40"
					rows="3" style="resize: none">${rentVO.rent_desc}</textarea></td>
			</tr>
			<tr>
				<td>出租人:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="les_no" size="6"
					value="${rentVO.les_no}" /></td>
			</tr>
			<tr>
				<td>租物狀態:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_sta" size="10" value="待審核"
					readonly="readonly" /></td>
			</tr>
			<jsp:useBean id="tagSvc" scope="page"
				class="back.tag.model.TagService" />
			<tr>
				<td>租物分類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tag_no">
						<c:forEach var="tagVO" items="${tagSvc.all}">
							<option value="${tagVO.tag_no}"
								${(rentVO.tag_no==tagVO.tag_no)?'selected':''}>${tagVO.tag_desc}
						</c:forEach>
				   </select>
			   </td>
			</tr>
			<tr>
				<td>租物押金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_dps" size="10"
					value="${rentVO.rent_dps}" /></td>
			</tr>
			<tr>
				<td>每日租金:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="unit_price" size="10"
					value="${rentVO.unit_price}" /></td>
			</tr>
			<tr>
				<td>重整天數:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="reset_days" size="3"
					value="${rentVO.reset_days}" /></td>
			</tr>
			
			<jsp:useBean id="locSvc" scope="page"
				class="back.loc.model.LocService" />						
			<tr>
				<td>地區:<font color=red><b>*</b></font></td>
				<td><select size="1" name="loc_no">
						<c:forEach var="locVO" items="${locSvc.all}">
							<option value="${locVO.loc_no}"
								${(rentVO.loc_no==locVO.loc_no)?'selected':'' }>${locVO.loc_desc}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>租物地址:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="rent_addr" size="45"
					value="${rentVO.rent_addr}" /></td>
			</tr>
			<tr>
				<td>租物圖片(1):<font color=red><b>*</b></font></td>
				<td>
					<div id="div1" class="preview">
    					<img id="img1" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic1" onchange="previewImage(this,'div1','img1')"/>
				</td>
				
			</tr>
			<tr>
				<td>租物圖片(2):<font color=red><b>*</b></font></td>
				<td>
				     <div id="div2" class="preview">
    					<img id="img2" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic2" onchange="previewImage(this,'div2','img2')"/>
				</td>
			</tr>
			<tr>
				<td>租物圖片(3):<font color=red><b>*</b></font></td>
				<td>
					<div id="div3" class="preview">
    					<img id="img3" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic3" onchange="previewImage(this,'div3','img3')"/>
				</td>
			</tr>
			<tr>
				<td>租物圖片(4):<font color=red><b>*</b></font></td>
				<td>
					<div id="div4" class="preview">
    					<img id="img4" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic4" onchange="previewImage(this,'div4','img4')"/>
				</td>
			</tr>
			<tr>
				<td>租物圖片(5):<font color=red><b>*</b></font></td>
				<td>
					<div id="div5" class="preview">
    					<img id="img5" width=100 height=100 border=0 src='' class="imghead">
					</div>
					<input type="file" name="pic5" onchange="previewImage(this,'div5','img5')"/>
				</td>
			</tr>			
		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>

</html>
