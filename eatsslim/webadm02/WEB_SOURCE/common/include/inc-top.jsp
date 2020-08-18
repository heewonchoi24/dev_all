<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta name="robots" content="noindex,nofollow,noarchive">

	<title>바른 다이어트 잇슬림</title>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />

	<script src="//code.jquery.com/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="/common/js/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="/common/js/jquery.cycle.js"></script>
	<!-- 주문수량 Spinner -->
	<script type="text/javascript" src="/common/js/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
	<!-- Lightbox -->
	<script type="text/javascript" src="/common/js/jquery.lightbox.js"></script>
	<!-- Bottom Panel -->
	<script type="text/javascript" src="/common/js/jquery.slidedrawer.js"></script>
	<script type="text/javascript" src="/common/js/jquery.selectBox.js"></script>
	<script type="text/javascript" src="/common/js/eatsslim.js"></script>
	<script type="text/javascript" src="/common/js/util.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
	
	
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