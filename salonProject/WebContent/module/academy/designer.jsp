<%@page import="salonProject.DesignerBean"%>
<%@page import="salonProject.DesignerDAO"%>
<%@page import="salonProject.AcademyBean"%>
<%@page import="java.util.List"%>
<%@page import="salonProject.AcademyDAO"%>
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
    	<h2>강사 소개</h2>
      <table width="1000px" border="1">
      <%
      	DesignerDAO dao = new DesignerDAO();
      	List<DesignerBean> desList = dao.getDesignerList();
      	DesignerBean des = new DesignerBean();
      	
      	for(int i=0; i<desList.size(); i+=4){
		%>
     		<tr height="10px">
		<%
      		for(int j=i; j<=i+3 && j<desList.size(); j++){
        		des = desList.get(j);
		%>
				<td width="230px"><%=des.getD_name() %></td>
		<%
      		}
		%>
			</tr>
		<%
      	}
      %>
      </table>
      <button type="button" class="reservation_btn" name="button" onclick="location.href='index_academy.jsp?CONTENTPAGE=academy/reservation.jsp&n=0'">
        예약하러가기
      </button>
    </center>
  </body>
</html>