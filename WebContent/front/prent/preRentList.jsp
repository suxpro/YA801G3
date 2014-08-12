<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.prerent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>
<%!
	//定義返回的日期格式
	static SimpleDateFormat dateformatAll = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//定義返回的日期格式

	//去掉時間的毫秒數方法
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//格式化傳過來的時間就可以去掉毫秒數
		else
			return "";
	}
%>
<%
	MemberVO memberVO = (MemberVO)session.getAttribute("memberVO");
	if (memberVO != null){
		String mno = memberVO.getMno(); 
	}
	
	PrentService prentSVC = new PrentService();
	List<PrentVO> prentList = prentSVC.getAll();
//	List<PrentVO> prentList = prentSVC.getAll(mno);
	RentService rentSVC = new RentService();
	//List<RentVO> list = rentSvc.getAll();
	//pageContext.setAttribute("list", list);
	MemberService memberSVC = new MemberService();
	int count=0;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Refresh" content="30;URL=<%=request.getContextPath()%>/front/prent/preRentList.jsp">
<title> 追蹤清單 - preRentList.jsp</title>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body bgcolor='white' align='center'>
	<table border='1' cellpadding='5' cellspacing='0' width='800' align='center'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>欲租清單 - preRentList.jsp</h3> 
			<a href="<%=request.getContextPath()%>/front/prent/preRentList.jsp">
				<img src="<%=request.getContextPath()%>/front/prent/images/back1.gif"
					width="100" height="32" border="0">回首頁
			</a></td>
		</tr>
	</table>

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

	<%-- 一般提示 --%>
 	<c:if test="${not empty alertMsgs}">
 		<script>alert("${alertMsgs.alert}");</script>
 	</c:if>

	<table border='1' bordercolor='#CCCCFF' align='center'>
		<tr align='center' valign='middle'>
			<th>租物圖片</th>
			<th>租物名稱</th>
			<th>出租者</th>
			<th>租物狀態</th>
			<th>租物押金</th>
			<th>租物價格/天</th>
			<th>出貨/回收緩衝</th>
			<th>地區</th>
<!-- 			<th>租物地址</th> -->
		</tr>

		<%@ include file="page1.file"%>
		<c:forEach var="rent_no" items="${prentList.rent_no}"  varStatus="s">
			<% 
		    	RentVO rentVO = rentSVC.getOneRent((String)pageContext.getAttribute("rent_no"));
				pageContext.setAttribute("rentVO",rentVO);
				
				MemberVO lesVO = memberSVC.getOneMember(rentVO.getLes_no());
				pageContext.setAttribute("lesVO",lesVO);
				count++;
			%>
	
			<tr align='center' valign='middle'>
				<td><img width="100" height="100" src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>		
                <td><a href="javascript:pressesA${s.index}()">${rentVO.rent_name}</a></td>
				<td><a href="javascript:pressesB${s.index}()">${lesVO.mname}</a></td>	
				<td>${rent_staMap[rentVO.rent_sta]}</td>		
				<td>${rentVO.rent_dps         }元</td>
				<td>${rentVO.unit_price       }元</td>
				<td>${rentVO.reset_days       }天</td>
				<td>${loc_staMap[rentVO.loc_no]}</td>
<%-- 				<td>${rentVO.rent_addr        }</td> --%>

<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
<%-- 						.getAttribute("rentVO")).getLast_sta_time())%></td> --%>
<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
<%-- 						.getAttribute("rentVO")).getLast_onshelf_time())%></td> --%>
<%-- 				<td><%=getTimestampString(((RentVO) pageContext --%>
<%-- 						.getAttribute("rentVO")).getLast_mod_time())%></td> --%>

				<td>
					<FORM method="post" action="<%=request.getContextPath()%>/front/ord/addOrd.jsp">
						<input type="submit" id="add_ord<%=count%>" value="前往結帳"> 
						<input type="hidden" name="rent_no" value="${rentVO.rent_no}"> 
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
					<script>
					var rent_sta = "${rentVO.rent_sta}";
					if(rent_sta == "W_RENT"){ 
						$("#add_ord<%=count%>").attr("disabled", false);							
					} else {
						$("#add_ord<%=count%>").attr("disabled", true); 
					}
					</script>
				</td>
				<td>
					<FORM method="post" action="<%=request.getContextPath()%>/front/cart/cart.do">
						<input type="submit" value="移除"> 
						<input type="hidden" name="del" value="${s.index}">
						<input type="hidden" name="action" value="delete">
					</FORM>
 
				</td>
			</tr>
			
			<script>
				//超連結至該租物
         		function pressesA${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
				//超連結至該出租人
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${rentVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
         		
        	</script>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
