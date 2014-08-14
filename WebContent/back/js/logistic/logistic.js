/**
 * 
 */
//後端物流管理AJAX | class="btnCallAjaxLogistic" type="button"
$(".btnCallAjaxLogistic").off();
$(".btnCallAjaxLogistic").on("click", function(event) {
	
	var form = $(this).closest("form");
	
	form.parent("div").dialog("close");
	
	console.log(form.attr("action"));
	
	$.ajax({
		url : form.attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : form.serialize(),
		dataType : "html",
		success : function(returnData) {
				$("#listAllTrade").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});