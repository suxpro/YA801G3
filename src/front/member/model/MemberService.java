package front.member.model;

import java.util.*;

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

}
