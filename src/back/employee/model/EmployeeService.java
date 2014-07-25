package back.employee.model;

import java.util.List;
import java.sql.Date;

public class EmployeeService {

	private EmployeeDAO_interface dao;

	public EmployeeService() {
		dao = new EmployeeDAO();
	}

	public EmployeeVO addEmployee(String emp_id, String emp_pwd, String emp_name,
			String emp_sex, String emp_tel, String emp_cell, String emp_mail,
			String emp_addr, String emp_job, Integer emp_sal, Date emp_tod,
			Date emp_lod, String emp_ecp, String emp_ecell, byte[] emp_pic,
			String emp_format) {

		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmp_id(emp_id);
		employeeVO.setEmp_pwd(emp_pwd);
		employeeVO.setEmp_name(emp_name);
		employeeVO.setEmp_sex(emp_sex);
		employeeVO.setEmp_tel(emp_tel);
		employeeVO.setEmp_cell(emp_cell);
		employeeVO.setEmp_mail(emp_mail);
		employeeVO.setEmp_addr(emp_addr);
		employeeVO.setEmp_job(emp_job);
		employeeVO.setEmp_sal(emp_sal);
		employeeVO.setEmp_tod(emp_tod);
		employeeVO.setEmp_lod(emp_lod);
		employeeVO.setEmp_ecp(emp_ecp);
		employeeVO.setEmp_ecell(emp_ecell);
		employeeVO.setEmp_pic(emp_pic);
		employeeVO.setEmp_format(emp_format);
		dao.insert(employeeVO);

		return employeeVO;
	}

	//預留給 Struts 2 用的
	public void addEmployee(EmployeeVO employeeVO) {
		dao.insert(employeeVO);
	}
	
	public EmployeeVO updateEmployee(String emp_no, String emp_id, String emp_pwd,
			String emp_name, String emp_sex, String emp_tel, String emp_cell,
			String emp_mail, String emp_addr, String emp_job, Integer emp_sal,
			Date emp_tod, Date emp_lod, String emp_ecp, String emp_ecell,
			byte[] emp_pic, String emp_format) {

		EmployeeVO employeeVO = new EmployeeVO();

		employeeVO.setEmp_no(emp_no);
		employeeVO.setEmp_id(emp_id);
		employeeVO.setEmp_pwd(emp_pwd);
		employeeVO.setEmp_name(emp_name);
		employeeVO.setEmp_sex(emp_sex);
		employeeVO.setEmp_tel(emp_tel);
		employeeVO.setEmp_cell(emp_cell);
		employeeVO.setEmp_mail(emp_mail);
		employeeVO.setEmp_addr(emp_addr);
		employeeVO.setEmp_job(emp_job);
		employeeVO.setEmp_sal(emp_sal);
		employeeVO.setEmp_tod(emp_tod);
		employeeVO.setEmp_lod(emp_lod);
		employeeVO.setEmp_ecp(emp_ecp);
		employeeVO.setEmp_ecell(emp_ecell);
		employeeVO.setEmp_pic(emp_pic);
		employeeVO.setEmp_format(emp_format);
		dao.update(employeeVO);

		return dao.findByPrimaryKey(emp_no);
	}
	
	//預留給 Struts 2 用的
	public void updateEmp(EmployeeVO employeeVO) {
		dao.update(employeeVO);
	}

	public void deleteEmp(String emp_no) {
		dao.delete(emp_no);
	}

	public EmployeeVO getOneEmp(String emp_no) {
		return dao.findByPrimaryKey(emp_no);
	}

	public List<EmployeeVO> getAll() {
		return dao.getAll();
	}
}
