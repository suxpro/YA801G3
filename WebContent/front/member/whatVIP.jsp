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
	width: 540px;
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
�˷R���|���z�n�I�ɯŬ�VIP�����|�����S�v�p�U�G
		
 �@�B�����ϰӫ~ 
 1.�z�������|�P�@��|�����ҰϧO�A�N�|�֦��P�����P���ĪG�A���s�����������ȯన�W�����@�G�A�j�j���_�ӯ����N�@�C
 2.�z���������ǱN�|�u����@��|�����ƦC�覡�A�����ȯ�̥��s���z�������A�j�j�W�[�ӯ����N�@�C

�G�B�s�i����
 ��o�ӤH�����s�i���v�Q(�i�W�Ǧۤv�ӤH�����S�O�s�i)�A�é�m�b�����������W�������Ϥ����A�N�i�H�j�j�W�[�ۤv�������n���v�A�]�����ۤv���ӫ~�ɮ����H�L�H�`��A�åB�����ӯ����N�@�C


		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">�T�w</button>
			</div>
		</div>
	</form>

</BODY>
</html>
