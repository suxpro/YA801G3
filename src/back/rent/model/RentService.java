package back.rent.model;

import java.sql.Timestamp;
import java.util.List;

public class RentService {

	private RentDAO_interface dao;

	public RentService() {
		dao = new RentDAO();
	}

	// 預留給 Struts 2 用的
	public void onShelf_pass(String rent_no) {
		dao.update_pass(rent_no);
	}

	// 預留給 Struts 2 用的
	public void onShelf_fail(String rent_no, String cause) {
		dao.update_fail(rent_no, cause);
	}

//	public void deleteRent(String rent_no) {
//		dao.delete(rent_no);
//	}

	public RentVO getOneRent(String rent_no) {
		return dao.findByPrimaryKey(rent_no);
	}

	public List<RentVO> getAll() {
		return dao.getAll();
	}
}
