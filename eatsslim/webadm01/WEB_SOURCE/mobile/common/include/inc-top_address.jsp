<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />

	<title>잇슬림</title>
    <link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/stylesheet.css" />
    <!--link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/jquery.lightbox.css" /-->
    <script type="text/javascript" src="/mobile/common/js/jquery.js"></script>
    <script type="text/javascript" src="/mobile/common/js/jquery-ui.js"></script>	
    <script type="text/javascript" src="/mobile/common/js/jquery.colorbox.js"></script>
	<script type="text/javascript" src="/mobile/common/js/util.js"></script>

<%
if(session.getAttribute("DIMENSION_VALUE") == null) {
	String referer = request.getHeader("referer");
	String sessionDimensionValue = "";
	if(session.getAttribute("DIMENSION_VALUE") == null){
		if(referer!= null && referer.length()!=0) {
			// 프로토콜 문자열 제거
			referer = referer.replaceAll("http://", "").replaceAll("https://", "");
			referer = referer.substring(0,referer.indexOf("/"));
			sessionDimensionValue = referer;
		}else{
			sessionDimensionValue = "direct";
		}
		
		session.setAttribute("DIMENSION_VALUE", sessionDimensionValue);
	}
	
}
%>	
	
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-61938491-5', 'auto',{
   'allowLinker':true
  });
  
  ga('require','linker');
  ga('linker:autoLink', ['pulmuone.co.kr']);  
  
  var dimensionValue = '<%=session.getAttribute("DIMENSION_VALUE")%>';
  ga('set', 'dimension1', dimensionValue);
  ga('set', 'dimension2', '<%=session.getAttribute("esl_customer_num")==null?"N":"Y"%>');            //로그인시 고객번호전송
  ga('set', 'dimension3', '<%=session.getAttribute("esl_customer_num")==null?"":session.getAttribute("esl_customer_num")%>');            //로그인시 고객번호전송
  
  ga('send', 'pageview');

</script>