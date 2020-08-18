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
	response.setCharacterEncoding("euc-kr");        //�ѱ� ���� ����

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
	<title>�α���</title>
</head>
<body>
<script type="text/javascript">

//	Kakao API Key


if(Kakao.Auth == undefined) Kakao.init('731d595060bf450c56ec6954d32ab98d');

//	Kakao API Start
function loginWithKakao(){
  Kakao.Auth.login({
	  success: function(authObj) {
          // �α��� ������, API�� ȣ���մϴ�.
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


//facebook �ʱ� ���� �ڵ�
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
	// response ��ü�� ���� �α��� ���¸� ��Ÿ���� ������ �����ش�.
	// �ۿ��� ������ �α��� ���¿� ���� �����ϸ� �ȴ�.
	// FB.getLoginStatus().�� ���۷������� �� �ڼ��� ������ ���� �����ϴ�.
	if (response.status === 'connected') {
		//���̽����� ���ؼ� �α����� �Ȱ��
 	   	testAPI();
	} else if(response.status === 'not_authorized' ){
		//���̽��Ͽ��� �α��� ������ �ۿ��� �α����� �Ǿ� ���� ���� ���
		//document.getElementById('status').innerHTML = 'Please log ' + 'into this app.';
		alert('Please log ' + 'into this app.');
 	} else {
 		//���̽��Ͽ� �α����� �Ǿ� ���� �ʾƼ� �ۿ��� �α��� ���ΰ� ��Ȯ�� �� ���
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
// ���̹� ����
String clientId 	= "R3bOi32f0cKYCX8LuXDq";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
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
		    <h2>�α���</h2>
			<!-- <p>�ֹ��ϱ� �� ������ ��� �����ϱ� ���ؼ��� Ǯ���� ����ȸ�� �α����� �ʿ��մϴ�.</p> -->
		</div>
	    <div class="contentpop">
		    <!-- <div class="popup columns offset-by-one">
					<div class="row">
					   <div class="one last col center">
					      <p class="mart30 marb20">Ǯ���� ����ȸ�� �α��� �������� �̵��Ͻðڽ��ϱ�?</p>
                          <div class="button white small"><a href="/sso/single_sso.jsp">�� ></a></div>
                          <div class="button white small"><a href="javascript:;" onclick="$.lightbox().close();">�ƴϿ� ></a></div>
                          <div class="divider"></div>
                          <p>Ǯ���� ����ȸ�� ���̵� ������ ����<br />Ǯ���� ����ȸ���� ���� �ϼž� �ֹ��ϱ� �� ������ ��� �����Ͻ� �� �ֽ��ϴ�.</p>
					   </div>
					</div>
					End row
					<div class="row">
						<div class="one last col center">
							<div class="button small dark"><a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000" onMouseDown="_trk_flashEnvView('_TRK_PI=RGF2','_TRK_G2=1');">Ǯ���� ȸ������</a></div>
						</div>
					</div>
					End row
			  </div> -->
			<div class="pop_section1">
				<div class="section_sso">
					<div class="section_inner">
						<p>Ǯ���� ����ȸ�� �α��� �������� �̵��Ͻðڽ��ϱ�?</p>
						<a href="/sso/single_sso.jsp">
							<img src="/dist/images/common/img_sso_logo.png" alt="" />
							<strong>����ȸ��</strong> <span>�α���</span>
						</a>
					</div>
				</div>
				<div class="section_sns">
					<div class="section_inner">
						<h3>SNS �α���</h3>
						<p><!-- ������ ȸ�����Ծ��� �ҼȰ����� �����Ͽ� �α����մϴ�.<br/> -->SNS �α��� �� ���� �� ������ SNS�� �α��� ���� ����<br/> �ֹ����� ��ȸ�� �����մϴ�.</p>
						<ul>
							<li class="sns_naver"><a href="<%=apiURL%>" id="NaverLoginBtn"><span></span>���̹� ID�� �α���</a></li>
<%
if(browser.indexOf("Trident/4.0") == -1){
%>
							<li class="sns_kakao"><a href="javascript:loginWithKakao();" id="custom-login-btn"><span></span>īī�� ID�� �α���</a></li>
<%}%>
							<li class="sns_facebook"><a href="javascript:void(0);" id="fbLoginBtn"><span></span>���̽��� ID�� �α���</a></li>
							<!-- <li class="sns_instagram"><a href="javascript:void(0);"><span></span>�ν�Ÿ�׷� ID�� �α���</a></li> -->
						</ul>
						<p style="margin-top: 1em;">* SNS �α��� �� ���� �̿뿡 �Ϻ� ���ѵ� �� �ֽ��ϴ�.<br/>(īī���� ����ϰ����͸� ���� �ֹ� ��ȸ/���� �̿� ���� ��)</p>
					</div>
				</div>
			</div>
			<!-- <div class="pop_section2">
				<div class="pop_section2_text">Ǯ���� ����ȸ�� ���̵� ������ ���� Ǯ���� ����ȸ���� �����ϼž�<br>�ֹ��ϱ� �� ������ ��� �����Ͻ� �� �ֽ��ϴ�.</div>
				<div class="pop_section2_button">
					<a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000">Ǯ���� ȸ������</a>
				</div>
			</div> -->
			  <!-- End popup columns offset-by-one -->
		</div>
		<!-- End contentpop -->
	</div>

</body>
</html>

