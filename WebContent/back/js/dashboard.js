$(document).ready(
		function() {
//			$.getScript("js/employee/listAllEmp.js");
			
			//管理按鈕切換div
			$(".manage").on("click", function(event) {
				switch ($(this).attr("rel")) {
				case "employee":
					$("#indexMain").load("employee/indexEmp.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "member":
					$("#indexMain").load("employee/listAllEmp.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "rent":
					$("#indexMain").load("employee/indexEmp.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				case "trade":
					$("#indexMain").load("employee/listAllEmp.jsp", function() {
						$.getScript("js/dashboard.js");
					});
					break;
				default:
					alert("選擇管理error!");
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