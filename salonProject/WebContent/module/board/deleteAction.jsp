<%@page import="salonProject.BoardDAO"%>
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
	BoardDAO dao = new BoardDAO();
	boolean result = dao.boardDelete(Integer.parseInt(request.getParameter("no"))); // 선택된 글 번호로 삭제

    if(result){ // true: 삭제 성공
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('글이 삭제되었습니다.')");
        script.println("location.href='../../index_salon.jsp?CONTENTPAGE=board/list.jsp'");
        script.println("</script>");
    }
    else { // 실패
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('삭제 실패')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>