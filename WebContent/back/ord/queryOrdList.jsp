<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="back.ord.model.*"%>
<script>$.getScript("js/ord/ord.js");</script>
<script>
    //----日期處理-----------------------------------------------------------------------
    $(function() {
        $("#start_date").datepicker({
            dateFormat : 'yy-mm-dd',
            showOn : "button",
            buttonImage : "<%=request.getContextPath()%>/back/ship/images/calendar.gif",
            buttonImageOnly : true,
            numberOfMonths : 1,
            changeYear : true,
            changeMonth : true,
			onClose: function(selectedDate) {
				$("#end_date").datepicker("option", "minDate", selectedDate);
			}});

        $("#end_date").datepicker({
            dateFormat : 'yy-mm-dd',
            showOn : "button",
            buttonImage : "<%=request.getContextPath()%>/back/ship/images/calendar.gif",
            buttonImageOnly : true,
            numberOfMonths : 1,
            changeYear : true,
            changeMonth : true,				
            onClose: function(selectedDate) {
				$("#start_date").datepicker("option", "maxDate", selectedDate);
			}});
    });
</script>
<!-- <html> -->
<!-- <head> -->
<!-- <title>IBM Emp: Home</title> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->


<h3><b>訂單資料查詢:</b></h3>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
  <font color='red'>請修正以下錯誤:
  <ul>
  <c:forEach var="message" items="${errorMsgs}">
    <li>${message}</li>
  </c:forEach>
  </ul>
  </font>
</c:if>

<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
<ul>  
  <li>   
    <form method="post" action="<%=request.getContextPath()%>/back/ord/ord.do" name="form1">
<!--         <b><font color=blue>待配送資料查詢:</font></b>  -->
       <table>
       <tr>
       <td align="right"><b>	訂單編號:</b></td>
	   <td><input type="text" name="ord_no" value=" "></td>
       <td align="right"><b>	租物編號:</b></td>
	   <td><input type="text" name="rent_no" value=" "></td>
<!-- 	   </tr> -->
<!-- 	   <tr>          -->
       <td align="right"><b>	出租人編號:</b></td>
	   <td><input type="text" name="les_no" value=" "></td>
       <td align="right"><b>	承租人編號:</b></td>
	   <td><input type="text" name="ten_no" value=" "></td>
	   </tr>
	   <tr>    
       <td align="right"><b>	開始日期:</b></td>
	   <td><input type="text" name="start_date" id="start_date" class="text" value=" " readonly="readonly" /></td>
       <td align="right"><b>	結束日期:</b></td>
	   <td><input type="text" name="end_date" id="end_date" class="text" value=" " readonly="readonly" /></td>
<!-- 	   </tr> -->
<!-- 	   <tr>       -->
       <td align="right"><b>	訂單狀態:</b></td>
       <td><select size="1" name="ord_sta" >
          <option value="">
         <c:forEach var="ord_sta" items="${ord_staMap.keySet()}" > 
          <option value="${ord_sta}">${ord_staMap[ord_sta]}
         </c:forEach>   
       </select></td>
       <td align="right"><b>	結果排序:</b></td>
       <td><select size="1" name="orderBy" >
          <option value="normal">從先至後
          <option value="desc">從後至先
       </select></td>
       </tr> 
       </table>
        <br>
        <input class="btnCallAjaxOrd btn btn-primary" type="button" value="查詢">
<!--         <input class="btnCallAjaxShip btn btn-primary" type="submit" value="查詢"> -->
        <input type="hidden" name="action" value="getOrdList">
     </form>
  </li>
</ul>

<!-- 小豬加顯示result -->
<div id="ordListResult">
    <%@ include file="/back/ord/showOrdList.jsp"%>
</div>

<!-- </body> -->
<!-- </html> -->
