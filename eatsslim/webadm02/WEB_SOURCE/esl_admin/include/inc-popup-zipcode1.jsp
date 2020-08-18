<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>
	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	.scrollBox {position:relative;overflow-y:scroll;overflow-x:hidden; width:367px; height:443px;}
	</style>
</head>
<body>
	<!-- popup_wrap -->
	<div class="popup_wrap" style="width:380px;">
		<h2>배송가능지역 찾기</h2>
		<!--<p>
			<span class="mr_10">
				<input type="radio" class="radio1" onclick="$('.zip_box1').show();$('.zip_box2').hide();" checked="checked" name="rad1" />
				지번주소
			</span>
			<span class="mr_10">
				<input type="radio" class="radio1" onclick="$('.zip_box2').show();$('.zip_box1').hide();" name="rad1" />
				도로명주소
			</span>
		</p>-->
		<div class="zip_box1">
			<div class="zip_search">
				<strong>주소</strong>
				<input type="text" class="input1" style="width:200px;" maxlength="30" id="dong" value="" onfocus="this.select()" onkeydown="if(event.keyCode==13)searchAddr();" style="ime-mode:active"/>
				<a href="javascript:searchAddr()"><img src="../images/common/btn/btn_search.png" alt="검색" /></a>
				<p>동/읍/면 이름을 입력하세요. <span>예) 역삼동, 곡성읍, 오곡면</span></p>
			</div>
			<br/>
			<div class="zip_result">
				<table class="zip_tbl" border="1" cellspacing="0" style="display:none;">
					<colgroup>
					<col width="70px" />
					<col width="*" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">우편번호</th>
							<th scope="col">주소</th>
						</tr>
					</thead>
					<tbody id="AddressList">						
					</tbody>
				</table>
			</div>
		</div>
		
	</div>
	<!-- //popup_wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$('#dong').focus()
});

function searchAddr(){
	$(".zip_tbl").hide();
	$.post("../order/zipcode.jsp", {
		mode: 'post',
		dong: $("#dong").val()
	},
	function(data) {
		$('#AddressList *').remove(); // 데이터가 누적되어 나타나지 않도록 한번 클리어 해줌
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$(".zip_tbl").show();
				var zipcodeArr;
				$(data).find("address").each(function() {
					zipcodeArr = $(this).text().split("|");
					if (zipcodeArr[0] == "nodata") {
						$("#AddressList").append('<tr><td colspan="2">검색된 배송가능지역이 없습니다.</td></tr>');
					} else {
						$("#AddressList").append('<tr><td>'+ zipcodeArr[0] +"</td><td><a href=\"javascript:zipcode('"+ zipcodeArr[0] +"','"+ zipcodeArr[1] +"')\">"+ zipcodeArr[1] +'</a></td></tr>');
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
}

function zipcode(zip,addr){
	$("#rcv_zipcode", opener.document).val(zip);
	$("#rcv_addr1", opener.document).val(addr);
	self.close();
}
</script>
</body>
</html>