<%@page import="salonProject.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="member" class="salonProject.MemberBean" />
<jsp:setProperty property="name" name="member"/>

<!DOCTYPE html>
<html>
  <head>
  	<meta charset="utf-8">
    <link rel="stylesheet" href="css/style.css">
    <style>
      table { margin-top: 30px; margin-bottom: 30px; }
      caption { text-align: left; margin-left: 8px; font-size: 20px; margin-bottom: 10px;}
      td {
        border: 3px solid white;
        width: 300px; height: 450px;
        background-color: #BFB2AA;
        margin: 5px;
        text-align: center;
      }
    </style>
  </head>
  <body>
  	<%
  	//로그인이 되어있지 않은 경우
  	if(session.getAttribute("id") == null){
  		PrintWriter script = response.getWriter();
  		script.println("<script>alert('로그인이 필요한 메뉴 입니다.');");
  		script.println("location.href='index_salon.jsp?CONTENTPAGE=member/login.jsp'</script>");
  	} else {
  	%>
   	<center>
      <table width="900px">
        <tr>
          <td onclick="location.href='index_salon.jsp?CONTENTPAGE=member/update.jsp'">회원 정보 수정</td>
          <td onclick="location.href='index_salon.jsp?CONTENTPAGE=salon/reservation_list.jsp'">예약 조회</td>
          <td onclick="location.href='index_salon.jsp?CONTENTPAGE=salon/purchase_list.jsp'">구매 내역 조회</td>
          <td onclick="location.href='index_salon.jsp?CONTENTPAGE=board/listMy.jsp'">내가 쓴 글 조회</td>
        </tr>
      </table>
     </center>
     <%} %>
  </body>
</html>
