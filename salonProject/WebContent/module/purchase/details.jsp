<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="css/style.css">
    <style>
    table{ text-align: center; margin-top: 30px;}
    td { padding: 6px; border: 1px solid #BFB2AA; font-size: 15px; }
    #title { background-color: #BFB2AA; color: #402E24; }
    </style>
  </head>
  <body>
    <?php include 'html/menu_salon.html'; ?>
    <center>
      <table>
        <tr>
          <td colspan=1 class="align_l">No. 1111</td> <!-- -->
          <td colspan=2 class="align_r">주문 날짜</td>
        </tr>
        <tr>
          <td colspan="3" class="align_l">주문 처리 상태</td>
        </tr>
        <tr id="title">
          <td width="150px">상품번호</td>
          <td width="400px">상품명</td>
          <td width="50px">수량</td>
        </tr>
        <tr>
          <td>0000</td>
          <td>test이름이름test</td>
          <td>1</td>
        </tr>
        <tr>
          <td>0000</td>
          <td>test이름이름test</td>
          <td>2</td>
        </tr>
        <tr>
          <td>0000</td>
          <td>test이름이름test</td>
          <td>1</td>
        </tr>
        <tr>
          <td colspan=3 class="align_r">주문 가격 \00,000</td>
        </tr>
      </table>
      <button type="button" class="list_btn" name="button" onclick="location.href='view_purchase.php'">
        목록으로
      </button>
    </center>
  </body>
  <?php include 'html/footer.html'; ?>
</html>
