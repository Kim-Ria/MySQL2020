<%@page import="java.io.PrintWriter"%>
<%@page import="salonProject.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.deleteMember(session.getAttribute("id").toString()); // 현재 로그인 된 id 탈퇴

    if(result){ // true : 탈퇴 성공
    	session.invalidate(); // 로그인 정보 지우기
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원 탈퇴가 완료되었습니다.')");
        script.println("location.href='../../index.jsp'");
        script.println("</script>");
    }
    else { // DB 문제
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('탈퇴 실패')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>