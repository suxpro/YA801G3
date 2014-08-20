
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%
	RentVO rentVO = (RentVO) request.getAttribute("rentVO");
%>
<html>
<head>
</head>
<link rel="stylesheet" type="text/css" href="js/calendar.css">
<script language="JavaScript" src="js/calendarcode.js"></script>
<div id="popupcalendar" class="text"></div>

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
							<b>租物資料修改</b>
						</h2>
					</legend>
				</div>

				<div class="col-md-12 col-md-offset-0">

	<%-- 錯誤表列 --%>
	<script>
	<c:if test="${not empty errorMsgs}">
		alert("${errorMsgs.alert}");
	</c:if>
	</script>

	<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front/rent/rent.do" name="form1" enctype="multipart/form-data">
		<table class="table table-bordered " border="0" >


			<tr>
				<td align="right">租物名稱:<font color=red><b>*</b></font></td>
				<td><input type="text" name="rent_name" size="30"
					value="<%=rentVO.getRent_name()%>"/>
				<span><font color="red">${errorMsgs.rent_name}</font></span></td>
			</tr>
			<tr>
				<td align="right" valign="top">租物描述:<font color=red><b>*</b></font></td>
				<td><textarea name="rent_desc" maxlength="300" cols="40"
					rows="4" style="resize: none"><%=rentVO.getRent_desc()%></textarea>
				<span><font color="red">${errorMsgs.rent_desc}</font></span></td>
			</tr>			

					<input type="hidden" name="les_no" size="6" value="<%=rentVO.getLes_no()%>" />
					<input type="hidden" name="rent_sta" size="8" value="<%=rentVO.getRent_sta()%>" />

			<jsp:useBean id="tagSvc" scope="page"
				class="back.tag.model.TagService" />
			<tr>
				<td align="right">租物分類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="tag_no">
						<c:forEach var="tagVO" items="${tagSvc.all}">
							<option value="${tagVO.tag_no}"
								${(rentVO.tag_no==tagVO.tag_no)?'selected':'' }>${tagVO.tag_desc}
						</c:forEach>
				   </select>
			    <span><font color="red">${errorMsgs.tag_no}</font></span></td>
			</tr>
			<tr>
				<td align="right">租物押金:<font color=red><b>*</b></font></td>
				<td><input type="number" name="rent_dps" size="8"
					value="<%=rentVO.getRent_dps()%>"/>
				<span><font color="red">${errorMsgs.rent_dps}</font></span></td>
			</tr>
			<tr>
				<td align="right">租物價格/天:<font color=red><b>*</b></font></td>
				<td><input type="number" name="unit_price" size="8"
					value="<%=rentVO.getUnit_price()%>"/>
				<span><font color="red">${errorMsgs.unit_price}</font></span></td>
			</tr>
			<tr>
				<td align="right">出貨/回收緩衝:<font color=red><b>*</b></font></td>
				<td><input type="number" name="reset_days" size="8"
					value="<%=rentVO.getReset_days()%>"/>
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
				<td><input type="text" name="rent_addr" size="40"
					value="<%=rentVO.getRent_addr()%>"/>
				<span><font color="red">${errorMsgs.rent_addr}</font></span></td>
			</tr>	
			<tr>	
			    <td align="right" valign="top">租物圖片(1):<font color=red><b>*</b></font></td>	
				<td><img width="100" height="100" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic1">
				    <input type="file" name="pic1" />
				<span><font color="red">${errorMsgs.pics}</font></span></td>
			</tr>
			<tr>
				<td align="right" valign="top">租物圖片(2):<font color=red><b>*</b></font></td>			
				<td><img width="100" height="100" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic2">
				    <input type="file" name="pic2" /></td>
			</tr>
			<tr>
				<td align="right" valign="top">租物圖片(3):<font color=red><b>*</b></font></td>				
				<td><img width="100" height="100" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic3">
				    <input type="file" name="pic3" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="rent_no" value="<%=rentVO.getRent_no()%>"> 
			<button type="submit" class="col-xs-offset-9 btn btn-primary">送出修改</button>
	</FORM>

</div>
</div>
</div>
</div>
	<%@ include file="/front/footer.jsp"%>
</body>
</html>
