<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

<%@page import="salonProject.MemberBean"%>
<%@page import="salonProject.MemberDAO"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="member" class="salonProject.MemberBean" />
<jsp:setProperty property="id" name="member"/>
<jsp:setProperty property="pw" name="member"/>

<!DOCTYPE html>
<head>
</head>

<body>
<%
		MemberDAO dao = MemberDAO.getInstance();
		int result = dao.loginMember(member.getId(), member.getPw());
		
		//로그인 성공
		if(result == 1){
			PrintWriter script = response.getWriter();
			session.setAttribute("id", member.getId());
			script.println("<script>");
			script.println("location.href = '../../index_salon.jsp'");
			script.println("</script>");
		}
		//로그인 실패
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('잘못된 비밀번호입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}

		//아이디 없음
		else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('가입하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
		}
		
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('DB 문제')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
