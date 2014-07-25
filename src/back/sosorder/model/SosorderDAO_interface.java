package back.sosorder.model;

import java.util.*;

public interface SosorderDAO_interface {

	public void insert(SosorderVO sosorderVO);
    public void update(SosorderVO sosorderVO);
    public void delete(String sos_no);
    public SosorderVO findByPrimaryKey(String sos_no);
    public List<SosorderVO> getAll();
    public List<SosorderVO> getAll(Map<String, String[]> map);
	
}
