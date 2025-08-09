<%@page import="java.util.Vector"%>
<%@page import="salonProject.ProductDAO"%>
<%@page import="salonProject.ProductBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="proBean" class="salonProject.ProductBean" scope="page" />
<jsp:setProperty name="proBean" property="prod_name"/>
<!DOCTYPE html>
<html>
  <head>
    <title>상품</title>
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
    	String insertLink = "";
    	if(session.getAttribute("id") != null){
    		insertLink = "location.href='index_salon.jsp?CONTENTPAGE=purchase/insert.jsp'";
    	} else{
    		insertLink = "alert('로그인이 필요한 메뉴입니다.');";
    	}
    %>
      <div id="select_category">
        <form action="purchase/list.jsp" method="get">
          카테고리 선택:
          <select name="category" onchange="location.href='index_salon.jsp?CONTENTPAGE=purchase/list.jsp?category='+this.value">
          	<option selected hidden>카테고리선택</option>
            <option value="0">전체보기</option>
            <option value="1">샴푸</option>
            <option value="2">트리트먼트</option>
            <option value="3">에센스</option>
            <option value="4">미용도구</option>
          </select>
        </form>
        <form action="index_salon.jsp?CONTENTPAGE=purchase/search_list.jsp" method="post">
        <input type="text" name="prod_name" style="width:50px;">
        <input type="submit" value="검색">
        </form>
      </div>
	
	<%
		String search = proBean.getProd_name();
		System.out.println("name : " + search);
		ProductDAO pro = new ProductDAO();
		List<ProductBean> productList = pro.searchProductName(search);
		
		
		ProductBean product = new ProductBean();
		
		if(productList.size() == 0){
	%>
	    	<h1>상품이 없습니다.</h1>
	<%
		}
		else{
	
	%>
      <table border="0" align="center">
        <tr bgcolor="#BFB2AA">
          <th width="80px">No.</th>
          <th width="100px">분류</th>
          <th width="500px">상품명</th>
          <th width="100px">가격</th>
          <th width="80px">재고</th>
          <th width="80px">구매수량</th>
          <th width="50px"> </th>
        </tr>
        <%
	      	for(int i=0; i<productList.size(); i++){
        		product = productList.get(i);
        		String link="index_salon.jsp?CONTENTPAGE=purchase/details.jsp&p_no="+product.getP_no();
    	%>
    	<form action="index_salon.jsp?CONTENTPAGE=purchase/insertAction.jsp" method="post">
        	<tr>
	          <td><%=product.getP_no() %></td>
	          <td><%=product.getClassification().getC_category() %></td>
	          <td><%=product.getProd_name() %></td>
	          <td><%=product.getProd_price() %></td>
	          <td><%=product.getStock()%></td>
	          <td>
	          <input type="number" name="quantity" style="width:50px;" min="0" value="0">
	          </td>
	          <td>
			  <input type="hidden" name="stock" value="<%=product.getStock()%>">
	          <input type="hidden" name="p_no" value="<%=product.getP_no()%>">
	          <input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
	          <input type="submit" value="구매"></td>	
	        </tr>
	    </form>
	        <%
        	}
		}
    %>
      </table>
    </center>
  </body>
</html>
