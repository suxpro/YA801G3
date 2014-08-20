<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="back.ship.model.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%!//�w�q��^������榡
	static SimpleDateFormat dateformatAll = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");//�w�q��^������榡

	//�h���ɶ����@��Ƥ�k
	public static String getTimestampString(Timestamp ts) {
		if (ts != null)
			return dateformatAll.format(ts);//�榡�ƶǹL�Ӫ��ɶ��N�i�H�h���@���
		else
			return "";
	}%>
<%-- �U�νƦX�d��-�i�ѫȤ��select_page.jsp�H�N�W�����Q�d�ߪ���� --%>
<%-- �����u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��--%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>�t�e��Ƭd�ߵ��G - showShipList.jsp</title> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->

<table class="table table-hover">
	<tr class="info">
		<th style ="text-align:center">�q��s��</th>
		<th style ="text-align:center">�����s��</th>
		<th style ="text-align:center">�����W��</th>
		<th style ="text-align:center">��������</th>
		<th style ="text-align:center">���ݰt�e�ɶ�</th>
		<th style ="text-align:center">�ݥX�f�|��</th>
		<th style ="text-align:center">�|���q��</th>
		<th style ="text-align:center">���f�a�}</th>
		<th style ="text-align:center">�ݦ��f�|��</th>
		<th style ="text-align:center">�|���q��</th>
		<th style ="text-align:center">�e�f�a�}</th>
	</tr>
	<c:forEach var="shipVO" items="${shipList}">
								<%
								String start_time = getTimestampString(((ShipVO) pageContext.getAttribute("shipVO")).getStart_time());
												  String start_time_D = "";
												  String start_time_T = "";
												  if(start_time != ""){
													  start_time_D = start_time.substring(0, 10);
													  start_time_T = start_time.substring(11, 19);
												  }
												  
							%>
		<tr align='center' valign='middle'>
			<td style ="text-align:center">${shipVO.ord_no}</td>
			<td style ="text-align:center">${shipVO.rent_no}</td>
			<td style ="text-align:center">${shipVO.rent_name}</td>
			<td style ="text-align:center">${tag_staMap[shipVO.tag_no]}</td>
			<td style="text-align: center">
			<%=start_time_D%><br><%=start_time_T%></td>
			<td style ="text-align:center">${shipVO.rec_mem}</td>	
			<td style ="text-align:center">${shipVO.rec_cell}</td>
			<td style ="text-align:center">${shipVO.rec_addr}</td>
			<td style ="text-align:center">${shipVO.dest_mem}</td>
			<td style ="text-align:center">${shipVO.dest_cell}</td>
			<td style ="text-align:center">${shipVO.dest_addr}</td>		

		</tr>
	</c:forEach>
</table>

<!-- </body> -->
<!-- </html> -->
