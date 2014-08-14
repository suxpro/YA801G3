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
		alert("閱讀並同意會員條款才可進行註冊。");
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
	親愛的會員您好！ 歡迎您註冊成為本網站會員。為保障您的使用權益，請於註冊成為本網站會員之前，詳細閱覽以下規範內容。當您在線上點選「我接受」選項時，即表示您接受本網站提供之服務，並同意遵守以下所有規範內容。

一、服務提供

本網站係透過網際網路提供會員網路資訊服務。會員必須自行配備上網所需之各項電腦設備，以及負擔接上網際網路之費用及電話費用。
基於本網站所提供之各項服務，您同意於註冊時提供完整詳實之個人資料，您所登錄之資料如有變更，應隨時於線上更新。
您提供之個人資料若有填寫不實，或有任何誤導之嫌，本網站保留隨時終止您會員資格及使用各項服務之權利。

二、會員公約

同意於本網站所發表或傳輸的一切內容，應負所有法律責任。
承諾遵守中華民國相關法規及一切國際網際網路規定與慣例。
同意並保證不於本網站公布或傳送任何毀謗、不實、威脅、不雅、猥褻、不法、攻擊性、危害國家安全或侵害他人智慧財產權的文字、圖片或任何形式。
同意不於本網站從事廣告或販賣商品行為。
同意不於本網站討論私人事務，發表文章時，尊重他人的權益及隱私權。
同意遵守智慧財產權，不擅自重製、傳輸、改作、編輯或以其他任何形式、基於任何目的加以使用本網站提供之內容，否則應負所有法律責任。
本網站就會員的行為是否符合會員規範，有最終決定權。若本網站決定會員的行為違反本規範或任何法令，會員同意本網站得隨時停止帳號使用權或清除帳號，及停止使用本網站服務。會員違反法律規定之情事，應自負法律責任。
本網站不代表所有討論文章言論、連結、照片或檔案之立場或版權責任，會員所發表之任何言論、文章、連結、照片或檔案僅代表該作者(發表人)之立場；本網站可以在任何時間更改或刪除之。
會員若涉有不法者，除應由會員自負法律責任外，本網站將主動配合相關主管機關調查處理。

三、規範之修改

本網站保留隨時修改本規範之權利，修改規範時，將於本網站會員註冊首頁公告修改之內容，不另行個別通知。如果您不同意規範之修改內容，敬請自行取消會員註冊，否則即視為同意並接受本規範之增訂或修改內容。

四、服務之停止與更改

本網站保留隨時停止或更改各項服務內容或終止任一會員帳戶服務之權利，且無需事先通知會員。無論任何情形，就停止或更改服務或終止會員帳戶服務所可能產生之困擾、不便或損害，本網站對任何會員或第三人均不負任何責任。

於發生下列情形之一時，本網站有權停止或中斷提供服務；
* 對本網站之軟硬體系統進行必要之保養、施工或維護時；
* 發生突發性相關電子通信設備故障時；
* 由於天災等不可抗力之因素致使本網站無法提供服務時。
會員應瞭解並同意，本網站可能因相關單位軟硬體設備之故障或失靈、或人為操作上之疏失而全部或一部中斷、暫時無法使用、遲延、或造成資料傳輸或儲存上之錯誤、或遭第三人侵入系統篡改或偽造變造資料等，會員同意自負風險，不得因此而要求任何補償或賠償。
本網站得不待通知，隨時取消或停止會員之會員資格、或加以限制，會員不得因此要求補償或賠償。
本網站保留將來新增、修改或刪除本服務之全部或一部之權利，且不另行個別通知，會員不得因此而要求任何補償或賠償。
五、保管及通知義務

會員有義務妥善保管在本網站之帳號與密碼，並為此組帳號與密碼登入系統後所進行之一切活動負責。為維護會員自身權益，請勿將帳號與密碼洩露或提供予第三人知悉，或出借或轉讓他人使用。且每次連線完畢，應登出結束帳號使用，以避免帳號遭盜用或濫用。若會員發現帳號或密碼遭人非法使用或有任何異常破壞之情形時，應立即通知本網站。

六、個人資料

會員於本網站註冊之資料，將依照國家圖書館全球資訊網「隱私權政策」及「資訊安全政策」受到保護與規範。
會員所登錄或留存於本網站之個人資料，依據「個人資料保護法」第16條第5項規定，國家圖書館得以蒐集。會員同意本網站得於合理之範圍內蒐集、處理、保存、傳遞及使用該等資料，以提供使用者其他資訊或服務、或作成會員統計資料、或進行關於網路行為之調查或研究，或為任何之合法使用，或提供其他服務。
七、損害賠償

因會員違反相關法令或違背本服務條款之任一條款，致本網站或其他相關履行輔助人因此而受有損害或支出費用（包括且不限於因進行民事、刑事及行政程序所支出之律師費用）時，會員應負擔損害賠償責任或補償其費用。

八、準據法及管轄法院

本服務條款之解釋及適用，以及會員因使用本服務而與本網站間所產生之權利義務關係，應依中華民國法令解釋適用之。其因此所生之爭議，以台灣台北地方法院為第一審管轄法院。
九、附錄：個人資料保護法第16條

公務機關對個人資料之利用，除第六條第一項所規定資料外，應於執行法定職務必要範圍內為之，並與蒐集之特定目的相符。但有下列情形之一者，得為特定目的外之利用：
法律明文規定。
為維護國家安全或增進公共利益。
為免除當事人之生命、身體、自由或財產上之危險。
為防止他人權益之重大危害。
公務機關或學術研究機構基於公共利益為統計或學術研究而有必要，且資料經過提供者處理後或蒐集者依其揭露方式無從識別特定之當事人。
有利於當事人權益。
經當事人書面同意。
</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<input type="checkbox" id="Agree" /> <font color="#FF0000">
					我要加入會員並願意遵守以上所寫的條款。</font><br /> <br />
				<button type="button" class="btn btn-default" data-dismiss="modal">不同意</button>
				<button type="SUBMIT" class="btn btn-primary" onclick="return agree();">下一步</button>
			</div>
		</div>
	</form>

</BODY>
</html>
