<html>
<body>
<script type="text/javascript">
<!--
	var userAgent = navigator.userAgent.toLowerCase();
	document.write(userAgent);

     var mobile = (/iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));
              if (mobile) {
                  alert("MOBILE DEVICE DETECTED");
                  document.write("<b>----------------------------------------<br>")
                  document.write("<b>" + navigator.userAgent + "<br>")
                  document.write("<b>----------------------------------------<br>")
                  var userAgent = navigator.userAgent.toLowerCase();
                  if ((userAgent.search("android") > -1) && (userAgent.search("mobile") > -1))
                         document.write("<b> ANDROID MOBILE <br>")
                   else if ((userAgent.search("android") > -1) && !(userAgent.search("mobile") > -1))
                       document.write("<b> ANDROID TABLET <br>")
              }
              else
                  alert("NO MOBILE DEVICE DETECTED");
 //-->
</script>
</body>
</html>