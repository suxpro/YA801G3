package back.loc.model;

import java.util.List;

public class LocService {
	private LocDAO_interface dao;

	public LocService() {
		dao = new LocDAO();
	}

	public LocVO addLoc(String loc_desc) {

		LocVO locVO = new LocVO();

		locVO.setLoc_desc(loc_desc);
		dao.insert(locVO);

		return locVO;
	}

	//預留給 Struts 2 用的
	public void addLoc(LocVO locVO) {
		dao.insert(locVO);
	}
	
	public LocVO updateLoc(String loc_no, String loc_desc) {

		LocVO locVO = new LocVO();

		locVO.setLoc_no(loc_no);
		locVO.setLoc_desc(loc_desc);
		dao.update(locVO);

		return dao.findByPrimaryKey(loc_no);
	}
	
	//預留給 Struts 2 用的
	public void updateLoc(LocVO locVO) {
		dao.update(locVO);
	}

	public void deleteLoc(String loc_no) {
		dao.delete(loc_no);
	}

	public LocVO getOneLoc(String loc_no) {
		return dao.findByPrimaryKey(loc_no);
	}

	public List<LocVO> getAll() {
		return dao.getAll();
	}
}
