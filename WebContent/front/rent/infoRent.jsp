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
	<h4 class="modal-title">${rentVO.rent_name} | ${ordSvcInfoRent.hasLiveOrd(rentVO.rent_no)}</h4>
	<span id="rentStateSpan" class="label label-primary" data-rent-state="${rentVO.rent_sta}">${rent_staMap[rentVO.rent_sta]}</span>
</div>

<div class="modal-body">
	<div class="row">
		<!-- 租物資訊 -->
		<div class="col-md-4">
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
            <div id="map" style="width:100%;height:300px;">map!</div>
          </div>
          <!-- /row -->
		</div>
		<!-- 租物圖片 -->
		<div class="col-md-5">
			<img height="300" width="300"
	             src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
         </div>
		<!-- 租物日期 -->
		<div class="col-md-3">
		  <div id="datepicker" style="font-size: 60%;"></div>
		</div>
	</div>
	<!-- /row -->
	<div class="row">
		<!-- 租物小圖片 -->
		<div class="col-md-8"></div>
		<!-- 租物按鈕 -->
		<div class="col-md-4">
			<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			<button type="submit" class="btn btn-primary">確定</button>
			<input type="hidden" name="action" value="addEmp">
		</div>
	</div>
	<!-- /row -->

</div>