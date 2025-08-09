<%@page import="salonProject.LectureDAO"%>
<%@page import="java.io.PrintWriter"%>
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
	LectureDAO dao = new LectureDAO();
	int result = dao.lectureDelete(Integer.parseInt(request.getParameter("no")), Integer.parseInt(request.getParameter("a_no")));

    if(result==1){ // 취소 성공
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('예약이 취소되었습니다.')");
        script.println("location.href='index_academy.jsp?CONTENTPAGE=academy/list.jsp'");
        script.println("</script>");
    }
    else { // 취소 실패
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('취소 실패')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>