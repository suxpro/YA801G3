package front.ord.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class OrdService {

	private OrdDAO_interface dao;

	public OrdService() {
		dao = new OrdDAO();
	}

	public OrdVO addOrd(String rent_no, String les_no, String ten_no, String ord_sta,
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
		ordVO.setLes_no(les_no);
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
	
	public void addOrd(OrdVO ordVO) {
		dao.insert(ordVO);
	}
	//產生一筆續約訂單
	public void renew(OrdVO ordVO, Integer dif_price) {
		dao.renew(ordVO, dif_price);
	}
    //更改訂單狀態
	public void updateOrd(OrdVO ordVO, String sta) {
		dao.update(ordVO, sta);
	}
    //更改訂單狀態
	public void updateAses(OrdVO ordVO, String role) {
		dao.updateAses(ordVO, role);
	}
	//取消訂單
	public void deleteOrd(OrdVO ordVO, String role) {
		dao.delete(ordVO, role);
	}
    //取得單筆訂單紀錄
	public OrdVO getOneOrd(String ord_no) {
		return dao.findByPrimaryKey(ord_no);
	}
	//取得個人所有的訂單紀錄
	public List<OrdVO> getAll() {
		return dao.getAll();
	}
	
	//鈞彥,找出會員的所有歷史訂單
	public List<OrdVO> getAllOrdByMember(String mno) {
		return dao.getAllOrdByMember(mno);
	}
	
	//小豬加,找尋訂單資料是否該筆ord_no是否有人正在租
	public String hasLiveOrd(String rent_no) {
		return dao.findLiveOrdByRentNo(rent_no);
	}
	
	//取得會員的所出租產生的訂單或是所承租所產生的訂單
	public List<OrdVO> getAllByMno(String role, String mno) {
		return dao.getAllByMno(role, mno);
	}

}
