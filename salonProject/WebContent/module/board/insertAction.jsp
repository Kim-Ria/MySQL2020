<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="salonProject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
	boaBean.setWriter(session.getAttribute("id").toString());
	boolean result = dao.boardInsert(boaBean); // 글 등록

    if(result){ // true: 등록 성공
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('등록 완료')");
        script.println("location.href='../../index_salon.jsp?CONTENTPAGE=board/list.jsp'");
        script.println("</script>");
    }
    else{ // DB 문제
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
