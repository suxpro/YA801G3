package front.remind.model;
import java.sql.*;

public class RemindVO implements java.io.Serializable{
	private String rno;
	private String mno;
	private String rtno;
	private Date rtime;
	private String rstas;
	private String rdes;
	private String rflag;
	
	public String getRdes() {
		return rdes;
	}
	public void setRdes(String rdes) {
		this.rdes = rdes;
	}
	public String getRno() {
		return rno;
	}
	public void setRno(String rno) {
		this.rno = rno;
	}
	public String getMno() {
		return mno;
	}
	public void setMno(String mno) {
		this.mno = mno;
	}
	public String getRtno() {
		return rtno;
	}
	public void setRtno(String rtno) {
		this.rtno = rtno;
	}
	public Date getRtime() {
		return rtime;
	}
	public void setRtime(Date rtime) {
		this.rtime = rtime;
	}
	public String getRstas() {
		return rstas;
	}
	public void setRstas(String rstas) {
		this.rstas = rstas;
	}
	public String getRflag() {
		return rflag;
	}
	public void setRflag(String rflag) {
		this.rflag = rflag;
	}
	
	


}
