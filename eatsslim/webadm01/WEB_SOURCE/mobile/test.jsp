<html>
<body>
<script type="text/javascript">
<!--
var mobile = (/iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));
if (mobile) {
	// alert("MOBILE DEVICE DETECTED");
	// document.write("<b>----------------------------------------<br>")
	// document.write("<b>" + navigator.userAgent + "<br>")
	// document.write("<b>----------------------------------------<br>")
	var userAgent = navigator.userAgent.toLowerCase();
	if ((userAgent.search("android") > -1) && ((userAgent.search("4.1") > -1) || (userAgent.search("4.2") > -1) || (userAgent.search("4.3") > -1))) {
		alert('test');
		location.href = "http://www.eatsslim.co.kr/mobile/index.jsp";
	} else {
		location.href = "http://www.eatsslim.co.kr/mobile2/index.jsp";
	}
} else
	location.href = "http://www.eatsslim.co.kr/mobile2/index.jsp";
 //-->
</script>
</body>
</html>