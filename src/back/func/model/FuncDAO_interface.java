package back.func.model;

import java.util.*;

import back.competence.model.CompetenceVO;

public interface FuncDAO_interface {
	      public void insert(FuncVO funcVO);
          public void update(FuncVO funcVO);
          public void delete(String func_no);
          public FuncVO findByPrimaryKey(String func_no);
	      public List<FuncVO> getAll();
	      //查詢某權限的員工(一對多)(回傳 Set)
	      public Set<CompetenceVO> getCompetencesByFuncno(String func_no);

}
