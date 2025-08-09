package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

public class TreatmentDAO 
{
	private DBConnectionManager db = null;
	
	public TreatmentDAO() 
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
	
	//시술 정보 등록
	public boolean treatInsert(TreatmentBean treBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     boolean flag = false;
	     
	     try 
	        {
	            con = db.getConnection();
	            String strQuery = "insert into treatment values(?,?,?);";
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, treBean.getT_no());
	            pstmt.setString(2, treBean.getTreat_name());
	            pstmt.setInt(3, treBean.getTreat_price());
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
	
	// 시술 이름 조회
	public String getTreatName(int t_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select treat_name from treatment where t_no=?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, t_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	name = rs.getString("treat_name");
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
	
	//시술 가격 조회
	public int getTreatPrice(int t_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int price = 0;

        try 
        {
            con = db.getConnection();
            String strQuery = "select treat_price from treatment where t_no=?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, t_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	price = rs.getInt("treat_price");
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
        return price;
    }
	
	// 시술 정보 하나 가져오기
	public TreatmentBean getTreat(int t_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        TreatmentBean treBean = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from teratment where t_no=?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, t_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	treBean = new TreatmentBean();
            	treBean.setT_no(rs.getInt("t_no"));
            	treBean.setTreat_name(rs.getString("treat_name"));
            	treBean.setTreat_price(rs.getInt("treat_price"));
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
        return treBean;
    }
		
	// 시술 전체 조회
	public List<TreatmentBean> getTreatList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<TreatmentBean> treList = new ArrayList<TreatmentBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from treatment";
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	TreatmentBean treBean = new TreatmentBean();
            	treBean.setT_no(rs.getInt("t_no"));
            	treBean.setTreat_name(rs.getString("treat_name"));
            	treBean.setTreat_price(rs.getInt("treat_price"));
            	
            	treList.add(treBean);
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
        return treList;
    }
	
	//시술 정보 수정
	public boolean treatUpdate(TreatmentBean treBean)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update treatment set treat_name=?, t_price=?";
            strQuery = strQuery + " where t_no=?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, treBean.getTreat_name());
            pstmt.setInt(2, treBean.getTreat_price());
            pstmt.setInt(3, treBean.getT_no());
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
	
	//시술 정보 삭제
	public boolean treatDelete(int t_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "delete from treatment where t_no =?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, t_no);
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
