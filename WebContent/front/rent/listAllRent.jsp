<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>

<%
	RentService rentSvc = new RentService();
	List<RentVO> list = rentSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>所有問題資料 - listAllQue.jsp</title>
</head>
<body bgcolor='white'>
	<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='1800'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有租物資料 - ListAllRent.jsp</h3> 
			<a href="<%=request.getContextPath() %>/front/rent/select_page.jsp">
			<img src="<%=request.getContextPath() %>/front/rent/images/back1.gif" width="100" height="32" border="0">回首頁</a></td>
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

	<table border='1' bordercolor='#CCCCFF' width='1500'>
		<tr>
			<th>租物編號</th>
			<th>租物名稱</th>
			<th width='60px'>租物描述</th>
			<th>出租者</th>
			<th>租物狀態</th>
			<th>標籤編號</th>
			<th>租物押金</th>
			<th>租物價格/天</th>
			<th>重整天數</th>
			<th>地區編號</th>
			<th width='60px'>租物地址</th>
			<th>熱門租物Flag</th>
			<th>預租Flag</th>
			<th>檢舉Flag</th>
			<th>下架Flag</th>
			<th>最後狀態時間</th>
			<th>最後上架時間</th>
			<th>最後修改時間</th>
			<th>圖片1</th>
			<th>圖片1格式</th>
			<th>圖片2</th>
			<th>圖片2格式</th>
			<th>圖片3</th>
			<th>圖片3格式</th>
			<th>圖片4</th>
			<th>圖片4格式</th>
			<th>圖片5</th>
			<th>圖片5格式</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="rentVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr align='center' valign='middle'>
				<td>${rentVO.rent_no          }</td>
				<td>${rentVO.rent_name        }</td>
				<td width='60px'>${rentVO.rent_desc        }</td>
				<td>${rentVO.les_no           }</td>
				<td>${rentVO.rent_sta         }</td>
				<td>${rentVO.tag_no           }</td>
				<td>${rentVO.rent_dps         }</td>
				<td>${rentVO.unit_price       }</td>
				<td>${rentVO.reset_days       }</td>
				<td>${rentVO.loc_no           }</td>
				<td width='60px'>${rentVO.rent_addr        }</td>
				<td>${rentVO.pop_flag         }</td>
				<td>${rentVO.prent_flag       }</td>
				<td>${rentVO.report_flag      }</td>
				<td>${rentVO.offshelf_flag    }</td>
				<td>${rentVO.last_sta_time    }</td>
				<td>${rentVO.last_onshelf_time}</td>
				<td>${rentVO.last_mod_time    }</td>
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
				<td>${rentVO.pic1_format      }</td>
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic2"></td>
				<td>${rentVO.pic2_format      }</td>
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic3"></td>
				<td>${rentVO.pic3_format      }</td>
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic4"></td>
				<td>${rentVO.pic4_format      }</td>
				<td><img width="80" height="80" src="rent.do?rent_no=${rentVO.rent_no}&pic=pic5"></td>
				<td>${rentVO.pic5_format      }</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
						<input type="submit" value="修改"> <input type="hidden"
							name="rent_no" value="${rentVO.rent_no}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath() %>/front/rent/rent.do">
						<input type="submit" value="刪除"> <input type="hidden"
							name="rent_no" value="${rentVO.rent_no}"> <input
							type="hidden" name="action" value="delete">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>
