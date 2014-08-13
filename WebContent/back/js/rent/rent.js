/**
 * 
 */
$("#failRentAJAX").off();
$("#failRentAJAX input[type='button']").on("click", function(event) {

	$("#failRentAJAX").parent("div").dialog("close");
	console.log($("#failRentAJAX").attr("action"));
	
	$.ajax({
		url : $("#failRentAJAX").attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : {
			action : "fail",
			rent_no : $("#failRentAJAX").find("input[name='rent_no']").val(),
			cause : $("#failRentAJAX").find("textarea").val()
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

$("#passRentAJAX").off();
$("#passRentAJAX").on("submit", function(event) {

	var formData = $(this).serialize();

	console.log($(this).find("input[name='rent_no']").val());
	console.log($(this).attr("action"));
	$.ajax({
		url : $(this).attr("action"),
		type : "POST",
		contentType : "application/x-www-form-urlencoded",
		data : {
			action : "pass",
			rent_no : $(this).find("input[name='rent_no']").val()
		},
		dataType : "text",
		success : function(returnData) {
				$("#listAllRent").html(returnData);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});