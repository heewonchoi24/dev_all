<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>교환상품 선택</title>
</head>
<body>
<div class="pop-wrap">
  <div class="headpop">
    <h2>교환요청</h2>
    <p>상품을 교환하시겠습니까? 주문내역을 확인하시고 교환 신청을 해주십시오.</p>
  </div>
  <div class="contentpop">
    <div class="popup columns offset-by-one">
      <div class="row">
        <div class="one last col">
          <div class="sectionHeader">
            <h4> 주문내역<span class="font-blue f14 padl50">A2013080138441</span> ㅣ <span class="f14">2013.08.29</span> </h4>
          </div>
          <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th class="none">선택</th>
              <th class="none">택배구분</th>
              <th>상품명</th>
              <th>수량</th>
              <th>상품금액</th>
              <th class="last">주문상태</th>
            </tr>
            <tr>
              <td><input name="" type="checkbox" value=""></td>
              <td>택배</td>
              <td><div class="orderName"> <img class="thumbleft" src="/images/order_sample.jpg">
                  <h4> 뷰티워터티 </h4>
                </div></td>
              <td>1</td>
              <td><%=nf.format(defaultBagPrice)%>원</td>
              <td><div class="font-blue"> 배송완료 </div></td>
            </tr>
          </table>
          <!-- End orderList --> 
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col">
          <div class="sectionHeader">
            <h4>교환사유 입력</h4>
          </div>
          <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <th>교환사유선택</th>
              <td>
                <select name="select" id="select" style="width:200px;">
                  <option>교환사유선택</option>
                </select>
              </td>
            </tr>
            <tr>
              <th>교환사유 및<br />기타 요청사항</th>
              <td>
                <input type="text" name="textfield" id="textfield" style="width:500px;">
                <p class="font-gray">입력글자는 최대 한글60자, 영문/숫자 120자까지 가능합니다.</p>
              </td>
            </tr>
          </table>
          <!-- End orderList --> 
        </div>
      </div>
      <!-- End row -->
      <div class="row">
        <div class="one last col center">
          <div class="button large dark"><a href="#">교환요청</a></div>
        </div>
      </div>
      <!-- End row --> 
    </div>
    <!-- End popup columns offset-by-one --> 
  </div>
  <!-- End contentpop --> 
</div>
</body>
</html>