package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LectureDAO 
{
private DBConnectionManager db = null;
	
	public LectureDAO() 
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
	
	// 강좌 수강 정보 등록
	public int lectureInsert(LectureBean lecBean)
	{
		 Connection con = null;
	     PreparedStatement pstmt = null;
	     ResultSet rs = null;
	     int flag = 0;
	     
	     try 
	        {
	            con = db.getConnection();
	            
	            // 같은 시간 예약 내역 존재하는지 확인
	            String check = "select * from lecture where id=? and lecture_date=?"; 
	            pstmt = con.prepareStatement(check);
	            pstmt.setString(1, lecBean.getId());
	            pstmt.setTimestamp(2, lecBean.getLecture_date());
	            rs = pstmt.executeQuery();
	            
	            if (rs.next())
	            	flag = 0; // 같은 시간 예약 내역 존재
	            
	            // 같은 시간 예약 내역 존재하지 않는 경우
	            else { 
	            	AcademyDAO adao = new AcademyDAO();
	            	
	            	// 남은 수강 인원 확인
	            	int participants = adao.countParticipants(lecBean.getA_no());
	            	if(participants == 0) return -2; // 수강 인원 초과
	            	
	            	// 수강인원 초과하지 않는 경우
	            	else {
			            String strQuery = "insert into lecture values(?,?,?,?);"; // 수강 정보 insert
			            pstmt = con.prepareStatement(strQuery);
			            pstmt.setInt(1, lecBean.getL_no());
			            pstmt.setString(2, lecBean.getId());
			            pstmt.setInt(3, lecBean.getA_no());
			            pstmt.setTimestamp(4, lecBean.getLecture_date());
			            int count = pstmt.executeUpdate();
				            
			            if (count == 1)
			            {
			            	if(adao.participantsSub(lecBean.getA_no())) // 강좌 수강 가능 인원 -1
			            		flag = 1; // 수강 신청, 수강 인원 -1 성공
			            	else { // 수강 인원 update 실패
			            		lectureDelete(lecBean.getA_no(), lecBean.getA_no()); // 수강 신청 취소
			            		flag = -1; // 수강 신청 실패 DB 문제
			            	}
			            }
	            	}
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
	        return flag; // 1: 등록 성공 / 0: 같은 시간 예약 내역 존재 / -1: DB 문제 발생 / -2: 수강인원 초과
	}
	
	// 상위 수강 예약 내역 조회
	public List<LectureBean> getLectureRankList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<LectureBean> lecList = new ArrayList<LectureBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select a.lecture_name, l.a_no, count(l.a_no) from lecture l join academy a where l.a_no=a.a_no"
            		+ " group by l.a_no order by count(l.a_no) desc;"; // 수강신청 많이 된 순으로 정렬
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	LectureBean lecBean = new LectureBean();
            	DesignerBean desBean = new DesignerBean();
            	lecBean.setA_no(rs.getInt("a_no"));
            	//desBean.setD_name("d_name");
            	
            	lecList.add(lecBean);
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
        return lecList;
    }
	
	// 수강 정보 상세 조회
	public LectureBean getLecture(int l_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        LectureBean lecBean = null;
        AcademyBean acdBean = new AcademyBean();
        DesignerBean desBean = new DesignerBean();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from academy a join lecture l on a.a_no = l.a_no join"
            		+ " designer d on a.d_no=d.d_no where l_no=?"; // 수강 번호로 전체 정보 조회
            pstmt = con.prepareStatement(strQuery);
            pstmt.setInt(1, l_no);
            rs = pstmt.executeQuery();

            if (rs.next()) 
            {
            	lecBean = new LectureBean();
            	lecBean.setL_no(rs.getInt("l_no"));
            	lecBean.setId(rs.getString("id"));
            	lecBean.setA_no(rs.getInt("a_no"));
            	lecBean.setLecture_date(rs.getTimestamp("lecture_date"));
            	
            	acdBean.setLecture_name(rs.getString("lecture_name"));
            	acdBean.setTuition(rs.getInt("tuition"));
            	acdBean.setParticipants(rs.getInt("participants"));
            	lecBean.setAcademy(acdBean);
            	
            	desBean.setD_name(rs.getString("d_name"));
            	lecBean.setDesigner(desBean);
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
        return lecBean;
    }
	
	// 존재하는 예약 내역 전체 조회
	public List<LectureBean> getLectureList() 
    {
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        List<LectureBean> lecList = new ArrayList<LectureBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from academy a join lecture l on a.a_no = l.a_no join designer d on a.d_no=d.d_no;";
            
            stmt = con.createStatement();
            rs = stmt.executeQuery(strQuery);

            while (rs.next()) {
            	LectureBean lecBean = new LectureBean();
            	AcademyBean acdBean = new AcademyBean();
                DesignerBean desBean = new DesignerBean();
                
            	lecBean.setL_no(rs.getInt("l_no"));
            	lecBean.setId(rs.getString("id"));
            	lecBean.setA_no(rs.getInt("a_no"));
            	lecBean.setLecture_date(rs.getTimestamp("lecture_date"));
            	
            	acdBean.setLecture_name(rs.getString("lecture_name"));
            	acdBean.setTuition(rs.getInt("tuition"));
            	acdBean.setParticipants(rs.getInt("participants"));
            	lecBean.setAcademy(acdBean);
            	
            	desBean.setD_name(rs.getString("d_name"));
            	lecBean.setDesigner(desBean);
            	
            	lecList.add(lecBean);
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
        return lecList;
    }
	
	// id별 수강 예약 내역 조회
	public List<LectureBean> getLectureListbyID(String id) 
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<LectureBean> lecList = new ArrayList<LectureBean>();

        try 
        {
            con = db.getConnection();
            String strQuery = "select * from academy a join lecture l on a.a_no = l.a_no "
            		+ "join designer d on a.d_no=d.d_no where id=? order by lecture_date desc;";
            
            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, id);
            
            rs = pstmt.executeQuery();

            while (rs.next()) {
            	LectureBean lecBean = new LectureBean();
            	AcademyBean acdBean = new AcademyBean();
                DesignerBean desBean = new DesignerBean();
                
            	lecBean.setL_no(rs.getInt("l_no"));
            	lecBean.setId(rs.getString("id"));
            	lecBean.setA_no(rs.getInt("a_no"));
            	lecBean.setLecture_date(rs.getTimestamp("lecture_date"));
            	
            	acdBean.setLecture_name(rs.getString("lecture_name"));
            	acdBean.setTuition(rs.getInt("tuition"));
            	acdBean.setParticipants(rs.getInt("participants"));
            	lecBean.setAcademy(acdBean);
            	
            	desBean.setD_name(rs.getString("d_name"));
            	lecBean.setDesigner(desBean);
            	
            	lecList.add(lecBean);
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
        return lecList;
    }
	
	// 수강 예약 내역 변경
	public boolean lectureUpdate(LectureBean lecBean)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        boolean flag = false;
        try 
        {
            con = db.getConnection();
            String strQuery = "update lecture set lecture_date=?";
            strQuery = strQuery + " where l_no=?";

            pstmt = con.prepareStatement(strQuery);
            pstmt.setTimestamp(1, lecBean.getLecture_date());
            pstmt.setInt(2, lecBean.getL_no());
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
	
	// 수강 취소
	public int lectureDelete(int l_no, int a_no)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        int flag = 0;
        try 
        {
        	AcademyDAO adao = new AcademyDAO();
        	
        	
        	// 취소 전 강좌 수강 가능 인원 +1
        	if(adao.participantsPlus(a_no)) { 
        		con = db.getConnection();
                String strQuery = "delete from lecture where l_no =?"; // 수강 취소
                
                pstmt = con.prepareStatement(strQuery);
                pstmt.setInt(1, l_no);
                int count = pstmt.executeUpdate();
                
                if(count==1) { // 수강 인원 +1 & 수강 취소 되면
                	flag = 1;
                } else { // 수강 취소 실패
                	adao.participantsSub(l_no); // 수강인원 원래대로 돌리기
                }
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
        return flag; // 1: 성공 / 0 : 실패
    }
}
