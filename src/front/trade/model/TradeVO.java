package front.trade.model;
import java.sql.*;

public class TradeVO implements java.io.Serializable{
	private String tno;
	private String mno;
	private String tmid;
	private Timestamp tdate;
	private String tstas;
	private Double tfunds;
	private String tin;
	
	
	public String getTstas() {
		return tstas;
	}
	public void setTstas(String tstas) {
		this.tstas = tstas;
	}
	public String getTno() {
		return tno;
	}
	public void setTno(String tno) {
		this.tno = tno;
	}
	public String getMno() {
		return mno;
	}
	public void setMno(String mno) {
		this.mno = mno;
	}
	public String getTmid() {
		return tmid;
	}
	public void setTmid(String tmid) {
		this.tmid = tmid;
	}
	public Timestamp getTdate() {
		return tdate;
	}
	public void setTdate(Timestamp tdate) {
		this.tdate = tdate;
	}
	public Double getTfunds() {
		return tfunds;
	}
	public void setTfunds(Double tfunds) {
		this.tfunds = tfunds;
	}
	public String getTin() {
		return tin;
	}
	public void setTin(String tin) {
		this.tin = tin;
	}
	
	
}
