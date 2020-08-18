<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/link.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<title>정회원 전환</title>
<style>
</style>
<!-- jquery 는 가맹점에서 이용중인 jquery 버전으로 이용하셔도 됩니다. -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://testcpay.payple.kr/js/cpay.payple.1.0.0.js"></script>
<link rel="stylesheet" href="/assets2/css/main.css" />
<!-- TEST -->
</head>

<script>
	var pay_work = "";
	var payple_payer_id = "";
	var buyer_no = "";
	var buyer_name = "";
	var buyer_hp = "";
	var buyer_email = "";
	var buy_goods = "";
	var buy_total = "";
	var order_num = "";
	var is_reguler = "";
	var pay_year = "";
	var pay_month = "";
	var is_taxsave = "";
	var simple_flag = "";

	$(document).ready(function() {
		$('#orderFormSubmit').on('click', function(event) {

			var formData = $('#orderForm').serialize();

			$.ajax({
				url : "/pay/orderConfirm.do",
				type : "POST",
				data : formData,
				dataType : "json",
				success : function(data, status, xhr) {
					pay_work = "CERT";
					payple_payer_id = "";
					buyer_no = data.buyer_no;
					buyer_name = data.buyer_name;
					buyer_hp = data.buyer_hp;
					buyer_email = data.buyer_email;
					buy_goods = data.buy_goods;
					buy_total = data.buy_total;
					order_num = data.order_num;
					is_reguler = data.is_reguler;
					pay_year = data.pay_year;
					pay_month = data.pay_month;
					is_taxsave = data.is_taxsave;
					simple_flag = data.simple_flag;

					fnOrderFormSubmit();
				},
				error : function(xhr, status, error) {
				}
			});

		});
	});

	function fnOrderFormSubmit() {

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
			if (simple_flag == "Y" && payple_payer_id  != "") {
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
	}
</script>

<body data-spy="scroll" data-target=".navbar-collapse">
	<!-- Preloader -->
	<div id="loading">
		<div id="loading-center">
			<div id="loading-center-absolute">
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
				<div class="object"></div>
			</div>
		</div>
	</div>

	<!--End off Preloader -->
	<div class="culmn">
		<!--Home page style-->
		<nav
			class="navbar navbar-default navbar-fixed white no-background bootsnav text-uppercase">
			<div class="container">
				<%@ include file="common/header.jsp"%>
			</div>
		</nav>

		<footer id="footer" class="wrapper">
			<div class="inner">
				<section>
					<div class="box">
						<div class="content">
							<h2 class="align-center">정회원 전환</h2>
							<hr />
							<div style="font-size: 17px">
								연회비(만 원) 자동 결제 서비스입니다. <br> 정회원이 되시면 앞으로 더 많은 다양한 콘텐츠를 이용하실 수
								있으며, <br>회원님의 이러한 후원은 박정희 대통령님을 기념하기 위한 의미 있는 사업을 추진 가능하게
								만듭니다.
								<div>
									<br> <br> <br> <br>
									<form method="post" id="orderForm" name="orderForm">
										<div class="field half first">
											<label for="buyer_name">성함</label> <input type="text"
												name="buyer_name" id="buyer_name" value="${userNm}">
										</div>
										<div class="field half first">
											<label for="buyer_hp">휴대폰 번호</label> <input type="text"
												name="buyer_hp" id="buyer_hp" value="${userTelno}">
										</div>
										<div class="field half first">
											<label for="buyer_email">이메일 주소</label> <input type="text"
												name="buyer_email" id="buyer_email" value="${userEmail}">
										</div>
										<div class="field half first">
											<label for="buy_total">결제금액</label> <input type="text"
												name="buy_total" id="buy_total" value="10,000 (원)" readonly>
										</div>
										<button type="button" class="button special"
											id="orderFormSubmit" style="margin: 0px 0px 0px 400px;">결제</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</footer>
	</div>
</body>
</html>