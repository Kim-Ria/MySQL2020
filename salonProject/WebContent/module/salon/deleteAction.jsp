<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.Member_orderDAO" %>
<%@ page import="salonProject.ProductBean" %>
<%@ page import="salonProject.ProductDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="ordBean" class="salonProject.Member_orderBean" scope="page" />
<jsp:setProperty name="ordBean" property="p_no" />
<jsp:setProperty name="ordBean" property="quantity" />

<!DOCTYPE html>
<head>
</head>

<body>
<%
  String id = session.getAttribute("id").toString();
	Member_orderDAO ord = new Member_orderDAO();
	boolean result_delete = ord.orderDelete(id, ordBean.getP_no()); //복합키(아이디, 상품번호)로 삭제

	ProductBean proBean = new ProductBean();
	ProductDAO pro = new ProductDAO();
	proBean.setP_no(ordBean.getP_no());
	boolean result_quantity = pro.productStockUpdate(proBean,(-1)*ordBean.getQuantity()); // 취소 재고 update

    if(result_delete && result_quantity){ // 취소, 재고 update 모두 성공한 경우 취소 완료
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('취소 완료')");
        script.println("location.href='index_salon.jsp?CONTENTPAGE=salon/purchase_list.jsp'");
        script.println("</script>");
    }
    else{
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
