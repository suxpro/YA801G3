package front.rent.model;

import java.sql.Connection;
import java.util.*;


public interface RentDAO_interface {
          public void insert(RentVO rentVO);
          public void update(RentVO rentVO);
          public void updateRent_sta(RentVO rentVO, Connection con);
          public void delete(String rent_no);
          public RentVO findByPrimaryKey(String rent_no);
          public List<RentVO> getAllByMno (String mno);
          public List<RentVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
  