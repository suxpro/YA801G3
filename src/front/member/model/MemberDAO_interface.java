package front.member.model;

import java.sql.Connection;
import java.util.*;

import front.trade.model.TradeVO;

public interface MemberDAO_interface {
    public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void updateInfo(MemberVO memberVO);
    // 同時新增交易紀錄與升級會員
    public void updateVIP(MemberVO memberVO , List<TradeVO> list);
    // 同時新增交易紀錄與儲值金額
    public void storedMoney(MemberVO memberVO , List<TradeVO> list);
    public void delete(String mno);
    public MemberVO findByPrimaryKey(String mno);
    public MemberVO findByAccount(String mid);
    public List<MemberVO> getAll();
    //更新會員餘額 - by思賢
    public void updateMem_mbl(MemberVO memberVO , Connection con);
    //會員停權 排程器 - by小豬
    public void updateTimer(MemberVO memberVO , String action);
    
}