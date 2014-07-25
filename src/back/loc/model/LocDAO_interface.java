package back.loc.model;

import java.util.*;

public interface LocDAO_interface {
          public void insert(LocVO locVO);
          public void update(LocVO locVO);
          public void delete(String loc_no);
          public LocVO findByPrimaryKey(String loc_no);
          public List<LocVO> getAll();
}