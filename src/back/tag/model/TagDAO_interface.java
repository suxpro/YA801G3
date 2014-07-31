package back.tag.model;

import java.util.*;


public interface TagDAO_interface {
          public void insert(TagVO tagVO);
          public void update(TagVO tagVO);
          public void delete(String tag_no);
          public TagVO findByPrimaryKey(String tag_no);
          public List<TagVO> getAll();
          //public TagVO findTag(String tag_no);
          //萬用複合查詢(傳入參數型態Map)(回傳 List)
//        public List<TagVO> getAll(Map<String, String[]> map); 
}
