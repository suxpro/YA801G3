/**
 * 
 */
//後端物流管理AJAX | class="btnCallAjaxShip" type="button"
$(".btnCallAjaxShip").off();
$(".btnCallAjaxShip").on("click", function(event) {
	
	var form = $(this).closest("form");
	console.log(form.attr("action"));	
	console.log(form.serialize());
	
	$.ajax({
		url : form.attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : form.serialize(),
		dataType : "html",
		success : function(returnData) {
				$("#listAllShipResult").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});