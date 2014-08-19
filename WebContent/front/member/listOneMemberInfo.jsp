<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.member.model.*"%>
<%
// 	MemberService MemberSvc = new MemberService();
 	MemberVO memberVO = (MemberVO) request.getAttribute("memberVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)

// 	MemberVO memberVO = MemberSvc.getOneMember(memberVOxx.getMno());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>JustRent! - �|�����</title>

<style type="text/css">
#preview {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#preview2 {
	width: 100px;
	height: 100px;
	border: 1px solid #000;
	overflow: hidden;
}

#imghead2 {
	filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
}

#memform {width:85%;}

#vipPic{
width:120px;
height:120px;
background-color:#FEFFE5;
  position: relative;
  left: -17px;
  top: 20px;
  text-align:center;
  box-shadow:1px 1px 1px 1px rgba(20%,20%,40%,0.1);
  border-radius: 10px;
  
}
#vipPicLabel {
color: black;
font-weight: bold;

}  

</style>

<link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script>
<script	src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script>
<script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script>
<script src="<%=request.getContextPath()%>/front/js/justrent.js"></script>

<script language="JavaScript" src="js/previewImage.js"></script>
<script language="JavaScript" src="js/previewImage2.js"></script>

</head>
<body>

	<%@ include file="/front/header.jsp"%>

	<div class="container">
		<div class="row">

<!-- SideBar -->
			<div class="col-md-2 sidebar">
			<div class="panel-group" id="accordion">
<!-- �|����� -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
          �|���޲z
        </a>
      </h4>
    </div>
    <div id="collapseOne" class="panel-collapse collapse in">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li class="active"><a href="#" onclick="document.MemInfo.submit();">�|�����</a></li>
        <li><a href="#" onclick="document.storedMoney.submit();">�|���x��</a></li>
        <li><a href="#" onclick="document.updateVIP.submit();">�ɯŷ|��</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- �����޲z  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
          �����޲z
        </a>
      </h4>
    </div>
    <div id="collapseTwo" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/rent/listAllRent.jsp">�������</a></li>
        <li><a href="<%=request.getContextPath()%>/front/rent/addRent.jsp">�s�W����</a></li>
        </ul>
      </div>
    </div>
  </div>

<!-- �ӯ��޲z -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
         �ӯ��޲z
        </a>
      </h4>
    </div>
    <div id="collapseThree" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/cart/cart.jsp">������</a></li>
        <li><a href="<%=request.getContextPath()%>/front/ord/tenOrdList.jsp">�ӯ��M��</a></li>        
        <li><a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">�l�ܲM��</a></li>
        </ul>
      </div>
    </div>
  </div>
  
  
  <!-- �X���޲z  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
          �X���޲z
        </a>
      </h4>
    </div>
    <div id="collapseFour" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/lesOrdList.jsp">�X���M��</a></li>
        </ul>
      </div>
    </div>
  </div>

  <!-- ���v����  -->
  <div class="panel panel-success">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFive">
          ���v����
        </a>
      </h4>
    </div>
    <div id="collapseFive" class="panel-collapse collapse">
      <div class="panel-body">
        <ul class="nav nav-sidebar">
        <li><a href="<%=request.getContextPath()%>/front/ord/AllOrdByMember.jsp">���v���ɬ���</a></li>
        <li><a href="<%=request.getContextPath()%>/front/trade/OneMemberTrade.jsp">���v�������</a></li>
        </ul>
      </div>
    </div>
  </div>

</div>
			</div>
			
						
<!-- Form -->
			<div class="col-md-offset-0">
						<fieldset>
							<div id="legend">
								<legend >
									<h2>
										<b>�|�����</b>
									</h2>
								</legend>
							</div>

							
								<div class="col-md-5 col-md-offset-1">
									<!-- �ƪ� -->

									<!-- �|���b�� -->
									<div class="control-group  ">
										<label class="control-label" for="mid">�|���b�� </label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mid}</label>
									</div>


									<!-- �|���m�W -->
									<div class="control-group  ">
										<label class="control-label" for="mname">�|���m�W</label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mname}</label>
									</div>
									
									<!-- �|���l�B -->
									<div class="control-group  ">
										<label class="control-label" for="mname">�|���l�B</label> 
										<label class="control-label col-xs-offset-1" id="mid">${memberVO.mbalance}</label>
									</div>

									<!-- �|���ʧO -->
									<div class="control-group  ">
										<label class="control-label" for="msex">�|���ʧO</label> 
										<label class="control-label col-xs-offset-1" id="msex">${mem_staMap[memberVO.msex]}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="mlev">�|������</label> 
										<label class="control-label col-xs-offset-1" id="mlev">${mem_staMap[memberVO.mlev]}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="massess">�|������</label> 
										<label class="control-label col-xs-offset-1" id="massess">${memberVO.massess}</label>
									</div>

									<!-- �|���H�W���� -->
									<div class="control-group  ">
										<label class="control-label" for="millegal">�H�W����</label> 
										<label class="control-label col-xs-offset-1" id="millegal">${memberVO.millegal}</label>
									</div>

									<!-- �|����� -->
									<div class="control-group  ">
										<label class="control-label" for="mcell">�|�����</label>
										<label class="control-label col-xs-offset-1" id="mcell">${memberVO.mcell}</label>

									</div>

									<!-- �|���l�� -->
									<div class="control-group ">
										<label class="control-label" for="mmail">�|���l��</label> 
										<label class="control-label col-xs-offset-1" id="mmail">${memberVO.mmail}</label>
									</div>

									<!-- �a�� -->
									<div class="control-group  ">
										<label class="control-label" for="locno">�a�ϡ@�@</label>
										<label class="control-label col-xs-offset-1" id="locno">${loc_staMap[memberVO.locno]}</label>
									</div>

									<!-- �|���a�} -->
									<div class="control-group ">
										<label class="control-label" for="madrs">�|���a�}</label> 
										<label class="control-label col-xs-offset-1" id="madrs">${memberVO.madrs}</label>
									</div>
									
									<!-- �|������ -->
									<div class="control-group  ">
										<label class="control-label" for="mverification">�|������</label> 
										<label class="control-label col-xs-offset-1" id="mverification">${mem_staMap[memberVO.mverification]}</label>
									</div>
									
									<!-- �|���[�J��� -->
									<div class="control-group  ">
										<label class="control-label" for="mdate">�[�J���</label> 
										<label class="control-label col-xs-offset-1" id="mdate">${memberVO.mdate}</label>
									</div>


								</div>
								<!-- �ƪ� -->
								<div class="col-md-offset-7 sidebar-offcanvas ">
									<!-- �Ϥ��ƪ� -->

									<!-- �|���Ϥ� -->
									<div class="control-group ">
										<label class="control-label" for="mpic">�|���Ϥ�</label>
										<div class="controls">
											<img id="mpic" width="80" height="80"
												src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_PIC">
										</div>
									</div>

									 								

								</div>
								<!-- �Ϥ��ƪ� -->
								<br>
								<div class="col-md-6 col-md-offset-2">
									<c:if test="${memberVO.mlev == 'V' }">
										<!-- �|�������Ϥ� -->
										<div id="vipPic" class="control-group  ">
											<label id="vipPicLabel" class="control-label" for="password_confirm">�|�������Ϥ�</label>
											<div class="controls">
												<img id="mvpic" width="600" height="200"
													src="<%=request.getContextPath()%>/front/member/member.do?mno=${memberVO.mno}&pic=MEM_VPIC">
											</div>
										</div>
										<br/><br/><br/><br/><br/><br/>
									</c:if>									
								</div>
																					
							<br>
							<br>

							
							<div class="control-group col-md-8 col-md-offset-8">
								<c:if test="${memberVO.mlev != 'V' }">
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/memberVIP.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-warning">�ɯŷ|��</button>
									
								</FORM>
								</c:if>
								
								<br/>
															
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/front/member/member.do">
									<input type="hidden" name="mno" value="<%=memberVO.getMno()%>">
									<input type="hidden" name="action" value="getOne_For_Update">
									<button class="btn btn-success">�ק���</button>
								</FORM>
								
								
							</div>
					
							
						</fieldset>
				
			</div>

		</div>
	</div>


	<%@ include file="/front/footer.jsp"%>
</body>
</html>