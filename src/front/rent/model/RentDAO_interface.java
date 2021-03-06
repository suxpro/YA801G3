package front.rent.model;

import java.sql.Connection;
import java.util.*;


public interface RentDAO_interface {
          public void insert(RentVO rentVO);
          public void update(RentVO rentVO);
          public void updateRent_sta(RentVO rentVO, Connection con);
          public void delete(String rent_no);
          public RentVO findByPrimaryKey(String rent_no);
          //可找到已下架的租物資料
          public RentVO findByPrimaryKey2(String rent_no);
          public List<RentVO> getAllByMno (String mno);
          public List<RentVO> getAll();
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
          //小豬加,租物區只顯示待出租跟已出租
      	  public List<RentVO> getBodyRent();
}
  