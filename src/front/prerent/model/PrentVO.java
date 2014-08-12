package front.prerent.model;

import java.sql.Date;
import java.sql.Timestamp;

public class PrentVO implements java.io.Serializable {
	private String prent_no;
	private String rent_no;
	private String ten_no;
	private Timestamp prent_time;
	private Integer prent_days;
	private String prent_flag;
	private String ord_no;

	public String getPrent_no() {
		return prent_no;
	}

	public void setPrent_no(String prent_no) {
		this.prent_no = prent_no;
	}

	public String getRent_no() {
		return rent_no;
	}

	public void setRent_no(String rent_no) {
		this.rent_no = rent_no;
	}

	public String getTen_no() {
		return ten_no;
	}

	public void setTen_no(String ten_no) {
		this.ten_no = ten_no;
	}

	public Timestamp getPrent_time() {
		return prent_time;
	}

	public void setPrent_time(Timestamp prent_time) {
		this.prent_time = prent_time;
	}

	public Integer getPrent_days() {
		return prent_days;
	}

	public void setPrent_days(Integer prent_days) {
		this.prent_days = prent_days;
	}

	public String getPrent_flag() {
		return prent_flag;
	}

	public void setPrent_flag(String prent_flag) {
		this.prent_flag = prent_flag;
	}

	public String getOrd_no() {
		return ord_no;
	}

	public void setOrd_no(String ord_no) {
		this.ord_no = ord_no;
	}
}