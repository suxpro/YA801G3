<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="back.ship.model.*"%>
<%@ page import="back.tag.model.*"%>
<%@ page import="back.loc.model.*"%>
<script>$.getScript("js/ship/ship.js");</script>
<script>
    //----日期處理-----------------------------------------------------------------------
    $(function() {
        $("#start_time").datepicker({
            dateFormat : 'yy-mm-dd',
            showOn : "button",
            buttonImage : "<%=request.getContextPath()%>/back/ship/images/calendar.gif",
            buttonImageOnly : true,
            numberOfMonths : 1,
            changeYear : true,
            changeMonth : true,})
        });
</script>
<!-- <html> -->
<!-- <head><title>IBM Emp: Home</title> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->


<h3>資料查詢:</h3>
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
    <form method="post" action="<%=request.getContextPath()%>/back/ship/ship.do" name="form1">
        <b><font color=blue>待配送資料查詢:</font></b> <br>
 
   <jsp:useBean id="tagSVC" scope="page" class="back.tag.model.TagService" />
  
       <b>選擇租物分類:</b>
       <select size="1" name="tag_no" >
          <option value="">
         <c:forEach var="tagVO" items="${tagSVC.all}" > 
          <option value="${tagVO.tag_no}">${tagVO.tag_desc}
         </c:forEach>   
       </select><br>
               
   <jsp:useBean id="locSVC" scope="page" class="back.loc.model.LocService" />
       <b>選擇取貨地區:</b>
       <select size="1" name="rec_loc" >
          <option value="">
         <c:forEach var="locVO" items="${locSVC.all}" > 
          <option value="${locVO.loc_no}">${locVO.loc_desc}
         </c:forEach>   
       </select><br>
       
       <b>選擇配送地區:</b>
       <select size="1" name="dest_loc"  value =" ">
          <option value="">
         <c:forEach var="locVO" items="${locSVC.all}" > 
          <option value="${locVO.loc_no}">${locVO.loc_desc}
         </c:forEach>   
       </select><br>
    
        <b>需求產生日:</b>
		<td><input type="TEXT" name="start_time" id="start_time" class="text" value="${shipVO.start_time}" readonly="readonly" /></td>
        <br>		        
        <input class="btnCallAjaxShip btn btn-primary" type="button" value="查詢">
        <input type="hidden" name="action" value="getShipList">
     </form>
  </li>
</ul>


<!-- </body> -->
<!-- </html> -->
