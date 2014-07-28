package back.loc.model;

import java.util.*;

public interface LocDAO_interface {
          public void insert(LocVO locVO);
          public void update(LocVO locVO);
          public void delete(String loc_no);
          public LocVO findByPrimaryKey(String loc_no);
          public List<LocVO> getAll();
        //查詢某部門的員工(一對多)(回傳 Set)
	     // public Set<MemberVO> getMembersByLocno(String loc_no);
}