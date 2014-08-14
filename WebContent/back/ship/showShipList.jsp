<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- �U�νƦX�d��-�i�ѫȤ��select_page.jsp�H�N�W�����Q�d�ߪ���� --%>
<%-- �����u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��--%>

<!-- <html> -->
<!-- <head> -->
<!-- <title>�t�e��Ƭd�ߵ��G - showShipList.jsp</title> -->
<!-- </head> -->
<!-- <body bgcolor='white'> -->

<table class="table table-hover">
	<tr>
		<th>�q��s��</th>
		<th>�����s��</th>
		<th>�����W��</th>
		<th>��������</th>
		<th>���ݰt�e�ɶ�</th>
		<th>�ݥX�f�|��</th>
		<th>�|���q��</th>
		<th>���f�a�}</th>
		<th>�ݦ��f�|��</th>
		<th>�|���q��</th>
		<th>�e�f�a�}</th>
	</tr>
	<c:forEach var="shipVO" items="${shipList}">
		<tr align='center' valign='middle'>
			<td>${shipVO.ord_no}</td>
			<td>${shipVO.rent_no}</td>
			<td>${shipVO.rent_name}</td>
			<td>${tag_staMap[shipVO.tag_no]}</td>
			<td>${shipVO.start_time}</td>
			<td>${shipVO.rec_mem}</td>	
			<td>${shipVO.rec_cell}</td>
			<td>${shipVO.rec_addr}</td>
			<td>${shipVO.dest_mem}</td>
			<td>${shipVO.dest_cell}</td>
			<td>${shipVO.dest_addr}</td>		

		</tr>
	</c:forEach>
</table>

<!-- </body> -->
<!-- </html> -->
