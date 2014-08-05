package back.competence.model;

import java.util.List;

public class CompetenceService {

	private CompetenceDAO_interface dao;

	public CompetenceService() {
		dao = new CompetenceDAO();
	}

	public CompetenceVO addCompetence(String emp_no, String func_no) {

		CompetenceVO competenceVO = new CompetenceVO();

		competenceVO.setEmp_no(emp_no);
		competenceVO.setFunc_no(func_no);
		dao.insert(competenceVO);

		return competenceVO;
	}

	//預留給 Struts 2 用的
	public void addCompetence(CompetenceVO competenceVO) {
		dao.insert(competenceVO);
	}
	
	public CompetenceVO updateCompetence(String emp_no, String func_no) {

		CompetenceVO competenceVO = new CompetenceVO();

		competenceVO.setEmp_no(emp_no);
		competenceVO.setFunc_no(func_no);
		dao.update(competenceVO);

		return dao.findByPrimaryKey(emp_no);
	}
	
	//預留給 Struts 2 用的
	public void updateCompetence(CompetenceVO competenceVO) {
		dao.update(competenceVO);
	}

	public void deleteCompetence(String emp_no, String func_no) {
		dao.delete(emp_no, func_no);
	}

	public CompetenceVO getOneCompetence(String emp_no) {
		return dao.findByPrimaryKey(emp_no);
	}

	public List<CompetenceVO> getAll() {
		return dao.getAll();
	}
}
