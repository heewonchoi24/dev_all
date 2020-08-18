<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>잇슬림 배송지 가능지역 확인</title>

	<link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/layout.css" />
    <link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/skeleton.css" />
    <link rel="stylesheet" type="text/css" media="all" href="http://www.eatsslim.com/common/css/color-theme.css" />
    <script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
			<h2>배송지 가능지역 확인</h2>
			<p></p>
		</div>
		<div class="contentpop">
			<div class="popup columns offset-by-one"> 
				<div class="row">
					<div class="one last col">
						<form name="frm_zipcode" id="frm_zipcode">
							<div class="postSearchBox">
								<p>배송 가능한 지역을 확인해보세요.</p>
								<p>동/읍/면/리 이름을 입력하세요. 예) 역삼동,화도읍,장유면</p>
								<!--p>지번주소:동/읍/면/리 이름을 입력하세요. 예) 역삼동,화도읍,장유면</p>
                                <p>도로면주소(새주소):도로명을 입력하세요. 예) 중앙로,불정로 432번길</p>
								<label>지번/도로명</label>
								<label>지번</label-->
								<input type="text" class="inputfield" name="dong" id="dong"> <span class="button small light" style="margin:0;"><a href="javascript:;" onClick="schZipCode();">조회</a></span>
								<p><font color="blue">입력란에 지역명을 입력하시고 『조회』 버튼을 클릭하시기 바랍니다.</font></p>
								<p>
									<font color="green">
										- 일배상품: 냉장일일배달 식품(퀴진,알라까르떼,시크릿수프)<br />
										- 택배상품: 상온식품(잇슬림밸런스쉐이크)
									</font>
								</p>
							</div>
						</form>
						<!--div class="marb20 mart20" style="text-align:center;">
							<p class="bold7">검색결과에 주소가 검색될 경우, 배송가능한 지역입니다.<br />
							<font class="f12 font-gray">(주소 리스트에 검색되지 않을 경우 배송 불가한 지역입니다.)</font></p>
						</div-->
                        <div class="divider"></div>
						<div class="frameBox">
							<table class="tbmulti" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<th>우편번호</th>
									<th>주소</th>
                                    <th>일배</th>
                                    <th>택배</th>
								</tr>
							</table>
						</div> 
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<!-- End popup columns offset-by-one -->	
		</div>
		<!-- End contentpop -->
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#dong").focus();
	$("#frm_zipcode").submit(schZipCode);
});

function schZipCode() {
	$.post("/shop/zipcode_ajax.jsp", {
		mode: 'post',
		dong: $("#dong").val(),
		ztype: "2"
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(".tbmulti").html('<tr><th>우편번호</th><th>주소</th><th>일배</th><th>택배</th></tr>');
				var zipcodeArr;
				$(data).find("address").each(function() {
					zipcodeArr = $(this).text().split("|");
					if (zipcodeArr[0] == "nodata") {
						$(".tbmulti").append('<tr><td colspan="2">검색된 배송가능지역이 없습니다.</td></tr>');
					} else {
						$(".tbmulti").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
					}
				});
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#dong").focus();
					});
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>