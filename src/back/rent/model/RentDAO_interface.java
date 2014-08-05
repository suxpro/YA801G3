package back.rent.model;

import java.util.*;


public interface RentDAO_interface {

	      public void update_pass(String rent_no);
          public void update_fail(String rent_no);
          public RentVO findByPrimaryKey(String rent_no);
          public List<RentVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
  