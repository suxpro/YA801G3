<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script>

</script>
<style>
textarea {
	margin: 15px;
	width: 97%;
	height: 350px;
	overflow: auto;
	border: 0;
	font-size: 15px;
	line-height: 170%;
	font-family: Verdana, Arial, sans-serif;
}
</style>


<head>

</head>
<body>



	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">		
1.
�w���B��:
�s���:�u�n�X����b�����e�@�ѧ������X�ӽ� �������M��X���誺�N�@ �t�ΰ��F�ˬd�l�B���~���]��
2.
�����覡�אּ �u�}(+2), �}(+1), �@��(0), �H(-1)
3.
"�����������T�Q�ק� ���ݭn�U�[���s(�W�[�f��)  �f�֤��q�L�� �������A�אּ""�ݽƼf"" �B�����i�� ���q�L��]
�@���X����A�׭ק粒�� �������A�S�^��""�ݼf��""�� ��x�N���s�f��"
4.
����300���ন�S�ŷ|��(VIP) 
5.
�X����i�H�����U�[�ӫ~(�������A���ݥX�� �ݼf�� �ݽƼf)
6.
�p�G�X�Ωӯ���ڵ��q�� �i�[�W�ڵ���]�����
7.
�w���\�� ���C�J�ڪ��̷R �\��(�[��W��)
8.
"�s�W�����q��� �i�H���ӯ��H�ۥ��I�� �_�l��P����� ���_�l��n�̷ӯ�������ѼƩ��᩵��
�@���q�浲�b���� ��e�ܥX�����U �N�N�������A�אּ�w�X��
��: ����Ѽ� = (�X�f/�^�����w�Įɶ�)"
9.
���x����O �|�q�������3%
10.
�w������ �@�Ѧ�10%��� (�������ѥX�������| �~�|�̬����� �_�h�����| ���¤���H��)

		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">�T�w</button>
			</div>
		</div>
	</form>

</BODY>
</html>
