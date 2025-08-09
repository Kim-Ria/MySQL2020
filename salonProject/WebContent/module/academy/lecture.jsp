<%@page import="salonProject.AcademyBean"%>
<%@page import="java.util.List"%>
<%@page import="salonProject.AcademyDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
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
    	<h2>강좌 조회</h2>
      <table width="1000px" border="1">
      <%
      	AcademyDAO dao = new AcademyDAO();
		List<AcademyBean> acdList = dao.getAcademyList();
		AcademyBean acd = new AcademyBean();
		
		for(int i=0; i<acdList.size(); i+=4){
      %>
        <tr height="100px">
        <%
        	for(int j=i; j<=i+3 && j<acdList.size(); j++){
        		acd = acdList.get(j);
        %>
          <td width="230px"><%= acd.getLecture_name() %><br>강사: <%=acd.getD_name() %></td>
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
