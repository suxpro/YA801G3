package back.employee.model;

import java.util.*;

public interface EmployeeDAO_interface {

	public void insert(EmployeeVO employeeVO);
    public void update(EmployeeVO employeeVO);
    public void delete(String emp_no);
    public EmployeeVO findByPrimaryKey(String emp_no);
    public EmployeeVO findPwdByEmpId(String emp_id);
    public List<EmployeeVO> getAll();
    public List<EmployeeVO> getAll(Map<String, String[]> map);
	
}
