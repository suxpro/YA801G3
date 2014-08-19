<!-- 小豬加,show租物資訊 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="front.ord.model.*"%>

<%
    MemberService memSvc = new MemberService();
    OrdService ordSvc = new OrdService();
    pageContext.setAttribute("memSvcInfoRent", memSvc);
    pageContext.setAttribute("ordSvcInfoRent", ordSvc);
%>

<%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font color='red'>請修正以下錯誤: -->
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li>${message.value}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<!-- 	</font> -->
<%-- </c:if> --%>

<div class="modal-header">
	<label class="modal-title">${rentVO.rent_name}</label>
	<span id="rentStateSpan" class="label inline"
	 data-rent-state="${rentVO.rent_sta}"
	 data-live-ord="${ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)}"
	 data-ord-ten-date="${ordSvcInfoRent.getOneOrd(ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)).ten_date}"
	 data-ord-exp-date="${ordSvcInfoRent.getOneOrd(ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)).exp_date}"
	 data-has-member=<%=session.getAttribute("mid") %>>
	   ${rent_staMap[rentVO.rent_sta]}
	</span>
	<button type="button" class="close" data-dismiss="modal">
            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
    </button>
</div>

<div class="modal-body">
	<div class="row">
		<!-- 租物資訊 -->
		<div class="col-md-3">
		  <div class="row">
            <!-- 租物描述 -->
			<dl>
                <dt class="bg-info"><span class="glyphicon glyphicon-user"></span> 出租人:</dt>
                <dd>${memSvcInfoRent.getOneMember(rentVO.les_no).getMname()}</dd><br>
				<dt class="bg-info"><span class="glyphicon glyphicon-comment"></span> 描述:</dt>
				<dd>${rentVO.rent_desc}</dd><br>
                <dt class="bg-info"><span class="glyphicon glyphicon-map-marker"></span> 地址:</dt>
                <dd>${rentVO.rent_addr}</dd><br>
			</dl>
            <!-- 租物地圖 -->
            <div id="map" class="panel panel-primary" style="width:200px;height:200px;" data-map-rent-addr="${rentVO.rent_addr}">!map</div>
		  </div>
          <!-- /row -->
		</div>
        <div class="col-md-6">
            <!-- 租物圖片 -->
            <div class="row">
				<img class="imgMainShow img-responsive" height="100%" width="100%"
		             src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
	        </div>
            <!-- /row -->
        </div>
        <div class="col-md-3">
            <!-- 租物日期 -->
            <div class="row">
                <div id="datepicker" style="font-size: 40%;" data-reset-days="${rentVO.reset_days}"></div>
                <div id="hasRent" class="text-right"></div>
            </div>
            <!-- /row -->
            <!-- 租物小圖片 -->
            <div class="row">
                <img class="imgPreview img-thumbnail" height="50px" width="50px"
                     src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
                <img class="imgPreview img-thumbnail" height="50px" width="50px"
                     src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC2" />
                <img class="imgPreview img-thumbnail" height="50px" width="50px"
                     src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC3" />
<!--                 <span id="spanZoom" class="glyphicon glyphicon-search"></span> -->
            </div>
            <!-- /row -->
	        <!-- 租物按鈕 -->
	        <div class="row">
	            <div class="text-right lead" style="position:relative;top:-10px"><strong>$ ${rentVO.unit_price}/day</strong></div>
	            <button type="button" class="btn btn-default pull-right" data-dismiss="modal">取消</button>
	            <button type="button" class="btn btn-warning pull-right" id="btnAddRentToPrerent" data-servlet="<%=request.getContextPath()%>/front/rent/rent.do" data-rent-no="${rentVO.rent_no}" data-rent-state="${rentVO.rent_sta}">追蹤</button>
	            <button type="button" class="btn btn-primary pull-right" id="btnAddRentToCart" data-servlet="<%=request.getContextPath()%>/front/rent/rent.do" data-rent-no="${rentVO.rent_no}" data-rent-state="${rentVO.rent_sta}">承租</button>
	        </div>
            <!-- /row -->
        </div>
	</div>

</div>