<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"
    />
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <!-- <script src="https://testcpay.payple.kr/js/cpay.payple.1.0.0.js"></script> -->
    <!-- TEST (PCD_CPAY_VER : 1.0.0) -->
    <script src="https://testcpay.payple.kr/js/cpay.payple.1.0.1.js"></script>
    <!-- TEST (PCD_CPAY_VER : 1.0.1) -->
    <script>
      $(document).ready(function() {
        //#########################################################################################################################################################################
        /*
         * Payple ID, KEY, AUTH_URL 가져오기
         */

        // var cfg = new Object();

        // $.get("/cPayPayple/payple.cgi", function(data) {
        //     cfg = eval("(" + data + ")");
        // });

        //#########################################################################################################################################################################

        $("#payAction").on("click", function(event) {
          var pay_work = "CERT";
          var payple_payer_id = "";
          var buyer_no = "${buyer_no}";
          var buyer_name = "${buyer_name}";
          var buyer_hp = "${buyer_hp}";
          var buyer_email = "${buyer_email}";
          var buy_goods = "${buy_goods}";
          var buy_total = "${buy_total}";
          var order_num = "${order_num}";
          var is_reguler = "${is_reguler}";
          var pay_year = "${pay_year}";
          var pay_month = "${pay_month}";
          var is_taxsave = "${is_taxsave}";
          var simple_flag = "${simple_flag}";

          console.log(buy_total);
          var obj = new Object();

          //#########################################################################################################################################################################
          /*
           * DEFAULT SET 1
           */

          //-- 소스상에 표시하지 마시고 반드시 Server Side Script 를 이용하여 불러오시기 바랍니다. --//
          // obj.PCD_CST_ID = cfg.PCD_CST_ID;
          obj.PCD_CST_ID = "test";
          // obj.PCD_CUST_KEY = cfg.PCD_CUST_KEY;
          obj.PCD_CUST_KEY = "abcd1234567890";
          // obj.PCD_AUTH_URL = cfg.PCD_AUTH_URL;
          obj.PCD_AUTH_URL = "https://testcpay.payple.kr/php/auth.php";

          //#########################################################################################################################################################################

          obj.PCD_CPAY_VER = "1.0.1"; // (필수) 결제창 버전
          obj.PCD_PAY_TYPE = "card"; // (필수) 결제 수단

          //#########################################################################################################################################################################
          /*
           * 1. 결제자 인증
           * PCD_PAY_WORK : AUTH
           */
          if (pay_work == "AUTH") {
            obj.PCD_PAY_WORK = "AUTH"; // (필수) 결제요청 업무구분 (AUTH : 본인인증+계좌등록, CERT: 본인인증+계좌등록+결제요청등록(최종 결제승인요청 필요), PAY: 본인인증+계좌등록+결제완료)
            obj.PCD_PAYER_NO = buyer_no; // (선택) 가맹점 회원 고유번호 (결과전송 시 입력값 그대로 RETURN)
            obj.PCD_PAYER_NAME = buyer_name; // (선택) 결제자 이름
            obj.PCD_PAYER_HP = buyer_hp; // (선택) 결제자 휴대폰 번호
            obj.PCD_PAYER_EMAIL = buyer_email; // (선택) 결제자 Email
            obj.PCD_REGULER_FLAG = is_reguler; // (선택) 정기결제 여부 (Y|N)
            obj.PCD_SIMPLE_FLAG = simple_flag; // (선택) 간편결제 여부 (Y|N)
          }

          /*
           * 2. 결제자 인증 후 결제
           * PCD_PAY_WORK : CERT | PAY
           */

          //## 2.1 최초결제 및 단건(일반,비회원)결제
          if (pay_work != "AUTH") {
            if (simple_flag != "Y" || payple_payer_id == "") {
              obj.PCD_PAY_WORK = "CERT"; // (필수) 결제요청 업무구분 (AUTH : 본인인증+계좌등록, CERT: 본인인증+계좌등록+결제요청등록(최종 결제승인요청 필요), PAY: 본인인증+계좌등록+결제완료)
              obj.PCD_PAYER_NO = buyer_no; // (선택) 가맹점 회원 고유번호 (결과전송 시 입력값 그대로 RETURN)
              obj.PCD_PAYER_NAME = buyer_name; // (선택) 결제자 이름
              obj.PCD_PAYER_HP = buyer_hp; // (선택) 결제자 휴대폰 번호
              obj.PCD_PAYER_EMAIL = buyer_email; // (선택) 결제자 Email
              obj.PCD_PAY_GOODS = buy_goods; // (필수) 결제 상품
              obj.PCD_PAY_TOTAL = buy_total; // (필수) 결제 금액
              obj.PCD_PAY_OID = order_num; // 주문번호 (미입력 시 임의 생성)
              obj.PCD_REGULER_FLAG = is_reguler; // (선택) 정기결제 여부 (Y|N)
              obj.PCD_PAY_YEAR = pay_year; // (PCD_REGULER_FLAG = Y 일때 필수) [정기결제] 결제 구분 년도 (PCD_REGULER_FLAG : 'Y' 일때 필수)
              obj.PCD_PAY_MONTH = pay_month; // (PCD_REGULER_FLAG = Y 일때 필수) [정기결제] 결제 구분 월 (PCD_REGULER_FLAG : 'Y' 일때 필수)
              obj.PCD_TAXSAVE_FLAG = is_taxsave; // (선택) 현금영수증 발행 여부 (Y|N)
            }

            //## 2.2 간편결제 (재결제)

            if (simple_flag == "Y" && payple_payer_id != "") {
              obj.PCD_PAY_WORK = "CERT"; // (필수) 결제요청 업무구분 (AUTH : 본인인증+계좌등록, CERT: 본인인증+계좌등록+결제요청등록(최종 결제승인요청 필요), PAY: 본인인증+계좌등록+결제완료)
              obj.PCD_SIMPLE_FLAG = "Y"; // 간편결제 여부 (Y|N)
              //-- PCD_PAYER_ID 는 소스상에 표시하지 마시고 반드시 Server Side Script 를 이용하여 불러오시기 바랍니다. --//
              obj.PCD_PAYER_ID = payple_payer_id; // 결제자 고유ID (본인인증 된 결제회원 고유 KEY)
              //-------------------------------------------------------------------------------------//
              obj.PCD_PAYER_NO = buyer_no; // (선택) 가맹점 회원 고유번호 (결과전송 시 입력값 그대로 RETURN)
              obj.PCD_PAY_GOODS = buy_goods; // (필수) 결제 상품
              obj.PCD_PAY_TOTAL = buy_total; // (필수) 결제 금액
              obj.PCD_PAY_OID = order_num; // 주문번호 (미입력 시 임의 생성)
              obj.PCD_REGULER_FLAG = is_reguler; // (선택) 정기결제 여부 (Y|N)
              obj.PCD_PAY_YEAR = pay_year; // (PCD_REGULER_FLAG = Y 일때 필수) [정기결제] 결제 구분 년도 (PCD_REGULER_FLAG : 'Y' 일때 필수)
              obj.PCD_PAY_MONTH = pay_month; // (PCD_REGULER_FLAG = Y 일때 필수) [정기결제] 결제 구분 월 (PCD_REGULER_FLAG : 'Y' 일때 필수)
              obj.PCD_TAXSAVE_FLAG = is_taxsave; // (선택) 현금영수증 발행 여부 (Y|N)
            }
          }
          //#########################################################################################################################################################################

          /*
           * DEFAULT SET 2
           */
          obj.PCD_PAYER_AUTHTYPE = "pwd"; // (선택) [간편결제/정기결제] 본인인증 방식
          obj.PCD_RST_URL = "/pay/orderResult.do"; // (필수) 결제(요청)결과 RETURN URL

          PaypleCpayAuthCheck(obj);

          event.preventDefault();
        });
      });
    </script>
  </head>

  <body>
    <table border="1" cellspacing="0" cellpadding="1">
      <tr>
        <td>구매자 이름</td>
        <td>${buyer_name}</td>
      </tr>
      <tr>
        <td>구매자 휴대폰번호</td>
        <td>${buyer_hp}</td>
      </tr>
      <tr>
        <td>구매자 Email</td>
        <td>${buyer_email}</td>
      </tr>
      <tr>
        <td>구매상품</td>
        <td>${buy_goods}</td>
      </tr>
      <tr>
        <td>결제금액</td>
        <td>${buy_total}</td>
      </tr>
      <tr>
        <td>주문번호</td>
        <td>${order_num}</td>
      </tr>
      <tr>
        <td>정기결제</td>
        <td>${is_reguler}</td>
      </tr>
      <tr>
        <td>정기결제 구분년도</td>
        <td>${pay_year}</td>
      </tr>
      <tr>
        <td>정기결제 구분월</td>
        <td>${pay_month}</td>
      </tr>
      <tr>
        <td>현금영수증</td>
        <td>${is_taxsave}</td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <button id="payAction">결제하기</button>
        </td>
      </tr>
    </table>
  </body>
</html>
