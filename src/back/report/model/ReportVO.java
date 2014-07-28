package back.report.model;
import java.sql.*;

public class ReportVO implements java.io.Serializable{
	private String rno;
	private String rm_p;
	private String rr_no;
	private String rm_byp;
	private Date rtime;
	private String rcuz;
	private String re_chk;
	private String rsol;
	private Date rsolt;
	private String rsold;
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getRm_p() {
		return rm_p;
	}
	public void setRm_p(String rm_p) {
		this.rm_p = rm_p;
	}
	public String getRr_no() {
		return rr_no;
	}
	public void setRr_no(String rr_no) {
		this.rr_no = rr_no;
	}
	public String getRm_byp() {
		return rm_byp;
	}
	public void setRm_byp(String rm_byp) {
		this.rm_byp = rm_byp;
	}
	public Date getRtime() {
		return rtime;
	}
	public void setRtime(Date rtime) {
		this.rtime = rtime;
	}
	public String getRcuz() {
		return rcuz;
	}
	public void setRcuz(String rcuz) {
		this.rcuz = rcuz;
	}
	public String getRe_chk() {
		return re_chk;
	}
	public void setRe_chk(String re_chk) {
		this.re_chk = re_chk;
	}
	public String getRsol() {
		return rsol;
	}
	public void setRsol(String rsol) {
		this.rsol = rsol;
	}
	public Date getRsolt() {
		return rsolt;
	}
	public void setRsolt(Date rsolt) {
		this.rsolt = rsolt;
	}
	public String getRsold() {
		return rsold;
	}
	public void setRsold(String rsold) {
		this.rsold = rsold;
	}
	
	

}
