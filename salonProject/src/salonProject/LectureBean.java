package salonProject;

import java.sql.Timestamp;

public class LectureBean 
{
	private int l_no;
	private String id;
	private int a_no;
	private Timestamp lecture_date;
	private AcademyBean academy = new AcademyBean();
	private DesignerBean designer = new DesignerBean();
	
	public int getL_no() {
		return l_no;
	}
	public void setL_no(int l_no) {
		this.l_no = l_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public Timestamp getLecture_date() {
		return lecture_date;
	}
	public void setLecture_date(Timestamp lecture_date) {
		this.lecture_date = lecture_date;
	}
	public AcademyBean getAcademy() {
		return academy;
	}
	public void setAcademy(AcademyBean academy) {
		this.academy = academy;
	}
	public DesignerBean getDesigner() {
		return designer;
	}
	public void setDesigner(DesignerBean designer) {
		this.designer = designer;
	}
}
