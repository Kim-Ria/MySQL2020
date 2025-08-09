<%@page import="salonProject.LectureDAO"%>
<%@page import="salonProject.LectureBean"%>
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
	LectureDAO dao = new LectureDAO();
	LectureBean lecture = dao.getLecture(Integer.parseInt(request.getParameter("no")));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String time = sdf.format(lecture.getLecture_date());
	%>
    <center>
      <div id="view">
        <img src="img/logo1.png" alt="로고" width="100px" height="100px" id="logo">
        <center>
          <table width="400px">
            <tr>
              <th colspan="2">No. <%=lecture.getL_no() %></th>
            </tr>
            <tr>
              <td width="100px" class="title">일정</td>
              <td class="details"><%=time%></td>
            </tr>
            <tr>
              <td class="title">강좌명</td>
              <td class="details"><%= lecture.getAcademy().getLecture_name() %></td>
            </tr>
            <tr>
              <td class="title">강사</td>
              <td class="details"><%=lecture.getDesigner().getD_name() %></td>
            </tr>
            <tr>
              <td class="title">수강료</td>
              <td class="details"><%=lecture.getAcademy().getTuition() %>원</td>
            </tr>
          </table>
        </center>
        <button type="button" class="list_btn" name="button" onclick="location.href='index_academy.jsp?CONTENTPAGE=academy/deleteAction.jsp&no=<%=lecture.getL_no()%>&a_no=<%=lecture.getA_no()%>'">
          	예약취소
        </button><br>
        <button type="button" class="list_btn" name="button" onclick="location.href='index_academy.jsp?CONTENTPAGE=academy/list.jsp'">
          	목록으로
        </button>
      </div>
     </center>
   </body>
 </html>
