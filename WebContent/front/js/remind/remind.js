/**
 * 
 */
$(document).ready(function() {
	var intervalID;
	run();
	setRemindListNum();
	
	function run() {
	    intervalID = window.setInterval(setRemindListNum, 20*1000); //20秒跑一次
	}
	
	function stop() {
	    window.clearInterval(intervalID);
	}
	
	function setRemindListNum() {
//		$("#remindMain .remindList").find("font").text(Math.ceil(Math.random() * 10));
//		console.log($("#remindMainList").data("action"));
		if($("#divHeadTitle").data("islogin") == "yes"){
			$.ajax({
				type : "POST",
				url : $("#remindMain").data("action"),
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				data : {
					action : "remindHeaderNum",
//					rent_no : $(this).attr("id")
				},
				dataType : "json",
				success : function(jsonData) {
//					console.log(Object.keys(jsonData).length);
					if(Object.keys(jsonData).length > 1){
//						var jsonArray = [];
						var remindCountNum = 0;
						for (var key in jsonData) {
//							console.log(key + ' is ' + jsonData[key]);
//							jsonArray.push(jsonData[key]);
							$("#remindMain .remindList a:contains("+key+")").find("font").text(jsonData[key]);
							remindCountNum += jsonData[key];
						}
						console.log("目前共有"+remindCountNum+"筆提醒!");
						$("#remindCountNum").text(remindCountNum);
//						$("#remindMain .remindList").each(function( index ){
//							$(this).find("font").text(jsonArray[index]);
//						});
					} else {
						console.log(jsonData["resJson"][0]);
					}

				},
				error : function() {
					console.log("系統異常!");
				}
			});
			
		} else {
			console.log("尚未登入! "+$("#divHeadTitle").data("islogin"));
		}
	}
	 
});