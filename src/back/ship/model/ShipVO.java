package back.ship.model;
import java.sql.Date;
import java.sql.Timestamp;

public class ShipVO implements java.io.Serializable{
	private String ord_no;
	private String rent_no;
	private String rent_name;
	private String tag_no;
	private Timestamp start_time;
	private String rec_mem;
	private String rec_cell;
	private String rec_loc;
	private String rec_addr;
	private String dest_mem;
	private String dest_cell;
	private String dest_loc;
	private String dest_addr;
	
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
	public String getRent_name() {
		return rent_name;
	}
	public void setRent_name(String rent_name) {
		this.rent_name = rent_name;
	}
	public String getTag_no() {
		return tag_no;
	}
	public void setTag_no(String tag_no) {
		this.tag_no = tag_no;
	}
	public Timestamp getStart_time() {
		return start_time;
	}
	public void setStart_time(Timestamp start_time) {
		this.start_time = start_time;
	}
	public String getRec_mem() {
		return rec_mem;
	}
	public void setRec_mem(String rec_mem) {
		this.rec_mem = rec_mem;
	}
	public String getRec_cell() {
		return rec_cell;
	}
	public void setRec_cell(String rec_cell) {
		this.rec_cell = rec_cell;
	}
	public String getRec_loc() {
		return rec_loc;
	}
	public void setRec_loc(String rec_loc) {
		this.rec_loc = rec_loc;
	}
	public String getRec_addr() {
		return rec_addr;
	}
	public void setRec_addr(String rec_addr) {
		this.rec_addr = rec_addr;
	}
	public String getDest_mem() {
		return dest_mem;
	}
	public void setDest_mem(String dest_mem) {
		this.dest_mem = dest_mem;
	}
	public String getDest_cell() {
		return dest_cell;
	}
	public void setDest_cell(String dest_cell) {
		this.dest_cell = dest_cell;
	}
	public String getDest_loc() {
		return dest_loc;
	}
	public void setDest_loc(String dest_loc) {
		this.dest_loc = dest_loc;
	}
	public String getDest_addr() {
		return dest_addr;
	}
	public void setDest_addr(String dest_addr) {
		this.dest_addr = dest_addr;
	}
			

}
