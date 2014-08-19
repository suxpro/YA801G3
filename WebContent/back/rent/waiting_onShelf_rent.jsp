<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.rent.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>
<%!
    //定義返回的日期格式
    static SimpleDateFormat dateformatAll = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    //去掉時間的毫秒數方法
    public static String getTimestampString(Timestamp ts) {
        if (ts != null)
            return dateformatAll.format(ts);//格式化傳過來的時間就可以去掉毫秒數
        else
            return "";
    }
%>
<%
    RentService rentSvc = new RentService();
    List<RentVO> list = rentSvc.getAll();
    pageContext.setAttribute("list", list);
    int count = 0;
%>
<script>$.getScript("js/rent/rent.js");</script>

<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!-- <html> -->
<!-- <head> -->
<%-- <meta http-equiv="Refresh" content="30;URL=<%=request.getContextPath()%>/back/rent/waiting_onShelf_rent.jsp"> --%>
<!-- <title>租物上架審核 - waiting_onShelf_rent</title> -->
<!-- <link rel="stylesheet" -->
<!--    href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> -->
<!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script> -->
<!-- <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script> -->
<!-- </head> -->
<!-- <body bgcolor='white' align='center'> -->
<!--    <b><font color=red>此頁練習採用 EL 的寫法取值:</font></b> -->
<!--    <table border='1' cellpadding='5' cellspacing='0' width='1200' -->
<!--        align='center'> -->
<!--        <tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'> -->
<!--            <td><h3>待上架租物資料 - waiting_onShelf_rent.jsp</h3> <a -->
<%--                href="<%=request.getContextPath()%>/back/rent/waiting_onShelf_rent.jsp"> --%>
<!--                    <img -->
<%--                    src="<%=request.getContextPath()%>/back/rent/images/back1.gif" --%>
<!--                    width="100" height="32" border="0">沒地方回去 -->
<!--            </a></td> -->
<!--        </tr> -->
<!--    </table> -->

    <%-- 錯誤表列 --%>
    <c:if test="${not empty errorMsgs}">
        <font color='red'>請修正以下錯誤:
            <ul>
                <c:forEach var="message" items="${errorMsgs}">
                    <li>${message.value}</li>
                </c:forEach>
            </ul>
        </font>
    </c:if>

        <div class="table-responsive">
            <table id="listAllEmpTable" class="table table-hover"
                style="white-space: nowrap;">
        <tr align='center' valign='middle' class="info">
            <th>圖片</th>
            <th>租物編號</th>
            <th>出租人編號</th>
            <th>租物名稱</th>
            <th>租物分類</th>
            <th>租物押金</th>
            <th>租物價格/天</th>
<!--             <th>出貨/回收緩衝</th> -->
            <th>最後狀態時間</th>
            <th>最後上架時間</th>
            <th>最後修改時間</th>
        </tr>
        <%@ include file="page1.file"%>
        <c:forEach var="rentVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="s">

        <%
         	count++;
			String last_sta_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_sta_time());
			String last_sta_time_D = "";
			String last_sta_time_T = "";
			if(last_sta_time != ""){
				last_sta_time_D = last_sta_time.substring(0, 10);
				last_sta_time_T = last_sta_time.substring(11, 19);
			}
							  
			String last_onshelf_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_onshelf_time());
			String last_onshelf_time_D = "";
			String last_onshelf_time_T = "";
			if(last_onshelf_time != ""){
				last_onshelf_time_D = last_onshelf_time.substring(0, 10);
				last_onshelf_time_T = last_onshelf_time.substring(11, 19);
			}
							  
			String last_mod_time = getTimestampString(((RentVO) pageContext.getAttribute("rentVO")).getLast_mod_time());
			String last_mod_time_D = "";
			String last_mod_time_T = "";
			if(last_mod_time != ""){
				last_mod_time_D = last_mod_time.substring(0, 10);
				last_mod_time_T = last_mod_time.substring(11, 19);
			}
		%>
            <tr align='center' valign='middle'>
                <td><img width="100" height="100" src="<%=request.getContextPath()%>/back/rent/rent.do?rent_no=${rentVO.rent_no}&pic=pic1&action=getImg"></td>
                <td><a href="javascript:presses${s.index}()">${rentVO.rent_no}</a></td>
                <td><a href="javascript:presses2${s.index}()">${rentVO.les_no}</a></td>
                <td>${rentVO.rent_name}</td>
                <td>${tag_staMap[rentVO.tag_no]}</td>
                <td>${rentVO.rent_dps}元</td>
                <td>${rentVO.unit_price}元</td>
<%--                 <td>${rentVO.reset_days}天</td> --%>
<%--                 <td><%=getTimestampString(((RentVO) pageContext --%>
<%--                         .getAttribute("rentVO")).getLast_sta_time())%></td> --%>
<%--                 <td><%=getTimestampString(((RentVO) pageContext --%>
<%--                         .getAttribute("rentVO")).getLast_onshelf_time())%></td> --%>
<%--                 <td><%=getTimestampString(((RentVO) pageContext --%>
<%--                         .getAttribute("rentVO")).getLast_mod_time())%></td> --%>
				<td><%=last_sta_time_D %><br>
					<%=last_sta_time_T %></td>
				<td><%=last_onshelf_time_D %><br>
					<%=last_onshelf_time_T %></td>
				<td><%=last_mod_time_D %><br>
					<%=last_mod_time_T %></td>                        
                <td>
                    <button id="pass_rent<%=count%>" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
                        role="button" aria-disabled="false">
                        <span>通過</span>
                    </button>
                    <form method="post" action="<%=request.getContextPath()%>/back/rent/rent.do">
                        <input type="hidden" name="rent_no" value="${rentVO.rent_no}"> 
                        <input type="hidden" name="action" value="pass">
                        <input class="btnCallAjaxRent" type="button" id="pass<%=count%>" value="通過"> 
                    </form>
                </td>                           
                <td>
                    <button id="fail_rent<%=count%>">不通過</button>
                    <div id="dialog-form<%=count%>" title="不通過的原因">
                        <p>請輸入不通過的原因.</p>
                        <form method="post" action="<%=request.getContextPath()%>/back/rent/rent.do">
                            <input type="hidden" name="rent_no" value="${rentVO.rent_no}"> 
                            <input type="hidden" name="action" value="fail">
                            <textarea name="cause" rows="4" cols="35" maxlength="100"></textarea>
                            <input class="btnCallAjaxRent" type="button" id="fail<%=count%>" value="不通過">
                        </form>
                    </div> 
                </td>
                    <script>
                        // 設定dialog
                        $("#dialog-form<%=count%>").dialog({
                        autoOpen : false,
                        height : 300,
                        width : 400,
                        modal : true,
                        closeOnEscpe : true,
                        buttons : {
                                    送出 : function() {
                                        $("#fail<%=count%>").click();
                                        },
                                    返回 : function() {
                                        $("#dialog-form<%=count%>").dialog("close");
                                        }
                                    },
                        close : function() {
                            $("#dialog-form<%=count%>").dialog("close");
                            }
                        });
                        $("#fail<%=count%>").hide();
                        // fail_rent button click() 啟用 dialog
                        $("#fail_rent<%=count%>").button().on("click", function() {
                            $("#dialog-form<%=count%>").dialog("open");
                            $("#dialog-form<%=count%>").find("[type=submit]").hide();});
                        
                        // 隱藏 submit button
                        $("#pass<%=count%>").hide();
                        // pass_rent button click() 啟用 submit
                        $("#pass_rent<%=count%>").button().on("click", function() {
                            $("#pass<%=count%>").click();});
                    </script>
            </tr>
            
            <script>
                //超連結至該租物
                function presses${s.index}(){
                    document.open("<%=request.getContextPath()%>/back/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=500,width=500,left=65,top=60,resizable=yes,scrollbars=yes");
                }
                //超連結至該出租人
                function presses2${s.index}(){
                    document.open("<%=request.getContextPath()%>/back/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
                }
                
            </script>
            
        </c:forEach>
    </table>
    </div>
    <%@ include file="page2.file"%>

<!-- </body> -->
<!-- </html> -->
