<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<% String contentPage = request.getParameter("CONTENTPAGE");
   if (contentPage==null){
      contentPage="salon_content.jsp";
   }
 %>  
     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header>
  <jsp:include page="module/menu_salon.jsp" flush="false" />
</header>
<!-- content section -->
<div id="index">
  <section id="areaMain">
    <jsp:include page='<%= "module/" +contentPage %>' flush="false" /> 
  </section>
</div>
<footer>
  <jsp:include page="module/footer.jsp" flush="false" />
</footer>
</body>
</html>