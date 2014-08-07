package front.remind.model;

import java.util.*;
import java.sql.Connection;

public interface RemindDAO_interface {
    public void insert(RemindVO remindVO);
    public void update(RemindVO remindVO);
    public void delete(String rno);
    public RemindVO findByPrimaryKey(String rno);
    public List<RemindVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 
    //新增一筆提醒記錄 for Ord using by思賢
    public void insertForOrd(RemindVO remindVO, Connection con);

}
