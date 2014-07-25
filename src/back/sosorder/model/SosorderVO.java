package back.sosorder.model;

import java.sql.Timestamp;

public class SosorderVO {
	private String sos_no;
	private String sos_mno;
	private String sos_name;
	private String sos_desc;
	private Integer sos_pay;
	private Integer sos_days;
	private Timestamp sos_onsd;
	private Timestamp sos_ofsd;
	private byte[] sos_pic;
	private String sos_format;
	
	public String getSos_no() {
		return sos_no;
	}
	public void setSos_no(String sos_no) {
		this.sos_no = sos_no;
	}
	public String getSos_mno() {
		return sos_mno;
	}
	public void setSos_mno(String sos_mno) {
		this.sos_mno = sos_mno;
	}
	public String getSos_name() {
		return sos_name;
	}
	public void setSos_name(String sos_name) {
		this.sos_name = sos_name;
	}
	public String getSos_desc() {
		return sos_desc;
	}
	public void setSos_desc(String sos_desc) {
		this.sos_desc = sos_desc;
	}
	public Integer getSos_pay() {
		return sos_pay;
	}
	public void setSos_pay(Integer sos_pay) {
		this.sos_pay = sos_pay;
	}
	public Integer getSos_days() {
		return sos_days;
	}
	public void setSos_days(Integer sos_days) {
		this.sos_days = sos_days;
	}
	public Timestamp getSos_onsd() {
		return sos_onsd;
	}
	public void setSos_onsd(Timestamp sos_onsd) {
		this.sos_onsd = sos_onsd;
	}
	public Timestamp getSos_ofsd() {
		return sos_ofsd;
	}
	public void setSos_ofsd(Timestamp sos_ofsd) {
		this.sos_ofsd = sos_ofsd;
	}
	public byte[] getSos_pic() {
		return sos_pic;
	}
	public void setSos_pic(byte[] sos_pic) {
		this.sos_pic = sos_pic;
	}
	public String getSos_format() {
		return sos_format;
	}
	public void setSos_format(String sos_format) {
		this.sos_format = sos_format;
	}
	
}
