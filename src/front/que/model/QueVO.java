package front.que.model;

import java.sql.Timestamp;

public class QueVO implements java.io.Serializable{
	private String que_no	   ;
	private String rent_no	   ;
	private String que_mem	   ;
	private String que_sta     ;
	private Timestamp que_time ;
	private String que_desc    ;
	private Timestamp ans_time ;
	private String ans_desc    ;
	
	public String getQue_no() {
		return que_no;
	}
	public void setQue_no(String que_no) {
		this.que_no = que_no;
	}
	public String getRent_no() {
		return rent_no;
	}
	public void setRent_no(String rent_no) {
		this.rent_no = rent_no;
	}
	public String getQue_mem() {
		return que_mem;
	}
	public void setQue_mem(String que_mem) {
		this.que_mem = que_mem;
	}
	public String getQue_sta() {
		return que_sta;
	}
	public void setQue_sta(String que_sta) {
		this.que_sta = que_sta;
	}
	public Timestamp getQue_time() {
		return que_time;
	}
	public void setQue_time(Timestamp que_time) {
		this.que_time = que_time;
	}
	public String getQue_desc() {
		return que_desc;
	}
	public void setQue_desc(String que_desc) {
		this.que_desc = que_desc;
	}
	public Timestamp getAns_time() {
		return ans_time;
	}
	public void setAns_time(Timestamp ans_time) {
		this.ans_time = ans_time;
	}
	public String getAns_desc() {
		return ans_desc;
	}
	public void setAns_desc(String ans_desc) {
		this.ans_desc = ans_desc;
	}



    
}
