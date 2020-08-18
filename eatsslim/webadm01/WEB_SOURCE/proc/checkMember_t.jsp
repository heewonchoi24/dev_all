<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/lib/dbconn_mssql.jsp" %>

<!-- Screenview 스크린뷰 리타겟팅 Script-->
<script src="http://data.neoebiz.co.kr/cdata.php?reData=53880"></script>

<!-- LiveLog TrackingCheck Script Start -->
<script>
var LLscriptPlugIn = new function () { this.load = function(eSRC,fnc) { var script = document.createElement('script'); script.type = 'text/javascript'; script.charset = 'utf-8'; script.onreadystatechange= function () { if((!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') && fnc!=undefined && fnc!='' ) { eval(fnc); }; }; script.onload = function() { if(fnc!=undefined && fnc!='') { eval(fnc); }; }; script.src= eSRC; document.getElementsByTagName('head')[0].appendChild(script); }; }; LoadURL = "MjIIOAgwCDIzCDYINgg3CA"; LLscriptPlugIn.load('//livelog.co.kr/js/plugShow.php?'+LoadURL, 'sg_check.playstart()');
</script>
<!-- LiveLog TrackingCheck Script End -->

<%
request.setCharacterEncoding("euc-kr");
session.setMaxInactiveInterval(60*60*60);

String etc	= request.getParameter("id");
if (etc == null || etc.length()==0) etc = "";

Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate			= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
String stdate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.add(Calendar.DATE, 7);
String ltdate			= "2016-08-31"; //(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
String chkQuery			= "";
String query			= "";
String query1			= "";
String addQuery			= "";
String memberIdx		= "";
String moveUrl			= "https://www.eatsslim.co.kr/";
int couponCnt			= 0;
String couponNum		= "";
String preNum			= "";
int seq					= 0;
String regDate			= "";
String userIp			= request.getRemoteAddr();
int couponId			= 0;
String groupCode		= "";
String groupName		= "";
int i					= 0;
int giveCoupon			= 0;

out.println("<br>etc : " + etc);	

if (!etc.equals("")) {
	chkQuery	= "SELECT TOP 1";
	chkQuery	+= "	NAME, HPHONE_TYPE+'-'+HPHONE_FIRST+'-'+HPHONE_SECOND HP,";
	chkQuery	+= "	HOME_PHONEAREA+'-'+HOME_PHONEFIRST+'-'+HOME_PHONESECOND TEL, EMAIL, HOME_POST, HOME_ADDR1, HOME_ADDR2, HOME_ADDR_BUILDINGCODE, ";
	chkQuery	+= "	SEX, BIRTH_DT, SMS_YN, EMAIL_YN, A.CUSTOMER_NUM, SITE_USE, A.REG_DATE";
	chkQuery	+= " FROM pulmuone.dbo.ITF_MEMBER_INFO_FNC('0002400000', '129884') A";
	chkQuery	+= " WHERE A.MEM_ID='"+ etc +"'";
	chkQuery	+= " ORDER BY HP DESC";
	try {
		rs_mssql	= stmt_mssql.executeQuery(chkQuery);
	} catch(Exception e) {
		out.println(e+"=>"+chkQuery);
		if(true)return;
	}

	if (rs_mssql.next()) {


	} else {
		session.setAttribute("esl_member_idx", "1");
		session.setAttribute("esl_member_id", etc);
		session.setAttribute("esl_member_name", "1");
		session.setAttribute("esl_customer_num", "1");
		session.setAttribute("esl_member_code", "U"); //통합회원 구분
%>
		<script language="javascript">
			alert("회원님은 현재 사이트(http://www.eatsslim.co.kr)에 가입되어 있지 않습니다.\n가입 사이트 확인 페이지를 통해 현재 사이트를 체크해주세요...");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";
		</script>		
<% 
		if(true)return;	
	}
	rs_mssql.close();
}


%>

<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>