package back.ord.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;


public class OrdService {

	private OrdDAO_interface dao;

	public OrdService() {
		dao = new OrdDAO();
	}

	public List<OrdVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
//	public List<OrdVO> getAllByMno(String mno) {
//		return dao.getAllOrdByMno(mno);
//	}

}
