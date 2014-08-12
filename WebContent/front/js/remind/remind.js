/**
 * 
 */
$(document).ready(function() {
	var intervalID;
	run();
	
	function run() {
	    intervalID = window.setInterval(setRemindListNum, 30*1000); //30秒跑一次
	}
	
	function stop() {
	    window.clearInterval(intervalID);
	}
	
	function setRemindListNum() {
		$("#remindMain .remindList #SCES_RENT").find("front").text(Math.ceil(Math.random() * 10));
		$.ajax({
			type : "POST",
			url : $("#remindMain").data("urlremind"),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				action : "remindHeaderNum",
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