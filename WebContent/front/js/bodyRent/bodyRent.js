/**
 * 
 */
$(document).ready(
		function() {

			// 選擇租物
			$(".divRentItem").off();
			$(".divRentItem").on("click", function(event) {
				console.log($(this).attr("id"));
				$.ajax({
					type : "POST",
					url : $(this).attr("value"),
					contentType : "application/x-www-form-urlencoded",
					data : {
						action : "show",
						rent_no : $(this).attr("id")
					},
					dataType : "html",
					success : function(data) {
						$("#infoRentShow").html(data);
					},
					error : function() {
						alert("系統異常!");
					}
				});
			});

			// 租物詳細資料modal
			$('#infoRentModel').off();
			$('#infoRentModel').on('shown.bs.modal',function(e) {
//				console.log("bodyRent.rentState:"+$(this).find("#rentStateSpan").data("rentState"));
				//按鈕顯示承租/預租
//				$.trim($(this).find("#rentStateSpan").data("liveOrd")).length != 0? $("#btnAddRentToCart").text("預租").addClass("btn-warning") : $("#btnAddRentToCart").text("承租").addClass("btn-primary");
				$.trim($(this).find("#rentStateSpan").data("liveOrd")).length != 0? $("#btnAddRentToCart").hide("fast") : $("#btnAddRentToCart").show("fast");

				//點擊承租按鈕
				$("#btnAddRentToCart").off();
				$("#btnAddRentToCart").on("click", function(e) {
					console.log($(this).data("servlet"));
					console.log($(this).data("rentNo"));
					console.log($(this).data("rentState"));
					$.ajax({
						type : "POST",
						url : $(this).data("servlet"),
						contentType : "application/x-www-form-urlencoded",
						data : {
							action : "addRentToCart",
							rent_no : $(this).data("rentNo"),
							rent_state : $(this).data("rentState")
						},
						dataType : "json",
						success : function(rspJson) {
							console.log(rspJson);
						},
						error : function() {
							alert("系統異常!");
						}
					});
				});
				
				//點擊追蹤按鈕
				$("#btnAddRentToPrerent").off();
				$("#btnAddRentToPrerent").on("click", function(e) {
					console.log($(this).data("servlet"));
					console.log($(this).data("rentNo"));
					console.log($(this).data("rentState"));
					$.ajax({
						type : "POST",
						url : $(this).data("servlet"),
						contentType : "application/x-www-form-urlencoded",
						data : {
							action : "addRentToPrerent",
							rent_no : $(this).data("rentNo"),
							rent_state : $(this).data("rentState")
						},
						dataType : "text",
						success : function(rspJson) {
							console.log(rspJson);
						},
						error : function() {
							alert("系統異常!");
						}
					});
				});
				
				//點擊租物預覽圖片切換
				$(".imgPreview").click(function(e) {
					//console.log($(this).attr("src"));
					$(".imgMainShow").attr("src",$(this).attr("src"));
				});
				
				// google地圖
				$("#map").tinyMap({
					'center' : $("#map").data("mapRentAddr"),
					'zoom' : 16,
					'disableDefaultUI' : true,
					'marker' : [
					/* 給予每個標記唯一的 id 值 */
					{
						'addr' : $("#map").data("mapRentAddr"),
						'text' : $("#map").data("mapRentAddr"),
						'id' : $("#map").data("mapRentAddr")
					} ]
				});
				// 日曆
				// $( "#datepicker" ).datepicker({ minDate: -5,
				// maxDate: "+1M +10D" });
				var optDatepicker = {
					dayNames : [ "星期日", "星期一", "星期二", "星期三",
							"星期四", "星期五", "星期六" ],
					dayNamesMin : [ "日", "一", "二", "三", "四",
							"五", "六" ],
					monthNames : [ "一月", "二月", "三月", "四月",
							"五月", "六月", "七月", "八月", "九月", "十月",
							"十一月", "十二月" ],
					monthNamesShort : [ "一月", "二月", "三月", "四月",
							"五月", "六月", "七月", "八月", "九月", "十月",
							"十一月", "十二月" ],
					prevText : "上月",
					nextText : "次月",
					weekHeader : "週",
					showMonthAfterYear : true,
					dateFormat : "yy-mm-dd",
					// minDate:-10,
					// maxDate:+10,
					create : function(event, ui) {
						console.log("test");
					}
				};
				$("#datepicker").datepicker(optDatepicker);
				
				//判斷是否此租物已經有人正在租,日曆要顯示日期範圍
				if($.trim($(this).find("#rentStateSpan").data("liveOrd")).length != 0 ){
					var ordTenDate = new Date($(this).find("#rentStateSpan").data("ordTenDate")).getTime(); //承租日
					var ordExpDate = new Date($(this).find("#rentStateSpan").data("ordExpDate")).getTime(); //到期日
					var bufferDate = $("#datepicker").data("resetDays")*24*60*60*1000; //緩衝的天數
					console.log("bodyRent.liveOrd:"+$(this).find("#rentStateSpan").data("liveOrd"));
					console.log("bodyRent.ordTenDate:"+$(this).find("#rentStateSpan").data("ordTenDate"));
					console.log("bodyRent.ordExpDate:"+$(this).find("#rentStateSpan").data("ordExpDate"));
					
					$("#datepicker").datepicker("setDate", new Date((ordTenDate+ordExpDate)/2));
					$("#datepicker").datepicker(
							"option",
							"minDate",
							new Date(ordTenDate - bufferDate));
					$("#datepicker").datepicker(
							"option",
							"maxDate",
							new Date(ordExpDate + bufferDate));
					$("#hasRent").text("已出租,日期請參考上面");
				} else {
					$("#hasRent").text("尚未出租。");
				}
			});
			
			//分頁按鈕
			var showPage = 12; //一次要show得筆數
			$(".divRentItem:gt("+(showPage-1)+")").hide(); //一開始先將第2頁之後的筆數隱藏
			$(".liBodyRentPage").off();
			$(".liBodyRentPage").on("click",{showPage:showPage}, function(event) {
				var selectPageBtn = $(this).text(); //取得分頁按鈕的數字
				//console.log(selectPageBtn);
				$(this).addClass( "disabled" ); //將此按鍵的變成不可按
				$(this).siblings("li").removeClass( "disabled" ); //將其他變成可按
				$(".divRentItem").each(function(){
					if(Math.ceil($(this).data("rentListNo")/showPage) == selectPageBtn)
						$(this).show();
					else
						$(this).hide();
				});
			});

			//搜尋租物按鈕
			$("#btnBodyRentSubmit").off();
			$("#btnBodyRentSubmit").on("click", function(event) {
				if($.trim($("#inputBodyRentSearch").val()).length != 0){
					$(".divRentItem").fadeOut("fast", function() { //一開始先將所有的筆數隱藏
						$(".bodyRentName:contains("+$("#inputBodyRentSearch").val()+")").parents(".divRentItem").fadeIn("fast");
					});
				} else {
					var selectPage = $(".liBodyRentPage.disabled").text();
					console.log(selectPage);
					$(".divRentItem").fadeOut("fast").slice(showPage*(selectPage-1),showPage*selectPage).fadeIn("fast");
				}
			});
			
			//搜尋租物分類按鈕
			$("#bodyRentMenu > li").off();
			$("#bodyRentMenu > li").on("click", function(event) {
				console.log($(this).data("rentTagNo"));
//				console.log($(".divRentItem[data-rent-tag-no="+$(this).data("rentTagNo")+"]"));
				var rentTagNo = $(this).data("rentTagNo");
				if(rentTagNo != "T10000")
					$(".divRentItem").fadeOut("fast").filter("[data-rent-tag-no="+rentTagNo+"]").fadeIn("fast");
				else
					$(".divRentItem").fadeIn("fast");
			});
			
		});