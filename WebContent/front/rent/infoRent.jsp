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
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li>${message.value}</li>
			</c:forEach>
		</ul>
	</font>
</c:if>

<div class="modal-header">
	<label class="modal-title">${rentVO.rent_name}</label>
	<span id="rentStateSpan" class="label label-primary inline"
	 data-rent-state="${rentVO.rent_sta}"
	 data-live-ord="${ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)}"
	 data-ord-ten-date="${ordSvcInfoRent.getOneOrd(ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)).ten_date}"
	 data-ord-exp-date="${ordSvcInfoRent.getOneOrd(ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)).exp_date}">
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
          <!-- 租物描述 -->
		  <div class="row">
			<dl>
                <dt>出租人:</dt>
                <dd>${memSvcInfoRent.getOneMember(rentVO.les_no).getMname()}</dd>	
				<dt>描述:</dt>
				<dd>${rentVO.rent_desc}</dd>
			</dl>
		  </div>
          <!-- /row -->
          <!-- 租物地圖 -->
          <div class="row">
            <dl>
                <dt>地址:</dt>
                <dd>${rentVO.rent_addr}</dd>
            </dl>
            <div id="map" class="panel panel-primary" style="width:200px;height:200px;">map!</div>
          </div>
          <!-- /row -->
		</div>
		<!-- 租物圖片 -->
		<div class="col-md-6">
			<img height="100%" width="100%"
	             src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
         </div>
		<!-- 租物日期 -->
		<div class="col-md-3">
		    <div id="datepicker" style="font-size: 40%;"></div>
		    <div id="hasRent"></div>
		</div>
	</div>
	<!-- /row -->
	<div class="row">
		<!-- 租物小圖片 -->
		<div class="col-md-10"></div>
		<!-- 租物按鈕 -->
		<div class="col-md-offset-10">
            <div style="position:relative;top:-10px">$ ${rentVO.unit_price}/day</div>
            <button type="button" class="btn" id="btnAddRentToCart" data-servlet="<%=request.getContextPath()%>/front/rent/rent.do" data-rent-no="${rentVO.rent_no}"></button>
			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		</div>
	</div>
	<!-- /row -->

</div>