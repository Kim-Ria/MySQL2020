package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class ProductDAO 
{
private DBConnectionManager db = null;
	
	public ProductDAO() 
    {
        try 
        {
            db = DBConnectionManager.getInstance();
        }
        catch (Exception e) 
        {
            System.out.println("Error :db connect!!");
        }
    }
	
	//상품 등록
	public boolean productInsert(ProductBean proBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     boolean flag = false;
	     
	     try 
	        {
	            con = db.getConnection();
	            String strQuery = "insert into product values(?,?,?,?,?);";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, proBean.getP_no());
	            pstmt.setInt(2, proBean.getC_no());
	            pstmt.setString(3, proBean.getProd_name());
	            pstmt.setInt(4, proBean.getProd_price());
	            pstmt.setInt(5, proBean.getStock());
	            int count = pstmt.executeUpdate();

	            if (count == 1)
	            {
	                flag = true;
	            }

	        }
	        catch (Exception ex)
	        {
	            System.out.println("Exception" + ex);
	        } 
	        finally
	        {
	            db.freeConnection(con, pstmt);
	        }
	        return flag;
	}
	
	//상품 상세 선택
	public ProductBean getProduct(int p_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ProductBean proBean = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from product where p_no=?"; // 상품 번호로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, p_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	proBean = new ProductBean();
            	proBean.setP_no(rs.getInt("p_no"));
            	proBean.setC_no(rs.getInt("bc_no"));
            	proBean.setProd_name(rs.getString("prod_name"));
            	proBean.setProd_price(rs.getInt("prod_price"));
            	proBean.setStock(rs.getInt("stock"));
            }
        } 
        catch (Exception ex) 
        {
            System.out.println("Exception" + ex);
        }
        finally 
        {
            db.freeConnection(con, pstmt, rs);
        }
        return proBean;
    }
	
	//상품 이름 조회
	public String getProductName(int p_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select prod_name from product where p_no=?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, p_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	name = rs.getString("prod_name");
            }
        } 
        catch (Exception ex) 
        {
            System.out.println("Exception" + ex);
        }
        finally 
        {
            db.freeConnection(con, pstmt, rs);
        }
        return name;
    }
	
	// 재고 확인
	public int getProductStock(int p_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int stock = 0;

        try 
        {
            con = db.getConnection();
            String strQuery = "select stock from product where p_no=?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, p_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	stock = rs.getInt("stock");
            }
        } 
        catch (Exception ex) 
        {
            System.out.println("Exception" + ex);
        }
        finally 
        {
            db.freeConnection(con, pstmt, rs);
        }
        return stock;
    }
	
	//전체 상품 조회
	public List<ProductBean> getProductList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<ProductBean> proList = new ArrayList<ProductBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from product join classification where product.c_no = classification.c_no order by p_no desc";
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	ProductBean proBean = new ProductBean();
            	ClassificationBean claBean = new ClassificationBean();
            	
            	proBean.setP_no(rs.getInt("p_no"));
            	proBean.setC_no(rs.getInt("c_no"));
            	proBean.setProd_name(rs.getString("prod_name"));
            	proBean.setProd_price(rs.getInt("prod_price"));
            	proBean.setStock(rs.getInt("stock"));
            	
            	claBean.setC_category(rs.getString("class"));
            	proBean.setClassification(claBean);
            	
            	proList.add(proBean);
            }
        }
        catch (Exception ex) 
        {
            System.out.println("Exception" + ex);
        } 
        finally
        {
            db.freeConnection(con, stmt, rs);
        }
        return proList;
    }
	
	// 카테고리별 상품 조회
	public List<ProductBean> getProductListCategory(int c_no) 
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ProductBean> proList = new ArrayList<ProductBean>();
        
        try 
        {
        	if(c_no == 0) return getProductList(); // 카테고리 0인 경우 : 전체 조회
        	
            con = db.getConnection();
            String strQuery = "select * from product p join classification c on p.c_no=c.c_no where p.c_no=? order by p_no;";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, c_no);
            rs = pstmt.executeQuery();

            while (rs.next()) 
            {
            	ProductBean proBean = new ProductBean();
            	ClassificationBean claBean = new ClassificationBean();
            	
            	proBean.setP_no(rs.getInt("p_no"));
            	proBean.setC_no(rs.getInt("c_no"));
            	proBean.setProd_name(rs.getString("prod_name"));
            	proBean.setProd_price(rs.getInt("prod_price"));
            	proBean.setStock(rs.getInt("stock"));
            	
            	claBean.setC_category(rs.getString("class"));
            	proBean.setClassification(claBean);
            	
            	proList.add(proBean);
            }
        } 
        catch (Exception ex) 
        {
            System.out.println("Exception" + ex);
        } 
        finally
        {
            db.freeConnection(con, pstmt, rs);
        }
        return proList;
    }
	
    //상품 수정
    public boolean productUpdate(ProductBean proBean)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update product set prod_name=?, prod_price=?, stock=?";
            strQuery = strQuery + " where p_no=?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, proBean.getProd_name());
            pstmt.setInt(2, proBean.getProd_price());
            pstmt.setInt(3, proBean.getStock());
            pstmt.setInt(4, proBean.getP_no());
            int count = pstmt.executeUpdate();
            //System.out.println(regBean.getName());
            if (count == 1)
            {
                flag = true;
            }
        } 
        catch (Exception ex)
        {
            System.out.println("Exception" + ex);
        } 
        finally 
        {
            db.freeConnection(con, pstmt);
        }
        return flag;
    }
	
    //상품 재고 수정(남은수량 - 구매수량)
    public boolean productStockUpdate(ProductBean proBean, int buy)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        int stock = 0;
        
        try 
        {
            con = db.getConnection();
            String strQuery = "update product set stock=?";
            strQuery = strQuery + " where p_no=?";

            stock = getProductStock(proBean.getP_no());
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, stock-buy);
            pstmt.setInt(2, proBean.getP_no());
            int count = pstmt.executeUpdate();
            //System.out.println(regBean.getName());
            if (count == 1)
            {
                flag = true;
            }
        } 
        catch (Exception ex)
        {
            System.out.println("Exception" + ex);
        } 
        finally 
        {
            db.freeConnection(con, pstmt);
        }
        return flag;
    }
	
    //상품 삭제
    public boolean productDelete(int p_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "delete from product where p_no =?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, p_no);
            int count = pstmt.executeUpdate();

            if (count == 1)
            {
                flag = true;
            }
        } 
        catch (Exception ex)
        {
            System.out.println("Exception" + ex);
        } 
        finally 
        {
            db.freeConnection(con, pstmt);
        }
        return flag;
    }
}
