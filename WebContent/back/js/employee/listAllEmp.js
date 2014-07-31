/**
 * 
 */

// 新增員工按鈕
$("#addEmpForm").on("submit", function(event) {
	event.preventDefault();

	// grab all form data
	var formData = new FormData($(this)[0]);

	console.log(formData);

	$.ajax({
		url : $(this).attr("value"),
		type : "POST",
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		processData : false,
		success : function(data) {
			$("#addEmpModel").on("hidden.bs.modal", function(e) {
				$("#listAllEmp").html(data);
			}).modal("hide");
		},
		error : function() {
			alert("系統異常!");
		}
	});

	// $(".addSubmit").on( "click", function(event) {
	// disable the default form submission
	// $.ajax({
	// type:"POST",
	// url:$(this).attr("value"),
	// contentType:"multipart/form-data",
	// // processData:false,
	// data:creatQueryString($(this)),
	// dataType: "html",
	// //dataType:"json",
	// success:function (data){
	// alert("YAAA");
	// $("#listAllEmp").html(data);
	// //
	// $("#listAllEmp").load("employee/listAllEmp.jsp",function(){$.getScript("js/dashboard.js");});
	// },
	// error:function(){alert("error");}
	// })
});

// 修改員工按鈕
$("#updateEmpBtn").on("click",function(event) {
	$("#updateEmpBtn").attr( "disabled","disabled" );
	$(".updateEmpTd").show();
	var jsonObj = {};
	jsonObj["action"] = "update";// 插入action屬性值
	$("table td").on("click",function() {
//		console.log($(this).has("img").length);
		var tdTextBak=$(this).text();
		if (!$(this).is('.input') && $(this).attr('class') == undefined && $(this).has("img").length==0) {
			$(this).html('<input type="text" value="'+ $(this).text() + '" />').find('input').focus().bind("blur",{test:tdTextBak},function(event) {
				// var thisid =
				// $(this).parent().siblings("td:eq(1)").text();
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
//				console.log($(this).parent().siblings("td:eq(1)").text());
//				$(this).parent().text($(this).val() || "");
//				console.log(event.data.test);
//				console.log($(this).parent().siblings("td:eq(1)").text());
//				console.log($(this).val());
				
				if($.trim($(this).val()).length != 0){
					var tdFirst = $(this).parent().siblings("td:first");//此td為hidden的刪除按鈕
					$(this).parent().text($(this).val());//修改td欄位值,將<input>替換為輸入值
//					if(!jsonObj.hasOwnProperty(tdFirst.next().text())){//判斷jsonObj內是否已擁有此emp_id
						var str = tdFirst.next().text();
						var array =tdFirst.nextAll().map(function () { return $(this).text();}).toArray();
//						console.log(array);
						jsonObj[str] = array;
//					}
				} else {
//					console.log($(this).parent().siblings("td:eq(1)").text());
					$(this).parent().text(event.data.test);
				}
				console.log(jsonObj);
//				$.each(jsonObj, function(key, value){
//				        console.log(key, value);
//				        if(key=="action"){
//				        	console.log(key, value);
//				        } else {
//				        	$.each(value, function(key, value){
//				        		console.log($("#listAllEmpTable").find("th:eq("+(key+1)+")").attr("title"),key,value);
//							});
//				        }
//				});
				
				//按確定update
				$("#updateEmpYes").on("click",{jsonObj:jsonObj},function(event) {
					event.preventDefault();
					var ajaxUrl = $(this).attr("value");
					var actionDo = "";
					// grab all form data
					$.each(jsonObj, function(key, value){
					        console.log(key, value);
					        if(key=="action"){
					        	actionDo = value;
					        } else {
								var formData = new FormData();
					        	formData.append("action",actionDo);
					        	console.log("action",actionDo);
					        	$.each(value, function(key, value){
					        		formData.append($("#listAllEmpTable").find("th:eq("+(key+1)+")").attr("title"),value);
						        	console.log($("#listAllEmpTable").find("th:eq("+(key+1)+")").attr("title"),value);
					        	});
								console.log(ajaxUrl);
								$.ajax({
									url : ajaxUrl,
									type : "POST",
									data : formData,
									async : false,
									cache : false,
									contentType : false,
									processData : false,
									success : function(data) {
										$("#listAllEmp").html(data);
									},
									error : function() {
										alert("系統異常!");
									}
								});
					        }
					});
				});
			});
		}
	});
});

// 移除員工按鈕
$("#delEmpBtn").on("click", function(event) {
	$(".delEmpTd").show();
	$(".delEmpSubmit").click(function() {
		// alert($(this).parent().siblings("td:eq(0)").text());
		// alert($(this).attr("value"));
		$.ajax({
			type : "POST",
			url : $(this).attr("value"),
			contentType : "application/x-www-form-urlencoded",
			data : {
				action : "delete",
				emp_no : $(this).parent().siblings("td:eq(0)").text()
			},
			dataType : "html",
			success : function(data) {
				$("#listAllEmp").html(data);
			}
		});
	});
});
