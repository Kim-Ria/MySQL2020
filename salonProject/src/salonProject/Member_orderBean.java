package salonProject;

import java.sql.Date;

public class Member_orderBean 
{
	private String id;
	private int p_no;
	private int quantity;
	private Date order_date;
	private String state;
	private ProductBean product = new ProductBean();

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Date getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public ProductBean getProduct() {
		return product;
	}
	public void setProduct(ProductBean product) {
		this.product = product;
	}
}
