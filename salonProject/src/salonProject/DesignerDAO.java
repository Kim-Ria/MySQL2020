package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DesignerDAO 
{
	private DBConnectionManager db = null;
	public DesignerDAO() 
    {
        try 
        {
            db = DBConnectionManager.getInstance();
        }
        catch (Exception e) 
        {
            System.out.println("Error : DB 문제 발생");
        }
    }
	
	// 디자이너 입력
		public boolean designerInsert(DesignerBean desBean)
		{
			 Connection con = null;
		     PreparedStatement pstmt = null;
		     boolean flag = false;
		     
		     try 
		        {
		            con = db.getConnection();
		            String strQuery = "insert into designer values(?,?);";
		            pstmt = con.prepareStatement(strQuery);
		            pstmt.setInt(1, desBean.getD_no());
		            pstmt.setString(2, desBean.getD_name());
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
		
		// 디자이너 한 명 조회
		public DesignerBean getDesigner(int d_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        DesignerBean desBean = null;

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from designer where d_no=?"; // 디자이너 번호로 조회
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, d_no);
	            rs = pstmt.executeQuery();

	            if (rs.next()) 
	            {
	            	desBean = new DesignerBean();
	            	desBean.setD_no(rs.getInt("d_no"));
	            	desBean.setD_name(rs.getString("d_name"));
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
	        return desBean;
	    }
		
		// 디자이너 전체 조회
		public List<DesignerBean> getDesignerList() 
	    {
	        Connection con = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        List<DesignerBean> desList = new ArrayList<DesignerBean>();

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from designer";
	            stmt = con.createStatement();
	            rs = stmt.executeQuery(strQuery);

	            while (rs.next()) {
	            	DesignerBean desBean = new DesignerBean();
	            	desBean.setD_no(rs.getInt("d_no"));
	            	desBean.setD_name(rs.getString("d_name"));
	            	desList.add(desBean);
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
	        return desList;
	    }
		
		//디자이너 이름만 추출
		public String getDesignerName(int d_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        String name = null;

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select d_name from designer where d_no=?"; // 선택된 디자이너 이름
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, d_no);
	            rs = pstmt.executeQuery();

	            if (rs.next()) 
	            {
	            	name = rs.getString("d_name");
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
		
		// 디자이너 정보 수정
		public boolean designerUpdate(DesignerBean desBean)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "update designer set d_name=?";
	            strQuery = strQuery + " where d_no=?";

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, desBean.getD_name());
	            pstmt.setInt(2, desBean.getD_no());
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
		
		// 디자이너 삭제
		public boolean designerDelete(int d_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "delete from designer where d_no =?";

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, d_no);
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
