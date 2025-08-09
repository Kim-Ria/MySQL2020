package salonProject;

import java.sql.Date;

public class BoardBean 
{
	private int b_no;
	private int bc_no;
	private String category;
	private String writer;
	private String title;
	private String content;
	private Date write_date;
	
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public int getBc_no() {
		return bc_no;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getCategory() {
		return category;
	}
	public void setBc_no(int bc_no) {
		this.bc_no = bc_no;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Date write_date) {
		this.write_date = write_date;
	}
}
