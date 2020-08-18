<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
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
<%@ include file="/lib/config.jsp"%>
<%-- <%@ include file="/mobile/common/include/inc-login-check.jsp"%> --%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
    request.setCharacterEncoding("euc-kr");
	response.setCharacterEncoding("euc-kr");        //�ѱ� ���� ����

	String referer = request.getHeader("referer");
	if(referer == null || "".equals(referer)) referer = "/mobile";
	session.setAttribute("RETURN_URL",referer);

%>
<%
String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
Statement stmt2		= null;
ResultSet rs2		= null;
String minDate		= "";
String maxDate		= "";
String devlDates	= "";
stmt1				= conn.createStatement();
stmt2				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
/* int payPrice		= 0; */
String payType		= "";
String orderState	= "";
int cnt				= 0;
String goodsList	= "";
int listSize		= 0;
String gId			= "";
String groupCode	= "";
ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();
String menuF = request.getParameter("menuF");
String menuS = request.getParameter("menuS");
System.out.println("menuF : "+menuF);
System.out.println("menuS : "+menuS);

NumberFormat nf		= NumberFormat.getNumberInstance();
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
/* cal.add ( Calendar.MONTH, -1 ); */ //1������
cal.add ( Calendar.MONTH, -5 ); //10������
String preMonth3=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 0 AND ORDER_STATE < 90";
where			+= " AND DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') BETWEEN '"+ preMonth3 +"' AND '"+ cDate +"'";
query		= "SELECT COUNT(*)";
query		+= " FROM "+ table + where; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	cnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC"; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}


///////////////////////////
%>
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
              document.userForm.action = "/shop/popup/snsRegMUser.jsp";
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
	$("#fbLoginBtn").on("click",function(){checkLoginState()});
	/*
	//add event listener to login button
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
    document.userForm.action 		= "/shop/popup/snsRegMUser.jsp";
    document.userForm.submit();
}


</script>
<%
// ���̹� ����
String clientId 	= "R3bOi32f0cKYCX8LuXDq";//���ø����̼� Ŭ���̾�Ʈ ���̵�";
String redirectURI 	= URLEncoder.encode("http://www.eatsslim.co.kr/shop/popup/naverM.jsp", "UTF-8");
SecureRandom random = new SecureRandom();
String state 		= new BigInteger(130, random).toString();

String apiURL 		= "https://nid.naver.com/oauth2.0/authorize?response_type=code";
apiURL 				+= "&client_id=" + clientId;
apiURL 				+= "&redirect_uri=" + redirectURI;
apiURL 				+= "&state=" + state;
session.setAttribute("state", state);
%>

<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">
		<form name="userForm" id="userForm" method="post" action="/shop/popup/snsRegMUser.jsp">
			<input type="hidden" name="Id" id="Id">
			<input type="hidden" name="Name" id="Name">
			<input type="hidden" name="Key" id="Key">
			<input type="hidden" name="Email" id="Email">
		</form>
		<nav class="navigation nbd">
			<h1 class="title">�α���</h1>
		</nav>
		<div class="bx_sso_login">
			<div class="section_sso">
				<div class="section_inner">
					<p>Ǯ���� ����ȸ�� �α��� ��������<br>�̵��Ͻðڽ��ϱ�?</p>
					<a href="/sso/single_sso.jsp">
						<img src="/mobile/common/images/common/ico_m_logo.png" alt="">
						<strong>����ȸ��</strong> <span>�α���</span>
					</a>
				</div>
			</div>
 			<div class="section_sns">
 				<div class="section_inner">
 					<h3>SNS �α���</h3>
 					<p>SNS �α��� �� ���� �� ������ SNS�� �α��� ���� ����<br/> �ֹ����� ��ȸ�� �����մϴ�.</p>
 					<ul>
 						<li><a href="<%=apiURL%>" id="NaverLoginBtn"><img src="/mobile/common/images/common/ico_m_naver.png" alt="" /></a></li>
 						<li><a href="javascript:loginWithKakao();" id="custom-login-btn"><img src="/mobile/common/images/common/ico_m_kakao.png" alt="" /></a></li>
 						<li><a href="javascript:void(0);" id="fbLoginBtn"><img src="/mobile/common/images/common/ico_m_facebook.png" alt="" /></a></li>
 						<!-- <li><a href="javascript:void(0);"><img src="/mobile/common/images/common/ico_m_instagram.png" alt="" /></a></li> -->
 					</ul>
 					<p style="margin-top: 1em;">* SNS �α��� �� ���� �̿뿡 �Ϻ� ���ѵ� �� �ֽ��ϴ�.<br/>(īī���� ����ϰ����͸� ���� �ֹ� ��ȸ/���� �̿� ���� ��)</p>
 				</div>
 			</div>
		</div>
		<!-- <div class="bx_sso_join">
			<p>Ǯ���� ����ȸ�� ���̵� ������ ���� Ǯ���� ����ȸ����<br>���� �ϼž� �ֹ��ϱ� �� ������ ��� �����Ͻ� �� �ֽ��ϴ�.</p>
			<a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000">Ǯ���� ȸ������</a>
		</div> -->


	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>