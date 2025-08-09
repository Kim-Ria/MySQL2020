<%@page import="salonProject.TreatmentBean"%>
<%@page import="java.util.List"%>
<%@page import="salonProject.TreatmentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="css/style.css">
    <style>
      table{ margin-top: 30px; margin-bottom: 30px; text-align: center;}
      td { font-size: 16px; color: #402E24; padding: 10px; }
      table img { margin-bottom: 40px; }
    </style>
  </head>
  <body>
    <center>
    	<h2>시술 소개</h2>
      <table width="1000px" border="1">
      <%
        TreatmentDAO dao = new TreatmentDAO();
      	List<TreatmentBean> treList = dao.getTreatList();
      	TreatmentBean tre = new TreatmentBean();
      	
      	for(int i=0; i<treList.size(); i+=4){
		%>
     		<tr height="10px">
		<%
      		for(int j=i; j<=i+3 && j<treList.size(); j++){
      			tre = treList.get(j);
		%>
				<td width="230px"><%=tre.getTreat_name()%><br><%=tre.getTreat_price() %>원</td>
		<%
      		}
		%>
			</tr>
		<%
      	}
      %>
      </table>
      <button type="button" class="reservation_btn" name="button" onclick="location.href='index_salon.jsp?CONTENTPAGE=salon/reservation.jsp&n=0'">
        예약하러가기
      </button>
    </center>
  </body>
</html>