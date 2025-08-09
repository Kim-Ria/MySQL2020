<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Date"%>
<%@page import="salonProject.ReservationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="resBean" class="salonProject.ReservationBean" scope="page" />
<jsp:setProperty name="resBean" property="t_no" />
<jsp:useBean id="desBean" class="salonProject.DesignerBean" scope="page" />
<jsp:setProperty name="desBean" property="d_no" />
<jsp:useBean id="treBean" class="salonProject.TreatmentBean" scope="page" />
<jsp:setProperty name="treBean" property="t_no" />
<!DOCTYPE html>
<head>
</head>

<body>
<%
	ReservationDAO dao = new ReservationDAO();
	resBean.setId(session.getAttribute("id").toString());

	//날짜 설정
	//Date d = Date.valueOf(request.getParameter("reservation_date")+request.getParameter("time"));
	//resBean.setReserv_date(d);
	String date = request.getParameter("reservation_date").toString();
	String time = request.getParameter("time").toString();
	//System.out.println("date : "+date+", time : "+time);

	String form = date +" "+time+":00.0";
	java.sql.Timestamp t = java.sql.Timestamp.valueOf(form);
	//System.out.println("form : "+form);

	//SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//Date d = fm.parse(form);

	resBean.setReserv_date(t);


	//Date d = new Date(cal.getTimeInMillis());
	//resBean.setReserv_date(d);

	// 예약 번호 설정
	Calendar c = Calendar.getInstance();
    int no = c.get(Calendar.MONTH)*100000000 + c.get(Calendar.DATE)*1000000 +
    		c.get(Calendar.HOUR)*10000 + c.get(Calendar.MINUTE)*100 + c.get(Calendar.SECOND);
	resBean.setR_no(no);

	// 디자이너 번호 설정
	resBean.setD_no(desBean.getD_no());
	// 시술 번호 설정
	resBean.setT_no(treBean.getT_no());
	int result = dao.reserveInsert(resBean);

    if(result==1){ // 1: 예약 성공
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('예약이 완료되었습니다.')");
        script.println("location.href='../../index_salon.jsp?CONTENTPAGE=salon/reservation_list.jsp'");
        script.println("</script>");
    }
    else if(result==0){ // 0: 중복된 예약
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('같은 시간에 예약 내역이 존재합니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else if(result==-1){ //-1: 담당자 중복 시간 예약
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('담당자가 다른 예약이 존재합니다.')");
      script.println("history.back()");
      script.println("</script>");
    }
    else { // DB 문제
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
