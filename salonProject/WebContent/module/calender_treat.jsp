<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title></title>
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<style> a { text-decoration:none } </style>
	<script>
	function selectDate(year, month, day){
		document.getElementById("res_date").innerHTML = month+"월 "+day+"일";
		document.getElementById("res_date_input").value = year+"-"+(month)+"-"+day;
	}
	</script>
</head>
<body>
<%
	int next = Integer.parseInt(request.getParameter("n")); 
	
	// 오늘 날짜 설정
	Calendar calender = Calendar.getInstance();
	int year = calender.get(Calendar.YEAR);
	int month = calender.get(Calendar.MONTH) + next;
	int date = calender.get(Calendar.DATE);
	
	if(next == 1) date=0; // 다음달 달력은 오늘 날짜 표시 X
	
	String today = year + ":" + (month+1) + ":" + date;
	
	// 달력 월 설정
	calender.set(year, month, 1);
	
	// 해당 월의 첫날, 마지막날, 시작 요일
	int startDate = calender.getMinimum(Calendar.DATE);
	int endDate = calender.getActualMaximum(Calendar.DATE);
	int startDay = calender.get(Calendar.DAY_OF_WEEK);
	
	int count = 0;
%>
 <h3>
 <a href="index_salon.jsp?CONTENTPAGE=salon/reservation.jsp&n=0">&lt;&lt;</a>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <%=month+1 %>월 예약
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 <a href="index_salon.jsp?CONTENTPAGE=salon/reservation.jsp&n=1">&gt;&gt;</a>
 </h3>
 <table width = "400px" cellspacing="0" border="1" align="center" id="calender">
 	<tr class="dayText">
 		<td>일</td>
 		<td>월</td>
 		<td>화</td>
 		<td>수</td>
 		<td>목</td>
 		<td>금</td>
 		<td>토</td>
 	</tr>
 	
 	<!-- 시작 요일 설정 -->
 	<tr>
 	<% for(int i=1; i<startDay; i++){
		count++;
	%>
 		<td>&nbsp;</td>
 	<%
 	}
 	
 	for(int i=startDate; i<=endDate; i++){
 		String bgcolor = (today.equals(year+":"+(month+1)+":"+i))? "#ffc107" : "#FFFFFF"; // 오늘 배경색 설정
 		if(count<date) { bgcolor = "#bcbcbc"; } // 과거 배경색 설정
 		String color = "black";
 		String click = "selectDate("+year+", "+(month+1)+", this.value);";
 		if(count%7==0) color="red"; // 일요일
 		if(count%7==6) color="blue"; // 토요일
 		if(count<=date) click = "alert('과거 및 당일 예약은 불가능 합니다.');";
 		
 		count++;
 	%>
 		<td bgcolor="<%=bgcolor%>" name="day" value="<%=i%>">
 			<button type="button" id="dateBtn" value="<%=i %>"
 				onclick="<%=click%>"> <%=i %> </button>
 		</td>
 	<%
 		if(count%7 == 0 && i < endDate){
	%>
		</tr><tr>
	<%
 		}
 	}
 	while(count%7 != 0){ // 달력 남은 칸 채우기
	%>
		<td>&nbsp;</td>
	<%
		count++;
 	}
 	%>
 	</tr>
 </table>
</body>
</html>