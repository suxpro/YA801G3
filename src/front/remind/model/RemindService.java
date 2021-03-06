package front.remind.model;

import java.util.List;

public class RemindService {


	private RemindDAO_interface dao;

	public RemindService() {
		dao = new RemindDAO();
	}

	public RemindVO addRemind(String mno, String rtno, java.sql.Date rtime, String rstas, String rdes, String rflag) {
		// 新增
		RemindVO remindVO = new RemindVO();
		remindVO.setMno(mno);
		remindVO.setRtno(rtno);
		remindVO.setRtime(rtime);
		remindVO.setRstas(rstas);
		remindVO.setRdes(rdes);
		remindVO.setRflag(rflag);
		
		dao.insert(remindVO);

		return remindVO;
	}
	
	public RemindVO updateRemind(String rno , String mno, String rtno, java.sql.Date rtime, String rstas, String rdes, String rflag) {
		
		RemindVO remindVO = new RemindVO();
		remindVO.setRno(rno);
		remindVO.setMno(mno);
		remindVO.setRtno(rtno);
		remindVO.setRtime(rtime);
		remindVO.setRstas(rstas);
		remindVO.setRdes(rdes);
		remindVO.setRflag(rflag);
		
		dao.update(remindVO);

		return remindVO;
	}
	
	public void deleteRemind(String rno) {
		dao.delete(rno);
	}
	public RemindVO getOneRemind(String rno) {
		return dao.findByPrimaryKey(rno);
	}
	public List<RemindVO> getAll() {
		return dao.getAll();
	}
    //小豬加,AJAX查此會員的提醒狀態為N,動態更新提醒數字
    public List<RemindVO> ajaxGetMemRemind(String memNo, String getFlag) {
		return dao.ajaxGetMemRemind(memNo, getFlag);
    }
}
