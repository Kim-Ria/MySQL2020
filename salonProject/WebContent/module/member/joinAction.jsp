<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="member" class="salonProject.MemberBean" scope="page" />
<jsp:setProperty name="member" property="id" />
<jsp:setProperty name="member" property="pw" /> 
<jsp:setProperty name="member" property="name" /> 
<jsp:setProperty name="member" property="address" /> 
<jsp:setProperty name="member" property="phone" /> 

<!DOCTYPE html>
<head>
</head>

<body>
<%
	String id=null;
    if(session.getAttribute("id")!=null){
        id = (String) session.getAttribute("id");
    }
    if(id!=null){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 로그인이 되어있습니다.')");
        script.println("location.href='index.jsp'");
        script.println("</script>");
    }
    
    MemberDAO dao = MemberDAO.getInstance();
    int result = dao.insertMember(member); // 회원 가입
    
    if(result == -1){ // -1: 중복되는 아이디
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('존재하는 아이디입니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result == 1){ // 회원가입 성공
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입 완료')");
        script.println("location.href='../../index_salon.jsp?CONTENTPAGE=member/login.jsp'");
        script.println("</script>");
    }
    else { // DB 문제 발생
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
