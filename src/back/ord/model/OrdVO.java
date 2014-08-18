package back.ord.model;

import java.sql.Date;
import java.sql.Timestamp;

public class OrdVO implements java.io.Serializable {
	private String ord_no;
	private String rent_no;
	private String les_no;
	private String ten_no;
	private String ord_sta;
	private String tra_mode;
	private Integer freight;
	private Date ten_date;
	private Date exp_date;
	private Integer ten_days;
	private Integer rent_total;
	private Integer ot_days;
	private Integer init_dps;
	private Integer real_dps;
	private Integer tra_total;
	private String loc_no;
	private String rec_addr;
	private Integer les_ases;
	private String les_ases_ct;
	private Integer ten_ases;
	private String ten_ases_ct;
	private Timestamp w_apr_time;
	private Timestamp w_ship_time;
	private Timestamp dtbt_time;
	private Timestamp rec_com_time;
	private Timestamp rent_exp_time;
	private Timestamp rt_time;
	private Timestamp rt_com_time;
	private Timestamp cls_time;
	private Timestamp cc_ord_time;
	private String ord_cc_cause;
	public String getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(String ord_no) {
		this.ord_no = ord_no;
	}
	public String getRent_no() {
		return rent_no;
	}
	public void setRent_no(String rent_no) {
		this.rent_no = rent_no;
	}
	public String getLes_no() {
		return les_no;
	}
	public void setLes_no(String les_no) {
		this.les_no = les_no;
	}
	public String getTen_no() {
		return ten_no;
	}
	public void setTen_no(String ten_no) {
		this.ten_no = ten_no;
	}
	public String getOrd_sta() {
		return ord_sta;
	}
	public void setOrd_sta(String ord_sta) {
		this.ord_sta = ord_sta;
	}
	public String getTra_mode() {
		return tra_mode;
	}
	public void setTra_mode(String tra_mode) {
		this.tra_mode = tra_mode;
	}
	public Integer getFreight() {
		return freight;
	}
	public void setFreight(Integer freight) {
		this.freight = freight;
	}
	public Date getTen_date() {
		return ten_date;
	}
	public void setTen_date(Date ten_date) {
		this.ten_date = ten_date;
	}
	public Date getExp_date() {
		return exp_date;
	}
	public void setExp_date(Date exp_date) {
		this.exp_date = exp_date;
	}
	public Integer getTen_days() {
		return ten_days;
	}
	public void setTen_days(Integer ten_days) {
		this.ten_days = ten_days;
	}
	public Integer getRent_total() {
		return rent_total;
	}
	public void setRent_total(Integer rent_total) {
		this.rent_total = rent_total;
	}
	public Integer getOt_days() {
		return ot_days;
	}
	public void setOt_days(Integer ot_days) {
		this.ot_days = ot_days;
	}
	public Integer getInit_dps() {
		return init_dps;
	}
	public void setInit_dps(Integer init_dps) {
		this.init_dps = init_dps;
	}
	public Integer getReal_dps() {
		return real_dps;
	}
	public void setReal_dps(Integer real_dps) {
		this.real_dps = real_dps;
	}
	public Integer getTra_total() {
		return tra_total;
	}
	public void setTra_total(Integer tra_total) {
		this.tra_total = tra_total;
	}
	public String getLoc_no() {
		return loc_no;
	}
	public void setLoc_no(String loc_no) {
		this.loc_no = loc_no;
	}
	public String getRec_addr() {
		return rec_addr;
	}
	public void setRec_addr(String rec_addr) {
		this.rec_addr = rec_addr;
	}
	public Integer getLes_ases() {
		return les_ases;
	}
	public void setLes_ases(Integer les_ases) {
		this.les_ases = les_ases;
	}
	public String getLes_ases_ct() {
		return les_ases_ct;
	}
	public void setLes_ases_ct(String les_ases_ct) {
		this.les_ases_ct = les_ases_ct;
	}
	public Integer getTen_ases() {
		return ten_ases;
	}
	public void setTen_ases(Integer ten_ases) {
		this.ten_ases = ten_ases;
	}
	public String getTen_ases_ct() {
		return ten_ases_ct;
	}
	public void setTen_ases_ct(String ten_ases_ct) {
		this.ten_ases_ct = ten_ases_ct;
	}
	public Timestamp getW_apr_time() {
		return w_apr_time;
	}
	public void setW_apr_time(Timestamp w_apr_time) {
		this.w_apr_time = w_apr_time;
	}
	public Timestamp getW_ship_time() {
		return w_ship_time;
	}
	public void setW_ship_time(Timestamp w_ship_time) {
		this.w_ship_time = w_ship_time;
	}
	public Timestamp getDtbt_time() {
		return dtbt_time;
	}
	public void setDtbt_time(Timestamp dtbt_time) {
		this.dtbt_time = dtbt_time;
	}
	public Timestamp getRec_com_time() {
		return rec_com_time;
	}
	public void setRec_com_time(Timestamp rec_com_time) {
		this.rec_com_time = rec_com_time;
	}
	public Timestamp getRent_exp_time() {
		return rent_exp_time;
	}
	public void setRent_exp_time(Timestamp rent_exp_time) {
		this.rent_exp_time = rent_exp_time;
	}
	public Timestamp getRt_time() {
		return rt_time;
	}
	public void setRt_time(Timestamp rt_time) {
		this.rt_time = rt_time;
	}
	public Timestamp getRt_com_time() {
		return rt_com_time;
	}
	public void setRt_com_time(Timestamp rt_com_time) {
		this.rt_com_time = rt_com_time;
	}
	public Timestamp getCls_time() {
		return cls_time;
	}
	public void setCls_time(Timestamp cls_time) {
		this.cls_time = cls_time;
	}
	public Timestamp getCc_ord_time() {
		return cc_ord_time;
	}
	public void setCc_ord_time(Timestamp cc_ord_time) {
		this.cc_ord_time = cc_ord_time;
	}
	public String getOrd_cc_cause() {
		return ord_cc_cause;
	}
	public void setOrd_cc_cause(String ord_cc_cause) {
		this.ord_cc_cause = ord_cc_cause;
	}
	


}
