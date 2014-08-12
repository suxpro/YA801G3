package front.member.model;

import java.util.*;

import front.trade.model.TradeVO;

public class MemberService {

	private MemberDAO_interface dao;

	public MemberService() {
		dao = new MemberDAO();
	}

	public MemberVO addMember(String mid, String mpwd, byte[] mpic,
			String mname, String msex, String mcell, String mmail,
			String locno, String madrs, String mlev, Double mbalance,
			Integer milligal, Integer massess, String mverification, String mpic_info, byte[] mvpic,
			String mvpic_info) {
		// 新增
		MemberVO memberVO = new MemberVO();

		memberVO.setMid(mid);
		memberVO.setMpwd(mpwd);
		memberVO.setMpic(mpic);
		memberVO.setMname(mname);
		memberVO.setMsex(msex);
		memberVO.setMcell(mcell);
		memberVO.setMmail(mmail);
		memberVO.setLocno(locno);
		memberVO.setMadrs(madrs);
		memberVO.setMlev(mlev);
		memberVO.setMbalance(mbalance);
		memberVO.setMillegal(milligal);
		memberVO.setMassess(massess);
		memberVO.setMverification(mverification);
//		memberVO.setMdate(mdate);
		memberVO.setMpic_info(mpic_info);
		memberVO.setMvpic(mvpic);
		memberVO.setMvpic_info(mvpic_info);
		dao.insert(memberVO);

		return memberVO;
	}
	
	public MemberVO updateMemInfo(String mno, String mpwd, byte[] mpic, String mname,
			String msex, String mcell, String mmail,String locno, String madrs, String mpic_info, byte[] mvpic, String mvpic_info){

		MemberVO memberVO = new MemberVO();		
		memberVO.setMno(mno);
//		memberVO.setMid(mid);
		memberVO.setMpwd(mpwd);
		memberVO.setMpic(mpic);
		memberVO.setMname(mname);
		memberVO.setMsex(msex);
		memberVO.setMcell(mcell);
		memberVO.setMmail(mmail);
		memberVO.setLocno(locno);
		memberVO.setMadrs(madrs);
		memberVO.setMpic_info(mpic_info);
		memberVO.setMvpic(mvpic);
		memberVO.setMvpic_info(mvpic_info);
		dao.updateInfo(memberVO);
				
		return memberVO;
	}

	
	public MemberVO storedMoney(String mno, Double mbalance , Double cash){

		MemberVO memberVO = dao.findByPrimaryKey(mno);
		
		memberVO.setMno(mno);
		memberVO.setMbalance(mbalance);
		
		List<TradeVO> VIPList = new ArrayList<TradeVO>(); // 準備置入員工數人
		TradeVO tradeVOxx = new TradeVO();   // 員工POJO1
		
		tradeVOxx.setMno(mno);
//		tradeVOxx.setTmid(tmid);
		tradeVOxx.setTstas("金錢匯入");
		tradeVOxx.setTfunds(cash);
//		tradeVOxx.setTin("Y");
		
		VIPList.add(tradeVOxx);
		
		dao.storedMoney(memberVO, VIPList);

		return memberVO;
	
	}
	
	public MemberVO updateVIP(String mno, String mlev, Double mbalance, Double vip ){
		MemberVO memberVO = new MemberVO();
		
		memberVO.setMno(mno);
		memberVO.setMlev(mlev);
		memberVO.setMbalance(mbalance);
		
		List<TradeVO> VIPList = new ArrayList<TradeVO>(); // 準備置入員工數人
		TradeVO tradeVOxx = new TradeVO();   // 員工POJO1
		tradeVOxx.setMno(mno);
//		tradeVOxx.setTmid("1596258445612365");
		tradeVOxx.setTstas("VIP點數支出");
		tradeVOxx.setTfunds(vip);
//		tradeVOxx.setTin("Y");
		
		VIPList.add(tradeVOxx);
		
		dao.updateVIP(memberVO , VIPList);

		return memberVO;
	}
	
	public MemberVO updateMember(String mno, String mid, String mpwd,
			byte[] mpic, String mname, String msex, String mcell, String mmail,
			String locno, String madrs, String mlev, Double mbalance,
			Integer milligal, Integer massess, String mverification,
			java.sql.Date mdate, String mpic_info, byte[] mvpic,
			String mvpic_info) {

		MemberVO memberVO = new MemberVO();

		memberVO.setMno(mno);
		memberVO.setMid(mid);
		memberVO.setMpwd(mpwd);
		memberVO.setMpic(mpic);
		memberVO.setMname(mname);
		memberVO.setMsex(msex);
		memberVO.setMcell(mcell);
		memberVO.setMmail(mmail);
		memberVO.setLocno(locno);
		memberVO.setMadrs(madrs);
		memberVO.setMlev(mlev);
		memberVO.setMbalance(mbalance);
		memberVO.setMillegal(milligal);
		memberVO.setMassess(massess);
		memberVO.setMverification(mverification);
		memberVO.setMdate(mdate);
		memberVO.setMpic_info(mpic_info);
		memberVO.setMvpic(mvpic);
		memberVO.setMvpic_info(mvpic_info);
		dao.update(memberVO);

		return memberVO;
	}

	public void deleteMember(String mno) {
		dao.delete(mno);
	}

	public MemberVO getOneMember(String mno) {
		return dao.findByPrimaryKey(mno);
	}

	public MemberVO getAccountMember(String mid) {
		return dao.findByAccount(mid);
	}

	public List<MemberVO> getAll() {
		return dao.getAll();
	}

    //會員停權 排程器 - by小豬
    public void updateTimer(MemberVO memberVO, String action) {
    	dao.updateTimer(memberVO, action);
    }
}
