package front.ord.model;

import java.util.*;

public interface OrdDAO_interface {
          public void insert(OrdVO ordVO);
          public void renew(OrdVO ordVO, Integer dif_price);
          
          public void update(OrdVO ordVO, String sta);
          public void updateAses(OrdVO ordVO, String role);
          
          public void delete(OrdVO ordVO, String role);
//          public void delete(String ord_no, String ord_cc_cause);
          
          public OrdVO findByPrimaryKey(String ord_no);
          public List<OrdVO> getAll();
          public String findLiveOrdByRentNo(String rent_no);
          public Set<String> findRenewOrdByRentNo(String rent_no);
          public List<OrdVO> getAllOrdByMember(String mno);
          
//          public void AllOrdByMember(OrdVO ordVO, String mno);
//          public OrdVO AllOrdByMember(String mno);
          
}
