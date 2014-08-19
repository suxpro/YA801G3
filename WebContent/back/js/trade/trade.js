/**
 * 
 */
//後端會員管理AJAX | class="btnCallAjaxTrade" type="button"
$(".btnCallAjaxTrade").off();
$(".btnCallAjaxTrade").on("click", function(event) {
	
	var table = $(this).closest("table");
	
//	form.parent("div").dialog("close");
	
//	console.log($(this).closest("table").find("select").serialize());
	console.log(table.find("select").serialize());
	$.ajax({
		url : table.find("form").attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : table.find("select").serialize(),
		dataType : "html",
		success : function(returnData) {
				$("#listAllMem").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});