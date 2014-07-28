package front.prerent.model;

import java.util.List;

public class PrentService {
	
	private PrentDAO_interface dao;
	
	public PrentService() {
		dao = new PrentDAO();
	}
	
	public PrentVO addPrent(String rent_no, String ten_no, java.sql.Date prent_time, Integer prent_days, String prent_flag, String ord_no) {
		// 新增
		PrentVO prentVO = new PrentVO();
		prentVO.setRent_no(rent_no);
		prentVO.setTen_no(ten_no);
		prentVO.setPrent_time(prent_time);
		prentVO.setPrent_days(prent_days);
		prentVO.setPrent_flag(prent_flag);
		prentVO.setOrd_no(ord_no);
		
		dao.insert(prentVO);

		return prentVO;
	}
	
	public PrentVO updatePrent(String prent_no, String rent_no, String ten_no, java.sql.Date prent_time, Integer prent_days, String prent_flag, String ord_no) {
		// 新增
		PrentVO prentVO = new PrentVO();
		prentVO.setPrent_no(prent_no);
		prentVO.setRent_no(rent_no);
		prentVO.setTen_no(ten_no);
		prentVO.setPrent_time(prent_time);
		prentVO.setPrent_days(prent_days);
		prentVO.setPrent_flag(prent_flag);
		prentVO.setOrd_no(ord_no);
		
		dao.update(prentVO);

		return prentVO;
	}
	
	public void deletePrent(String prent_no) {
		dao.delete(prent_no);
	}
	public PrentVO getOnePrent(String prent_no) {
		return dao.findByPrimaryKey(prent_no);
	}
	public List<PrentVO> getAll() {
		return dao.getAll();
	}

}
