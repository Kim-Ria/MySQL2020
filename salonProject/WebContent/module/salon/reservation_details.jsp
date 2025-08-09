<%@page import="salonProject.ReservationDAO"%>
<%@page import="salonProject.ReservationBean"%>
<%@page import="salonProject.DesignerDAO"%>
<%@page import="salonProject.DesignerBean"%>
<%@page import="salonProject.TreatmentBean"%>
<%@page import="salonProject.TreatmentDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
 <!DOCTYPE html>
 <html>
   <head>
     <link rel="stylesheet" href="css/style.css">
     <style>
       th{
         border-bottom: 1px solid #BFB2AA;
         text-align: left;
         height: 40px;
       }
       table { margin-top: 30px; padding: 5px;}
       td{ padding: 5px; }
       #logo{ margin-top:30px; }
       .title { color: #999999; font-size: 15px; }
       .details { color: #402E24; font-size: 15px; }
     </style>
   </head>
   <body>
	<%
	ReservationDAO dao = new ReservationDAO();
	ReservationBean reservation = dao.getReserve(request.getParameter("no"));
	
	DesignerDAO desDao = new DesignerDAO();
	DesignerBean designer = new DesignerBean();
	TreatmentDAO treDao = new TreatmentDAO();
	TreatmentBean treatment = new TreatmentBean();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time = sdf.format(reservation.getReserv_date());
	%>
    <center>
      <div id="view">
        <img src="img/logo1.png" alt="로고" width="100px" height="100px" id="logo">
        <center>
          <table width="400px">
            <tr>
              <th colspan="2">No. <%=reservation.getR_no() %></th>
            </tr>
            <tr>
              <td width="100px" class="title">일정</td>
              <td class="details"><%=time%></td>
            </tr>
            <tr>
              <td class="title">시술명</td>
              <td class="details"><%=treDao.getTreatName(reservation.getT_no())%></td>
            </tr>
            <tr>
              <td class="title">디자이너</td>
              <td class="details"><%=desDao.getDesignerName(reservation.getD_no())%></td>
            </tr>
            <tr>
              <td class="title">시술가격</td>
              <td class="details"><%=treDao.getTreatPrice(reservation.getT_no())%>원</td>
            </tr>
          </table>
        </center>
        <button type="button" class="list_btn" name="button" onclick="location.href='index_salon.jsp?CONTENTPAGE=salon/reservation_deleteAction.jsp&no=<%=reservation.getR_no()%>'">
          	예약취소
        </button><br>
        <button type="button" class="list_btn" name="button" onclick="location.href='index_salon.jsp?CONTENTPAGE=salon/reservation_list.jsp'">
          	목록으로
        </button>
      </div>
     </center>
   </body>
 </html>
