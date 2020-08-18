<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
if(true){
	
	String httpCheck = request.getScheme();
	String serverNameCheck = request.getServerName();
	String siteUrlCheck = request.getRequestURI().toString() + ((request.getQueryString() == null) ? "" : "?" + request.getQueryString() );
	String returnUrlCheck = "";
		
	//-- 서버 주소 확인
	if(!"www.eatsslim.co.kr".equals(serverNameCheck)){
		returnUrlCheck = "http://" + "www.eatsslim.co.kr" + siteUrlCheck;
		response.sendRedirect(returnUrlCheck);
		return;
	}
	
	//-- 접속 경로 확인
	if(!"http".equals(httpCheck)){
		returnUrlCheck = "http://" + serverNameCheck + siteUrlCheck;
		response.sendRedirect(returnUrlCheck);
		return;
	}
}

/*
String ip = "115.94.37.77";
String remote = request.getRemoteAddr();
if(ip.indexOf(remote) == -1){
	response.sendRedirect("/checking_site.jsp");
	return;
}
*/
%>
<%
request.setCharacterEncoding("euc-kr");

int icnt			= 0;
int cartId			= 0;
int igroupId		= 0;
int ibuyQty			= 0;
String idevlType	= "";
String idevlDay		= "";
String idevlWeek	= "";
String idevlDate	= "";
String idevlPeriod	= "";
int iprice			= 0;
String ibuyBagYn	= "";
String igubun1		= "";
String igroupName	= "";
String icartImg		= "";
String iimgUrl		= "";
int payPrice		= 0;
int itotalPrice		= 0;
int totalPrice1		= 0;
int totalPrice2		= 0;
int totalPrice3		= 0;
int itagPrice		= 0;
int itagPrice2		= 0;
int itagPrice3		= 0;
int idevlPrice		= 0; // 밸런스쉐이크 택배비
int idevlPrice1		= 0; // 미니밀/라이스 택배비
int idevlPrice2		= 0; // 풀비타 택배비
int idevlPrice3		= 0; // 건강즙 택배비
int ibagPrice		= 0;
int cartItemCnt		= 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta name="viewport" content="height=device-height, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
	<!-- Chrome, Firefox OS and Opera -->
	<meta name="theme-color" content="#67c7ef" />
	<!-- Windows Phone -->
	<meta name="msapplication-navbutton-color" content="#67c7ef" />
	<!-- iOS Safari -->
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
	<title>풀무원 잇슬림</title>
	<meta name="description" content="풀무원 잇슬림, 칼로리조절 식단, 건강도시락 전문 브랜드" />
	
    <link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/eatsslim-ui.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/style.css" />
    <!-- <link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/jquery-ui.css" /> -->
    <!--link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/jquery.lightbox.css" /-->
    <link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/colorbox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/datepicker.css">
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/oldclass.css">
    <script src="/mobile/common/js/jquery.js"></script>
    <!-- <script src="/mobile/common/js/jquery-ui.js"></script> -->
    <script src="/mobile/common/js/jquery.colorbox.js"></script>
	<!-- <script src="/mobile/common/js/util.js"></script> -->
	<script src="/mobile/common/js/Tweenmax.min.js"></script>
	<script src="/mobile/common/js/common.js"></script>
	<script src="/mobile/common/js/slick.js"></script>
	<script src="/mobile/common/js/datepicker.js" charset="utf-8"></script>
	<script src="/mobile/common/js/calendar.js" charset="utf-8"></script>
	<script src="/mobile/common/js/jquery.lazyload.js"></script>
	<!-- 카카오 로그인 -->
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">

    <!-- <script>
		$(document).ready(function(){
			if($("#wrap, div").hasClass("expansioncss")){
				document.querySelector('head').innerHTML += '<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">';
			}
			$(".iframe").colorbox({iframe:true, width:"96%", height:"405px"});
		});
	</script> -->

<%
if(session.getAttribute("DIMENSION_VALUE") == null) {
	String referer = request.getHeader("referer");
	String sessionDimensionValue = "";
	if(session.getAttribute("DIMENSION_VALUE") == null){
		if(referer!= null && referer.length()!=0) {
			// 프로토콜 문자열 제거
			referer = referer.replaceAll("http://", "").replaceAll("https://", "");
			if (referer.indexOf("/") != -1) {
				referer = referer.substring(0,referer.indexOf("/"));
			}
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

<!-- Screenview 스크린뷰 리타겟팅 Script-->
<script src="http://data.neoebiz.co.kr/cdata.php?reData=53880"></script>

<!-- LiveLog TrackingCheck Script Start -->
<script>
var LLscriptPlugIn = new function () { this.load = function(eSRC,fnc) { var script = document.createElement('script'); script.type = 'text/javascript'; script.charset = 'utf-8'; script.onreadystatechange= function () { if((!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') && fnc!=undefined && fnc!='' ) { eval(fnc); }; }; script.onload = function() { if(fnc!=undefined && fnc!='') { eval(fnc); }; }; script.src= eSRC; document.getElementsByTagName('head')[0].appendChild(script); }; }; LoadURL = "MjIIOAgwCDIzCDYINgg3CA"; LLscriptPlugIn.load('//livelog.co.kr/js/plugShow.php?'+LoadURL, 'sg_check.playstart()');
</script>
<!-- LiveLog TrackingCheck Script End -->

<!-- ShowGet Widget Script Start -->
<script>
var SGscriptPlugIn = new function () { StarADPayment=''; this.loadSBox = function(eSRC,fnc) { var script = document.createElement('script'); script.type = 'text/javascript'; script.charset = 'utf-8'; script.onreadystatechange= function () { if((!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') && fnc!=undefined && fnc!='' ) { eval(fnc); }; }; script.onload = function() { if(fnc!=undefined && fnc!='') { eval(fnc); }; }; script.src= eSRC; document.getElementsByTagName('head')[0].appendChild(script); }; }; </script>
<script> SGscriptPlugIn.loadSBox('//showget.co.kr/js/plugShow.php?ecmdmkt','sg_paycheck.playstart()'); </script>
<!-- ShowGet Widget Script End -->
<!-- ShowGet SCON Script -->
<script src="//showget.co.kr/showcorn/js/showconbar.js.php?pid=ecmdmkt" charset='utf-8'>
</script>
<script>
showconbar.code = new Array('ecmdmkt');
showconbar.SCon();
</script>
<!-- ShowGet SCON Script -->
<!-- ShowGet Widget Script Start -->
<script> SGscriptPlugIn.loadSBox('//showget.co.kr/js/plugRank.php?ecmdmkt',"ShowGet_Rank.startPlugin()");</script>
<!-- ShowGet Widget Script End -->

<!-- Facebook Pixel Code -->
<script>
  !function(f,b,e,v,n,t,s)
  {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
  n.callMethod.apply(n,arguments):n.queue.push(arguments)};
  if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
  n.queue=[];t=b.createElement(e);t.async=!0;
  t.src=v;s=b.getElementsByTagName(e)[0];
  s.parentNode.insertBefore(t,s)}(window, document,'script',
  'https://connect.facebook.net/en_US/fbevents.js');
  fbq('init', '690391851131172');
  fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
  src="https://www.facebook.com/tr?id=690391851131172&ev=PageView&noscript=1"
/></noscript>
<!-- End Facebook Pixel Code -->