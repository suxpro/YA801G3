<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script>
function agree() {
	var Agree = document.getElementById("Agree");

	if (Agree.checked) {
		return true;
	} else {
		alert("�\Ū�æP�N�|�����ڤ~�i�i����U�C");
		return false;
	}
}
	$(document).ready(function() {		

	}); // end ready
</script>
<style>
#UserNote {
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
<%-- <link href="<%=request.getContextPath()%>/front/css/bootstrap.min.css" rel="stylesheet" media="screen"> --%>
<%-- <link href="<%=request.getContextPath()%>/front/css/justrent.css" rel="stylesheet"> --%>
<%-- <script src="<%=request.getContextPath()%>/front/js/jquery-1.7.2.min.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/front/js/bootstrap.min.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/front/js/jquery.easing.1.3.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/front/js/jquery.color.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/front/js/justrent.js"></script> --%>
</head>
<body>



	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">
	�˷R���|���z�n�I �w��z���U�����������|���C���O�ٱz���ϥ��v�q�A�Щ���U�����������|�����e�A�ԲӾ\���H�U�W�d���e�C��z�b�u�W�I��u�ڱ����v�ﶵ�ɡA�Y��ܱz�������������Ѥ��A�ȡA�æP�N��u�H�U�Ҧ��W�d���e�C

�@�B�A�ȴ���

�������Y�z�L���ں������ѷ|��������T�A�ȡC�|�������ۦ�t�ƤW���һݤ��U���q���]�ơA�H�έt�ᱵ�W���ں������O�Τιq�ܶO�ΡC
��󥻺����Ҵ��Ѥ��U���A�ȡA�z�P�N����U�ɴ��ѧ���Թꤧ�ӤH��ơA�z�ҵn������Ʀp���ܧ�A���H�ɩ�u�W��s�C
�z���Ѥ��ӤH��ƭY����g����A�Φ�����~�ɤ����A�������O�d�H�ɲפ�z�|�����ΨϥΦU���A�Ȥ��v�Q�C

�G�B�|������

�P�N�󥻺����ҵo��ζǿ骺�@�����e�A���t�Ҧ��k�߳d���C
�ӿտ�u���إ�������k�W�Τ@����ں��ں����W�w�P�D�ҡC
�P�N�ëO�Ҥ��󥻺��������ζǰe�������B����B�¯١B�����B�T���B���k�B�����ʡB�M�`��a�w���ΫI�`�L�H���z�]���v����r�B�Ϥ��Υ���Φ��C
�P�N���󥻺����q�Ƽs�i�γc��ӫ~�欰�C
�P�N���󥻺����Q�רp�H�ưȡA�o��峹�ɡA�L���L�H���v�q�����p�v�C
�P�N��u���z�]���v�A���զۭ��s�B�ǿ�B��@�B�s��ΥH��L����Φ��B������ت��[�H�ϥΥ��������Ѥ����e�A�_�h���t�Ҧ��k�߳d���C
�������N�|�����欰�O�_�ŦX�|���W�d�A���̲רM�w�v�C�Y�������M�w�|�����欰�H�ϥ��W�d�Υ���k�O�A�|���P�N�������o�H�ɰ���b���ϥ��v�βM���b���A�ΰ���ϥΥ������A�ȡC�|���H�Ϫk�߳W�w�����ơA���ۭt�k�߳d���C
���������N��Ҧ��Q�פ峹���סB�s���B�Ӥ����ɮפ��߳��Ϊ��v�d���A�|���ҵo�����󨥽סB�峹�B�s���B�Ӥ����ɮ׶ȥN��ӧ@��(�o��H)���߳��F�������i�H�b����ɶ����ΧR�����C
�|���Y�A�����k�̡A�����ѷ|���ۭt�k�߳d���~�A�������N�D�ʰt�X�����D�޾����լd�B�z�C

�T�B�W�d���ק�

�������O�d�H�ɭק糧�W�d���v�Q�A�ק�W�d�ɡA�N�󥻺����|�����U�������i�ק蠟���e�A���t��ӧO�q���C�p�G�z���P�N�W�d���ק鷺�e�A�q�Цۦ�����|�����U�A�_�h�Y�����P�N�ñ������W�d���W�q�έק鷺�e�C

�|�B�A�Ȥ�����P���

�������O�d�H�ɰ���Χ��U���A�Ȥ��e�βפ���@�|���b��A�Ȥ��v�Q�A�B�L�ݨƥ��q���|���C�L�ץ��󱡧ΡA�N����Χ��A�ȩβפ�|���b��A�ȩҥi�ಣ�ͤ��x�Z�B���K�ηl�`�A�����������|���βĤT�H�����t����d���C

��o�ͤU�C���Τ��@�ɡA���������v����Τ��_���ѪA�ȡF
* �糧�������n�w��t�ζi�楲�n���O�i�B�I�u�κ��@�ɡF
* �o�ͬ�o�ʬ����q�l�q�H�]�ƬG�ٮɡF
* �ѩ�Ѩa�����i�ܤO���]���P�ϥ������L�k���ѪA�ȮɡC
�|�����A�ѨæP�N�A�������i��]�������n�w��]�Ƥ��G�٩Υ��F�B�ΤH���ާ@�W�������ӥ����Τ@�����_�B�ȮɵL�k�ϥΡB�𩵡B�γy����ƶǿ���x�s�W�����~�B�ξD�ĤT�H�I�J�t�οy��ΰ��y�ܳy��Ƶ��A�|���P�N�ۭt���I�A���o�]���ӭn�D������v�ν��v�C
�������o���ݳq���A�H�ɨ����ΰ���|�����|�����B�Υ[�H����A�|�����o�]���n�D���v�ν��v�C
�������O�d�N�ӷs�W�B�ק�ΧR�����A�Ȥ������Τ@�����v�Q�A�B���t��ӧO�q���A�|�����o�]���ӭn�D������v�ν��v�C
���B�O�ޤγq���q��

�|�����q�ȧ����O�ަb���������b���P�K�X�A�ì����ձb���P�K�X�n�J�t�Ϋ�Ҷi�椧�@�����ʭt�d�C�����@�|���ۨ��v�q�A�ФűN�b���P�K�X���S�δ��Ѥ��ĤT�H���x�A�ΥX�ɩ������L�H�ϥΡC�B�C���s�u�����A���n�X�����b���ϥΡA�H�קK�b���D�s�Ω��ݥΡC�Y�|���o�{�b���αK�X�D�H�D�k�ϥΩΦ����󲧱`�}�a�����ήɡA���ߧY�q���������C

���B�ӤH���

�|���󥻺������U����ơA�N�̷Ӱ�a�Ϯ��]���y��T���u���p�v�F���v�Ρu��T�w���F���v����O�@�P�W�d�C
�|���ҵn���ίd�s�󥻺������ӤH��ơA�̾ڡu�ӤH��ƫO�@�k�v��16����5���W�w�A��a�Ϯ��]�o�H�`���C�|���P�N�������o��X�z���d�򤺻`���B�B�z�B�O�s�B�ǻ��Ψϥθӵ���ơA�H���ѨϥΪ̨�L��T�ΪA�ȡB�Χ@���|���έp��ơB�ζi����������欰���լd�ά�s�A�ά����󤧦X�k�ϥΡA�δ��Ѩ�L�A�ȡC
�C�B�l�`���v

�]�|���H�Ϭ����k�O�ιH�I���A�ȱ��ڤ����@���ڡA�P�������Ψ�L�����i�滲�U�H�]���Ө����l�`�Τ�X�O�Ρ]�]�A�B������]�i����ơB�D�ƤΦ�F�{�ǩҤ�X���߮v�O�Ρ^�ɡA�|�����t��l�`���v�d���θ��v��O�ΡC

�K�B�Ǿڪk�κ��Ҫk�|

���A�ȱ��ڤ������ξA�ΡA�H�η|���]�ϥΥ��A�ȦӻP���������Ҳ��ͤ��v�Q�q�����Y�A���̤��إ���k�O�����A�Τ��C��]���ҥͤ���ĳ�A�H�x�W�x�_�a��k�|���Ĥ@�f���Ҫk�|�C
�E�B�����G�ӤH��ƫO�@�k��16��

���Ⱦ�����ӤH��Ƥ��Q�ΡA���Ĥ����Ĥ@���ҳW�w��ƥ~�A�������k�w¾�ȥ��n�d�򤺬����A�ûP�`�����S�w�ت��۲šC�����U�C���Τ��@�̡A�o���S�w�ت��~���Q�ΡG
�k�ߩ���W�w�C
�����@��a�w���μW�i���@�Q�q�C
���K����ƤH���ͩR�B����B�ۥѩΰ]���W���M�I�C
������L�H�v�q�����j�M�`�C
���Ⱦ����ξǳN��s���c��󤽦@�Q�q���έp�ξǳN��s�Ӧ����n�A�B��Ƹg�L���Ѫ̳B�z��λ`���̨̨䴦�S�覡�L�q�ѧO�S�w����ƤH�C
���Q���ƤH�v�q�C
�g��ƤH�ѭ��P�N�C
</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<input type="checkbox" id="Agree" /> <font color="#FF0000">
					�ڭn�[�J�|�����@�N��u�H�W�Ҽg�����ڡC</font><br /> <br />
				<button type="button" class="btn btn-default" data-dismiss="modal">���P�N</button>
				<button type="SUBMIT" class="btn btn-primary" onclick="return agree();">�U�@�B</button>
			</div>
		</div>
	</form>

</BODY>
</html>
