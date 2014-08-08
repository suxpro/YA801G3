/**
 * 
 */

// 新增員工權限按鈕
$("#addComForm").off();
$("#addComForm").on("submit", function(event) {
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
			$("#addComModel").on("hidden.bs.modal", function(e) {
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
	// $("#listAllCom").html(data);
	// //
	// $("#listAllCom").load("competence/listAllCom.jsp",function(){$.getScript("js/dashboard.js");});
	// },
	// error:function(){alert("error");}
	// })
});

//// 修改員工按鈕
//$("#updateComBtn").on("click",function(event) {
//	$("#updateComBtn").attr( "disabled","disabled" );
//	$(".updateComTd").show();
//	var jsonObj = {};
//	jsonObj["action"] = "update";// 插入action屬性值
//	$("table td").on("click",function() {
////		console.log($(this).has("img").length);
//		var tdTextBak=$(this).text();
//		if (!$(this).is('.input') && $(this).attr('class') == undefined && $(this).has("img").length==0) {
//			$(this).html('<input type="text" value="'+ $(this).text() + '" />').find('input').focus().bind("blur",{test:tdTextBak},function(event) {
//				
//				if($.trim($(this).val()).length != 0){
//					var tdFirst = $(this).parent().siblings("td:first");//此td為hidden的刪除按鈕
//					$(this).parent().text($(this).val());//修改td欄位值,將<input>替換為輸入值
////					if(!jsonObj.hasOwnProperty(tdFirst.next().text())){//判斷jsonObj內是否已擁有此Com_id
//						var str = tdFirst.next().text();
//						var array =tdFirst.nextAll().map(function () { return $(this).text();}).toArray();
////						console.log(array);
//						jsonObj[str] = array;
////					}
//				} else {
////					console.log($(this).parent().siblings("td:eq(1)").text());
//					$(this).parent().text(event.data.test);
//				}
//				console.log(jsonObj);
////				$.each(jsonObj, function(key, value){
////				        console.log(key, value);
////				        if(key=="action"){
////				        	console.log(key, value);
////				        } else {
////				        	$.each(value, function(key, value){
////				        		console.log($("#listAllComTable").find("th:eq("+(key+1)+")").attr("title"),key,value);
////							});
////				        }
////				});
//				
//				//按確定update
//				$("#updateComYes").on("click",{jsonObj:jsonObj},function(event) {
//					event.preventDefault();
//					var ajaxUrl = $(this).attr("value");
//					var actionDo = "";
//					// grab all form data
//					$.each(jsonObj, function(key, value){
//					        console.log(key, value);
//					        if(key=="action"){
//					        	actionDo = value;
//					        } else {
//								var formData = new FormData();
//					        	formData.append("action",actionDo);
//					        	console.log("action",actionDo);
//					        	$.each(value, function(key, value){
//					        		formData.append($("#listAllComTable").find("th:eq("+(key+1)+")").attr("title"),value);
//						        	console.log($("#listAllComTable").find("th:eq("+(key+1)+")").attr("title"),value);
//					        	});
//								console.log(ajaxUrl);
//								$.ajax({
//									url : ajaxUrl,
//									type : "POST",
//									data : formData,
//									async : false,
//									cache : false,
//									contentType : false,
//									processData : false,
//									success : function(data) {
//										$("#listAllCom").html(data);
//									},
//									error : function() {
//										alert("系統異常!");
//									}
//								});
//					        }
//					});
//				});
//			});
//		}
//	});
//	//按取消update
//	$("#updateComNo").on("click",function(event) {
//		$(".updateComTd").hide();
//		$("#updateComBtn").removeAttr( "disabled","disabled" );
//	});
//});

// 移除員工權限按鈕
$("#btnDelCom").off();
$("#btnDelCom").on("click", function(event) {
	$(".delComTd").fadeToggle();
	$(".delComSubmit").click(function() {
		console.log($(this).parent().siblings("td:eq(0)").text());
		console.log($(this).attr("value"));
		$.ajax({
			type : "POST",
			url : $(this).attr("value"),
			contentType : "application/x-www-form-urlencoded",
			data : {
				action : "delete",
				emp_no : $(this).parent().siblings("td:eq(0)").text(),
				func_no : $(this).parent().siblings("td:eq(2)").text()
			},
			dataType : "html",
			success : function(data) {
				$("#listAllEmp").html(data);
			},
			error : function() {
				alert("系統異常!");
			}
		});
	});
});

//分頁按鈕
var showPage = 8; //一次要show得筆數
console.log();
$("#listAllComTable tbody tr:gt("+(showPage-1)+")").hide(); //一開始先將第2頁之後的筆數隱藏
$(".liListAllComPage").off();
$(".liListAllComPage").on("click",{showPage:showPage}, function(event) {
	var selectPageBtn = $(this).text(); //取得分頁按鈕的數字
//	console.log(selectPageBtn);
	$(this).addClass( "disabled" ); //將此按鍵的變成不可按
	$(this).siblings("li").removeClass( "disabled" ); //將其他變成可按
	$("#listAllComTable tbody tr").each(function(){
		if(Math.ceil($(this).attr("title")/showPage) == selectPageBtn)
			$(this).show();
		else
			$(this).hide();
	});
});

//搜尋員工按鈕
$("#btnListAllComSubmit").off();
$("#btnListAllComSubmit").on("click", function(event) {
	if($.trim($("#inputListAllComSearch").val()).length != 0){
		$("#listAllComTable tbody tr").fadeOut("fast", function() { //一開始先將所有的筆數隱藏
			$("#listAllComTable tbody tr td:contains("+$("#inputListAllComSearch").val()+")").parent("tr").fadeIn("fast");
		});
	} else {
		var selectPage = $(".listAllComTable.disabled").text();
		console.log(selectPage);
		$("#listAllComTable tbody tr").fadeOut("fast").slice(showPage*(selectPage-1),showPage*selectPage).fadeIn("fast");
//		$("#listAllComTable tbody tr").hide(function() { 
//			var selectPage = $(".liListAllComPage.disabled").text();
//			console.log(selectPage);
////			$("#listAllComTable tbody tr:gt("+(showPage-1)+")").fadeIn("fast"); //顯示第一頁筆數
//			$("#listAllComTable tbody tr").each(function(){
//				if(Math.ceil($(this).attr("title")/showPage) == selectPage)
//					$(this).fadeIn("fast");
//			});
//		});
	}
});