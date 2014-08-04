package back.rent.model;

import java.sql.Timestamp;
 
public class RentVO implements java.io.Serializable {
	private String rent_no;
	private String rent_name;
	private String rent_desc;
	private String les_no;
	private String rent_sta;
	private String tag_no;
	private Integer rent_dps;
	private Integer unit_price;
	private Integer reset_days;
	private String loc_no;
	private String rent_addr;
	private String pop_flag;
	private String prent_flag;
	private String report_flag;
	private String offshelf_flag;
	private Timestamp last_sta_time;
	private Timestamp last_onshelf_time;
	private Timestamp last_mod_time;
	private byte[] pic1;
	private String pic1_format;
	private byte[] pic2;
	private String pic2_format;
	private byte[] pic3;
	private String pic3_format;
	private byte[] pic4;
	private String pic4_format;
	private byte[] pic5;
	private String pic5_format;
	
	public String getRent_no() {
		return rent_no;
	}
	public void setRent_no(String rent_no) {
		this.rent_no = rent_no;
	}
	public String getRent_name() {
		return rent_name;
	}
	public void setRent_name(String rent_name) {
		this.rent_name = rent_name;
	}
	public String getRent_desc() {
		return rent_desc;
	}
	public void setRent_desc(String rent_desc) {
		this.rent_desc = rent_desc;
	}
	public String getLes_no() {
		return les_no;
	}
	public void setLes_no(String les_no) {
		this.les_no = les_no;
	}
	public String getRent_sta() {
		return rent_sta;
	}
	public void setRent_sta(String rent_sta) {
		this.rent_sta = rent_sta;
	}
	public String getTag_no() {
		return tag_no;
	}
	public void setTag_no(String tag_no) {
		this.tag_no = tag_no;
	}
	public Integer getRent_dps() {
		return rent_dps;
	}
	public void setRent_dps(Integer rent_dps) {
		this.rent_dps = rent_dps;
	}
	public Integer getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(Integer unit_price) {
		this.unit_price = unit_price;
	}
	public Integer getReset_days() {
		return reset_days;
	}
	public void setReset_days(Integer reset_days) {
		this.reset_days = reset_days;
	}
	public String getLoc_no() {
		return loc_no;
	}
	public void setLoc_no(String loc_no) {
		this.loc_no = loc_no;
	}
	public String getRent_addr() {
		return rent_addr;
	}
	public void setRent_addr(String rent_addr) {
		this.rent_addr = rent_addr;
	}
	public String getPop_flag() {
		return pop_flag;
	}
	public void setPop_flag(String pop_flag) {
		this.pop_flag = pop_flag;
	}
	public String getPrent_flag() {
		return prent_flag;
	}
	public void setPrent_flag(String prent_flag) {
		this.prent_flag = prent_flag;
	}
	public String getReport_flag() {
		return report_flag;
	}
	public void setReport_flag(String report_flag) {
		this.report_flag = report_flag;
	}
	public String getOffshelf_flag() {
		return offshelf_flag;
	}
	public void setOffshelf_flag(String offshelf_flag) {
		this.offshelf_flag = offshelf_flag;
	}
	public Timestamp getLast_sta_time() {
		return last_sta_time;
	}
	public void setLast_sta_time(Timestamp last_sta_time) {
		this.last_sta_time = last_sta_time;
	}

	public Timestamp getLast_onshelf_time() {
		return last_onshelf_time;
	}
	public void setLast_onshelf_time(Timestamp last_onshelf_time) {
		this.last_onshelf_time = last_onshelf_time;
	}
	public Timestamp getLast_mod_time() {
		return last_mod_time;
	}
	public void setLast_mod_time(Timestamp last_mod_time) {
		this.last_mod_time = last_mod_time;
	}
	public byte[] getPic1() {
		return pic1;
	}
	public void setPic1(byte[] pic1) {
		this.pic1 = pic1;
	}
	public String getPic1_format() {
		return pic1_format;
	}
	public void setPic1_format(String pic1_format) {
		this.pic1_format = pic1_format;
	}
	public byte[] getPic2() {
		return pic2;
	}
	public void setPic2(byte[] pic2) {
		this.pic2 = pic2;
	}
	public String getPic2_format() {
		return pic2_format;
	}
	public void setPic2_format(String pic2_format) {
		this.pic2_format = pic2_format;
	}
	public byte[] getPic3() {
		return pic3;
	}
	public void setPic3(byte[] pic3) {
		this.pic3 = pic3;
	}
	public String getPic3_format() {
		return pic3_format;
	}
	public void setPic3_format(String pic3_format) {
		this.pic3_format = pic3_format;
	}
	public byte[] getPic4() {
		return pic4;
	}
	public void setPic4(byte[] pic4) {
		this.pic4 = pic4;
	}
	public String getPic4_format() {
		return pic4_format;
	}
	public void setPic4_format(String pic4_format) {
		this.pic4_format = pic4_format;
	}
	public byte[] getPic5() {
		return pic5;
	}
	public void setPic5(byte[] pic5) {
		this.pic5 = pic5;
	}
	public String getPic5_format() {
		return pic5_format;
	}
	public void setPic5_format(String pic5_format) {
		this.pic5_format = pic5_format;
	}


}
