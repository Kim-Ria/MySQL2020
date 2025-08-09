<%@page import="java.io.PrintWriter"%>
<%@page import="salonProject.AcademyBean"%>
<%@page import="java.util.List"%>
<%@page import="salonProject.AcademyDAO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <title>예약페이지</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
      table{text-align: center;}
      #reservation_btn{
        margin-bottom: 30px;
        width:550px; height: 30px;
        background-color: #A6837B;
        border: none;
        color: white;
      }
      #result{
        margin-top: 40px;
        width: 550px; height: 150px;
      }
      h3{ margin-bottom: 15px; }
      #date{ width: 520px; height: 30px;}
      #l_name{ font-size: 16px; }
      #d_name{ font-size: 12px; }
    </style>
    <script>
    	function changeLecture(lecture, tuition, no){
    		document.getElementById("lecture").innerText = lecture;
    		document.getElementById("tuition").innerText = tuition+"원";
    		document.getElementById("acd_no_input").value = no;
    	}
    	function updateTime(t){
    		document.getElementById("lec_time").innerText = t;
    	}
    </script>
  </head>

  <body>
  	<%
  	//로그인이 되어있지 않은 경우
  	if(session.getAttribute("id") == null){
  		PrintWriter script = response.getWriter();
  		script.println("<script>alert('로그인이 필요한 메뉴 입니다.');");
  		script.println("location.href='index_salon.jsp?CONTENTPAGE=member/login.jsp'</script>");
  	} else {
  	%>
    <center>
      <form action="module/academy/reservationAction.jsp" method="post">
        <div id="left">
          <div id="select_lecture">
            <h3>강좌 선택</h3>
            <%
            AcademyDAO dao = new AcademyDAO();
    		List<AcademyBean> acdList = dao.getAcademyList();
    		AcademyBean acd = new AcademyBean();
    		
    		for(int i=0; i<acdList.size(); i+=3){
    			for(int j=i; j<i+3 && j<acdList.size(); j++){
    				acd = acdList.get(j);
    				String bgcolor="white";
    				if(acd.getParticipants()==0) bgcolor="#bcbcbc"; 
    		%>
	            <label>
	            	<button bgcolor="<%=bgcolor %>" type="button" id="<%=acd.getLecture_name()%>" onclick="changeLecture(this.id, <%=acd.getTuition() %>, <%=acd.getA_no()%>)">
	            		강좌명 : <%=acd.getLecture_name() %> <br>           		
	            		강사명 : <%=acd.getD_name() %> <br>
	           			수강료 : <%=acd.getTuition() %> <br>
	           		</button>
	            </label>
    		<%
    			}
    		%><br><%
    		}
            %>
          </div>
        </div>

        <div id="right">
          <div id="select_date">
          	<jsp:include page='<%= "../calender.jsp"%>' flush="false" /> 
          </div>
          
          <div id="select_time">
            <h4>시간 선택</h4>
            <div id="timeselect">
            <label><input type="radio" name="time" value="10:00" onclick="updateTime(this.value)" hidden="hidden" required>10:00</label>
            <label><input type="radio" name="time" value="14:00" onclick="updateTime(this.value)" hidden="hidden">14:00</label>
            <label><input type="radio" name="time" value="16:00" onclick="updateTime(this.value)" hidden="hidden">16:00</label>
            <label><input type="radio" name="time" value="18:00" onclick="updateTime(this.value)" hidden="hidden">18:00</label>
            <label><input type="radio" name="time" value="20:00" onclick="updateTime(this.value)" hidden="hidden">20:00</label>
            </div>
          </div>
          <hr>
          <div id="result">
            <h3>선택내역</h3>
            <table align="center" width="400px" border="0" height="90px">
            	<tr>
            		<td width="60px">강좌</td>
            		<td colspan="2" id="lecture">희망하는 강좌를 선택해주세요.</td>
            		<input type="text" name="a_no" readonly id="acd_no_input" hidden="hidden" required>
            	</tr>
            	<tr>
            		<td>수강료</td>
            		<td colspan="2" id="tuition"></td>
            	</tr>
            	<tr>
            		<td>예약</td>
            		<td id="lec_date" width="100px">날짜</td>
            		<td id="lec_time" width="160px">시간</td>
            		<input type="text" name="lecture_date" readonly id="lec_date_input" hidden="hidden">
            		<input type="text" name="lecture_time" readonly id="lec_time_input" hidden="hidden">
            	</tr>
            </table>
          </div>
          <button type="submit" id="reservation_btn" name="reservation">예약하기</button>
        </div>
      </form>
    </center>
    <%}%>
  </body>
</html>
