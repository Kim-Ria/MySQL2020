<%@page import="org.apache.catalina.ha.backend.Sender"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="salonProject.BoardDAO"%>
<%@page import="salonProject.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<?php include 'html/menu_salon.html'; ?>
<!DOCTYPE html>
<html>
  <head>
    <title>게시판</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      table { margin-top: 30px;}
      th {
        text-align: left; font-size: 18px;
        border-bottom: 1px solid #BFB2AA; padding: 7px;
      }
      td {
        font-size: 15px;
        border-bottom: 1px solid #BFB2AA; padding: 7px;
      }
      #content { vertical-align: top; }
    </style>
  </head>
  <body>
  <%
  	BoardDAO dao = new BoardDAO();
  	BoardBean board = dao.getBoard(Integer.parseInt(request.getParameter("b_no")));
  %>
    <center>
      <table border="0" width="900px">
        <tr>
          <th colspan="2"><%=board.getTitle() %></th>
        </tr>
        <tr>
          <td width="100px"><%=board.getWriter() %></td>
          <td width=""><%=board.getWrite_date() %></td>
        </tr>
        <tr>
          <td colspan="2" height="500px" id="content"><%=board.getContent() %></td>
        </tr>
      </table>
    <%
      if(session.getAttribute("id") != null && session.getAttribute("id").equals(board.getWriter())){
	%>
		<button type="button" class="change_btn" name="button" onclick="location.href='index_salon.jsp?CONTENTPAGE=board/update.jsp&b_no=<%=board.getB_no()%>'">
	      	수정 </button>
		<button type="button" class="change_btn" name="button" onclick="func_confirm()">
	      	삭제 </button>
	      	
      	<script type="text/javascript">
       	function func_confirm () {
       		if(confirm('정말 삭제하시겠습니까?')){
       			location.href='module/board/deleteAction.jsp?no=<%= board.getB_no()%>';
       		} else {
       			alert("cancle");
       		}
       	}
       	</script>
	    <br>
	<%
  		}
    %>
      <button type="button" class="list_btn" name="button" onclick="location.href='index_salon.jsp?CONTENTPAGE=board/list.jsp'">
      	목록으로 </button>
    </center>
  </body>
</html>
