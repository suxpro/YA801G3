package front.ord.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class OrdService {

	private OrdDAO_interface dao;

	public OrdService() {
		dao = new OrdDAO();
	}

	public OrdVO addOrd(String rent_no, String ten_no, String ord_sta,
			String tra_mode, Integer freight, Date ten_date, Date exp_date,
			Integer ten_days, Integer rent_total, Integer ot_days,
			Integer init_dps, Integer real_dps, Integer tra_total,
			String loc_no, String rec_addr) {

// Ord		
//		public OrdVO addOrd(String rent_no, String ten_no, String ord_sta,
//				String tra_mode, Integer freight, Date ten_date, Date exp_date,
//				Integer ten_days, Integer rent_total, Integer ot_days,
//				Integer init_dps, Integer real_dps, Integer tra_total,
//				String loc_no, String rec_addr, Integer les_ases,
//				String les_ases_ct, Integer ten_ases, String ten_ases_ct,
//				Timestamp w_apr_time, Timestamp w_ship_time, Timestamp dtbt_time,
//				Timestamp rec_com_time, Timestamp rent_exp_time, Timestamp rt_time,
//				Timestamp rt_com_time, Timestamp cls_time, Timestamp cc_ord_time,
//				String ord_cc_cause) {		
		
		OrdVO ordVO = new OrdVO();

		ordVO.setRent_no(rent_no);
		ordVO.setTen_no(ten_no);
		ordVO.setOrd_sta(ord_sta);
		ordVO.setTra_mode(tra_mode);
		ordVO.setFreight(freight);
		ordVO.setTen_date(ten_date);
		ordVO.setExp_date(exp_date);
		ordVO.setTen_days(ten_days);
		ordVO.setRent_total(rent_total);
		ordVO.setOt_days(ot_days);
		ordVO.setInit_dps(init_dps);
		ordVO.setReal_dps(real_dps);
		ordVO.setTra_total(tra_total);
		ordVO.setLoc_no(loc_no);
		ordVO.setRec_addr(rec_addr);
		//ordVO.setLes_ases(les_ases);		
		//ordVO.setLes_ases_ct(les_ases_ct);
		//ordVO.setTen_ases(ten_ases);
		//ordVO.setTen_ases_ct(ten_ases_ct);
		//ordVO.setW_apr_time(w_apr_time);
		//ordVO.setW_ship_time(w_ship_time);
		//ordVO.setDtbt_time(dtbt_time);
		//ordVO.setRec_com_time(rec_com_time);
		//ordVO.setRent_exp_time(rent_exp_time);
		//ordVO.setRt_time(rt_time);
		//ordVO.setRt_com_time(rt_com_time);
		//ordVO.setCls_time(cls_time);
		//ordVO.setCc_ord_time(cc_ord_time);
		//ordVO.setOrd_cc_cause(ord_cc_cause);

		dao.insert(ordVO);

		return ordVO;
	}

	// �w�d�� Struts 2 �Ϊ�
	public void addOrd(OrdVO ordVO) {
		dao.insert(ordVO);
	}

	public OrdVO updateOrd(String ord_no, String rent_no, String ten_no,
			String ord_sta, String tra_mode, Integer freight, Date ten_date,
			Date exp_date, Integer ten_days, Integer rent_total,
			Integer ot_days, Integer init_dps, Integer real_dps,
			Integer tra_total, String loc_no, String rec_addr, 
			Integer les_ases, String les_ases_ct, Integer ten_ases,
			String ten_ases_ct, Timestamp w_apr_time, Timestamp w_ship_time,
			Timestamp dtbt_time, Timestamp rec_com_time,
			Timestamp rent_exp_time, Timestamp rt_time, Timestamp rt_com_time,
			Timestamp cls_time, Timestamp cc_ord_time, String ord_cc_cause) {

		OrdVO ordVO = new OrdVO();

		ordVO.setOrd_no(ord_no);
		ordVO.setRent_no(rent_no);
		ordVO.setTen_no(ten_no);
		ordVO.setOrd_sta(ord_sta);
		ordVO.setTra_mode(tra_mode);
		ordVO.setFreight(freight);
		ordVO.setTen_date(ten_date);
		ordVO.setExp_date(exp_date);
		ordVO.setTen_days(ten_days);
		ordVO.setRent_total(rent_total);
		ordVO.setOt_days(ot_days);
		ordVO.setInit_dps(init_dps);
		ordVO.setReal_dps(real_dps);
		ordVO.setTra_total(tra_total);
		ordVO.setLoc_no(loc_no);
		ordVO.setRec_addr(rec_addr);
		ordVO.setLes_ases(les_ases);
		ordVO.setLes_ases_ct(les_ases_ct);
		ordVO.setTen_ases(ten_ases);
		ordVO.setTen_ases_ct(ten_ases_ct);
		ordVO.setW_apr_time(w_apr_time);
		ordVO.setW_ship_time(w_ship_time);
		ordVO.setDtbt_time(dtbt_time);
		ordVO.setRec_com_time(rec_com_time);
		ordVO.setRent_exp_time(rent_exp_time);
		ordVO.setRt_time(rt_time);
		ordVO.setRt_com_time(rt_com_time);
		ordVO.setCls_time(cls_time);
		ordVO.setCc_ord_time(cc_ord_time);
		ordVO.setOrd_cc_cause(ord_cc_cause);

		dao.update(ordVO);

		return dao.findByPrimaryKey(ord_no);
	}

	// �w�d�� Struts 2 �Ϊ�
	public void updateOrd(OrdVO ordVO) {
		dao.update(ordVO);
	}

	public void deleteOrd(String ord_no, String ord_cc_cause) {
		dao.delete(ord_no,ord_cc_cause);
	}

	public OrdVO getOneOrd(String ord_no) {
		return dao.findByPrimaryKey(ord_no);
	}

	public List<OrdVO> getAll() {
		return dao.getAll();
	}
}
