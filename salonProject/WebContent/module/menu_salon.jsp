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
      <li><a href="index_salon.jsp">미용실</a>
        <ul id="submenu">
          <li><a href="index_salon.jsp">미용실</a></li>
          <li><a href="index_academy.jsp">아카데미</a></li>
        </ul>
      </li>
      <li><a href="index_salon.jsp?CONTENTPAGE=salon/reservation.jsp&n=0">예약하기</a>
        <ul id="submenu">
          <li><a href="index_salon.jsp?CONTENTPAGE=salon/treatment.jsp">시술조회</a></li>
          <li><a href="index_salon.jsp?CONTENTPAGE=salon/reservation.jsp&n=0">예약하기</a></li>
          <li><a href="index_salon.jsp?CONTENTPAGE=salon/reservation_list.jsp">예약조회</a></li>
        </ul>
      </li>
      <li><a href="index_salon.jsp?CONTENTPAGE=purchase/list.jsp">상품구매</a></li>
      <li><a href="index_salon.jsp?CONTENTPAGE=board/list.jsp">고객센터</a></li>
      <li><a href="index_salon.jsp?CONTENTPAGE=member/mypage.jsp">마이페이지</a></li>
      <%
      if(session.getAttribute("id") == null) // 로그인이 안되었을 때
      { 
    	  out.print("<li><a id='login_status' href='index_salon.jsp?CONTENTPAGE=member/login.jsp'>로그인</a></li>");
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