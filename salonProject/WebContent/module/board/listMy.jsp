<%@page import="java.util.Vector"%>
<%@page import="salonProject.BoardDAO"%>
<%@page import="salonProject.BoardBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
  <head>
    <title>게시판</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      th { font-size: 15px; padding-top: 5px; padding-bottom: 5px;}
      td { border-bottom: 1px solid #BFB2AA; padding: 3px;}
      select { width: 110px; height: 25px; }
    </style>
  </head>
  <body>
    <center>
	<%
		BoardDAO dao = new BoardDAO();
		List<BoardBean> boardList = dao.getBoardListId(session.getAttribute("id").toString());
		
		BoardBean board = new BoardBean();
		
		if(boardList.size() == 0){
	%>
	    	<h1>게시물이 없습니다.</h1>
	<%
		}
		else{
	
	%>
	<h1>내 게시물 조회</h1>
      <table border="0">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="150px">분류</th>
          <th width="500px">제목</th>
          <th width="150px">작성날짜</th>
        </tr>
        
    <%
	      	for(int i=0; i<boardList.size(); i++){
        		board = boardList.get(i);
        		String link="index_salon.jsp?CONTENTPAGE=board/details.jsp&b_no="+board.getB_no();
    %>
        	<tr>
	          <td><a href="<%=link%>"><%=board.getB_no() %></a></td>
	          <td><%=board.getCategory() %></td>
	          <td><a href="<%=link%>"><%=board.getTitle() %></a></td>
	          <td><%=board.getWrite_date() %></td>
	        </tr>
    <%
        	}
		}
    %>
      </table>
    </center>
  </body>
</html>
