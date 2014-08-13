/**
 * 
 */
$(document).ready(function() {
	var intervalID;
	run();
	setRemindListNum();
	
	function run() {
	    intervalID = window.setInterval(setRemindListNum, 30*1000); //30秒跑一次
	}
	
	function stop() {
	    window.clearInterval(intervalID);
	}
	
	function setRemindListNum() {
//		$("#remindMain .remindList").find("font").text(Math.ceil(Math.random() * 10));
		$.ajax({
			type : "POST",
			url : $("#remindMain").data("urlremind"),
			contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			data : {
				action : "remindHeaderNum",
//				rent_no : $(this).attr("id")
			},
			dataType : "json",
			success : function(jsonData) {
//				$("#infoRentShow").html(data);
				for (var key in jsonData) {
					console.log(key + ' is ' + jsonData[1]);
					
				}
				$("#remindMain .remindList").each(function( index ){
					$(this).find("font").text(index);
				});
			},
			error : function() {
				console.log("尚未登入!");
			}
		});
	}
	 
});