<%@page import="front.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
MemberService memberSvc = new MemberService();

pageContext.setAttribute("memberSvcMoney", memberSvc);

%>

<script>
    $.getScript("js/remind/remind.js");
</script>

<style>
#money{
color:white;
padding-top: 14px;
}

</style>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title></title>
</head>
<body>
	<!-- header -->
	<div class="navbar navbar-inverse navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<!-- Brand -->
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/front/index.jsp"><img
					width="75" height="70"
					src="<%=request.getContextPath()%>/front/img/JustRent_Logo7.png"
					width="130px"> </a>
			</div>
			
		<!-- �n�J�� -->
			<c:if test="${memberVO != null}">
			   <div class="navbar-collapse collapse navbar-right" >	
<!-- �l�B -->
			   <label class="nav navbar-nav " id="money"><strong><i class="fa fa-usd"></i>&nbsp;&nbsp;${memberSvcMoney.getOneMember(memberVO.mno).getMbalance() }</strong></label>
			   
			   
				 <ul class="nav navbar-nav ">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">���� <front class="badge">14</front><b class="caret"></b></a>
                            <ul id="remindMain" class="dropdown-menu dropdown-menu-right" data-urlRemind="<%=request.getContextPath()%>/ScheduleServlet">
                                 <li class="dropdown-plus-title">
                                    <i class="fa fa-bell-o fa-spin"></i>		���ȯ��Ѵ���
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                  						<li class="remindList"><a id="SCES_RENT" href="#">   ���\�X��&nbsp;<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="SCES_TEN" href="#">    ���\�ӯ�<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="CF_RENT" href="#">     �X���T�{<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="PRENT" href="#">       �w���q��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="NTC_SHIP" href="#">    �X�f�q��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="NTC_LEASE" href="#">   �����q��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="NTC_RETR" href="#">    �k�ٳq��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="ANN_BRENT" href="#">   �D�����i<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="LM_QA" href="#">       Q&A�d��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="ASES" href="#">        �����q��<font class="badge pull-right">0</font></a></li>
                  						<li class="remindList"><a id="OT" href="#">          �O���q��<font class="badge pull-right">0</font></a></li>  
                                        <li class="remindList"><a id="CC_ORD" href="#">      �����q��<font class="badge pull-right">0</font></a></li>  
                                        <li class="remindList"><a id="SELL_PASS" href="#">   �W�[�q�L<font class="badge pull-right">0</font></a></li>  
                                        <li class="remindList"><a id="SELL_NO_PASS" href="#">�W�[���q�L<font class="badge pull-right">0</font></a></li> 
                                        <li class="remindList"><a href="#">                  �q�浲��<font class="badge pull-right">0</font></a></li>  
                                        <li class="remindList"><a href="#">                  �l�ܴ���<font class="badge pull-right">0</font></a></li>                                                                
                                
                            </ul>
                        </li>
                 </ul>			
				 <ul class="nav navbar-nav ">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"> ${memberVO.mname} <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                 <li class="dropdown-plus-title">
                                    <i class="fa fa-user fa-spin"></i>		${memberVO.mname}
                                    <b class="pull-right glyphicon glyphicon-chevron-up"></b>
                                </li>
                                
                                <li><a href="#" onclick="document.MemInfo.submit();">�|�����</a>
                                	<FORM name="MemInfo" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/member.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_MemberInfo_Display">
									</FORM>
                                </li>
                                
                                <li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a>
                                	<FORM name="storedMoney" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/memberStored.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                
                                </li>
 								<li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a>
                                	<FORM name="updateVIP" METHOD="post" ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
										<input type="hidden" name="mno" value="${memberVO.mno}"> 						
										<input type="hidden" name="action" value="getOne_For_Update">
									</FORM>
                                </li>
                                
                                 <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�����޲z</a></li>
                                
                                <li><a href="#">�X���޲z</a></li>
                                <li><a href="#">�q��޲z</a></li>
                                <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">���v���ɬd��</a></li>


              					<li class="divider"></li>
                                <li>
                                	<li><a href="#" onclick="document.logoutMember.submit();"><i class="glyphicon glyphicon-off"></i> �n�X</a>
                                	<FORM name="logoutMember" METHOD="post" ACTION="<%=request.getContextPath()%>/front/login/LogoutHandler">
										<input type="hidden" name="action" value="logout">
									</FORM>
									</li>
								</li>
                                
                            </ul>
                        </li>
                 </ul>
               </div>
			</c:if>
		<!-- �n�J�e -->
				<c:if test="${memberVO == null}">
				<div class="navbar-collapse collapse navbar-form navbar-right" >
					<button class="btn btn-default" data-toggle="modal"	data-target="#myLogin">�n�J</button>
					<button class="btn btn-danger" data-toggle="modal"	data-target="#Agreement">���U</button>
				</div><!--/.navbar-collapse -->
				</c:if>
			
			
		</div>
	</div>

	<!-- modal login-->
	<div class="modal fade" id="myLogin" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">JustRent!</h4>
				</div>
				<!-- login -->
				<div class="modal-body">
					<%@ include file="/front/login/login.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- modal agreement-->
	<div class="modal fade" id="Agreement" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span> <span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">�|������</h4>
				</div>
				<!-- agreement -->
				<div class="modal-body">
					<%@ include file="/front/member/AgreementMember.jsp"%>
				</div>
			</div>
		</div>
	</div>

	<!-- �������� -->
	<div class="container">
		<div class="row">
			<!-- The carousel -->
			<div id="transition-timer-carousel"
				class="carousel slide transition-timer-carousel"
				data-ride="carousel">
				<!-- Indicators -->
				<ol class="carousel-indicators">
					<li data-target="#transition-timer-carousel" data-slide-to="0"
						class="active"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="1"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="2"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="3"></li>
					<li data-target="#transition-timer-carousel" data-slide-to="4"></li>
				</ol>

				<!-- Wrapper for slides -->
				<div class="carousel-inner">
					<div class="item active">
						<img src="<%=request.getContextPath()%>/front/img/1.png" />
						<div class="carousel-caption">
                        <h1 class="carousel-caption-header">Slide 1</h1>
                        <p class="carousel-caption-text hidden-sm hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim aliquet rutrum. Praesent vitae ante in nisi condimentum egestas. Aliquam.
                        </p>
                    </div>
					</div>

<!-- $(div).data("testWer") -->
					<div class="item" data-test-wer="123"> 
						<img src="<%=request.getContextPath()%>/front/img/2.png" />
						<div class="carousel-caption">
                        <h1 class="carousel-caption-header">Slide 1</h1>
                        <p class="carousel-caption-text hidden-sm hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim aliquet rutrum. Praesent vitae ante in nisi condimentum egestas. Aliquam.
                        </p>
                    </div>
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/3.png" />
						<div class="carousel-caption">
                        <h2 class="carousel-caption-header">Slide 1</h2>
                        <p class="carousel-caption-text hidden-sm hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim aliquet rutrum. Praesent vitae ante in nisi condimentum egestas. Aliquam.
                        </p>
                    </div>
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/4.png" />
						<div class="carousel-caption">
                        <h3 class="carousel-caption-header">Slide 1</h3>
                        <p class="carousel-caption-text hidden-sm hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim aliquet rutrum. Praesent vitae ante in nisi condimentum egestas. Aliquam.
                        </p>
                    </div>
					</div>

					<div class="item">
						<img src="<%=request.getContextPath()%>/front/img/6.jpg" />
						<div class="carousel-caption">
						
                        <h4 class="carousel-caption-header">Slide 1</h4>
                        <p class="carousel-caption-text hidden-sm hidden-xs">
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse dignissim aliquet rutrum. Praesent vitae ante in nisi condimentum egestas. Aliquam.
                        </p>
                    </div>
					</div>
				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#transition-timer-carousel"
					data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left"></span>
				</a> <a class="right carousel-control" href="#transition-timer-carousel"
					data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right"></span>
				</a>

				<!-- Timer "progress bar" -->
				<hr class="transition-timer-carousel-progress-bar animate" />
			</div>
		</div>
	</div>


</BODY>
</html>
