package back.competence.model;

import java.util.*;

import back.employee.model.*;

public interface CompetenceDAO_interface {
	      public void insert(CompetenceVO competenceVO);
          public void update(CompetenceVO competenceVO);
          //刪除此員工所擁有的所有權限
          public void delete(String emp_no);
          //刪除此員工所擁有的單一權限
          public void delete(String emp_no, String func_no);
          //複合主鍵查詢
          public CompetenceVO findByPrimaryKey(String emp_no);
	      public List<CompetenceVO> getAll();
}
