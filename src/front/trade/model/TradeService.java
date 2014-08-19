package front.trade.model;

import java.util.*;

public class TradeService {


	private TradeDAO_interface dao;

	public TradeService() {
		dao = new TradeDAO();
	}

	public TradeVO addTrade(String mno, String tmid, String tstas, Double tfunds, String tin) {
		// 新增
		TradeVO tradeVO = new TradeVO();
		tradeVO.setMno(mno);
		tradeVO.setTmid(tmid);
//		tradeVO.setTdate(tdate);
		tradeVO.setTstas(tstas);
		tradeVO.setTfunds(tfunds);
		tradeVO.setTin(tin);
		dao.insert(tradeVO);

		return tradeVO;
	}
	
	public TradeVO updateTrade(String tno, String mno, String tmid, java.sql.Timestamp tdate, String tstas, Double tfunds, String tin) {
		
		TradeVO tradeVO = new TradeVO();
		
		tradeVO.setTno(tno);
		tradeVO.setMno(mno);
		tradeVO.setTmid(tmid);
		tradeVO.setTdate(tdate);
		tradeVO.setTstas(tstas);
		tradeVO.setTfunds(tfunds);
		tradeVO.setTin(tin);
		dao.update(tradeVO);

		return tradeVO;
	}
	
	public void deleteTrade(String tno) {
		dao.delete(tno);
	}
	public TradeVO getOneTrade(String tno) {
		return dao.findByPrimaryKey(tno);
	}
	public List<TradeVO> getAll() {
		return dao.getAll();
	}

	//getOneMemberTrade
	public List<TradeVO> getOneMemberTrade(String mno){
		return dao.getOneMemberTrade(mno);
	}
}
