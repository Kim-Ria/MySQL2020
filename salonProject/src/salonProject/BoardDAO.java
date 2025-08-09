package salonProject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO 
{
	private DBConnectionManager db = null;
	
	public BoardDAO() 
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
	
	//게시글 등록
		public boolean boardInsert(BoardBean boaBean)
		{
			 Connection con = null;
		     PreparedStatement pstmt = null;
		     boolean flag = false;
		     
		     try 
		        {
		            con = db.getConnection();
		            String strQuery = "insert into board values(?,?,?,?,?,now());"; // 게시글 등록 시간 : 현재 시간
		            pstmt = con.prepareStatement(strQuery);
		            pstmt.setInt(1, boaBean.getB_no());
		            pstmt.setInt(2, boaBean.getBc_no());
		            pstmt.setString(3, boaBean.getWriter());
		            pstmt.setString(4, boaBean.getTitle());
		            pstmt.setString(5, boaBean.getContent());

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
		
		//게시물 하나 상세 조회
		public BoardBean getBoard(int b_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        BoardBean boaBean = null;

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from board where b_no=?"; // 게시물 번호로 조회
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, b_no);
	            rs = pstmt.executeQuery();

	            if (rs.next()) 
	            {
	            	boaBean = new BoardBean();
	            	boaBean.setB_no(rs.getInt("b_no"));
	            	boaBean.setBc_no(rs.getInt("bc_no"));
	            	boaBean.setWriter(rs.getString("writer"));
	            	boaBean.setTitle(rs.getString("title"));
	            	boaBean.setContent(rs.getString("content"));
	            	boaBean.setWrite_date(rs.getDate("write_date"));
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
	        return boaBean;
	    }
		
		//게시글 전체 조회
		public List<BoardBean> getBoardList() 
	    {
	        Connection con = null;
	        Statement stmt = null;
	        ResultSet rs = null;
	        List<BoardBean> boaList = new ArrayList<BoardBean>();

	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from board join board_category where board.bc_no = board_category.bc_no order by b_no desc;"; // 카테고리 이름도 함께 조회
	            stmt = con.createStatement();
	            rs = stmt.executeQuery(strQuery);

	            while (rs.next()) {
	            	BoardBean boaBean = new BoardBean();
	            	boaBean.setB_no(rs.getInt("b_no"));
	            	boaBean.setBc_no(rs.getInt("bc_no"));
	            	boaBean.setCategory(rs.getString("category"));
	            	boaBean.setWriter(rs.getString("writer"));
	            	boaBean.setTitle(rs.getString("title"));
	            	boaBean.setContent(rs.getString("content"));
	            	boaBean.setWrite_date(rs.getDate("write_date"));
	            	
	            	boaList.add(boaBean);
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
	        return boaList;
	    }
		
		//게시글 조회 (카테고리별)
		public List<BoardBean> getBoardListCategory(int bc_no) 
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<BoardBean> boaList = new ArrayList<BoardBean>();
	        
	        try 
	        {
	        	if(bc_no == 0) return getBoardList(); // 선택된 카테고리가 0인 경우 : 전체 조회
	        	
	        	// 선택된 카테고리가 있으면
	        	else {
		            con = db.getConnection();
		            String strQuery = "select * from board join board_category where board.bc_no = board_category.bc_no"
		            		+ " and board.bc_no = ? order by b_no desc;";
		            pstmt = con.prepareStatement(strQuery);
		            pstmt.setInt(1, bc_no);
		            rs = pstmt.executeQuery();
	
		            while (rs.next()) 
		            {
		            	BoardBean boaBean = new BoardBean();
		            	boaBean.setB_no(rs.getInt("b_no"));
		            	boaBean.setBc_no(rs.getInt("bc_no"));
		            	boaBean.setCategory(rs.getString("category"));
		            	boaBean.setWriter(rs.getString("writer"));
		            	boaBean.setTitle(rs.getString("title"));
		            	boaBean.setContent(rs.getString("content"));
		            	boaBean.setWrite_date(rs.getDate("write_date"));
		            	
		            	boaList.add(boaBean);
		            }
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
	        return boaList;
	    }
		
		//게시글 조회 (내 게시글만 조회)
		public List<BoardBean> getBoardListId(String id) 
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;
	        List<BoardBean> boaList = new ArrayList<BoardBean>();
	        
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "select * from board join board_category where board.bc_no = board_category.bc_no "
	            		+ "and writer=? order by b_no desc;"; // 게시글 작성자가 현재 로그인 된 id인 경우만 조회
	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();

	            while (rs.next()) 
	            {
	            	BoardBean boaBean = new BoardBean();
	            	boaBean.setB_no(rs.getInt("b_no"));
	            	boaBean.setBc_no(rs.getInt("bc_no"));
	            	boaBean.setCategory(rs.getString("category"));
	            	boaBean.setWriter(rs.getString("writer"));
	            	boaBean.setTitle(rs.getString("title"));
	            	boaBean.setContent(rs.getString("content"));
	            	boaBean.setWrite_date(rs.getDate("write_date"));
	            	
	            	boaList.add(boaBean);
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
	        return boaList;
	    }
		
		//게시글 수정
		public boolean boardUpdate(BoardBean boaBean)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "update board set bc_no=?, title=?, content=? where b_no=?"; // 카테고리, 제목, 내용 수정

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, boaBean.getBc_no());
	            pstmt.setString(2, boaBean.getTitle());
	            pstmt.setString(3, boaBean.getContent());
	            pstmt.setInt(4, boaBean.getB_no());
	            
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
		
		//게시글 삭제
		public boolean boardDelete(int b_no)
	    {
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        boolean flag = false;
	        try 
	        {
	            con = db.getConnection();
	            String strQuery = "delete from board where b_no =?"; // 게시글 번호로 삭제

	            pstmt = con.prepareStatement(strQuery);
	            pstmt.setInt(1, b_no);
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
