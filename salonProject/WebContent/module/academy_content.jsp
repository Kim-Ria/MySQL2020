<%@page import="salonProject.BoardBean"%>
<%@page import="salonProject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="salonProject.LectureDAO"%>
<%@page import="salonProject.LectureBean"%>
<%@page import="salonProject.AcademyBean"%>
<%@page import="salonProject.AcademyDAO"%>
<%@page import="salonProject.DesignerBean"%>
<%@page import="salonProject.DesignerDAO"%>

<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
  <head>
    <title>미용실 아카데미</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

  </head>

  <body>
    <div id="image">
      인기 강좌
      <%
      	AcademyDAO aca = new AcademyDAO();
      	LectureDAO lec = new LectureDAO();
      	DesignerDAO des = new DesignerDAO();
  		List<LectureBean> lectureList = lec.getLectureRankList();
				
  		LectureBean lecture = new LectureBean();
  		AcademyBean academy = new AcademyBean();
  		DesignerBean designer = new DesignerBean();
		
		if(lectureList.size() == 0){
	%>
	    	<h5>수강된 강좌가 없습니다.</h5>
	<%
		}
		else{
	
			%>
			<br>
			<center>
			<table border="0" style="text-align: left; font-size:40px;" width="500px">
		        <%
		        	int size = 0;
		        	if(lectureList.size() < 3) size = lectureList.size();
		        	else size = 3;
			      	for(int i=0; i<size; i++){
			      		lecture = lectureList.get(i);
		    	%>
		    	<tr>
		    		  <td width="100px"><%=i+1%>위 </td>
			          <td><%=aca.getAcademyName(lecture.getA_no()) %></td>
			    </tr>
		           <%
		        	}
		        }
		    %>
		      </table>
		      </center>
    </div>

    <div id="notice">
      	<h3>공지사항</h3><hr>
      	<%
      		BoardDAO dao = new BoardDAO();
      		List <BoardBean> boardList = dao.getBoardListCategory(1); // 공지사항만 가져오기
      		BoardBean board = new BoardBean();
      		
      		if(boardList.size() == 0){
		%>
			아직 공지사항이 없습니다.
		<%
      		}else{
      			int size=3; // 최근 공지사항 3개까지만 출력
      			if(boardList.size()<3) size = boardList.size();
      			for(int i=0; i<size; i++){
      				board = boardList.get(i);
      	%>
      			<div>[<%=i+1%>] <a href="index_salon.jsp?CONTENTPAGE=board/details.jsp?b_no=<%=board.getB_no()%>">
      							<%=board.getTitle() %></a></div>
      	<%
      			}
      		}
      	%>
    </div>
  </body>
</html>
