<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="javax.servlet.http.HttpUtils"%>
<%@ include file="/lib/dbconn.jsp" %>
<%@ include file="/lib/util.jsp" %>
<%
    request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");        //한글 깨짐 방지

	String browser		= request.getHeader("User-Agent");

	String referer = request.getHeader("referer");
	if(referer == null || "".equals(referer)) referer = "/";
	session.setAttribute("RETURN_URL",referer);
%>

<script type="text/javascript">
var returnUrl = location.pathname + location.search;
if(returnUrl == null && returnUrl == "") returnUrl = "/";
document.cookie = "returnUrl" + "=" + escape(returnUrl) + "; path=/;";
</script>
<html lang="ko">
<head>
	<title>로그인</title>
</head>
<body>
<script type="text/javascript">

//	Kakao API Key


if(Kakao.Auth == undefined) Kakao.init('731d595060bf450c56ec6954d32ab98d');

//	Kakao API Start
function loginWithKakao(){
  Kakao.Auth.login({
	  success: function(authObj) {
          // 로그인 성공시, API를 호출합니다.
          Kakao.API.request({
            url: '/v1/user/me',
            success: function(res) {

              var id = JSON.stringify(res.kaccount_email);
              var name = JSON.stringify(res.properties.nickname);
              var key = JSON.stringify(res.id);

              var idS = String(id);
           	  var nameS = String(name);

              var idR = idS.replace("\"", "");
           	  var nameR = nameS.replace("\"", "");

           	  var idT 	= idR.replace("\"", "");
           	  var nameT = nameR.replace("\"", "");

              document.userForm.Name.value = nameT;
              document.userForm.Id.value = "ka_"+key;
              document.userForm.Key.value = key;
              document.userForm.Email.value = idT;

              document.acceptCharset  = "euc-kr";
              document.userForm.action = "/shop/popup/snsRegUser.jsp";
              document.userForm.submit();

            },
            fail: function(error) {
              alert(JSON.stringify(error));
            }
          });
        },
   		fail: function(err) {
     		alert(JSON.stringify(err));
   		}
   	});
}


//facebook 초기 설정 코드
window.fbAsyncInit = function() {
	FB.init({
		appId      : '230623714086295',
	    xfbml      : true,
	    version    : 'v2.9'
	});
	FB.AppEvents.logPageView();
};

(function(d, s, id){
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) {return;}
	js 		= d.createElement(s); js.id = id;
	js.src 	= "//connect.facebook.net/en_US/sdk.js";
	fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));




function statusChangeCallback(response) {
	console.log('statusChangeCallback');
	console.log(response);
	// response 객체는 현재 로그인 상태를 나타내는 정보를 보여준다.
	// 앱에서 현재의 로그인 상태에 따라 동작하면 된다.
	// FB.getLoginStatus().의 레퍼런스에서 더 자세한 내용이 참조 가능하다.
	if (response.status === 'connected') {
		//페이스북을 통해서 로그인이 된경우
 	   	testAPI();
	} else if(response.status === 'not_authorized' ){
		//페이스북에는 로그인 했으나 앱에는 로그인이 되어 있지 않은 경우
		//document.getElementById('status').innerHTML = 'Please log ' + 'into this app.';
		alert('Please log ' + 'into this app.');
 	} else {
 		//페이스북에 로그인이 되어 있지 않아서 앱에도 로그인 여부가 불확실 한 경우
 	  	//document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
 	  	alert('Please log ' + 'into Facebook.');
 	}
}

//facebook login
function checkLoginState() {
	/* FB.getLoginStatus(function(response) {
		FB.login(function(response) {
		}, {scope: 'public_profile, email, user_birthday '});
	  });
    statusChangeCallback(response); */

	FB.login(function(response) {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});
	}, {scope: 'public_profile, email, user_birthday', return_scopes: true});
}

$(document).ready(function(){

	//add event listener to login button
	$("#fbLoginBtn").on("click",function(){checkLoginState()});
	/*
	document.getElementById('fbLoginBtn').addEventListener('click', function() {
		checkLoginState();
	}, false);
	*/

});


function testAPI() {
	var name	= "";
	var userId 	= "";
	var email	= "";
	var key		= "";
	FB.api('/me', function(response) {
		key = response.id;
		document.getElementById('Key').value = response.id;
		document.getElementById('Id').value = "fa_"+key;
		name = response.name;
		document.getElementById('Name').value = response.name;
	});
	FB.api('/me', {fields: 'email'}, function(response) {
		id = response.email;
		document.getElementById('Email').value = response.email;
		instInfo();
	});

}

function instInfo(){
    document.acceptCharset  		= "euc-kr";
    document.userForm.action 		= "/shop/popup/snsRegUser.jsp";
    document.userForm.submit();
}


</script>

<%
// 네이버 설정
String clientId 	= "R3bOi32f0cKYCX8LuXDq";//애플리케이션 클라이언트 아이디값";
String redirectURI 	= URLEncoder.encode("http://www.eatsslim.co.kr/shop/popup/naver.jsp?lightbox[width]=640&lightbox[height]=740", "UTF-8");
SecureRandom random = new SecureRandom();
String state 		= new BigInteger(130, random).toString();

String apiURL 		= "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL 				+= "&client_id=" + clientId;
apiURL 				+= "&redirect_uri=" + redirectURI;
apiURL 				+= "&state=" + state;
session.setAttribute("state", state);
%>


	<div class="pop-wrap ff_noto">
		<form name="userForm" id="userForm" method="post" action="/shop/popup/snsRegUser.jsp">
			<input type="hidden" name="Id" id="Id">
			<input type="hidden" name="Name" id="Name">
			<input type="hidden" name="Key" id="Key">
			<input type="hidden" name="Email" id="Email">
		</form>
		<div class="headpop">
		    <h2>로그인</h2>
			<!-- <p>주문하기 및 결제를 계속 진행하기 위해서는 풀무원 통합회원 로그인이 필요합니다.</p> -->
		</div>
	    <div class="contentpop">
		    <!-- <div class="popup columns offset-by-one">
					<div class="row">
					   <div class="one last col center">
					      <p class="mart30 marb20">풀무원 통합회원 로그인 페이지로 이동하시겠습니까?</p>
                          <div class="button white small"><a href="/sso/single_sso.jsp">예 ></a></div>
                          <div class="button white small"><a href="javascript:;" onclick="$.lightbox().close();">아니오 ></a></div>
                          <div class="divider"></div>
                          <p>풀무원 통합회원 아이디가 없으신 분은<br />풀무원 통합회원에 가입 하셔야 주문하기 및 결제를 계속 진행하실 수 있습니다.</p>
					   </div>
					</div>
					End row
					<div class="row">
						<div class="one last col center">
							<div class="button small dark"><a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000" onMouseDown="_trk_flashEnvView('_TRK_PI=RGF2','_TRK_G2=1');">풀무원 회원가입</a></div>
						</div>
					</div>
					End row
			  </div> -->
			<div class="pop_section1">
				<div class="section_sso">
					<div class="section_inner">
						<p>풀무원 통합회원 로그인 페이지로 이동하시겠습니까?</p>
						<a href="/sso/single_sso.jsp">
							<img src="/dist/images/common/img_sso_logo.png" alt="" />
							<strong>통합회원</strong> <span>로그인</span>
						</a>
					</div>
				</div>
				<div class="section_sns">
					<div class="section_inner">
						<h3>SNS 로그인</h3>
						<p><!-- 별도의 회원가입없이 소셜계정과 연동하여 로그인합니다.<br/> -->SNS 로그인 후 결제 시 동일한 SNS로 로그인 했을 때에<br/> 주문정보 조회가 가능합니다.</p>
						<ul>
							<li class="sns_naver"><a href="<%=apiURL%>" id="NaverLoginBtn"><span></span>네이버 ID로 로그인</a></li>
<%
if(browser.indexOf("Trident/4.0") == -1){
%>
							<li class="sns_kakao"><a href="javascript:loginWithKakao();" id="custom-login-btn"><span></span>카카오 ID로 로그인</a></li>
<%}%>
							<li class="sns_facebook"><a href="javascript:void(0);" id="fbLoginBtn"><span></span>페이스북 ID로 로그인</a></li>
							<!-- <li class="sns_instagram"><a href="javascript:void(0);"><span></span>인스타그램 ID로 로그인</a></li> -->
						</ul>
						<p style="margin-top: 1em;">* SNS 로그인 시 서비스 이용에 일부 제한될 수 있습니다.<br/>(카카오톡 모바일고객센터를 통한 주문 조회/변경 이용 제한 등)</p>
					</div>
				</div>
			</div>
			<!-- <div class="pop_section2">
				<div class="pop_section2_text">풀무원 통합회원 아이디가 없으신 분은 풀무원 통합회원에 가입하셔야<br>주문하기 및 결제를 계속 진행하실 수 있습니다.</div>
				<div class="pop_section2_button">
					<a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000">풀무원 회원가입</a>
				</div>
			</div> -->
			  <!-- End popup columns offset-by-one -->
		</div>
		<!-- End contentpop -->
	</div>

</body>
</html>

