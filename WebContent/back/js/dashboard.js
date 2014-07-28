$(document).ready(function() {
	$.getScript("js/employee/listAllEmp.js");
//	
//			// add
//			$("#addSubmit").on("submit", function(event) {
//				event.preventDefault();
//
//				// grab all form data
//				var formData = new FormData($(this)[0]);
//
//				console.log(formData);
//
//				$.ajax({
//					url : $(this).attr("value"),
//					type : "POST",
//					data : formData,
//					async : false,
//					cache : false,
//					contentType : false,
//					processData : false,
//					success : function(data) {
//						$("#addEmpModel").on("hidden.bs.modal", function(e) {
//							$("#listAllEmp").html(data);
//						}).modal("hide");
//					}
//				});
//
//				// $(".addSubmit").on( "click", function(event) {
//				// disable the default form submission
//				// $.ajax({
//				// type:"POST",
//				// url:$(this).attr("value"),
//				// contentType:"multipart/form-data",
//				// // processData:false,
//				// data:creatQueryString($(this)),
//				// dataType: "html",
//				// //dataType:"json",
//				// success:function (data){
//				// alert("YAAA");
//				// $("#listAllEmp").html(data);
//				// //
//				// $("#listAllEmp").load("employee/listAllEmp.jsp",function(){$.getScript("js/dashboard.js");});
//				// },
//				// error:function(){alert("error");}
//				// })
//			});
//
//			// remove
//			$("#delEmpBtn").on("click", function(event) {
//				$(".delSubmit").show();
//
//			});

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

			$("#toggle").click(function() {
				$("#emp").toggle(1000);
			});

//			$("#addEmpSubmit").click(function() {
//				htmlobj = $.ajax({
//					type : "post",
//					url : "<%=request.getContextPath()%>/employee/employee.do",
//					success : function(data, textStatus) {
//						$("#emp").html(data);
//						// complete: function(msg){
//						// $("#emp").html(htmlobj.responseText);
//						// //console.log(msg);
//					},
//					error : function() {
//						alert("系統異常!");
//					}
//				});
//			});

			$("table td").on("click",
					function() {
						if (!$(this).is('.input') && $(this).attr('class') == undefined) {
							$(this).html('<input type="text" value="'+ $(this).text() + '" />').find('input').focus().blur(
									function() {
										// var thisid =
										// $(this).parent().siblings("td:eq(0)").text();
										// var thisvalue=$(this).val();
										// var thisclass =
										// $(this).parent().attr("class");
										// alert(thisid+" "+thisvalue+"
										// "+thisclass);
										// $.ajax({
										// type: 'POST',
										// url: 'update.php',
										// data:
										// "thisid="+thisid+"&thisclass="+thisclass+"&thisvalue="+thisvalue
										// });
										$(this).parent().html($(this).val() || "");
									});
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