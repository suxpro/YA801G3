/**
 * 
 */

// add
$("#addSubmit").on("submit", function(event) {
	event.preventDefault();

	// grab all form data
	var formData = new FormData($(this)[0]);

	console.log(formData);

	$.ajax({
		url : $(this).attr("value"),
		type : "POST",
		data : formData,
		async : false,
		cache : false,
		contentType : false,
		processData : false,
		success : function(data) {
			$("#addEmpModel").on("hidden.bs.modal", function(e) {
				$("#listAllEmp").html(data);
			}).modal("hide");
		}
	});

	// $(".addSubmit").on( "click", function(event) {
	// disable the default form submission
	// $.ajax({
	// type:"POST",
	// url:$(this).attr("value"),
	// contentType:"multipart/form-data",
	// // processData:false,
	// data:creatQueryString($(this)),
	// dataType: "html",
	// //dataType:"json",
	// success:function (data){
	// alert("YAAA");
	// $("#listAllEmp").html(data);
	// //
	// $("#listAllEmp").load("employee/listAllEmp.jsp",function(){$.getScript("js/dashboard.js");});
	// },
	// error:function(){alert("error");}
	// })
});

$("#addEmpSubmit").click(function() {
	htmlobj = $.ajax({
		type : "post",
		url : "<%=request.getContextPath()%>/employee/employee.do",
		success : function(data, textStatus) {
			$("#emp").html(data);
			// complete: function(msg){
			// $("#emp").html(htmlobj.responseText);
			// //console.log(msg);
		},
		error : function() {
			alert("系統異常!");
		}
	});
});


// remove
$("#delEmpBtn").on("click", function(event) {
	$(".delSubmit").show();

});