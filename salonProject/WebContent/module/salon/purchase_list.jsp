<%@page import="salonProject.Member_orderDAO"%>
<%@page import="java.util.Vector"%>
<%@page import="salonProject.Member_orderBean"%>
<%@page import="salonProject.ProductDAO"%>
<%@page import="salonProject.ProductBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
  <head>
    <title>구매목록</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      th { font-size: 15px; padding-top: 5px; padding-bottom: 5px;}
      td { border-bottom: 1px solid #BFB2AA; padding: 3px;}
      select { width: 110px; height: 25px; }
    </style>
  </head>
  <body>
    <center>
    <%
		String id = session.getAttribute("id").toString();
    	String insertLink = "";
    	if(id != null){
    		insertLink = "location.href='index_salon.jsp?CONTENTPAGE=purchase/insert.jsp'";
    	} else{
    		insertLink = "alert('로그인이 필요한 메뉴입니다.');";
    	}
    	int no = 1;
    	int sum = 0;
    	int cnt = 0;
    %>
      <div id="select_category">
        <form action="salon/purchase_list.jsp" method="get">
          카테고리 선택:
          <select name="category" onchange="location.href='index_salon.jsp?CONTENTPAGE=salon/purchase_list.jsp?category='+this.value">
          	<option selected hidden>카테고리선택</option>
            <option value="0">전체보기</option>
            <option value="1">샴푸</option>
            <option value="2">트리트먼트</option>
            <option value="3">에센스</option>
            <option value="4">미용도구</option>
          </select>
        </form>
      </div>

	<%
		Member_orderDAO ord = new Member_orderDAO();
		List<Member_orderBean> orderList = ord.getOrderListbyID(id);

		ProductDAO pro = new ProductDAO();
		String prod_name;

		sum = ord.getSum(id);
		cnt = ord.getCnt(id);

		if(request.getParameter("category") != null){
			orderList = ord.getOrderListCategory(Integer.parseInt(request.getParameter("category")),id);
		}

		Member_orderBean order = new Member_orderBean();

		if(orderList.size() == 0){
	%>
	    	<h1>구매내역이 없습니다.</h1>
	<%
		}
		else{

	%>
      <table border="0">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="100px">분류</th>
          <th width="180px">구매상품</th>
          <th width="60px">구매수량</th>
          <th width="80px">상품가격</th>
          <th width="100px">구매날짜</th>
          <th width="120px">배송상태</th>
          <th width="50px"> </th>
        </tr>
        <%
	      	for(int i=0; i<orderList.size(); i++){
        		order = orderList.get(i);
        		String link="index_salon.jsp?CONTENTPAGE=purchase/purchase_list.jsp&p_no="+order.getP_no();
    	%>
    	<form action="index_salon.jsp?CONTENTPAGE=salon/deleteAction.jsp" method="post">
        	<tr>
        	  <td><%=no%></td>
        	  <td><%=order.getProduct().getClassification().getC_category() %></td>
	          <td><%=order.getProduct().getProd_name()%></td>
	          <td><%=order.getQuantity() %></td>
	          <td><%=order.getProduct().getProd_price() %></td>
	          <td><%=order.getOrder_date() %></td>
	          <td><%=order.getState()%></td>
	          <td>
			  <input type="hidden" name="p_no" value="<%=order.getP_no()%>">
			  <input type="hidden" name="quantity" value="<%=order.getQuantity()%>">
	          <% if(order.getState().equals("배송준비중")){ %>
	          	<input type="submit" value="구매취소"></td>
	          <%} %>
	        </tr>
	    </form>
	        <%
	        no++;
        	}
       %><tr>
       <td></td>
       <td></td>
       <td></td>
       <td></td>
       <td>구매 개수</td>
       <td><%=cnt%></td>
       <td>총 가격</td>
       <td><%=sum%></td>
       </tr>
    <%
		}
    %>
      </table>
    </center>
  </body>
</html>
