<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.List"%>
<%@page import="salonProject.TreatmentDAO"%>
<%@page import="salonProject.TreatmentBean"%>
<%@page import="salonProject.DesignerDAO"%>
<%@page import="salonProject.DesignerBean"%>
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
      #select_designer{ margin-top : 30px; }
    </style>
    <script>
    	function changeTreat(treatment, price, no){
    		document.getElementById("treatment").innerText = treatment;
    		document.getElementById("price").innerText = price+"원";
    		document.getElementById("tre_no_input").value = no;
    	}
    	function changeDesigner(designer, no){
    		document.getElementById("designer").innerText = designer;
    		document.getElementById("d_no_input").value = no;
    	}
    	function updateTime(t){
    		document.getElementById("res_time").innerText = t;
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
      <form action="module/salon/reservationAction.jsp" method="post">
        <div id="left">
          <div id="select_treatment">
            <h3>시술 선택</h3>
            <%    		
    		TreatmentDAO treDao = new TreatmentDAO();
    		List<TreatmentBean> treList = treDao.getTreatList();
    		TreatmentBean tre = new TreatmentBean();
    		
    		for(int i=0; i<treList.size(); i+=3){
    			for(int j=i; j<i+3 && j<treList.size(); j++){
    				tre = treList.get(j);
    		%>
	            <label>
	            <button type="button" id="<%=tre.getTreat_name()%>" onclick="changeTreat(this.id, <%=tre.getTreat_price()%>, <%=tre.getT_no()%>)">
	            		시술명 : <%=tre.getTreat_name() %> <br>           		
	            		시술가격 : <%=tre.getTreat_price() %> <br>
	           		</button>
	            </label>
    		<%
    			}
    		%><br><%
    		}
            %>
          </div>
          <div id="select_designer">
            <h3>디자이너 선택</h3>
            <%    		
    		DesignerDAO desDao = new DesignerDAO();
    		List<DesignerBean> desList = desDao.getDesignerList();
    		DesignerBean des = new DesignerBean();
    		
    		for(int i=0; i<desList.size(); i+=3){
    			for(int j=i; j<i+3 && j<desList.size(); j++){
    				des = desList.get(j);
    		%>
	            <label>
	            <button type="button" id="<%=des.getD_name()%>" onclick="changeDesigner(this.id, <%=des.getD_no()%>)">
	            		이름 : <%=des.getD_name() %> <br>           		
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
          	<jsp:include page='<%= "../calender_treat.jsp"%>' flush="false" /> 
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
            		<td width="60px">시술</td>
            		<td colspan="2" id="treatment">희망하는 시술를 선택해주세요.</td>
            		<input type="text" name="t_no" readonly id="tre_no_input" hidden="hidden" required>
            	</tr>
            	<tr>
            		<td>시술료</td>
            		<td colspan="2" id="price"></td>
            	</tr>
            	<tr>
            		<td>담당자</td>
            		<td colspan="2" id="designer"></td>
            		<input type="text" name="d_no" readonly id="d_no_input" hidden="hidden" required>
            	</tr>
            	<tr>
            		<td>예약</td>
            		<td id="res_date" width="100px">날짜</td>
            		<td id="res_time" width="160px">시간</td> 
            		<input type="text" name="reservation_date" readonly id="res_date_input" hidden="hidden">
            		<input type="text" name="reservation_time" readonly id="res_time_input" hidden="hidden">
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
