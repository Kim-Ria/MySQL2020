<%@page import="salonProject.LectureBean"%>
<%@page import="salonProject.LectureDAO"%>
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
		LectureDAO dao = new LectureDAO();
		String id = session.getAttribute("id").toString();
		List<LectureBean> lecList = dao.getLectureListbyID(id);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		if(lecList.size() == 0){
	%>
	    	<h1>아카데미 예약 내역이 없습니다.</h1><br>
	<%
		}
		else{
	
	%>
	<h1>강좌 예약 내역</h1>
      <table border="0">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="500px">강좌명</th>
          <th width="150px">수강날짜</th>
        </tr>
        
    <%
	      	for(int i=0; i<lecList.size(); i++){
        		LectureBean lecture = lecList.get(i);
        		String link="index_salon.jsp?CONTENTPAGE=academy/details.jsp&no="+lecture.getL_no();
        		String time = sdf.format(lecture.getLecture_date());
     %>
        	<tr>
	          <td><a href="<%=link%>"><%=lecture.getL_no() %></a></td>
	          <td><%=lecture.getAcademy().getLecture_name() %></td>
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
