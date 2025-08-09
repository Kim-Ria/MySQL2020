<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<head>
  <title>회원가입</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    #logo {
      margin-top: 50px;
      margin-bottom: 30px;
      width: 100px; height: 100px;
    }
    input {
      width: 350px; height: 30px;
      margin-bottom: 15px;
    }
    button{
      margin-top: 20px;
      width:359px; height: 35px;
      background-color: #A6837B;
      border: none;
      color: white;
    }
    label{ font-size: 15px; color: #402E24; }
  </style>
</head>

<body>
  <center>
    <div id="join">
      <center><img src="img/logo1.png" alt="로고" id="logo"></center>

      <div id="join_form">
      <form method="post" action="module/member/joinAction.jsp">
        <label>아이디<br>
        <input type="text" name="id" required></label><br>

        <label>비밀번호<br>
        <input type="password" name="pw" required></label> <br>

        <label>이름<br>
        <input type="text" name="name" required></label><br>

        <label>주소<br>
        <input type="text" name="address" required></label><br>

        <label>전화번호<br>
        <input type="tel" name="phone" required placeholder="010-1234-1234" pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"></label><br>

        <button type="submit" name="button">회원가입</button>
      </form>
    </div>
  </center>
</body>
