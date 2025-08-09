<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

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
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.updateMember(member);
	
    if(result == 1){ // 수정 성공
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원 정보 수정 완료')");
        script.println("location.href='../../index_salon.jsp'");
        script.println("</script>");
    }
    else{ // 수정 실패
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('DB 오류')");
        script.println("location.href='../../index_salon.jsp'");
        script.println("</script>");
    }
%>
</body>
