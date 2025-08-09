<%@page import="salonProject.BoardBean"%>
<%@page import="salonProject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>게시판</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      table { margin-top: 20px; }
      th {
        text-align: left;
        font-size: 18px;
        border-bottom: 1px solid #BFB2AA;
      }
      td {
        font-size: 15px;
        border-bottom: 1px solid #BFB2AA;
        padding: 3px
      }
      input {width: 860px; height: 30px;}
      select{width: 120px; height: 30px;}
      textarea{padding: 15px;}
      button{margin-top: 10px; margin-bottom: 10px;}
    </style>
  </head>
  <body>
   <%
  	BoardDAO dao = new BoardDAO();
  	BoardBean board = dao.getBoard(Integer.parseInt(request.getParameter("b_no")));
  	%>
    <form method="post" action="module/board/updateAction.jsp">
      <center>
        <table border="0" width="1000px">
          <tr>
            <td width="120px" height="40px">
              <select name="bc_no">
                <option value="2">시술후기</option>
	            <option value="3">아카데미후기</option>
	            <option value="4">질문게시판</option>
              </select>
            </td>
            <td><input type="text" name="title" placeholder="제목을 입력하세요. (최대 30자)" maxlength="30" required value="<%=board.getTitle()%>"></td>
          </tr>
          <tr>
            <td colspan="2" height="450px">
              <textarea name="content" rows="28" cols="138" maxlength="100"
              	placeholder="내용을 입력하세요. (최대 1000자)" required><%=board.getContent() %></textarea>
            </td>
          </tr>
        </table>
        <input type="text" name="b_no" value="<%=board.getB_no()%>" hidden="hidden">
        <button type="submit" class="insert_btn" name="button"> 수정하기
        </button>
      </center>
    </form>
  </body>
</html>
