package front.trade.model;

import java.util.*;
import java.sql.Connection;


public interface TradeDAO_interface {
    public void insert(TradeVO tradeVO);
    public void update(TradeVO tradeVO);
    public void delete(String tno);
    public TradeVO findByPrimaryKey(String tno);
    public List<TradeVO> getAll();
    
    //同時新增交易紀錄與升級會員
    public void insertWithVIP(TradeVO tradeVO , Connection con);
    //同時新增交易紀錄與會員儲值
    public void insertWithMoney(TradeVO tradeVO , Connection con);
    //訂單新增的扣款紀錄 by思賢
    public void insertForOrd(TradeVO tradeVO, Connection con);
    //GetOneMemberTrade
    public List<TradeVO> getOneMemberTrade(String mno);
}
