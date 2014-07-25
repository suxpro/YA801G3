package back.func.model;

import java.util.List;

public class FuncService {

	private FuncDAO_interface dao;

	public FuncService() {
		dao = new FuncDAO();
	}

	public FuncVO addFunc(String func_desc) {

		FuncVO funcVO = new FuncVO();

		funcVO.setFunc_desc(func_desc);
		dao.insert(funcVO);

		return funcVO;
	}

	//預留給 Struts 2 用的
	public void addFunc(FuncVO FuncVO) {
		dao.insert(FuncVO);
	}
	
	public FuncVO updateFunc(String func_no, String func_desc) {

		FuncVO funcVO = new FuncVO();

		funcVO.setFunc_no(func_no);
		funcVO.setFunc_desc(func_desc);
		dao.update(funcVO);

		return dao.findByPrimaryKey(func_no);
	}
	
	//預留給 Struts 2 用的
	public void updateFunc(FuncVO funcVO) {
		dao.update(funcVO);
	}

	public void deleteFunc(String func_no) {
		dao.delete(func_no);
	}

	public FuncVO getOneFunc(String func_no) {
		return dao.findByPrimaryKey(func_no);
	}

	public List<FuncVO> getAll() {
		return dao.getAll();
	}
}
