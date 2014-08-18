<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="front.rent.model.*"%>
<%@ page import="front.member.model.*"%>
<%@ page import="back.ord.model.*"%>
<%-- �U�νƦX�d��-�i�ѫȤ��select_page.jsp�H�N�W�����Q�d�ߪ���� --%>
<%-- �����u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��--%>

<html>
<head>
<title>�t�e��Ƭd�ߵ��G - showShipList.jsp</title>
</head>
<body bgcolor='white'>

<table border='1' bordercolor='#CCCCFF' align='center' width='70%'>
	<tr>
		<th>�����Ϥ�</th>
		<th>�q��s��</th>
		<th>�����W��</th>
		<th>�q�檬�A</th>
		<th>����覡</th>
		<th>����</th>
		<th>�ӯ��Ѽ�</th>
		<th>�O���Ѽ�</th>
		<th>�ӯ��|��</th>
		<th>�ӯ�����</th>
		<th>�ӯ��������e</th>
		<th>�X���|��</th>
		<th>�X������</th>
		<th>�X���������e</th>


	</tr>
	<c:forEach var="ordVO" items="${ordList}" varStatus="s">
		<%
			RentService rentSVC = new RentService();
				RentVO rentVO = rentSVC.getOneRent(((OrdVO) pageContext
						.getAttribute("ordVO")).getRent_no());
				pageContext.setAttribute("rentVO", rentVO);
				//�d�X�ӯ����p�����
				MemberService memberSVC = new MemberService();
				MemberVO tenVO = memberSVC.getOneMember(((OrdVO) pageContext
						.getAttribute("ordVO")).getTen_no());
				MemberVO tenVOxx = memberSVC.getOneMember(((OrdVO) pageContext
						.getAttribute("ordVO")).getLes_no());
				// 					pageContext.setAttribute("lesVO",lesVO);
		%>

		<tr align='center' valign='middle'>

			<td><img width="100" height="100"
				src="<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${ordVO.rent_no}&pic=pic1"></td>
			<td><a href="javascript:pressesA${s.index}()">${ordVO.ord_no    }</a></td>
			<td><a href="javascript:pressesB${s.index}()">${rentVO.rent_name}</a></td>
			<td>${ord_staMap[ordVO.ord_sta]}</td>
			<td>${tra_staMap[ordVO.tra_mode]}</td>
			<td>${ordVO.ten_date       }<br> ~ <br>
				${ordVO.exp_date       }
			</td>
			<td>${ordVO.ten_days       }��</td>
			<td>${ordVO.ot_days        }��</td>
			<td><a href="javascript:pressesC${s.index}()"><%=tenVO.getMname()%></a></td>
			<td>${ordVO.les_ases       }</td>
			<td>${ordVO.les_ases_ct    }</td>
			<td><a href="javascript:pressesD${s.index}()"><%=tenVOxx.getMname()%></a></td>
			<td>${ordVO.ten_ases       }</td>
			<td>${ordVO.ten_ases_ct    }</td>


		</tr>
		<script>
				//�W�s���ܸӭq�����
     			function pressesA${s.index}(){
    	 			document.open("<%=request.getContextPath()%>/front/ord/ord.do?ord_no=${ordVO.ord_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
     			}
				//�W�s���ܸӯ���
         		function pressesB${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/rent/rent.do?rent_no=${rentVO.rent_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
				//�W�s���ܸөӯ��H
         		function pressesC${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.ten_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
         		//�W�s���ܸӥX���H
         		function pressesD${s.index}(){
        	 		document.open("<%=request.getContextPath()%>/front/member/member.do?mno=${ordVO.les_no}&action=getOne_For_Display", "" ,"height=400,width=1000,left=65,top=157,resizable=yes,scrollbars=yes");
         		}
			</script>
	</c:forEach>
</table>

</body>
</html>
