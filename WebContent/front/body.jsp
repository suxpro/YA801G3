<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>

<%
	RentService rentSvc = new RentService();
    List<RentVO> list = rentSvc.getBodyRent();
    pageContext.setAttribute("rentBodyList", list);
%>
<script>
	$.getScript("js/bodyRent/bodyRent.js");
</script>


<style>
#cart{
text-align:center;
}
</style>

<div class="container">
	<!-- MENU -->
	<nav class="animate">
		<h4>Menu</h4>
		<ul id="bodyRentMenu">
			<li class="active" data-rent-tag-no="T10000"><a>全部租物</a></li>
			<li data-rent-tag-no="T10001"><a>${tag_staMap["T10001"]}</a></li>
            <li data-rent-tag-no="T10002"><a>${tag_staMap["T10002"]}</a></li>
            <li data-rent-tag-no="T10003"><a>${tag_staMap["T10003"]}</a></li>
            <li data-rent-tag-no="T10004"><a>${tag_staMap["T10004"]}</a></li>
            <li data-rent-tag-no="T10005"><a>${tag_staMap["T10005"]}</a></li>
            <li data-rent-tag-no="T10006"><a>${tag_staMap["T10006"]}</a></li>
            <li data-rent-tag-no="T10007"><a>${tag_staMap["T10007"]}</a></li>
            <li data-rent-tag-no="T10008"><a>${tag_staMap["T10008"]}</a></li>
		</ul>
	</nav>
	<div class="nav-controller">
		<span class="[ fa fa-folder-o ] controller-open"></span>
		<span class="[ fa fa-folder-open-o ] controller-close"></span>
	</div>


	<div class="row">
	       

        
		<!-- 分頁 -->
		<div class="col-md-6">
            <ul class="nav nav-tabs " role="tablist">
                <li role="presentation" class="dropdown">
                    <a class="dropdown-toggle bg-primary" data-toggle="dropdown" href="#">
                        租物狀態<span class="caret"></span>
<!--                       <span class="label label-primary">租物狀態</span> <span class="caret"></span> -->
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a class="aShowByState" data-state="all">全部</a></li>
                        <li><a class="aShowByState" data-state="W_RENT">未出租</a></li>
                        <li><a class="aShowByState" data-state="A_RENT">已出租</a></li>
                    </ul>
                </li>
                <li class="liBodyRentPage disabled"><a class="navbar-link">1</a></li>
                <c:forEach var="i" begin="2" end="${rentBodyList.size()/12+1}" step="1">
                    <li class="liBodyRentPage"><a class="navbar-link">${i}</a></li>
                </c:forEach>
            </ul>
		</div>
        
		<!-- 搜尋 -->
		<div class="col-md-4">
            <form id="formBodyRentSearch" role="search" class="navbar-form navbar-right" value="<%=request.getContextPath()%>/employee/employee.do" enctype="multipart/form-data">
                <div class="form-group">
                    <input type="text" id="inputBodyRentSearch" class="form-control" placeholder="Search By 關鍵字">
                    <input type="hidden" name="action" value="searchEmp">
                </div>
                <button type="button" id="btnBodyRentSubmit" class="btn btn-default">搜尋</button>
            </form>
		</div>
		<!-- search -->

	</div>
	<!-- /.row -->

	<div class="row row-offcanvas row-offcanvas-light">
	

	
	
		<!-- SOS/熱門 -->
		<div class="col-md-2 sidebar-offcanvas navbar-right" id="sidebar" role="navigation">

<!-- CART -->

<div id="cart" >
			<a href="<%=request.getContextPath()%>/front/cart/cart.jsp">
			<i  title="Cart" style="color:#0CEEBF" class="fa fa-shopping-cart fa-5x"></i></a>
			<br/>
<!-- 			<strong>前往結帳</strong> -->
</div>		
			<br/><br/>
			
			<div class="list-group">
				<a href="#" class="list-group-item active">即時SOS訊息</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a> <a
					href="<%=request.getContextPath()%>/front/member/select_page.jsp"
					class="list-group-item">Link</a>
			</div>

			<div class="list-group">
				<a href="#" class="list-group-item active">熱門訊息</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a> <a href="#"
					class="list-group-item">Link</a>
			</div>
		</div>

		<!-- 商品 -->
		<div class="col-md-10">
			<div id="masonry" class="row">
				<div class='list-group gallery'>

					<c:forEach var="rentVO" items="${rentBodyList}" varStatus="status">
						<div id="${rentVO.rent_no}" class='divRentItem col-md-3' value="<%=request.getContextPath()%>/front/rent/rent.do" data-rent-list-no="${status.count}" data-rent-tag-no="${rentVO.tag_no}">
						    <a class="thumbnail" rel="ligthbox" style='text-decoration:none' data-toggle="modal" data-target="#infoRentModel">
							    <img class="img-rounded" height="300px" width="300px" src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
								<div class='text-right'>
									<small class='bodyRentName text-muted' style='display:inline-block; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; width:150px;'>${rentVO.rent_name}</small>
                                    <h3><span id="rentStateSpan" class="rentStateSpanClass label" data-rentState="${rentVO.rent_sta}" style="position:absolute;top:-5px;left:10px;z-index:1">${rent_staMap[rentVO.rent_sta]}</span></h3>
                                    <h3><span class="rentPriceClass label label-success" style="position:absolute;top:83%;left:70%;z-index:1"><span class="glyphicon glyphicon-usd"></span>${rentVO.unit_price}</span></h3>
								</div><!-- text-right / end -->
							</a>
						</div>
						<!-- col-6 / end -->
					</c:forEach>

				</div>
				<!-- list-group / end -->
			</div>
			<!-- row / end -->

		</div>

		<!-- Modal -->
		<div class="modal fade" id="infoRentModel" tabindex="-1" role="dialog"
			aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div id="infoRentShow" class="modal-content">
				    
				</div>
			</div>
		</div>
	</div>
</div>
