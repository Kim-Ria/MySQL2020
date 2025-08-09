package salonProject;

public class ProductBean 
{
	private int p_no;
	private int c_no;
	private String prod_name;
	private int prod_price;
	private int stock;
	private ClassificationBean classification = new ClassificationBean();

	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public ClassificationBean getClassification() {
		return classification;
	}
	public void setClassification(ClassificationBean classification) {
		this.classification = classification;
	}
}
