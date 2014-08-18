package back.ord.model;

import java.util.*;

import back.ord.model.OrdVO;

public interface OrdDAO_interface {
	   
	//給予欄位名稱(ten_no,les_no,rent_no,ord_no)回傳該該欄位的選項資料
//    public Set<String> getOrdNoSet(String field_name);
	
	//藉由複合查詢找尋符合的訂單
	public List<OrdVO> getAll(Map<String, String[]> map);
	
	//藉由輸入會員編號查詢所有可能的編號
//    public List<OrdVO> getAllOrdByMno(String mno);
}
