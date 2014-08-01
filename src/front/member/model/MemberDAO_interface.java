package front.member.model;

import java.util.*;

public interface MemberDAO_interface {
    public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void updateInfo(MemberVO memberVO);
    public void delete(String mno);
    public MemberVO findByPrimaryKey(String mno);
    public MemberVO findByAccount(String mid);
    public List<MemberVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}