package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AcademyDAO 
{
	private DBConnectionManager db = null;
	
	public AcademyDAO() 
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
	
	//아카데미 등록
	public boolean academyInsert(AcademyBean acdBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     boolean flag = false;
	     
	     try 
	        {
	            con = db.getConnection();
	            String strQuery = "insert into academy values(?,?,?,?,?);";
	            
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, acdBean.getA_no());
	            pstmt.setString(2, acdBean.getLecture_name());
	            pstmt.setInt(3, acdBean.getD_no());
	            pstmt.setInt(4, acdBean.getTuition());
	            pstmt.setInt(5, acdBean.getParticipants());
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
	
	//아카데미 하나 가져오기 (상세 조회)
	public AcademyBean getAcademy(int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        AcademyBean acdBean = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from academy where a_no=?"; // 강좌 번호로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, a_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	acdBean = new AcademyBean();
            	acdBean.setA_no(rs.getInt("a_no"));
            	acdBean.setLecture_name(rs.getString("lecture_name"));
            	acdBean.setD_no(rs.getInt("d_no"));
            	acdBean.setTuition(rs.getInt("tuition"));
            	acdBean.setParticipants(rs.getInt("participants"));
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
        return acdBean;
    }
	
	// 아카데미 강좌 이름 가져오기
	public String getAcademyName(int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = null;

        try 
        {
            con = db.getConnection();
            String strQuery = "select lecture_name from academy where a_no=?"; // 선택된 강좌 번호로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, a_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	name = rs.getString("lecture_name");
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
	
	// 강좌 전체 조회
	public List<AcademyBean> getAcademyList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<AcademyBean> acdList = new ArrayList<AcademyBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from academy join designer where academy.d_no = designer.d_no;"; // designer 이름도 같이 조회
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	AcademyBean acdBean = new AcademyBean();
            	acdBean.setA_no(rs.getInt("a_no"));
            	acdBean.setLecture_name(rs.getString("lecture_name"));
            	acdBean.setD_no(rs.getInt("d_no"));
            	acdBean.setTuition(rs.getInt("tuition"));
            	acdBean.setParticipants(rs.getInt("participants"));
            	acdBean.setD_name(rs.getString("d_name"));
            	acdList.add(acdBean);
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
        return acdList;
    }
	
	// 강좌 정보 수정
	public boolean academyUpdate(AcademyBean acdBean)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update academy set lecture_name=?, tuition=?, participants=?";
            strQuery = strQuery + " where a_no=?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, acdBean.getLecture_name());
            pstmt.setInt(2, acdBean.getTuition());
            pstmt.setInt(3, acdBean.getParticipants());
            pstmt.setInt(4, acdBean.getA_no());
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
	
	// 수강 인원 정보 받아오기
	public int countParticipants(int a_no) {
		Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int participants = 0;

        try 
        {
            con = db.getConnection();
            String strQuery = "select participants from academy where a_no=?"; // 선택된 강좌 번호로 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, a_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	participants = rs.getInt("participants");
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
        return participants;
	}
	
	// 수강 인원 정보 수정 (-1)
	public boolean participantsSub(int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update academy set participants=participants-1 where a_no=?"; // 수강신청 시 수강 가능 인원 -1 되도록

            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, a_no);
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
	// 수강 인원 정보 수정 (-1)
	public boolean participantsPlus(int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update academy set participants=participants+1 where a_no=?"; // 수강취소 시 수강 가능 인원 +1 되도록

            pstmt = con.prepareStatement(strQuery);	
            pstmt.setInt(1, a_no);
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
	
	
	// 아카데미 삭제
	public boolean academyDelete(int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "delete from academy where a_no =?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, a_no);
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
