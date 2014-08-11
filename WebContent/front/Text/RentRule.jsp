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
預租、續租:
新方案:只要出租方在到期日前一天完成提出申請 完全取決於出租方的意願 系統除了檢查餘額之外不設限
2.
評價方式改為 優良(+2), 良(+1), 一般(0), 劣(-1)
3.
"租物的任何資訊被修改 都需要下架重新(上架審核)  審核不通過時 租物狀態改為""需複審"" 且提醒告知 不通過原因
一旦出租方再度修改完成 租物狀態又回到""待審核""時 後台將重新審核"
4.
評價300分轉成特級會員(VIP) 
5.
出租方可以直接下架商品(當租物狀態為待出租 待審核 需複審)
6.
如果出或承租方拒絕訂單 可加上拒絕原因給對方
7.
預租功能 為列入我的最愛 功能(觀察名單)
8.
"新增租物訂單時 可以讓承租人自由點選 起始日與到期日 但起始日要依照租物重整天數往後延期
一旦訂單結帳完成 轉送至出租方當下 就將租物狀態改為已出租
附: 重整天數 = (出貨/回收的緩衝時間)"
9.
平台手續費 會從租金抽取3%
10.
預期未還 一天扣10%押金 (但必須由出租方檢舉 才會依約扣款 否則不檢舉 依舊不算違約)

		</textarea>
		<div class="form-group">
			<div class="modal-footer">
				<button type="SUBMIT" class="btn btn-primary" data-dismiss="modal">確定</button>
			</div>
		</div>
	</form>

</BODY>
</html>
