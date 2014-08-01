package front.que.model;

import java.util.*;


public interface QueDAO_interface {
          public void insert(QueVO queVO);
          public void update(QueVO queVO);
          public void delete(String que_no);
          public QueVO findByPrimaryKey(String que_no);
          public List<QueVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
