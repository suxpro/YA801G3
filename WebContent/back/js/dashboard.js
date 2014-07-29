$(document).ready(
		function() {
			$.getScript("js/employee/listAllEmp.js");

			// ---------------
			$(".manage").click(function() {
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

				// $(#indexMain).html("<%@ include
				// file=\"/employee/listAllEmp.jsp\"%>");
			});

//			$("table td").on(
//					"click",
//					function() {
//						if (!$(this).is('.input')
//								&& $(this).attr('class') == undefined) {
//							$(this).html(
//									'<input type="text" value="'
//											+ $(this).text() + '" />').find(
//									'input').focus().blur(function() {
//								// var thisid =
//								// $(this).parent().siblings("td:eq(0)").text();
//								// var thisvalue=$(this).val();
//								// var thisclass =
//								// $(this).parent().attr("class");
//								// alert(thisid+" "+thisvalue+"
//								// "+thisclass);
//								// $.ajax({
//								// type: 'POST',
//								// url: 'update.php',
//								// data:
//								// "thisid="+thisid+"&thisclass="+thisclass+"&thisvalue="+thisvalue
//								// });
//								$(this).parent().html($(this).val() || "");
//							});
//						}
//					});
		});

function creatQueryString(addSubmit) {
	var jsonObj = {};
	jsonObj["action"] = addSubmit.attr("id");// 插入action屬性值
	addSubmit.parent().siblings().find("input").each(function() { // 動態新增屬性值
		jsonObj[$(this).attr("name")] = $(this).val();
	});
	return jsonObj;
}