$(document).ready(function() {
	$(".manage").click(function() {
		switch($(this).attr("rel")) {
			case "employee":
				$("#indexMain").load("employee/indexEmp.jsp",function(){$.getScript("js/dashboard.js");});
				break;
			case "member":
				$("#indexMain").load("employee/listAllEmp.jsp",function(){$.getScript("js/dashboard.js");});
				break;
			case "rent":
				$("#indexMain").load("employee/indexEmp.jsp",function(){$.getScript("js/dashboard.js");});
				break;
			case "trade":
				$("#indexMain").load("employee/listAllEmp.jsp",function(){$.getScript("js/dashboard.js");});
				break;
			default:
				alert("選擇管理error!");
				break;
		}
		
        //$(#indexMain).html("<%@ include file=\"/employee/listAllEmp.jsp\"%>");
    });
	
    $("#toggle").click(function() {
        $("#emp").toggle(1000);
    });

    $("#addEmpSubmit").click(function(){
        htmlobj=$.ajax({
        	type:"post",
        	url: "<%=request.getContextPath()%>/employee/employee.do",
        	success:function(data,textStatus){
        	    $("#emp").html(data);
//        	complete: function(msg){
//        		$("#emp").html(htmlobj.responseText);
//        		//console.log(msg);
        	},
        	error:function(){
        		alert("系統異常!");
        	}
        });
    });
    
    $("table td").click(function(){
    	if(!$(this).is('.input')){    
            $(this).addClass('input').html('<input type="text" value="'+ $(this).text() +'" />').find('input').focus().blur(function(){    
//                var thisid = $(this).parent().siblings("td:eq(0)").text();    
//                var thisvalue=$(this).val();    
//                var thisclass = $(this).parent().attr("class");
//                alert(thisid+" "+thisvalue+" "+thisclass);
//                $.ajax({    
//                    type: 'POST',    
//                    url: 'update.php',    
//                    data: "thisid="+thisid+"&thisclass="+thisclass+"&thisvalue="+thisvalue    
//                  });    
                  $(this).parent().removeClass('input').html($(this).val() || "");    
            });
    	}
    });
    
    
});