package front.prerent.model;

import java.util.*;

public interface PrentDAO_interface {
    public void insert(PrentVO prentVO);
    public void update(PrentVO prentVO);
    public void delete(String prent_no);
    public PrentVO findByPrimaryKey(String prent_no);
    public List<PrentVO> getAll(String mno);
}
