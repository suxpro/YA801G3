<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

</head>
<body>

	<!-- 這是footer -->
		<footer>
	<div class="container">
		<div class="row">
			<div class="col-lg-3">
				<div class="widget">
					<h5 class="widgetheading">關於我們</h5>
					<address>
					<strong>JustRent!</strong><br>
					 320  桃園縣中壢市中大路300號 </address>
					<p>
					
						<i class="glyphicon glyphicon-phone-alt"></i>&nbsp;&nbsp; (886) 922282252 <br>
						<i class="fa fa-envelope"></i>&nbsp;&nbsp; justrent.service@gmail.com
					</p>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="widget">
					<h5 class="widgetheading">相關說明</h5>
					<ul class="link-list">
						<li><a href="#" class="control-label" data-toggle="modal" data-target="#Question">常見問題</a></li>
						<li><a href="#" class="control-label" data-toggle="modal" data-target="#TradeRule">交易問題</a></li>
						<li><a href="#" class="control-label" data-toggle="modal" data-target="#RentRule">租物規則</a></li>
						
						
					</ul>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="widget">
					<h5 class="widgetheading">關於目的</h5>
					<ul class="link-list">
						<li><a href="#" class="control-label" data-toggle="modal" data-target="#Purpose">開發目的</a></li>
						<li><a href="#" class="control-label" data-toggle="modal" data-target="#Origin">開發緣起</a></li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="widget">
					<h5 class="widgetheading">開發團隊</h5>
					<div class="flickr_badge">
					
						<img title="SuxPRO" src="<%=request.getContextPath()%>/front/img/profile/suxpro.jpg">													
						<img title="Barnett-Wan" src="<%=request.getContextPath()%>/front/img/profile/barnett.jpg">								
						<img title="Angus" src="<%=request.getContextPath()%>/front/img/profile/angus.jpg">					
						<img title="Sam" src="<%=request.getContextPath()%>/front/img/profile/sam.jpg">			

					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div id="sub-footer">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="copyright">
						<p>
							&copy; 2014 <strong>JustRent!</strong>. All Rights Reserved.
						</p>
					</div>
				</div>
				<div class="col-lg-6">
					<ul class="social-network">
						<li><a href="#" data-placement="top" title="Facebook"><i class="fa fa-facebook"></i></a></li>
						<li><a href="#" data-placement="top" title="Twitter"><i class="fa fa-twitter"></i></a></li>
						<li><a href="#" data-placement="top" title="Google plus"><i class="fa fa-google-plus"></i></a></li>
						<li><a href="#" data-placement="top" title="Iinstagram"><i class="fa fa-instagram"></i></a></li>
						
					</ul>
				</div>
			</div>
		</div>
	</div> 
			
		</footer>
	
	<!-- back to top -->
			<a id="back-to-top" href="#" class="btn btn-default btn-lg back-to-top" role="button" title="Click to return on the top page" data-toggle="tooltip" data-placement="left">
			<span class="glyphicon glyphicon-chevron-up"></span></a>
	
	
		<!-- modal Question-->
	<div class="modal fade" id="Question" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">常見問題</h4>
				</div>
				<div class="modal-body">
					<%@ include file="/front/Text/Question.jsp"%>
				</div>
			</div>
		</div>
	</div>
	
		<!-- modal RentRule-->
	<div class="modal fade" id="RentRule" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">租務規則</h4>
				</div>
				<div class="modal-body">
					<%@ include file="/front/Text/RentRule.jsp"%>
				</div>
			</div>
		</div>
	</div>
	
		<!-- modal TradeRule-->
	<div class="modal fade" id="TradeRule" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">交易問題</h4>
				</div>
				<div class="modal-body">
					<%@ include file="/front/Text/TradeRule.jsp"%>
				</div>
			</div>
		</div>
	</div>
	
			<!-- modal Purpose-->
	<div class="modal fade" id="Purpose" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">開發目的</h4>
				</div>
				<div class="modal-body">
					<%@ include file="/front/Text/Purpose.jsp"%>
				</div>
			</div>
		</div>
	</div>
	
			<!-- modal Origin-->
	<div class="modal fade" id="Origin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">開發緣起</h4>
				</div>
				<div class="modal-body">
					<%@ include file="/front/Text/Origin.jsp"%>
				</div>
			</div>
		</div>
	</div>

</BODY>
</html>