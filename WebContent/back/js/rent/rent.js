/**
 * 
 */
//後端租物管理AJAX | class="btnCallAjaxRent" type="button"
$(".btnCallAjaxRent").off();
$(".btnCallAjaxRent").on("click", function(event) {
	
	var form = $(this).closest("form");
	
	form.parent("div").dialog("close");
	
//	console.log(form.attr("action"));
	
	$.ajax({
		url : form.attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : form.serialize(),
		dataType : "html",
		success : function(returnData) {
				$("#listAllRent").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});