$(document).ready(
		function() {
//			$.getScript("js/employee/listAllEmp.js");
//			$.getScript("js/competence/listAllCompetence.js");
			
			//管理按鈕切換div
			$(".manage").off();
			$(".manage").on("click", function(event) {
				switch ($(this).attr("rel")) {
				case "employee":
					$("#indexMain").load("employee/indexEmp.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "member":
					$("#indexMain").load("member/indexMem.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "rent":
					$("#indexMain").load("rent/indexRent.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "trade":
					$("#indexMain").load("trade/indexTrade.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				default:
					alert("選擇管理error!");
					break;
				}
			});
			
			//員工管理按鈕切換div
			$(".aIndexEmp").off();
			$(".aIndexEmp").on("click", function(event) {
				$(this).parent("li").addClass( "active" ).siblings("li").removeClass( "active" );
				switch ($(this).attr("rel")) {
				case "employee":
					$("#listAllEmp").load("employee/listAllEmp.jsp",function() {
						$.getScript("js/employee/listAllEmp.js");
					});
					break;
				case "competence":
					$("#listAllEmp").load("competence/listAllCompetence.jsp", function() {
						$.getScript("js/competence/listAllCompetence.js");
					});
					break;
				default:
					alert("選擇員工管理error!");
					break;
				}
			});
			
			//會員管理按鈕切換div
			$(".aIndexMem").off();
			$(".aIndexMem").on("click", function(event) {
				$(this).parent("li").addClass( "active" ).siblings("li").removeClass( "active" );
				switch ($(this).attr("rel")) {
				case "member":
					$("#listAllMem").load("member/listAllMem.jsp",function() {
//						此區看是否有後續動作要做
//						$.getScript("js/member/listAllMem.js");
					});
					break;
				case "temp1":
					$("#listAllMem").load("member/temp1.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				case "temp2":
					$("#listAllMem").load("member/temp2.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				case "temp3":
					$("#listAllMem").load("member/temp3.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				default:
					alert("選擇員工管理error!");
					break;
				}
			});
			
			//租物管理按鈕切換div
			$(".aIndexRent").off();
			$(".aIndexRent").on("click", function(event) {
				$(this).parent("li").addClass( "active" ).siblings("li").removeClass( "active" );
				switch ($(this).attr("rel")) {
				case "rent":
					$("#listAllRent").load("rent/listAllRent.jsp",function() {
//						此區看是否有後續動作要做
//						$.getScript("js/rent/listAllRent.js");
					});
					break;
				case "temp1":
					$("#listAllRent").load("rent/temp1.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				case "temp2":
					$("#listAllRent").load("rent/temp2.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				default:
					alert("選擇員工管理error!");
					break;
				}
			});
			
			//物流管理按鈕切換div
			$(".aIndexTrade").off();
			$(".aIndexTrade").on("click", function(event) {
				$(this).parent("li").addClass( "active" ).siblings("li").removeClass( "active" );
				switch ($(this).attr("rel")) {
				case "trade":
					$("#listAllTrade").load("trade/listAllTrade.jsp",function() {
//						此區看是否有後續動作要做
//						$.getScript("js/trade/listAllTrade.js");
					});
					break;
				case "temp1":
					$("#listAllTrade").load("trade/temp1.jsp", function() {
//						此區看是否有後續動作要做
					});
					break;
				default:
					alert("選擇員工管理error!");
					break;
				}
			});
			
		});

function creatQueryString(addSubmit) {
	var jsonObj = {};
	jsonObj["action"] = addSubmit.attr("id");// 插入action屬性值
	addSubmit.parent().siblings().find("input").each(function() { // 動態新增屬性值
		jsonObj[$(this).attr("name")] = $(this).val();
	});
	return jsonObj;
}

function initDashboard() {
    //判斷登入帳號的職位顯示Manage
    $(".ulDashboardEmpManage li").show();
    switch ($(".pDashboardAccount").attr("title")) {
        case "administrator":
            $("#indexMain").load("employee/indexEmp.jsp", function() {
				$.getScript("js/dashboard.js");
			});
            break;
        case "employee":
            $(".ulDashboardEmpManage li a[rel='employee']").hide();
            $("#indexMain").load("member/indexMem.jsp", function() {
				$.getScript("js/dashboard.js");
			});
            break;
        case "logistics":
            $(".ulDashboardEmpManage li a[rel='employee']").hide();
            $(".ulDashboardEmpManage li a[rel='member']").hide();
            $(".ulDashboardEmpManage li a[rel='rent']").hide();
            $("#indexMain").load("trade/indexTrade.jsp", function() {
				$.getScript("js/dashboard.js");
			});
            break;
        default:
            alert("登入帳號職位error!");
            break;
    }
}