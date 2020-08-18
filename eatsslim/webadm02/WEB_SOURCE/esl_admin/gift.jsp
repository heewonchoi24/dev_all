<html>
<head>
	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
</head>
<body>
<form name="frm_gift" id="frm_gift">
	주문번호
	<input type="text" name="order_num" id="order_num" /><br />
	서브번호
	<input type="text" name="sub_num" id="sub_num" /><br />
	증정일자
	<input type="text" name="stdate" id="stdate" /><br />
	<input type="button" value="확인" onclick="setGift();" />
</form>
<script type="text/javascript">
function setGift() {
	$.post("gift_ajax.jsp", $("#frm_gift").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>