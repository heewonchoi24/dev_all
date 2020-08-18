<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>배달지 가능지역 확인</h2>
        <button id="cboxClose" type="button">close</button>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<div class="bg-gray">
			<p>배달가능한 지역을 확인해보세요.</p>
			<p>동/읍/면/리 이름을 입력하세요. 예) 역삼동,화도읍,장유면</p>
			<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="70"><label>지역검색</label></td>
					<td style="padding-right:20px;"><input type="text" name="dong" id="dong" style="width:100%;"></td>
					<td width="40"><button class="ui-btn ui-mini ui-btn-up-b" onClick="schZipCode();" value="조회" /><span class="ui-btn-inner"><span class="ui-btn-text">조회</span></span></button></td>
				</tr>
			</table>
			<p>
				<font color="blue">입력란에 지역명을 입력하시고 『조회』 버튼을 클릭하시기 바랍니다</font>
			</p>
			<p>
				<font color="green">
					- 일배상품: 냉장일일배달 식품(퀴진,알라까르떼,시크릿수프)<br />
					- 택배상품: 상온식품(잇슬림밸런스쉐이크)
				</font>
			</p>
		</div>
		<div class="row">
			<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th width="60">우편번호</th>
				  <th>주소</th>
					<th width="40">택배</th>
				  <th width="40">일배</th>
			  </tr>
			</table>
		</div>
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#dong").focus();
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
				$(".spectable").html('<tr><th width="60">우편번호</th><th>주소</th><th width="40">일배</th><th width="40">택배</th></tr>');
				var zipcodeArr;
				$(data).find("address").each(function() {
					zipcodeArr = $(this).text().split("|");
					if (zipcodeArr[0] == "nodata") {
						$(".spectable").append('<tr><td colspan="2">검색된 배달가능지역이 없습니다.</td></tr>');
					} else {
						$(".spectable").append('<tr><td>'+ zipcodeArr[0] +'</td><td>'+ zipcodeArr[1] +'</td><td>'+ zipcodeArr[4] +'</td><td>'+ zipcodeArr[5] +'</td></tr>');
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