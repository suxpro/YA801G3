<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.sosorder.model.*"%>
<%@ page import="front.ord.model.*"%>
<%@ page import="front.member.model.*"%>

<%
	RentService rentSvc = new RentService();
    List<RentVO> list = rentSvc.getBodyRent();
    pageContext.setAttribute("rentBodyList", list);
    
    SosorderService sosSvc = new SosorderService();
    List<SosorderVO> listSos = sosSvc.getAll();
    pageContext.setAttribute("rentBodyListSos", listSos);
    
    MemberService memSvc = new MemberService();
    pageContext.setAttribute("memSvcListSos", memSvc);
    
    OrdService ordSvc = new OrdService();
    List<OrdVO> listOrd = ordSvc.getAll();
    
    Map<RentVO, Integer> map = new LinkedHashMap<RentVO, Integer>();
    for(RentVO rentVO : list){
        map.put(rentVO, 0);
    }
    for(OrdVO ordVO : listOrd){
        for(RentVO rentVO : list){
        	if(rentVO.getRent_no().equals(ordVO.getRent_no())){
        		map.put(rentVO, (Integer) map.get(rentVO) + 1);
        	}
        }
    }
    List<Map.Entry<RentVO,Integer>> list_Data = new ArrayList<Map.Entry<RentVO,Integer>>(map.entrySet());
    Collections.sort(list_Data, new Comparator<Map.Entry<RentVO, Integer>>(){
        public int compare(Map.Entry<RentVO, Integer> entry1,
                           Map.Entry<RentVO, Integer> entry2){
            return (entry2.getValue() - entry1.getValue());
        }
    });
    pageContext.setAttribute("rentBodyListHotOrd", list_Data);
%>
<script>
	$.getScript("js/bodyRent/bodyRent.js");
</script>


<style>
#cart {
	text-align: center;
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
		<span class="[ fa fa-folder-o ] controller-open"></span> <span
			class="[ fa fa-folder-open-o ] controller-close"></span>
	</div>


	<div class="row">



		<!-- 分頁 -->
		<div class="col-md-6">
			<ul class="nav nav-tabs " role="tablist">
				<li role="presentation" class="dropdown"><a
					class="dropdown-toggle bg-primary" data-toggle="dropdown" href="#">
						租物狀態<span class="caret"></span> <!--                       <span class="label label-primary">租物狀態</span> <span class="caret"></span> -->
				</a>
					<ul class="dropdown-menu" role="menu">
						<li><a class="aShowByState" data-state="all">全部</a></li>
						<li><a class="aShowByState" data-state="W_RENT">未出租</a></li>
						<li><a class="aShowByState" data-state="A_RENT">已出租</a></li>
					</ul></li>
				<li class="liBodyRentPage disabled"><a class="navbar-link">1</a></li>
				<c:forEach var="i" begin="2" end="${rentBodyList.size()/12+1}"
					step="1">
					<li class="liBodyRentPage"><a class="navbar-link">${i}</a></li>
				</c:forEach>
			</ul>
		</div>

		<!-- 搜尋 -->
		<div class="col-md-4">
			<form id="formBodyRentSearch" role="search"
				class="navbar-form navbar-right"
				value="<%=request.getContextPath()%>/employee/employee.do"
				enctype="multipart/form-data">
				<div class="form-group">
					<input type="text" id="inputBodyRentSearch" class="form-control"
						placeholder="Search By 關鍵字"> <input type="hidden"
						name="action" value="searchEmp">
				</div>
				<button type="button" id="btnBodyRentSubmit" class="btn btn-default">搜尋</button>
			</form>
		</div>
		<!-- search -->


        <!-- CART -->
        <div id="cart" class="col-md-2">
            <a href="<%=request.getContextPath()%>/front/cart/cart.jsp"> <i
                title="Cart" style="color: #0CEEBF"
                class="fa fa-shopping-cart fa-5x"></i></a> <br />
            <!--            <strong>前往結帳</strong> -->
        </div>
	</div>
	<!-- /.row -->

	<div class="row row-offcanvas row-offcanvas-light">

		<!-- SOS/熱門 -->
		<div class="col-md-2 sidebar-offcanvas navbar-right" id="sidebar"
			role="navigation">

			<div class="list-group">
				<a class="list-group-item active">即時SOS訊息
					<button id="btnNewSosorder" class="btn btn-primary glyphicon glyphicon-plus-sign"
					    data-action="<%=request.getContextPath()%>/front/sosorder/sosorder.do"
						data-toggle="modal" data-target="#sosorderModel"></button>
				</a>
				<!-- Modal -->
				<div class="modal fade" id="sosorderModel" tabindex="-1"
					role="dialog" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div id="sosorderShow" class="modal-content">
                            <%@ include file="/front/sosorder/addSosorder.jsp"%>
						</div>
					</div>
				</div>
				<c:forEach var="sosorderVO" items="${rentBodyListSos}" end="6"
					varStatus="status">
					<div class="hidden"
						style="width: 0px; height: 0px; border: 1px solid;">
						<img class="img-rounded" style="position: absolute" height="75px"
							width="75px"
							src="<%=request.getContextPath()%>/front/sosorder/sosorder.do?sos_no=${sosorderVO.sos_no}&pic=SOS_PIC" />
						<dl class="dl-horizontal">
							<dt class="bg-info">
								<span class="glyphicon glyphicon-user"></span> 求租人:
							</dt>
							<dd>${memSvcListSos.getOneMember(sosorderVO.sos_mno).getMname()}</dd>
							<dt class="bg-info">
								<span class="glyphicon glyphicon-usd"></span> 租金總額:
							</dt>
							<dd>${sosorderVO.sos_pay}</dd>
							<dt class="bg-info">
								<span class="glyphicon glyphicon-time"></span> 欲租天數:
							</dt>
							<dd>${sosorderVO.sos_days}</dd>
							<dt class="bg-info">
								<span class="glyphicon glyphicon-phone"></span> 手機:
							</dt>
							<dd>${memSvcListSos.getOneMember(sosorderVO.sos_mno).getMcell()}</dd>
							<div class="bg-success">
								<span class="glyphicon glyphicon-comment text-left"></span> 描述:
							</div>
							<div>${sosorderVO.sos_desc}</div>
						</dl>
					</div>
					<a class="listSosorder list-group-item"><img
						class="img-rounded" height="30px" width="30px"
						src="<%=request.getContextPath()%>/front/sosorder/sosorder.do?sos_no=${sosorderVO.sos_no}&pic=SOS_PIC" />
						${sosorderVO.sos_name}</a>
				</c:forEach>
			</div>

			<div class="list-group">
				<a class="list-group-item active">熱門訊息</a>
                <c:forEach var="rentHotVO" items="${rentBodyListHotOrd}" end="4" varStatus="status">
                    <a class="list-group-item">
                    <h4>
                        <span class="rentPriceClass label label-danger"
                            style="position: absolute; top: 0px; left: -10px; z-index: 1">No.${status.count}</span>
                    </h4>
                    <img class="img-rounded" height="30px" width="30px" style="position: absolute; top: 0px; right: 0px; z-index: 1" src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentHotVO.getKey().rent_no}&pic=PIC1" />
                    <span class='text-muted'
                        style='display: inline-block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 100px;'> ${rentHotVO.getKey().getRent_name()}</span></a>
                </c:forEach>
			</div>
		</div>

		<!-- 商品 -->
		<div class="col-md-10">
			<div id="masonry" class="row">
				<div class='list-group gallery'>

					<c:forEach var="rentVO" items="${rentBodyList}" varStatus="status">
						<div id="${rentVO.rent_no}" class='divRentItem col-md-3'
							value="<%=request.getContextPath()%>/front/rent/rent.do"
							data-rent-list-no="${status.count}"
							data-rent-tag-no="${rentVO.tag_no}">
							<a class="thumbnail" rel="ligthbox" style='text-decoration: none'
								data-toggle="modal" data-target="#infoRentModel"> <img
								class="img-rounded" height="300px" width="300px"
								src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=PIC1" />
								<div class='text-right'>
									<small class='bodyRentName text-muted'
										style='display: inline-block; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 150px;'>${rentVO.rent_name}</small>
									<h3>
										<span id="rentStateSpan" class="rentStateSpanClass label"
											data-rentState="${rentVO.rent_sta}"
											style="position: absolute; top: -5px; left: 10px; z-index: 1">${rent_staMap[rentVO.rent_sta]}</span>
									</h3>
									<h3>
										<span class="rentPriceClass label label-success"
											style="position: absolute; bottom: 10px; right: 5px; z-index: 1"><span
											class="glyphicon glyphicon-usd"></span>${rentVO.unit_price}</span>
									</h3>
								</div>
								<!-- text-right / end -->
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
				<div id="infoRentShow" class="modal-content"></div>
			</div>
		</div>
	</div>
</div>
