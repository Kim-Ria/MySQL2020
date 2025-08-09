<%@page import="salonProject.ReservationDAO"%>
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
	ReservationDAO dao = new ReservationDAO();
	boolean result = dao.reserveDelete(request.getParameter("no"));

    if(result){ // true: 예약 취소 성공
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('예약이 취소되었습니다.')");
        script.println("location.href='index_salon.jsp?CONTENTPAGE=salon/reservation_list.jsp'");
        script.println("</script>");
    }
    else { 
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('취소 실패')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
</html>