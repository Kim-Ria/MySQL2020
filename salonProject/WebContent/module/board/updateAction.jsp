<%@page import="salonProject.BoardDAO"%>
<%@page import="salonProject.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="boaBean" class="salonProject.BoardBean" scope="page" />
<jsp:setProperty name="boaBean" property="b_no" />
<jsp:setProperty name="boaBean" property="bc_no" />  
<jsp:setProperty name="boaBean" property="title" /> 
<jsp:setProperty name="boaBean" property="content" />

<!DOCTYPE html>
<head>
</head>

<body>
<%
	BoardDAO dao = new BoardDAO();
	boolean result = dao.boardUpdate(boaBean);
	
    if(result){ // true: 수정 성공
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('게시물 수정 완료')");
        script.println("location.href='../../index_academy.jsp?CONTENTPAGE=board/list.jsp'");
        script.println("</script>");
    }
    else{ // DB 문제
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("location.href='../../index_salon.jsp'");
        script.println("</script>");
    }
%>
</body>
