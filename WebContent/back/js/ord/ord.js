/**
 * 
 */
//後端租物管理AJAX | class="btnCallAjaxOrd" type="button"
$(".btnCallAjaxOrd").off();
$(".btnCallAjaxOrd").on("click", function(event) {
	
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
				$("#ordListResult").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});