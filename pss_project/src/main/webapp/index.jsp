<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>


<html>
<head>
<title>보건복지 개인정보보호 지원시스템</title>
</head>
<body>
<script>
	
	var ieCheck;
	var version = "0";
	var agent = navigator.userAgent.toLowerCase();
	if(navigator.appName == "Microsoft Internet Explorer") {
		ieCheck = "msie ";
	} else {
		if(agent.search("trident") > -1) {
			ieCheck = "trident/.*rv:";
		} else if(agent.search("edge/") > -1) {
			ieCheck = "edge/";
		}
	}
	var reg =  new RegExp(ieCheck + "([0-9]{1,})(\\.{0,}[0-9]{0,1})");
	if(reg.exec(agent) != null) {
		version = RegExp.$1;
	}
	if(0 != version) {
		if(10 > version) {
			location.href="/login/browserVersion.do";
		} else {
			location.href="/login/login.do";
		}
	} else {
		location.href="/login/login.do";
	}
</script>
</body>
</html>