<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JustRent!後端</title>
<link rel="stylesheet"
	href="css/bootstrap.min.css">
<link href="css/dashboard.css" rel="stylesheet">
<script src="js/jquery-1.7.2.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/dashboard.js"></script>
<script>            
//JustRent圖片旋轉
var angle = 0;
setInterval(function(){
     angle+=1;
     $(".imgDashboardJustRent").css("transform","rotate(" + angle + "deg)");
},50);

function initDashboard() {
    //判斷登入帳號的職位顯示Manage
    $(".ulDashboardEmpManage li").show();
    switch ($(".pDashboardAccount").attr("title")) {
        case "administrator":
            $("#indexMain").load("employee/indexEmp.jsp");
            break;
        case "employee":
            $(".ulDashboardEmpManage li a[rel='employee']").hide();
            $("#indexMain").load("member/indexMem.jsp");
            break;
        case "logistics":
            $(".ulDashboardEmpManage li a[rel='employee']").hide();
            $(".ulDashboardEmpManage li a[rel='member']").hide();
            $(".ulDashboardEmpManage li a[rel='rent']").hide();
            $("#indexMain").load("trade/indexTrade.jsp");
            break;
        default:
            alert("登入帳號職位error!");
            break;
    }
}
</script>

</head>
<body onload="initDashboard()">
    <div style="position:fixed;left:-50px;bottom:-50px;z-index:1001;">
        <img src="<%=request.getContextPath()%>/back/img/JustRent_Logo.png" class="imgDashboardJustRent" height="275" width="275" class="img-responsive"/>
    </div>
	<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand navbar-left" href="#">JustRent!後端</a>
				<p class="pDashboardAccount navbar-text" title="<%=request.getSession().getAttribute("accountBackJob")%>">登入帳號: <%=request.getSession().getAttribute("accountBack")%></p>
                <form class="navbar-form navbar-left" role="form" action="<%=request.getContextPath()%>/LogoutHandler" method="post">
			            <button class="btn btn-warning btn-sm" type="submit" value="OK">登出</button>
                </form>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="ulDashboardEmpManage nav navbar-nav navbar-right">
					<li><a href="#" class="manage" rel="employee">員工管理</a></li>
					<li><a href="#" class="manage" rel="member">會員管理</a></li>
					<li><a href="#" class="manage" rel="rent">租物管理</a></li>
					<li><a href="#" class="manage" rel="trade">物流管理</a></li>
				</ul>
			</div>
		</div>
	</div>
	<div id="indexMain">
    </div>
</body>
</html>