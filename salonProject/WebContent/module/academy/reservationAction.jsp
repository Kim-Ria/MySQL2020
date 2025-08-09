<%@page import="java.util.Calendar"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@page import="salonProject.LectureDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="lecBean" class="salonProject.LectureBean" scope="page" />
<jsp:setProperty name="lecBean" property="a_no" />

<!DOCTYPE html>
<head>
</head>

<body>
<%
	LectureDAO dao = new LectureDAO();
	lecBean.setId(session.getAttribute("id").toString()); // 현재 로그인 한 id로 예약
	
	//날짜 설정
	String day = request.getParameter("lecture_date").toString();
	String time = request.getParameter("time").toString();
	String form = day +" "+time+":00.0";
	java.sql.Timestamp t = java.sql.Timestamp.valueOf(form);
	//System.out.println("form : "+form);
	lecBean.setLecture_date(t);
	
	// 예약 번호 설정
	Calendar c = Calendar.getInstance();
    int no = c.get(Calendar.MONTH)*100000000 + c.get(Calendar.DATE)*1000000 + 
    		c.get(Calendar.HOUR)*10000 + c.get(Calendar.MINUTE)*100 + c.get(Calendar.SECOND);
	lecBean.setL_no(no);
	int result = dao.lectureInsert(lecBean);

    if(result==1){ // 1: 예약 완료
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('예약이 완료되었습니다.')");
        script.println("location.href='../../index_academy.jsp?CONTENTPAGE=academy/list.jsp'");
        script.println("</script>");
    }
    else if(result==0){ // 0: 예약 시간 중복
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('같은 시간에 예약 내역이 존재합니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result==-2){ // -2: 수강 인원 초과
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('수강 인원 초과!')");
        script.println("history.back()");
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
