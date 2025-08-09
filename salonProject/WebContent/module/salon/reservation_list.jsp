<%@page import="salonProject.ReservationBean"%>
<%@page import="salonProject.ReservationDAO"%>
<%@page import="salonProject.DesignerDAO"%>
<%@page import="salonProject.DesignerBean"%>
<%@page import="salonProject.TreatmentBean"%>
<%@page import="salonProject.TreatmentDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
  <head>
    <title>게시판</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      th { font-size: 15px; padding-top: 5px; padding-bottom: 5px;}
      td { border-bottom: 1px solid #BFB2AA; padding: 3px;}
      select { width: 110px; height: 25px; }
    </style>
  </head>
  <body>
    <%
  	//로그인이 되어있지 않은 경우
  	if(session.getAttribute("id") == null){
  		PrintWriter script = response.getWriter();
  		script.println("<script>alert('로그인이 필요한 메뉴 입니다.');");
  		script.println("location.href='index_academy.jsp?CONTENTPAGE=member/login.jsp'</script>");
  	} else {
    %>
    <center>
	<%
		ReservationDAO dao = new ReservationDAO();
		String id = session.getAttribute("id").toString();
		List<ReservationBean> resList = dao.getReserveListbyID(id);
		
		DesignerDAO desDao = new DesignerDAO();
		TreatmentDAO treDao = new TreatmentDAO();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		if(resList.size() == 0){
	%>
	    	<h1>시술 예약 내역이 없습니다.</h1><br>
	<%
		}
		else{
	
	%>
	<h1>시술 예약 내역</h1>
      <table border="0" align="center" text-algin="center">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="200px">시술명</th>
          <th width="200px">담당자</th>
          <th width="100px">예약날짜</th>
        </tr>
        
    <%
	      	for(int i=0; i<resList.size(); i++){
	      		ReservationBean reservation = resList.get(i);
        		String link="index_salon.jsp?CONTENTPAGE=salon/reservation_details.jsp&no="+reservation.getR_no();
        		String time = sdf.format(reservation.getReserv_date());
        		%>
        	<tr>
	          <td><a href="<%=link%>"><%=reservation.getR_no() %></a></td>
	          <td><%=treDao.getTreatName(reservation.getT_no())%></td>
	          <td><%=desDao.getDesignerName(reservation.getD_no())%></td>
			  <td><%=time%></td>
	        </tr>
    <%
        	}
		}
    %>
      </table>
    </center>
    <%
  	}
    %>
  </body>
</html>
