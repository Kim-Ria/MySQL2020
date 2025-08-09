<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="salonProject.Member_orderDAO" %>
<%@ page import="salonProject.ProductDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="proBean" class="salonProject.ProductBean" scope="page" />
<jsp:setProperty name="proBean" property="p_no"/>
<jsp:setProperty name="proBean" property="stock"/>
<jsp:useBean id="ordBean" class="salonProject.Member_orderBean" scope="page" />
<jsp:setProperty name="ordBean" property="p_no" />
<jsp:setProperty name="ordBean" property="quantity" />

<!DOCTYPE html>
<head>
</head>

<body>
<%
	Member_orderDAO ord = new Member_orderDAO();

	//사용자 아이디 설정
  String id = session.getAttribute("id").toString();
	ordBean.setId(id);

	int result_order = ord.orderInsert(ordBean, proBean);


	if(result_order == 1){ // 1: 구매 완료
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('구매 완료')");
        script.println("location.href='index_salon.jsp?CONTENTPAGE=purchase/list.jsp'");
        script.println("</script>");
    }
    else if(result_order == -1){ // -1: 재고 부족
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('재고가 부족합니다.')");
        script.println("history.back()");
        script.println("</script>");
    }
    else{ // DB 문제
    	PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('문제 발생')");
        script.println("history.back()");
        script.println("</script>");
    }
%>
</body>
