<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="back.ord.model.*"%>
<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>配送資料查詢結果 - showShipList.jsp</title> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->

<table class="table table-hover" style="white-space: nowrap;">
	<tr class="info">
		<th style ="text-align:center">租物圖片</th>
		<th style ="text-align:center">訂單編號</th>
		<th style ="text-align:center">租物名稱</th>
		<th style ="text-align:center">訂單狀態</th>
		<th style ="text-align:center">交易方式</th>
		<th style ="text-align:center">租期</th>
		<th style ="text-align:center">承租天數</th>
		<th style ="text-align:center">逾期天數</th>
		<th style ="text-align:center">承租會員</th>
		<th style ="text-align:center">承租評價</th>
		<th style ="text-align:center">承租評價內容</th>
		<th style ="text-align:center">出租會員</th>
		<th style ="text-align:center">出租評價</th>
		<th style ="text-align:center">出租評價內容</th>


	</tr>
	<c:forEach var="ordVO" items="${ordList}" varStatus="s">
		<%
			RentService rentSVC = new RentService();
				RentVO rentVO = rentSVC.getOneRent(((OrdVO) pageContext
						.getAttribute("ordVO")).getRent_no());
				pageContext.setAttribute("rentVO", rentVO);
				//查出承租者聯絡資料
				MemberService memberSVC = new MemberService();
				MemberVO tenVO = memberSVC.getOneMember(((OrdVO) pageContext
						.getAttribute("ordVO")).getTen_no());
				MemberVO tenVOxx = memberSVC.getOneMember(((OrdVO) pageContext
						.getAttribute("ordVO")).getLes_no());
				// 					pageContext.setAttribute("lesVO",lesVO);
		%>

		<tr align='center' valign='middle'>

			<td style ="text-align:center"><img width="100" height="100"
				src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${ordVO.rent_no}&pic=pic1"></td>
			<td style ="text-align:center"><a href="javascript:pressesA${s.index}()">${ordVO.ord_no    }</a></td>
			<td style ="text-align:center"><a href="javascript:pressesB${s.index}()">${rentVO.rent_name}</a></td>
			<td style ="text-align:center">${ord_staMap[ordVO.ord_sta]}</td>
			<td style ="text-align:center">${tra_staMap[ordVO.tra_mode]}</td>
			<td style ="text-align:center">${ordVO.ten_date       }<br> ~ <br>
				${ordVO.exp_date       }
			</td>
			<td style ="text-align:center">${ordVO.ten_days       }天</td>
			<td style ="text-align:center">${ordVO.ot_days        }天</td>
			<td style ="text-align:center"><a href="javascript:pressesC${s.index}()"><%=tenVO.getMname()%></a></td>
			<td style ="text-align:center">${ordVO.les_ases       }</td>
			<td style ="text-align:center">${ordVO.les_ases_ct    }</td>
			<td style ="text-align:center"><a href="javascript:pressesD${s.index}()"><%=tenVOxx.getMname()%></a></td>
			<td style ="text-align:center">${ordVO.ten_ases       }</td>
			<td style ="text-align:center">${ordVO.ten_ases_ct    }</td>


		</tr>
		<script>
				//超連結至該訂單明細
     			function pressesA${s.index}(){
    	 			document.open("<%=request.getContextPath()%>/front/ord/ord.do?ord_no=${ordVO.ord_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
     			}
				//超連結至該租物
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
				//超連結至該承租人
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.ten_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
         		//超連結至該出租人
         		function pressesD${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
			</script>
	</c:forEach>
</table>

<!-- </body> -->
<!-- </html> -->
