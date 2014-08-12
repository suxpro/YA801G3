/**
 * 
 */
$("#failRentAJAX").off();
$("#failRentAJAX").on("submit", function(event) {

	$(this).parent("div").dialog("close");
	
	$.ajax({
		url : $(this).attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : {
			action : "fail",
			rent_no : $(this).find("input[name='rent_no']").val(),
			cause : $(this).find("textarea").val()
		},
		dataType : "html",
		success : function(returnData) {
				$("#listAllRent").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});