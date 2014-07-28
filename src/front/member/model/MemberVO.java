package front.member.model;
import java.sql.*;

public class MemberVO implements java.io.Serializable{
	private String mno;
	private String mid;
	private String mpwd;
	private byte[] mpic;
	private String mname;
	private String msex;
	private String mcell;
	private String mmail;
	private String locno;
	private String madrs;
	private String mlev;
	private Double mbalance;
	private Integer millegal;
	private Integer massess;
	private String mverification;
	private Date mdate;
	private String mpic_info;
	private byte[] mvpic;
	private String mvpic_info;
	
	public byte[] getMvpic() {
		return mvpic;
	}
	public void setMvpic(byte[] mvpic) {
		this.mvpic = mvpic;
	}
	public String getMvpic_info() {
		return mvpic_info;
	}
	public void setMvpic_info(String mvpic_info) {
		this.mvpic_info = mvpic_info;
	}
	public String getMno() {
		return mno;
	}
	public void setMno(String mno) {
		this.mno = mno;
	}
	public String getLocno() {
		return locno;
	}
	public void setLocno(String locno) {
		this.locno = locno;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpwd() {
		return mpwd;
	}
	public void setMpwd(String mpwd) {
		this.mpwd = mpwd;
	}
	public byte[] getMpic() {
		return mpic;
	}
	public void setMpic(byte[] mpic) {
		this.mpic = mpic;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMsex() {
		return msex;
	}
	public void setMsex(String msex) {
		this.msex = msex;
	}
	public String getMcell() {
		return mcell;
	}
	public void setMcell(String mcell) {
		this.mcell = mcell;
	}
	public String getMmail() {
		return mmail;
	}
	public void setMmail(String mmail) {
		this.mmail = mmail;
	}
	public String getMadrs() {
		return madrs;
	}
	public void setMadrs(String madrs) {
		this.madrs = madrs;
	}
	public String getMlev() {
		return mlev;
	}
	public void setMlev(String mlev) {
		this.mlev = mlev;
	}
	public Double getMbalance() {
		return mbalance;
	}
	public void setMbalance(Double mbalance) {
		this.mbalance = mbalance;
	}
	public Integer getMillegal() {
		return millegal;
	}
	public void setMillegal(Integer millegal) {
		this.millegal = millegal;
	}
	public Integer getMassess() {
		return massess;
	}
	public void setMassess(Integer massess) {
		this.massess = massess;
	}
	public String getMverification() {
		return mverification;
	}
	public void setMverification(String mverification) {
		this.mverification = mverification;
	}
	public Date getMdate() {
		return mdate;
	}
	public void setMdate(Date mdate) {
		this.mdate = mdate;
	}
	public String getMpic_info() {
		return mpic_info;
	}
	public void setMpic_info(String mpic_info) {
		this.mpic_info = mpic_info;
	}
	
	
}
