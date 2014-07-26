package front.que.model;

import java.sql.Timestamp;
import java.util.List;

public class QueService {

	private QueDAO_interface dao;

	public QueService() {
		dao = new QueDAO();
	}

	public QueVO addQue(String rent_no, String que_mem,
			String que_sta, Timestamp que_time, String que_desc) {
		
//		public QueVO addQue(String rent_no, String que_mem,
//				String que_sta, Timestamp que_time, String que_desc,
//				Timestamp ans_time, String ans_desc) {

		QueVO queVO = new QueVO();

		queVO.setRent_no(rent_no);
		queVO.setQue_mem(que_mem);
		queVO.setQue_sta(que_sta);
		queVO.setQue_time(que_time);
		queVO.setQue_desc(que_desc);
		//queVO.setAns_time(ans_time);
		//queVO.setAns_desc(ans_desc);

		dao.insert(queVO);

		return queVO;
	}

	public void addQue(QueVO queVO) {
		dao.insert(queVO);
	}

	public QueVO updateQue(String que_no, String rent_no, String que_mem,
			String que_sta, Timestamp que_time, String que_desc,
			Timestamp ans_time, String ans_desc) {

		QueVO queVO = new QueVO();

		queVO.setQue_no (que_no);
		queVO.setRent_no(rent_no);
		queVO.setQue_mem(que_mem);
		queVO.setQue_sta(que_sta);
		queVO.setQue_time(que_time);
		queVO.setQue_desc(que_desc);
		queVO.setAns_time(ans_time);
		queVO.setAns_desc(ans_desc);
		
		dao.update(queVO);

		return dao.findByPrimaryKey(que_no);
	}

	public void updateQue(QueVO queVO) {
		dao.update(queVO);
	}

	public void deleteQue(String que_no) {
		dao.delete(que_no);
	}

	public QueVO getOneQue(String que_no) {
		return dao.findByPrimaryKey(que_no);
	}

	public List<QueVO> getAll() {
		return dao.getAll();
	}
}
