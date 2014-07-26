package front.rent.model;

import java.sql.Timestamp;
import java.util.List;

public class RentService {

	private RentDAO_interface dao;

	public RentService() {
		dao = new RentDAO();
	}

	public RentVO addRent(String rent_name, String rent_desc, String les_no,
			String rent_sta, String tag_no, Integer rent_dps,
			Integer unit_price, Integer reset_days, String loc_no,
			String rent_addr, byte[] pic1, String pic1_format, byte[] pic2,
			String pic2_format, byte[] pic3, String pic3_format, byte[] pic4,
			String pic4_format, byte[] pic5, String pic5_format) {
		
//// all fields
		// public RentVO addRent(String rent_name, String rent_desc, String
		// les_no,
		// String rent_sta, String tag_no, Integer rent_dps,
		// Integer unit_price, Integer reset_days, String loc_no,
		// String rent_addr, String pop_flag, String prent_flag,
		// String report_flag, String offshelf_flag, Timestamp last_sta_time,
		// Timestamp last_onshelf_time, Timestamp last_mod_time, byte[] pic1,
		// String pic1_format, byte[] pic2, String pic2_format, byte[] pic3,
		// String pic3_format, byte[] pic4, String pic4_format, byte[] pic5,
		// String pic5_format) {

		RentVO rentVO = new RentVO();

		rentVO.setRent_name(rent_name);
		rentVO.setRent_desc(rent_desc);
		rentVO.setLes_no(les_no);
		rentVO.setRent_sta(rent_sta);
		rentVO.setTag_no(tag_no);
		rentVO.setRent_dps(rent_dps);
		rentVO.setUnit_price(unit_price);
		rentVO.setReset_days(reset_days);
		rentVO.setLoc_no(loc_no);
		rentVO.setRent_addr(rent_addr);
//		rentVO.setPop_flag(pop_flag);
//		rentVO.setPrent_flag(prent_flag);
//		rentVO.setReport_flag(report_flag);
//		rentVO.setOffshelf_flag(offshelf_flag);
//		rentVO.setLast_sta_time(last_sta_time);
//		rentVO.setLast_onshelf_time(last_onshelf_time);
//		rentVO.setLast_mod_time(last_mod_time);
		rentVO.setPic1(pic1);
		rentVO.setPic1_format(pic1_format);
		rentVO.setPic2(pic2);
		rentVO.setPic2_format(pic2_format);
		rentVO.setPic3(pic3);
		rentVO.setPic3_format(pic3_format);
		rentVO.setPic4(pic4);
		rentVO.setPic4_format(pic4_format);
		rentVO.setPic5(pic5);
		rentVO.setPic5_format(pic5_format);

		dao.insert(rentVO);

		return rentVO;
	}

	// �w�d�� Struts 2 �Ϊ�
	public void addRent(RentVO rentVO) {
		dao.insert(rentVO);
	}

	public RentVO updateRent(String rent_no, String rent_name, String rent_desc, String les_no,
			String rent_sta, String tag_no, Integer rent_dps,
			Integer unit_price, Integer reset_days, String loc_no,
			String rent_addr, byte[] pic1, String pic1_format, byte[] pic2,
			String pic2_format, byte[] pic3, String pic3_format, byte[] pic4,
			String pic4_format, byte[] pic5, String pic5_format) {

//all fileds		
//		public RentVO updateRent(String rent_no, String rent_name,
//				String rent_desc, String les_no, String rent_sta, String tag_no,
//				Integer rent_dps, Integer unit_price, Integer reset_days,
//				String loc_no, String rent_addr, String pop_flag,
//				String prent_flag, String report_flag, String offshelf_flag,
//				Timestamp last_sta_time, Timestamp last_onshelf_time,
//				Timestamp last_mod_time, byte[] pic1, String pic1_format,
//				byte[] pic2, String pic2_format, byte[] pic3, String pic3_format,
//				byte[] pic4, String pic4_format, byte[] pic5, String pic5_format) {
		
		
		RentVO rentVO = new RentVO();

		rentVO.setRent_no(rent_no);
		rentVO.setRent_name(rent_name);
		rentVO.setRent_desc(rent_desc);
		rentVO.setLes_no(les_no);
		rentVO.setRent_sta(rent_sta);
		rentVO.setTag_no(tag_no);
		rentVO.setRent_dps(rent_dps);
		rentVO.setUnit_price(unit_price);
		rentVO.setReset_days(reset_days);
		rentVO.setLoc_no(loc_no);
		rentVO.setRent_addr(rent_addr);
//		rentVO.setPop_flag(pop_flag);
		rentVO.setPop_flag("N");
//		rentVO.setPrent_flag(prent_flag);
		rentVO.setPrent_flag("N");
//		rentVO.setReport_flag(report_flag);
		rentVO.setReport_flag("N");
//		rentVO.setOffshelf_flag(offshelf_flag);
		rentVO.setOffshelf_flag("N");
//		rentVO.setLast_sta_time(last_sta_time);
//		rentVO.setLast_onshelf_time(last_onshelf_time);
//		rentVO.setLast_mod_time(last_mod_time);
		rentVO.setPic1(pic1);
		rentVO.setPic1_format(pic1_format);
		rentVO.setPic2(pic2);
		rentVO.setPic2_format(pic2_format);
		rentVO.setPic3(pic3);
		rentVO.setPic3_format(pic3_format);
		rentVO.setPic4(pic4);
		rentVO.setPic4_format(pic4_format);
		rentVO.setPic5(pic5);
		rentVO.setPic5_format(pic5_format);

		dao.update(rentVO);

		return dao.findByPrimaryKey(rent_no);
	}

	// �w�d�� Struts 2 �Ϊ�
	public void updateRent(RentVO rentVO) {
		dao.update(rentVO);
	}

	public void deleteRent(String rent_no) {
		dao.delete(rent_no);
	}

	public RentVO getOneRent(String rent_no) {
		return dao.findByPrimaryKey(rent_no);
	}

	public List<RentVO> getAll() {
		return dao.getAll();
	}
}
