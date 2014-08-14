<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<script>

</script>
<style>



<head>

</head>
<body>



	<form class="form-horizontal" role="form" METHOD=POST
		ACTION="<%=request.getContextPath()%>/front/member/addMember.jsp">

		<TEXTAREA id="UserNote">		
Q：使用JustRent!的好處
使用JustRent!有三大好處：
1.完整刊登您的出租物品資訊：租金、押金、租期隨你訂，還可上傳租借方式的說明黨或合約書，讓使用者一目了然，承租人可直接下標成立交易，從此不需要在另開賣場了做交易了。

2.交易流程圖設計讓您清楚掌握交易階段：
承租人的匯款通知、歸還通知和出租人的出貨通知、退回押金通知，都可透過租生活做更新，系統會直接幫您做記錄並通知對方，讓您輕鬆掌握交易步驟。
在租期到期前，系統還會發出到期通知，提醒承租人，讓租借物品像去圖書館借閱書籍一樣方便。

3.求租專區PO上需求徵求大家幫忙：臨時有意想不到的需求，目前沒人提供怎麼辦？可在求租專區PO上你的需求，不論是要徵求物品或是想找家教老師，透過求租專區讓徵求大家幫忙吧。

Q：如何加入JustRent!？
在首頁上方點擊註冊/登入加入JustRent!

1.	註冊新帳號，在您註冊完成後，系統會寄出帳號啟動通知信至您註冊的信箱，點選信件內的連結即成功加入。

Q：刊登和交易需要付費嗎？
不論您是商家還是個人，租生活提供的交易服務都是免費的，沒有刊登費和交易費用。


		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">確定</button>
			</div>
		</div>
	</form>

</BODY>
</html>
