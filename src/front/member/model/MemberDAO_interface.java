package front.member.model;

import java.util.*;

import front.trade.model.TradeVO;

public interface MemberDAO_interface {
    public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void updateInfo(MemberVO memberVO);
    // 同時新增交易紀錄與升級會員
    public void updateVIP(MemberVO memberVO , List<TradeVO> list);
    // 同時(新增交易紀錄)與儲值金額
    public void storedMoney(MemberVO memberVO);
    public void delete(String mno);
    public MemberVO findByPrimaryKey(String mno);
    public MemberVO findByAccount(String mid);
    public List<MemberVO> getAll();

}