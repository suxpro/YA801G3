package front.trade.model;

import java.util.*;

public interface TradeDAO_interface {
    public void insert(TradeVO tradeVO);
    public void update(TradeVO tradeVO);
    public void delete(String tno);
    public TradeVO findByPrimaryKey(String tno);
    public List<TradeVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 
}
