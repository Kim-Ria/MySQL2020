<%@page import="salonProject.BoardBean"%>
<%@page import="salonProject.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="salonProject.Member_orderDAO"%>
<%@page import="salonProject.Member_orderBean"%>
<%@page import="salonProject.ProductDAO"%>
<%@page import="salonProject.ProductBean"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
  <head>
    <title>미용실 예약</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
  </head>

  <body>
    <div id="image">
      	인기 상품
        <%
		ProductDAO pro = new ProductDAO();
  		Member_orderDAO ord = new Member_orderDAO();
  		List<Member_orderBean> orderList = ord.getOrderRankList();
				
  		Member_orderBean member_order = new Member_orderBean();
		ProductBean product = new ProductBean();
		
		if(orderList.size() == 0){
	%>
	    	<h5>판매된 상품이 없습니다.</h5>
	<%
		}
		else{
	
	%>
	<center>
	<br>
	<table border="0" style="text-align: left; font-size:40px;" width="500px">
        <%
        	int size = 0;
        	if(orderList.size() < 3) size = orderList.size();
        	else size = 3;
	      	for(int i=0; i<size; i++){
	      		member_order = orderList.get(i);
    	%>
    	<tr>
    		  <td width="100px"><%=i+1%>위 </td>
	          <td><%=pro.getProductName(member_order.getP_no()) %></td>
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
			<h6>공지사항이 없습니다.</h6>
		<%
      		}else{
      			int size=3;
      			if(boardList.size()<3) size = boardList.size();
      			for(int i=0; i<size; i++){
      				board = boardList.get(i);
      	%>
      			<div><%=i+1%>. <a href="index_salon.jsp?CONTENTPAGE=board/details.jsp?b_no=<%=board.getB_no()%>">
      							<%=board.getTitle() %></a></div><br>
      	<%
      			}
      		}
      	%>
    </div>
  </body>
</html>
