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
	session.invalidate(); // 모든세션정보 삭제
	response.sendRedirect("../../index_salon.jsp");
%>
</body>
