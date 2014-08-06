package front.trade.model;

import java.util.*;


public interface TradeDAO_interface {
    public void insert(TradeVO tradeVO);
    public void update(TradeVO tradeVO);
    public void delete(String tno);
    public TradeVO findByPrimaryKey(String tno);
    public List<TradeVO> getAll();
    
    //同時新增交易紀錄與升級會員
    public void insertWithVIP(TradeVO tradeVO , java.sql.Connection con);
}
