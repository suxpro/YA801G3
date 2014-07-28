package back.report.model;

import java.util.List;

public class ReportService {

	private ReportDAO_interface dao;

	public ReportService() {
		dao = new ReportDAO();
	}

	public ReportVO addReport(String rm_p, String rr_no,
			String rm_byp, java.sql.Date rtime, String rcuz, String re_chk,
			String rsol, java.sql.Date rsolt, String rsold) {
		// 新增
		ReportVO reportVO = new ReportVO();
	
		reportVO.setRm_p(rm_p);
		reportVO.setRr_no(rr_no);
		reportVO.setRm_byp(rm_byp);
		reportVO.setRtime(rtime);
		reportVO.setRcuz(rcuz);
		reportVO.setRe_chk(re_chk);
		reportVO.setRsol(rsol);
		reportVO.setRsolt(rsolt);
		reportVO.setRsold(rsold);
		dao.insert(reportVO);

		return reportVO;
	}

	public ReportVO updateReport(String rno, String rm_p, String rr_no,
			String rm_byp, java.sql.Date rtime, String rcuz, String re_chk,
			String rsol, java.sql.Date rsolt, String rsold) {

		ReportVO reportVO = new ReportVO();
		reportVO.setRno(rno);
		reportVO.setRm_p(rm_p);
		reportVO.setRr_no(rr_no);
		reportVO.setRm_byp(rm_byp);
		reportVO.setRtime(rtime);
		reportVO.setRcuz(rcuz);
		reportVO.setRe_chk(re_chk);
		reportVO.setRsol(rsol);
		reportVO.setRsolt(rsolt);
		reportVO.setRsold(rsold);

		dao.update(reportVO);

		return reportVO;
	}

	public void deleteReport(String rno) {
		dao.delete(rno);
	}

	public ReportVO getOneReport(String rno) {
		return dao.findByPrimaryKey(rno);
	}

	public List<ReportVO> getAll() {
		return dao.getAll();
	}

}
