<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<head>
  <title>로그인</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    input {
      width: 300px; height: 30px;
      margin-top: 20px;
    }
    #loginbtn {
      margin-top: 30px;
      width:305px; height: 35px;
      background-color: #A6837B;
      border: none;
      color: white;
    }
    #joinbtn{
      background-color: white;
      color:#402E24;
      width:305px; height: 32px;
      border: 1.5px solid #A6837B;
      margin-top: 50px;
    }
    #logo {
      margin-top: 50px;
      margin-bottom: 30px;
      width: 100px; height: 100px;
    }
  </style>
</head>

<body>
  <center>
    <div id="login">
      <img src="img/logo1.png" alt="로고" id="logo">
      <div id="login_form">
	      <form method="post" action="module/member/loginAction.jsp">
	        <input type="text" name="id" placeholder="아이디" autofocus required> <br>
	        <input type="password" name="pw" placeholder="비밀번호" required> <br>
	        <button type="submit" id="loginbtn">로그인</button>
	      </form>
	      <button type="button" name="join" onclick="location.href='index_academy.jsp?CONTENTPAGE=member/join.jsp'" id="joinbtn">회원가입</button>
    </div>
  </center>
</body>
