<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%><%
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta http-equiv="Cache-Control" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>

	<title>잇슬림 - 세심하게관리받는식단</title>
	<meta name="description" content="풀무원 잇슬림, 칼로리조절 식단, 건강도시락 전문 브랜드"></meta>

	<link rel="canonical" href="http://www.eatsslim.co.kr"> 
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/layout.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/skeleton.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/color-theme.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery-ui.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.selectBox.css" />
	<link rel="stylesheet" type="text/css" media="all" href="/common/css/jquery.lightbox.css" />
    <link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar.css" />
    <link rel="stylesheet" type="text/css" media="print" href="/common/css/print.css" />


	<script src="/common/js/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="/common/js/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="/common/js/jquery.cycle.js"></script>
	<!-- 주문수량 Spinner -->
	<script type="text/javascript" src="/common/js/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="/common/js/jquery.ui.button.js"></script>
	<!-- Lightbox -->
	<script type="text/javascript" src="/common/js/jquery.lightbox.js"></script>
	<script type="text/javascript" src="/common/js/jquery.mCustomScrollbar.js"></script>
	<script type="text/javascript" src="/common/js/slick.js"></script>
	<script type="text/javascript" src="/common/js/Tweenmax.min.js"></script>
	<!-- Bottom Panel -->
	<script type="text/javascript" src="/common/js/jquery.slidedrawer.js"></script>
	<script type="text/javascript" src="/common/js/jquery.selectBox.js"></script>
	<script type="text/javascript" src="/common/js/fullcalendar.js"></script>
	<script type="text/javascript" src="/common/js/eatsslim.js"></script>
	<script type="text/javascript" src="/common/js/util.js"></script>

<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css">
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
    <!--[if gte IE 9]>
	<style type="text/css">
	.gradient {filter: none;}
	</style>
    <![endif]-->
<script type="text/javascript" src="/common/js/main.js"></script>
	<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script type="text/javascript"	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"	charset="utf-8"></script>
	<script type="text/javascript">
	function popup_getcookie(name) {
		var nameOfcookie = name + "=";
		var x = 0;
		while ( x <= document.cookie.length ) {
			var y = (x+nameOfcookie.length);
			if ( document.cookie.substring( x, y ) == nameOfcookie ) {
				if ( (endOfcookie=document.cookie.indexOf( ";", y )) == -1 )
					endOfcookie = document.cookie.length;
				return unescape( document.cookie.substring( y, endOfcookie ) );
			}
			x = document.cookie.indexOf( " ", x ) + 1;
			if ( x == 0 )
				break;
		}
		return "";
	}

	function clickMainBanner(url) {

		ga('send', 'event', 'main', 'click', '잇슬림이벤트');

		if (url) {
			location = url;
		}

	}
	</script>

<%
String queryLogin = "";
int popupCnt	= 0;
int popupId		= 0;
String attr		= "";

queryLogin		= "SELECT COUNT(ID) FROM ESL_POPUP WHERE OPEN_YN = 'Y' AND DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
try {
	rs	= stmt.executeQuery(queryLogin);
} catch(Exception e) {
	out.println(e+"=>"+queryLogin);
	if(true)return;
}

if (rs.next()) {
	popupCnt	= rs.getInt(1);
}
rs.close();

if (popupCnt > 0) {
	queryLogin		= "SELECT ID, ATTR FROM ESL_POPUP WHERE OPEN_YN = 'Y' AND DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
	try {
		rs	= stmt.executeQuery(queryLogin);
	} catch(Exception e) {
		out.println(e+"=>"+queryLogin);
		if(true)return;
	}

	while (rs.next()) {
		popupId		= rs.getInt("ID");
		attr		= rs.getString("ATTR");
%>
	<script type="text/javascript">
	if (popup_getcookie("popup_<%=popupId%>") != "done") {
		window.open('/popup/popup.jsp?id=<%=popupId%>','essmainpopup','<%=attr%>,resizable=no,toolbar=no,status=no,menubar=no,');
	}
	</script>
<%
	}
	rs.close();
}



%>

<%
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
if(session.getAttribute("DIMENSION_VALUE") == null) {
	String referer = request.getHeader("referer");
	String sessionDimensionValue = "";
	if(session.getAttribute("DIMENSION_VALUE") == null){
		if(referer!= null && referer.length()>0) {
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
<script> var SGscriptPlugIn = new function () { StarADPayment=''; this.loadSBox = function(eSRC,fnc) { var script = document.createElement('script'); script.type = 'text/javascript'; script.charset = 'utf-8'; script.onreadystatechange= function () { if((!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') && fnc!=undefined && fnc!='' ) { eval(fnc); }; }; script.onload = function() { if(fnc!=undefined && fnc!='') { eval(fnc); }; }; script.src= eSRC; document.getElementsByTagName('head')[0].appendChild(script); }; }; </script>
<script>SGscriptPlugIn.loadSBox('//showget.co.kr/js/plugRank.php?ecmdmkt','');</script>
<!-- ShowGet Widget Script End -->

<!-- 다음 DDN 스크립팅 Start 2017.01.09 -->
<script type="text/javascript">
    var roosevelt_params = {
        retargeting_id:'PXhBM5qlN9UaFqhYLxnkJw00',
        tag_label:'XHeuE9FLQ9GJxgO_A86ZLQ'
    };
</script>
<script type="text/javascript" src="//adimg.daumcdn.net/rt/roosevelt.js" async></script>
<!-- 다음 DDN 스크립팅 End -->

<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">
window.criteo_q = window.criteo_q || [];
window.criteo_q.push(
{ event: "setAccount", account: 36733 },
{ event: "setEmail", email: "smyook@pulmuone.com" },
{ event: "setSiteType", type: "d" },
{ event: "viewHome" }
);
</script>

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