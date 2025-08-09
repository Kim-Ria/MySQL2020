package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO 
{
private DBConnectionManager db = null;
	
	public ReservationDAO() 
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
	
	//예약 등록
	public int reserveInsert(ReservationBean resBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;
	     int flag = 0;
	     
	     try 
	        {	
	            con = db.getConnection();
	            
	            // 같은 시간 예약 내역 존재하는지 확인
	            String check = "select * from reservation where id=? and reserv_date=?";
	            pstmt = con.prepareStatement(check);
	            pstmt.setString(1, resBean.getId());
	            pstmt.setTimestamp(2, resBean.getReserv_date());
	            System.out.println(resBean.getReserv_date().toString());
	            rs = pstmt.executeQuery();

	            if (rs.next())
	            	return 0; // 같은 시간 예약 내역 존재 > 예약 불가능 

		//담당자의 다른 손님 예약이 존재하는지 확인
	            String dCheck = "select * from reservation where d_no=? and reserv_date=?";
	            pstmt = con.prepareStatement(dCheck);
	            pstmt.setInt(1, resBean.getD_no());
	            pstmt.setTimestamp(2, resBean.getReserv_date());
	            System.out.println(resBean.getReserv_date().toString());
	            rs = pstmt.executeQuery();
	            //담당자가 시간이 남지않으면
	            if(rs.next())
	            	return -1;	   
         
	            // 같은 시간 예약 내역이 존재하지 않고, 담당자또한 시간이 남을 때 
	            	String strQuery = "insert into reservation values(?,?,?,?,?);"; // 예약 등록
	 	            pstmt = con.prepareStatement(strQuery);
	 	            pstmt.setInt(1, resBean.getR_no());
	 	            pstmt.setString(2, resBean.getId());
	 	            pstmt.setInt(3, resBean.getT_no());
	 	            pstmt.setInt(4, resBean.getD_no());
	 	            pstmt.setTimestamp(5, resBean.getReserv_date());
	 	            int count = pstmt.executeUpdate();
		            if (count == 1)
		            {
		                flag = 1;
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
	
	//예약 상세 조회
	public ReservationBean getReserve(String r_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        ReservationBean resBean = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from reservation where r_no=?"; // 예약 번호로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, r_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	resBean = new ReservationBean();
            	resBean.setR_no(rs.getInt("r_no"));
            	resBean.setId(rs.getString("id"));
            	resBean.setT_no(rs.getInt("t_no"));
            	resBean.setD_no(rs.getInt("d_no"));
            	resBean.setReserv_date(rs.getTimestamp("reserv_date"));
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
        return resBean;
    }
	
	// 전체 예약 내역 조회
	public List<ReservationBean> getReserveList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<ReservationBean> resList = new ArrayList<ReservationBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from treatment;";
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	ReservationBean resBean = new ReservationBean();
            	
            	resBean.setR_no(rs.getInt("r_no"));
            	resBean.setId(rs.getString("id"));
            	resBean.setT_no(rs.getInt("f_no"));
            	resBean.setD_no(rs.getInt("d_no"));
            	resBean.setReserv_date(rs.getTimestamp("reserv_date"));
            	
            	
            	resList.add(resBean);
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
        return resList;
    }
	
	// id별 예약 내역 조회
	public List<ReservationBean> getReserveListbyID(String id) 
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<ReservationBean> resList = new ArrayList<ReservationBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from reservation r join treatment t on r.t_no = t.t_no "
            		+ "join designer d on r.d_no=d.d_no where id=? order by reserv_date desc;";
            
            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, id);
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	ReservationBean resBean = new ReservationBean();
            	
            	resBean.setR_no(rs.getInt("r_no"));
            	resBean.setId(rs.getString("id"));
            	resBean.setT_no(rs.getInt("t_no"));
            	resBean.setD_no(rs.getInt("d_no"));
            	resBean.setReserv_date(rs.getTimestamp("reserv_date"));
            	
            	resList.add(resBean);
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
        return resList;
    }
	
	//예약 수정
	public boolean ReserveUpdate(ReservationBean resBean)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update reservation set reserv_date=?";
            strQuery = strQuery + " where l_no=?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setTimestamp(1, resBean.getReserv_date());
            pstmt.setInt(2, resBean.getR_no());
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
	
	//날짜 format
	public java.sql.Date convert(java.util.Date uDate) {
		java.sql.Date sDate = new java.sql.Date(uDate.getTime());
		return sDate;
	}
	
	//예약 취소
	public boolean reserveDelete(String r_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "delete from reservation where r_no =?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, r_no);
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
