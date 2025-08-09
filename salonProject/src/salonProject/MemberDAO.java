package salonProject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberDAO {
	
	private static MemberDAO instance;
	
	DBConnectionManager db;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
    private MemberDAO(){}
    public static MemberDAO getInstance(){
        if(instance==null)
            instance=new MemberDAO();
        return instance;
    }
    
    // 회원 가입
    public int insertMember(MemberBean member){
    	int result = 0;
		try {
			db = DBConnectionManager.getInstance();
			conn = db.getConnection();
			
			// 아이디 중복 체크
			String query = "select * from member where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) return -1;
			
			// 중복되지 않은 경우
			else {
				query = "insert into member values (?, ?, ?, ?, ?)";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPw());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getAddress());
				pstmt.setString(5, member.getPhone());
				int count = pstmt.executeUpdate();
				
				if(count==1) // 회원가입 성공
					return 1;
			}
			
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		finally {
			try {
				if(pstmt!=null) { pstmt.close(); pstmt=null; }
				if(conn!=null) { conn.close(); conn=null; }
			} catch(Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		return result;
	}
    
    // 로그인
    public int loginMember(String id, String pw){
		try {
            db = DBConnectionManager.getInstance();
			conn = db.getConnection();
			
			String query = "select pw from member where id=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){ // 회원 정보 존재하는 경우
				if(rs.getString("pw").equals(pw)){ // 비밀번호도 같은 경우
					return 1; // 로그인 성공
				}else{ // 비밀번호 다른 경우
					return 0; // 로그인 실패
				}
			}else{ // 가입하지 않은 사용자
				return -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
            return -2; // DB 문제 발생
        } finally {
            try{
                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
                if ( conn != null ){ conn.close(); conn=null;    }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
        }
	}
    
    // 회원 정보 가져오기
    public MemberBean getMemberInfo(String id){
    	try {
            MemberBean member = new MemberBean();
            db = DBConnectionManager.getInstance();
			conn = db.getConnection();
			
			String query = "select * from member where id=?"; // id로 조회 
			
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member.setId(rs.getString("id"));
				member.setPw(rs.getString("pw"));
				member.setName(rs.getString("name"));
				member.setAddress(rs.getString("address"));
				member.setPhone(rs.getString("phone"));
			}
			return member;
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        } finally {
            try{
                if ( pstmt != null ){ pstmt.close(); pstmt=null; }
                if ( conn != null ){ conn.close(); conn=null;    }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
        }
    }
	
	// 회원 정보 수정
	public int updateMember(MemberBean member){
		DBConnectionManager manager = new DBConnectionManager();
		try {
			conn = manager.getConnection();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		String query = "update member set pw=?, address=?, phone=? where id=?";
		
		try{
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, member.getPw());
			pstmt.setString(2, member.getAddress());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getId());
			pstmt.executeUpdate();
		}catch(SQLException e){
			return 0;
		}
		return 1;
	}
	
	// 관리자 확인		
	public boolean adminCheck(String admin_id, String admin_pw)
    {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        boolean loginCon = false;
        try
        {
            con = db.getConnection();
            String strQuery = "select admin_id, admin_pw from admin where admin_id = ? and admin_pw = ?";
            pstmt = con.prepareStatement(strQuery);
            pstmt.setString(1, admin_id);
            pstmt.setString(2, admin_pw);
            rs = pstmt.executeQuery();
            loginCon = rs.next();
        }
        catch (Exception ex)
        {
            System.out.println("Exception" + ex);
        }
        finally 
        {
        	db.freeConnection(con, pstmt, rs);
        }
        return loginCon;
    }
	
	// 회원 탈퇴
	public boolean deleteMember(String id) {
		 Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "delete from member where id =?"; // 현재 로그인 한 id 탈퇴

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
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
