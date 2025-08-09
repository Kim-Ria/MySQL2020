package salonProject;

import java.sql.Timestamp;

public class ReservationBean 
{
	private int r_no;
	private String id;
	private int t_no;
	private int d_no;
	private Timestamp reserv_date;
	
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getT_no() {
		return t_no;
	}
	public void setT_no(int t_no) {
		this.t_no = t_no;
	}
	public int getD_no() {
		return d_no;
	}
	public void setD_no(int d_no) {
		this.d_no = d_no;
	}
	public Timestamp getReserv_date() {
		return reserv_date;
	}
	public void setReserv_date(Timestamp reserv_date) {
		this.reserv_date = reserv_date;
	}
}
