package front.prerent.model;

import java.util.*;

public interface PrentDAO_interface {
    public int insert(PrentVO prentVO);
    public int update(PrentVO prentVO);
    public int delete(String prent_no);
    public PrentVO findByPrimaryKey(String prent_no);
    public List<PrentVO> getAll();
}
