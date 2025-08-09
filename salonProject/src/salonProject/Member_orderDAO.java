package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Member_orderDAO 
{
	private DBConnectionManager db = null;
	
	public Member_orderDAO() 
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
	
	//구매 등록
	public int orderInsert(Member_orderBean ordBean, ProductBean proBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     boolean search = false;
	     search = checkOrder(ordBean.getId(), ordBean.getP_no()); //해당 컬럼이 존재하는지 검색
	     
	     try 
	        {
	            con = db.getConnection();
	            
	            ProductDAO pdao = new ProductDAO();
	            
	            int stock = pdao.getProductStock(ordBean.getP_no());
	            if(stock < ordBean.getQuantity()) { // 재고보다 많이 구매하는 경우
	            	return -1;
	            }
	            
	            if(search) //이미 존재하는 컬럼인 경우
	   	     	{
	            	//member_order의 quantity만 update
	            	//구매 후 product의 stock update
	            	ProductDAO pro = new ProductDAO();
	             	boolean result_stock = pro.productStockUpdate(proBean, ordBean.getQuantity());
	             	boolean result_quantity = orderQuantityUpdate(ordBean);
	             	if(result_stock&&result_quantity)
	             		return 1; //구입 완료
	             	else
	             		orderDelete(ordBean.getId(),ordBean.getP_no()); // product 재고 업데이트 실패한 경우 주문 취소
	   	     	}
	            //구입가능한 범위에 속하고, 존재하지 않는 컬럼인 경우
	            String strQuery = "insert into member_order(id,p_no,quantity,order_date) values(?,?,?,now());";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, ordBean.getId());
	            pstmt.setInt(2, ordBean.getP_no());
	            pstmt.setInt(3, ordBean.getQuantity());
	            int count = pstmt.executeUpdate();

	            if (count == 1)
	            {
	            	ProductDAO pro = new ProductDAO();
	             	boolean result_quantity = pro.productStockUpdate(proBean, ordBean.getQuantity());
	             	if(result_quantity)
	             		return 1;
	             	else
	             		orderDelete(ordBean.getId(),ordBean.getP_no()); // product 재고 업데이트 실패한 경우 주문 취소
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
	        return 0; // 0 DB문제, 1 성공, -1 재고부족
	}
	//구매 목록 중복 check
	public boolean checkOrder(String id, int p_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean result = false;

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from member_order where id=? and p_no=?"; //복합키로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, id);
            pstmt.setInt(2, p_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	result = true;
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
        return result;
    }
		//상위구매제품 조회
		public List<Member_orderBean> getOrderRankList() 
	    {
	        Connection con = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        List<Member_orderBean> ordList = new ArrayList<Member_orderBean>();

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select p.prod_name, o.p_no, count(o.p_no) from member_order o join product p where o.p_no=p.p_no group by p_no order by count(o.p_no) desc;";
	            stmt = con.createStatement();
	            rs = stmt.executeQuery(strQuery);

	            while (rs.next()) {
	            	Member_orderBean ordBean = new Member_orderBean();
	            	ordBean.setP_no(rs.getInt("p_no"));
	            	
	            	ordList.add(ordBean);
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
	        return ordList;
	    }
		//구매 개수 출력
				public int getCnt(String id) 
			    {
					Connection con = null;
			        PreparedStatement pstmt = null;
			        ResultSet rs = null;
			        int cnt = 0;

			        try 
			        {
			            con = db.getConnection();
			            String strQuery = "select sum(o.quantity) as 'sum_cnt' from member_order o join product p where o.p_no = p.p_no and id=? group by id;";
			            pstmt = con.prepareStatement(strQuery);
			            pstmt.setString(1, id);
			            rs = pstmt.executeQuery();

			            while (rs.next()) {
			            	cnt = rs.getInt("sum_cnt");
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
			        return cnt;
			    }
		//구매 총합 출력
		public int getSum(String id) 
	    {
			Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int sum = 0;

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select o.id, sum(o.quantity*p.prod_price) as 'sum' from member_order o join product p where o.p_no = p.p_no and id=? group by id;";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	            	sum = rs.getInt("sum");
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
	        return sum;
	    }
		//카테고리별 구매내역 조회
		public List<Member_orderBean> getOrderListCategory(int c_no, String id) 
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<Member_orderBean> ordList = new ArrayList<Member_orderBean>();
	        
	        try 
	        {
	        	System.out.println("id" + id);
	        	if(c_no == 0) return getOrderListbyID(id);
	        	
	            con = db.getConnection();
	            String strQuery = "select * from member_order o join product p on o.p_no = p.p_no"
	            		+ " join classification c on p.c_no=c.c_no"
	            		+ " where p.c_no=? and o.id=? order by o.p_no desc;";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, c_no);
	            pstmt.setString(2, id);
	            rs = pstmt.executeQuery();

	            while (rs.next()) 
	            {
	            	Member_orderBean ordBean = new Member_orderBean();
	            	ProductBean proBean = new ProductBean();
	            	ClassificationBean claBean = new ClassificationBean();
	            	
	            	ordBean.setId(rs.getString("id"));
	            	ordBean.setP_no(rs.getInt("p_no"));
	            	ordBean.setQuantity(rs.getInt("quantity"));
	            	ordBean.setOrder_date(rs.getDate("order_date"));
	            	ordBean.setState(rs.getString("state"));
	            	
	            	proBean.setProd_name(rs.getString("prod_name"));
	            	proBean.setProd_price(rs.getInt("prod_price"));
	            	claBean.setC_category(rs.getString("class"));
	            	
	            	proBean.setClassification(claBean);
	            	ordBean.setProduct(proBean);
	            	
	            	ordList.add(ordBean);
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
	        return ordList;
	    }
		//사용자 로그인에따라 구매목록 조회
		public List<Member_orderBean> getOrderListbyID(String id) 
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<Member_orderBean> ordList = new ArrayList<Member_orderBean>();

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from member_order o join product p on o.p_no = p.p_no "
	            		+ "join classification c on p.c_no=c.c_no where o.id=? order by o.order_date desc;";
	            
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
	            
	            rs = pstmt.executeQuery();

	            while (rs.next()) {
	            	
	            	Member_orderBean ordBean = new Member_orderBean();
	            	ProductBean proBean = new ProductBean();
	            	ClassificationBean claBean = new ClassificationBean();
	            	
	            	ordBean.setId(rs.getString("id"));
	            	ordBean.setP_no(rs.getInt("p_no"));
	            	ordBean.setQuantity(rs.getInt("quantity"));
	            	ordBean.setOrder_date(rs.getDate("order_date"));
	            	ordBean.setState(rs.getString("state"));
	            	
	            	proBean.setProd_name(rs.getString("prod_name"));
	            	proBean.setProd_price(rs.getInt("prod_price"));
	            	claBean.setC_category(rs.getString("class"));
	            	
	            	proBean.setClassification(claBean);
	            	ordBean.setProduct(proBean);
	            	
	            	ordList.add(ordBean);
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
	        return ordList;
	    }
		//주문 수량 조회
		public int getOrderQuantity(String id, int p_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        int quantity = 0;

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select quantity from member_order where id=? and p_no=?";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
	            pstmt.setInt(2, p_no);
	            rs = pstmt.executeQuery();

	            if (rs.next()) 
	            {
	            	quantity = rs.getInt("quantity");
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
	        return quantity;
	    }
		
		//구매 수량 수정(구매수량 + 추가수량)
		public boolean orderQuantityUpdate(Member_orderBean ordBean)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        Member_orderDAO ord = new Member_orderDAO();
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "update member_order set quantity=?";
	            strQuery = strQuery + " where id=? and p_no=?";

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, ordBean.getQuantity()+ ord.getOrderQuantity(ordBean.getId(),ordBean.getP_no()));
	            pstmt.setString(2, ordBean.getId());
	            pstmt.setInt(3, ordBean.getP_no());
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
		
		//구매내역 삭제
		public boolean orderDelete(String id, int p_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "delete from member_order where id =? and p_no=?";

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
	            pstmt.setInt(2, p_no);
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
