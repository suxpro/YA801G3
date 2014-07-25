package back.sosorder.model;

import java.sql.Timestamp;
import java.util.List;

public class SosorderService {

	private SosorderDAO_interface dao;

	public SosorderService() {
		dao = new SosorderDAO();
	}

	public SosorderVO addSosorder(String sos_mno, String sos_name,
			String sos_desc, Integer sos_pay, Integer sos_days, Timestamp sos_onsd,
			Timestamp sos_ofsd, byte[] sos_pic, String sos_format) {

		SosorderVO sosorderVO = new SosorderVO();

		sosorderVO.setSos_mno(sos_mno);
		sosorderVO.setSos_name(sos_name);
		sosorderVO.setSos_desc(sos_desc);
		sosorderVO.setSos_pay(sos_pay);
		sosorderVO.setSos_days(sos_days);
		sosorderVO.setSos_onsd(sos_onsd);
		sosorderVO.setSos_ofsd(sos_ofsd);
		sosorderVO.setSos_pic(sos_pic);
		sosorderVO.setSos_format(sos_format);
		dao.insert(sosorderVO);

		return sosorderVO;
	}

	//預留給 Struts 2 用的
	public void addSosorder(SosorderVO sosorderVO) {
		dao.insert(sosorderVO);
	}
	
	public SosorderVO updateSosorder(String sos_no, String sos_mno, String sos_name,
			String sos_desc, Integer sos_pay, Integer sos_days, Timestamp sos_onsd,
			Timestamp sos_ofsd, byte[] sos_pic, String sos_format) {

		SosorderVO sosorderVO = new SosorderVO();

		sosorderVO.setSos_no(sos_no);
		sosorderVO.setSos_mno(sos_mno);
		sosorderVO.setSos_name(sos_name);
		sosorderVO.setSos_desc(sos_desc);
		sosorderVO.setSos_pay(sos_pay);
		sosorderVO.setSos_days(sos_days);
		sosorderVO.setSos_onsd(sos_onsd);
		sosorderVO.setSos_ofsd(sos_ofsd);
		sosorderVO.setSos_pic(sos_pic);
		sosorderVO.setSos_format(sos_format);
		dao.update(sosorderVO);

		return dao.findByPrimaryKey(sos_no);
	}
	
	//預留給 Struts 2 用的
	public void updateSosorder(SosorderVO sosorderVO) {
		dao.update(sosorderVO);
	}

	public void deleteSosorder(String sosorder_no) {
		dao.delete(sosorder_no);
	}

	public SosorderVO getOneSosorder(String sosorder_no) {
		return dao.findByPrimaryKey(sosorder_no);
	}

	public List<SosorderVO> getAll() {
		return dao.getAll();
	}
}
