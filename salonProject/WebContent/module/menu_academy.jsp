<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="css/menu.css">
  </head>

  <body>
    <div id="logo_img">
      <img src="img/logo2.png" alt="로고" width="80px" height="40px" onclick="location.href='index.jsp'">
    </div>
    <ul id="mainmenu">
      <li><a href="index_academy.jsp">아카데미</a>
        <ul id="submenu">
          <li><a href="index_salon.jsp">미용실</a></li>
          <li><a href="index_academy.jsp">아카데미</a></li>
        </ul>
      </li>
      <li><a href="index_academy.jsp?CONTENTPAGE=academy/lecture.jsp">강좌소개</a>
        <ul id="submenu">
          <li><a href="index_academy.jsp?CONTENTPAGE=academy/lecture.jsp">강좌소개</a></li>
          <li><a href="index_academy.jsp?CONTENTPAGE=academy/designer.jsp">강사소개</a></li>
        </ul>
      </li>
      <li><a href="index_academy.jsp?CONTENTPAGE=academy/reservation.jsp&n=0">강좌예약</a>
      	<ul id="submenu">
          <li><a href="index_academy.jsp?CONTENTPAGE=academy/reservation.jsp&n=0">강좌예약</a></li>
          <li><a href="index_academy.jsp?CONTENTPAGE=academy/list.jsp">예약조회</a></li>
        </ul>
      </li>
      <li><a href="index_academy.jsp?CONTENTPAGE=board/list.jsp">고객센터</a></li>
      <li><a href="index_academy.jsp?CONTENTPAGE=member/academy_mypage.jsp">마이페이지</a></li>
      <%
      if(session.getAttribute("id") == null) // 로그인이 안되었을 때
      { 
    	 out.print("<li><a id='login_status' href='index_academy.jsp?CONTENTPAGE=member/login.jsp'>로그인</a></li>");
      }
      else // 로그인 했을 경우
      {
    	out.print("<li><a id='login_status' href='module/member/logoutAction.jsp'>로그아웃</a></li>");
      }
      %>
    </ul>
    <br><hr width="100%">
  </body>
</html>
