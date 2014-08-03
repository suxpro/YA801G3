<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%-- 此頁採用 JSTL 與 EL 取值 --%>
<%!static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");//定義返回的日期格式

	//去掉後帶.123時間的毫秒數方法
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
	//定義返回的日期格式
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Refresh" content="30">
<title>所有問題資料 - listAllQue.jsp</title>
</head>
<body bgcolor='white' align='center'>
	<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
	<table border='1' cellpadding='5' cellspacing='0' width='1200'
		align='center'>
		<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
			<td><h3>所有租物資料 - ListAllRent.jsp</h3> <a
				href="<%=request.getContextPath()%>/front/rent/select_page.jsp">
					<img
					src="<%=request.getContextPath()%>/front/rent/images/back1.gif"
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

	<table border='1' bordercolor='#CCCCFF' align='center'>
		<tr>
			<th>圖片</th>
			<th>租物名稱</th>
			<th>租物描述</th>
			<!-- 			<th width='100px'>租物狀態</th> -->
			<th>租物分類</th>
			<th>租物押金</th>
			<th>租物價格/天</th>
			<th>重整天數</th>
			<!-- 			<th>地區編號</th> -->
			<!-- 			<th>租物地址</th> -->
			<th>最後狀態時間</th>
			<th>最後上架時間</th>
			<th>最後修改時間</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="rentVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<c:set var="rentVO1" value="${rentVO}" scope="page" />
			<tr align='center' valign='middle'>
				<td><img width="100" height="100"
					src="rent.do?rent_no=${rentVO.rent_no}&pic=pic1"></td>
				<td>${rentVO.rent_name        }</td>
				<%-- 				<td width='100px'>${rentVO.rent_desc        }</td> --%>
				<td>${rent_staMap[rentVO.rent_sta]}</td>
				<td>${tag_staMap[rentVO.tag_no]}</td>
				<td>${rentVO.rent_dps         }元</td>
				<td>${rentVO.unit_price       }元</td>
				<td>${rentVO.reset_days       }天</td>
				<%-- 				<td>${loc_staMap[rentVO.loc_no]}</td> --%>
				<%-- 				<td>${rentVO.rent_addr        }</td> --%>
				<%--  				<td>${rentVO.last_sta_time}</td> --%>
				<%-- 				<td>${rentVO.last_onshelf_time}</td> --%>
				<%-- 				<td>${rentVO.last_mod_time    }</td> --%>
				<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO1")).getLast_sta_time())%></td>
				<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO1")).getLast_onshelf_time())%></td>
				<td><%=getTimestampString(((RentVO) pageContext
						.getAttribute("rentVO1")).getLast_mod_time())%></td>

				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
						<input type="submit" value="編輯"> <input type="hidden"
							name="rent_no" value="${rentVO.rent_no}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/front/rent/rent.do">
						<input type="submit" value="下架"> <input type="hidden"
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
