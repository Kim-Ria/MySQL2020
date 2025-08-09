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
    	String insertLink = "";
    	if(session.getAttribute("id") != null){
    		insertLink = "location.href='index_salon.jsp?CONTENTPAGE=board/insert.jsp'";
    	} else{
    		insertLink = "alert('로그인이 필요한 메뉴입니다.');";
    	}
    %>
      <button type="button" id="new_btn" onclick="<%=insertLink%>">새 글</button>
      <div id="select_category">
        <form action="board/list.jsp" method="get">
          카테고리 선택:
          <select name="category" onchange="location.href='index_salon.jsp?CONTENTPAGE=board/list.jsp?category='+this.value">
          	<option selected hidden>카테고리선택</option>
            <option value="0">전체보기</option>
            <option value="1">공지사항</option>
            <option value="2">시술후기</option>
            <option value="3">아카데미후기</option>
            <option value="4">질문게시판</option>
          </select>
        </form>
      </div>
	
	<%
		BoardDAO dao = new BoardDAO();
		List<BoardBean> boardList = dao.getBoardList();
		
		if(request.getParameter("category") != null){ // 카테고리별 조회
			boardList = dao.getBoardListCategory(Integer.parseInt(request.getParameter("category")));
	 	}
		
		BoardBean board = new BoardBean();
		
		if(boardList.size() == 0){
	%>
	    	<h1>게시물이 없습니다.</h1>
	<%
		}
		else{
	
	%>
      <table border="0">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="150px">분류</th>
          <th width="500px">제목</th>
          <th width="100px">작성자</th>
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
	          <td><%=board.getWriter() %></td>
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
