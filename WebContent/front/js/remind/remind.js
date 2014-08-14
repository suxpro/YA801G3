/**
 * 
 */
$(document).ready(function() {
	var intervalID;
	run();
	setRemindListNum();
	
	function run() {
	    intervalID = window.setInterval(setRemindListNum, 60*1000); //60秒跑一次
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
//				var jsonArray = [];
				var remindCountNum = 0;
				for (var key in jsonData) {
//					console.log(key + ' is ' + jsonData[key]);
//					jsonArray.push(jsonData[key]);
					$("#remindMain .remindList a:contains("+key+")").find("font").text(jsonData[key]);
					remindCountNum += jsonData[key];
				}
				console.log(remindCountNum);
				$("#remindCountNum").text(remindCountNum);
//				$("#remindMain .remindList").each(function( index ){
//					$(this).find("font").text(jsonArray[index]);
//				});
			},
			error : function() {
				console.log("尚未登入!");
			}
		});
	}
	 
});