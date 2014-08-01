package front.ord.model;

import java.util.*;

public interface OrdDAO_interface {
          public void insert(OrdVO ordVO);
          public void update(OrdVO ordVO);
          public void delete(String ord_no, String ord_cc_cause);
          public OrdVO findByPrimaryKey(String ord_no);
          public List<OrdVO> getAll();
}
