package front.rent.model;

import java.util.*;


public interface RentDAO_interface {
          public void insert(RentVO rentVO);
          public void update(RentVO rentVO);
          public void delete(String rent_no);
          public RentVO findByPrimaryKey(String rent_no);
          public List<RentVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
