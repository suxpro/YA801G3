package back.report.model;

import java.util.*;

public interface ReportDAO_interface {
    public void insert(ReportVO reportVO);
    public void update(ReportVO reportVO);
    public void delete(String rno);
    public ReportVO findByPrimaryKey(String rno);
    public List<ReportVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 


}
