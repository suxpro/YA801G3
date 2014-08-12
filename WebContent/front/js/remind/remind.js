/**
 * 
 */
$(document).ready(function() {
	var intervalID;
	run();
	
	function run() {
//	    intervalID = window.setInterval(setRemindListNum, 10*1000);
	}
	
	function stop() {
	    window.clearInterval(intervalID);
	}
	
	function setRemindListNum() {
		$("#remindMain .remindList #D0001").find("front").text(Math.ceil(Math.random() * 10));
		$.ajax({
			type : "POST",
			url : $("#remindMain").data("urlremind"),
			contentType : "application/x-www-form-urlencoded",
			data : {
				action : "remind",
//				rent_no : $(this).attr("id")
			},
			dataType : "json",
			success : function(data) {
//				$("#infoRentShow").html(data);
				console.log(data);
			},
			error : function() {
				alert("系統異常!");
			}
		});
	}
	 
});