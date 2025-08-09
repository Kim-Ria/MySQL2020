<%@page import="salonProject.MemberBean"%>
<%@page import="salonProject.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="member" class="salonProject.MemberBean"/>
<script type="text/javascript">
    function changeForm(val){
        if(val == "-1"){
            location.href="MainForm.jsp";
        }else if(val == "0"){
            location.href="MainForm.jsp?contentPage=member/view/ModifyFrom.jsp";
        }else if(val == "1"){
            location.href="MainForm.jsp?contentPage=member/view/DeleteForm.jsp";
        }
    }
</script>

<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="css/style.css">
    <style>
      #update img {
        margin-top: 30px; margin-bottom: 30px;
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
        border: none; color: white;
      }

      label{ font-size: 15px; color: #402E24; }
    </style>
  </head>
  <body>
  <%
	//세션에 저장된 아이디를 가져와서
  	// 그 아이디 해당하는 회원정보를 가져온다.
    String id = session.getAttribute("id").toString();
        
    MemberDAO dao = MemberDAO.getInstance();
    member = dao.getMemberInfo(id);
  %>

    <center>
      <div id="update">
        <center><h3>회원 정보 수정</h3></center>
        <form method="post" action="module/member/updateAction.jsp">
          <label>아이디<br>
          <input type="text" name="id" value=<%=member.getId() %> readonly></label><br>

          <label>비밀번호<br>
          <input type="password" name="pw" required></label> <br>

          <label>이름<br>
          <input type="text" name="name" value=<%=member.getName() %> readonly></label><br>

          <label>주소<br>
          <input type="text" name="address" value=<%=member.getAddress() %> required></label><br>

          <label>전화번호<br>
          <input type="tel" name="phone" required value=<%= member.getPhone() %> placeholder="010-1234-1234" pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"></label><br>

          <button type="submit" name="button">수정하기</button>
          <br>
          <button type="button" name="button" onclick="func_confirm()">회원탈퇴</button>
          <script>
          	function func_confirm(){
          		if(confirm('정말 탈퇴하시겠습니까?')){
           			location.href='module/member/deleteAction.jsp';
           		}
          	}
          </script>
        </form>
      </div>
    </center>
  </body>
</html>
