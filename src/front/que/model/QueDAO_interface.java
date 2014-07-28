package front.que.model;

import java.util.*;


public interface QueDAO_interface {
          public void insert(QueVO queVO);
          public void update(QueVO queVO);
          public void delete(String que_no);
          public QueVO findByPrimaryKey(String que_no);
          public List<QueVO> getAll();
          //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
