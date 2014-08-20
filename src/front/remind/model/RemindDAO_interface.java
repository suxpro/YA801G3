package front.remind.model;

import java.util.*;
import java.sql.Connection;

public interface RemindDAO_interface {
    public void insert(RemindVO remindVO);
    public void update(RemindVO remindVO);
    public void delete(String rno);
    public RemindVO findByPrimaryKey(String rno);
    public List<RemindVO> getAll();
    //利用會員編號去取得所有提醒紀錄
    public List<RemindVO> getAllByMno(String mno);

    //新增一筆提醒記錄 for Ord using by思賢
    public void insertForOrd(RemindVO remindVO, Connection con);
    
    //小豬加,AJAX查此會員的提醒狀態為N,動態更新提醒數字
    public List<RemindVO> ajaxGetMemRemind(String memNo, String getFlag);

}
