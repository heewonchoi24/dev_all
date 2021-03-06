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

String etc	= ut.inject(request.getParameter("id"));
if (etc == null || etc.length()==0) etc = "";

Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate			= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
String stdate			= (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.add(Calendar.DATE, 7);
String ltdate			= "2016-07-31"; //(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
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

if (!etc.equals("")) {
	chkQuery	= "SELECT TOP 1";
	//chkQuery	+= "	NAME, MEM_PWD, HPHONE_TYPE+'-'+HPHONE_FIRST+'-'+HPHONE_SECOND HP,";
	chkQuery	+= "	NAME, HPHONE_TYPE+'-'+HPHONE_FIRST+'-'+HPHONE_SECOND HP,";
	chkQuery	+= "	HOME_PHONEAREA+'-'+HOME_PHONEFIRST+'-'+HOME_PHONESECOND TEL, EMAIL, HOME_POST, HOME_ADDR1, HOME_ADDR2, HOME_ADDR_BUILDINGCODE, ";
	chkQuery	+= "	SEX, BIRTH_DT, SMS_YN, EMAIL_YN, A.CUSTOMER_NUM, SITE_USE, A.REG_DATE";
	//chkQuery	+= " FROM MEMBER_INFO A, SITE_USED_YN B";
	chkQuery	+= " FROM pulmuone.dbo.ITF_MEMBER_INFO_FNC('0002400000', '129884') A";
	//chkQuery	+= " WHERE A.CUSTOMER_NUM = B.CUSTOMER_NUM";
	//chkQuery	+= " AND A.DEREG_APP_YN = 'N'";
	//chkQuery	+= " AND B.SITE_USE = 'Y'";
	//chkQuery	+= " AND B.SITE_NO = '0002400000'";
	//chkQuery	+= " AND A.MEM_ID='"+ etc +"'";
	chkQuery	+= " WHERE A.MEM_ID='"+ etc +"'";
	chkQuery	+= " ORDER BY HP DESC";
	try {
		rs_mssql	= stmt_mssql.executeQuery(chkQuery);
	} catch(Exception e) {
		out.println(e+"=>"+chkQuery);
		if(true)return;
	}

	if (rs_mssql.next()) {

		if(rs_mssql.getString("SITE_USE").equals("N")){
			session.setAttribute("esl_member_idx", "1");
			session.setAttribute("esl_member_id", etc);
			session.setAttribute("esl_member_name", "1");
			session.setAttribute("esl_customer_num", "1");
			session.setAttribute("esl_member_code", "U"); //통합회원 구분
%>
			<script language="javascript">
				alert("회원님은 현재 사이트(http://www.eatsslim.co.kr)에 가입되어 있지 않습니다.\n가입 사이트 확인 페이지를 통해 현재 사이트를 체크해주세요.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";		
			</script>		
<% 
			if(true)return;
		}

		String table			= "ESL_MEMBER";
		String memberId			= etc;
		//String memberPw			= rs_mssql.getString("MEM_PWD");
		String memberName		= rs_mssql.getString("NAME");
		String hp				= rs_mssql.getString("HP");
		String tel				= rs_mssql.getString("TEL");
		String email			= rs_mssql.getString("EMAIL");
		String zipcode			= rs_mssql.getString("HOME_POST");
		String address			= rs_mssql.getString("HOME_ADDR1");
		String addressDetail	= rs_mssql.getString("HOME_ADDR2");
		String addressBCode		= rs_mssql.getString("HOME_ADDR_BUILDINGCODE");
		String sex				= rs_mssql.getString("SEX");
		String birthDate		= rs_mssql.getString("BIRTH_DT");
		String smsYn			= rs_mssql.getString("SMS_YN");
		String customerNum		= rs_mssql.getString("CUSTOMER_NUM");
		if (smsYn == null || smsYn.length()==0) smsYn = "N";
		String emailYn			= rs_mssql.getString("EMAIL_YN");
		if (emailYn == null || emailYn.length()==0) emailYn	= "N";
		regDate					= rs_mssql.getString("REG_DATE");		
		
		query		= "SELECT ";
		query		+= "	ID, MEM_NAME, MEM_ID, MEM_PW, EMAIL, EMAIL_YN, ZIPCODE, ADDRESS, ADDRESS_DETAIL, ADDRESS_BUILDINGCODE, HP, SMS_YN, TEL";
		query		+= " FROM "+ table +" WHERE MEM_ID = '"+ memberId +"'"; 
		try {
			stmt		= conn.createStatement();
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		int cnt	= 0;
		if (rs.next()) {
			cnt			= 1;
			memberIdx	= rs.getString("ID");
			memberName	= rs.getString("MEM_NAME");
			addQuery	= "";
			//if (rs.getString("MEM_PW") != null && !rs.getString("MEM_PW").equals(memberPw)) {
			//	addQuery	+= ", MEM_PW = '"+ memberPw +"'";
			//}
			if (rs.getString("EMAIL") != null && !rs.getString("EMAIL").equals(email)) {
				addQuery	+= ", EMAIL = '"+ email +"'";
			}
			if (rs.getString("ZIPCODE") != null && !rs.getString("ZIPCODE").equals(zipcode)) {
				addQuery	+= ", ZIPCODE = '"+ zipcode +"'";
			}
			if (rs.getString("ADDRESS") != null && !rs.getString("ADDRESS").equals(address)){
				addQuery	+= ", ADDRESS = '"+ address +"'";
			}
			if (rs.getString("ADDRESS_DETAIL") != null && !rs.getString("ADDRESS_DETAIL").equals(addressDetail)){
				addQuery	+= ", ADDRESS_DETAIL = '"+ addressDetail +"'";
			}
			if (rs.getString("ADDRESS_BUILDINGCODE") != null && !rs.getString("ADDRESS_BUILDINGCODE").equals(addressBCode)){
				addQuery	+= ", ADDRESS_BUILDINGCODE = '"+ addressBCode +"'";
			}
			if (rs.getString("HP") != null && !rs.getString("HP").equals(hp)) {
				addQuery	+= ", HP ='"+ hp +"'";
			}
			if (rs.getString("TEL") != null && !rs.getString("TEL").equals(tel)){
				addQuery	+= ", TEL = '"+ tel +"'";
			}
			if (rs.getString("SMS_YN") != null && !rs.getString("SMS_YN").equals(smsYn)){
				addQuery	+= ", SMS_YN = '"+ smsYn +"'";
			}
			if (rs.getString("EMAIL_YN") != null && !rs.getString("EMAIL_YN").equals(emailYn)){
				addQuery	+= ", EMAIL_YN = '"+ emailYn +"'";
			}

			if (!addQuery.equals("")) { //회원정보 변경사항 저장
				query1		=	"UPDATE "+ table +" SET MEMO = CONCAT(MEMO, '\n통합회원정보변경(',now(),')')"+ addQuery +" WHERE MEM_ID = '"+ memberId +"'";
				try {
					stmt.executeUpdate(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
				}
			}			

			// 로그인 시 쿠폰 지급을 위한 소스
			if (Integer.parseInt(cDate) >= 20141017 && Integer.parseInt(cDate) <= 20141030) {
				query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
				query		+= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 988";
				try {
					rs		= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					couponCnt	= rs.getInt(1);
				}
				rs.close();

				if (couponCnt > 0) {
				} else {
					SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
					couponNum		= "ET" + dt.format(new Date()) + "001";

					query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
					query		+= " VALUES (988,'"+ couponNum +"','"+ memberId +"','N',NOW())";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e);
						if(true)return;
					}
				}
				rs.close();
			}
		} else {
			cnt			= 0;
		}

		if (cnt == 0) {
			query		= "INSERT INTO "+ table;
			query		+= "	(CUSTOMER_NUM, MEM_NAME, MEM_ID, MEM_PW, SEX, BIRTH_DATE, EMAIL, EMAIL_YN, ZIPCODE, ADDRESS,";
			query		+= "	ADDRESS_DETAIL, ADDRESS_BUILDINGCODE, HP, SMS_YN, TEL, INST_DATE)";
			query		+= " VALUES";
			query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try {
				pstmt		= conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				pstmt.setString(1, customerNum);
				pstmt.setString(2, memberName);
				pstmt.setString(3, memberId);
				//pstmt.setString(4, memberPw);
				pstmt.setString(4, "");
				pstmt.setString(5, sex);
				pstmt.setString(6, birthDate);
				pstmt.setString(7, email);
				pstmt.setString(8, emailYn);
				pstmt.setString(9, zipcode);
				pstmt.setString(10, address);
				pstmt.setString(11, addressDetail);
				pstmt.setString(12, addressBCode);
				pstmt.setString(13, hp);
				pstmt.setString(14, smsYn);
				pstmt.setString(15, tel);
				pstmt.setString(16, regDate);
				pstmt.executeUpdate();

				rs			= pstmt.getGeneratedKeys();
				if (rs.next()) {
					memberIdx		= rs.getString(1);
				}
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			rs.close();

			if (Integer.parseInt(cDate) >= 20160708 && Integer.parseInt(cDate) <= 20160731) {
%>
<%@ include file="/proc/welcomeCoupon.jsp"%>
<%
			}

			// 로그인 시 쿠폰 지급을 위한 소스
			if (Integer.parseInt(cDate) >= 20141017 && Integer.parseInt(cDate) <= 20141030) {
				query		= "SELECT COUNT(ID) FROM ESL_COUPON_MEMBER";
				query		+= " WHERE MEMBER_ID = '"+ memberId +"' AND COUPON_ID = 988";
				try {
					rs		= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					couponCnt	= rs.getInt(1);
				}
				rs.close();

				if (couponCnt > 0) {
				} else {
					SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
					couponNum		= "ET" + dt.format(new Date()) + "003";

					query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
					query		+= " VALUES (988,'"+ couponNum +"','"+ memberId +"','N',NOW())";
					try {
						stmt.executeUpdate(query);
					} catch (Exception e) {
						out.println(e);
						if(true)return;
					}
				}
				rs.close();
			}
%>
<!-- ADWorks Target Script START --><script language="javascript">try{_OPMS_AN='1810';_OPMS_AC='0702';_OPMS_PN='회원가입';}catch(e){}</script><!-- ADWorks Target Script END -->
<!-- ADWorks Common Script START --><script language="javascript">try{var _adws_un='1813';_adws_ckDmYn='Y';_adws_ver='22';_adws_src=location.protocol=="https:"?"https://"+"adws2.opms.co.kr/":"http://"+"js.adws.opms.co.kr/";_adws_src+="script/"+_adws_ver+"/"+"adworks.js";if((typeof _ADWS_CNT_)!='number'){var _ADWS_CNT_=0;};if(_ADWS_CNT_==0){_ADWS_CNT_++;eval("try{_vu=top.document.location.href;}catch(_e){_vu ='';};");eval("try{_svu=self.document.location.href;}catch(_e){_svu ='';};");if((_vu.indexOf("_OPMS_CK=")>-1&&_vu.indexOf("_OPMS_VID=")>-1&&_vu==_svu)||((typeof _OPMS_AN)!="undefined"&&_OPMS_AN!=""&&(typeof _OPMS_PN)!="undefined"&&_OPMS_PN!=""&&document.cookie.indexOf("_OPMS_LD_TID===")>-1)||((typeof _adws_dcTgYn)!="undefined"||_adws_dcTgYn!="")){document.write('<scr'+'ipt language="javascript" src="'+_adws_src+'"></scr'+'ipt>');};};}catch(e){}</script><!-- ADWorks Common Script END -->

<!-- LiveLog TrackingCheck Script Start -->
<script>
LLOrderName="<%=memberId%>";
LLNumber="<%=customerNum%>";
LLDBid=LLOrderName+"|dinfo|"+LLNumber;
LLscriptPlugIn.load('//livelog.co.kr/js/plugShow.php', "sg_check.payment('"+LLDBid+"','"+LLNumber+"','Y')");
eval(function(p,a,c,k,e,r){e=function(c){return c.toString(a)};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('0(5);6 0(a){1 b=2 3();1 c=b.4()+a;7(8){b=2 3();9(b.4()>c)d}}',14,14,'sleep|var|new|Date|getTime|2000|function|while|true|if||||return'.split('|'),0,{}));
</script>
<!-- LiveLog TrackingCheck Script End -->

<SCRIPT type="text/javascript">
var _TRK_PI = "RGR";
var _TRK_MBR = "Y";
var _TRK_SX = "<%=sex%>";
var _TRK_AG = "";
var _TRK_UVP1 = "";
</SCRIPT>

<%
			//moveUrl		= "https://www.eatsslim.co.kr/shop/mypage/index.jsp";
			
		} else {
%>		

<SCRIPT type="text/javascript">
var _TRK_PI = "LIR";
var _TRK_ISLOGIN = "Y";
var _TRK_MBR = "";
var _TRK_SX = "<%=sex%>";
var _TRK_AG = "";
var _TRK_UVP1 = "";
</SCRIPT>

<%
		}
%>

<!-- 비즈스프링 인사이트 수집용 Start 2016.07.06 -->
<script src="5732_Insight_WebAnalytics.js"></script>
<!-- 비즈스프링 인사이트 수집용 End -->

<%

		//if(true)return;

		query		= "UPDATE ESL_MEMBER SET LAST_LOGIN_DATE = NOW(),";
		query		+= "				LAST_LOGIN_IP = '"+ userIp +"'";
		query		+= "	WHERE MEM_ID = '"+ memberId +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_mssql.getString("SITE_USE").equals("N")) {
			session.setAttribute("esl_member_idx","1");
			session.setAttribute("esl_member_id",etc);
			session.setAttribute("esl_member_name","1");
			session.setAttribute("esl_customer_num", "1");
			session.setAttribute("esl_member_code","U"); //통합회원 구분
%>
			<script language="javascript">
				alert("회원님은 현재 사이트(http://www.eatsslim.co.kr)에 가입되어 있지 않습니다.\n가입 사이트 확인 페이지를 통해 현재 사이트를 체크해주세요.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";
			</script>		
<% 
			if(true)return;
		}

		session.setAttribute("esl_member_idx", memberIdx);
		session.setAttribute("esl_member_id", memberId);
		session.setAttribute("esl_member_name", memberName);
		session.setAttribute("esl_customer_num", customerNum);
		session.setAttribute("esl_member_code","U"); //통합회원 구분
		
		//out.print(rs_mssql.getString("SITE_NO"));if(true)return;
	} else {
		session.setAttribute("esl_member_idx", "1");
		session.setAttribute("esl_member_id", etc);
		session.setAttribute("esl_member_name", "1");
		session.setAttribute("esl_customer_num", "1");
		session.setAttribute("esl_member_code", "U"); //통합회원 구분
%>
		<script language="javascript">
			alert("회원님은 현재 사이트(http://www.eatsslim.co.kr)에 가입되어 있지 않습니다.\n가입 사이트 확인 페이지를 통해 현재 사이트를 체크해주세요.");
				location.href = "https://member.pulmuone.co.kr/customer/custSite_R1.jsp?siteno=0002400000";
		</script>		
<% 
		if(true)return;	
	} //if(rs_mssql.next()){
	rs_mssql.close();
}

if (request.getParameter("mode")==null || request.getParameter("mode").length()==0) {
	// response.sendRedirect(moveUrl);
	if (giveCoupon > 0) {
%>
		<script type="text/javascript">
			alert("반갑습니다. 바른다이어트 잇슬림입니다.\n회원가입 축하 '웰컴쿠폰'이 발급되었습니다.\n마이페이지을 확인해주세요.\n감사합니다.");
			location.href = "<%=moveUrl%>";
		</script>
<%
	} else {
		response.sendRedirect(moveUrl);
	}
} else {
	if (memberIdx.equals("")) {
		out.println("<script>alert('입력하신 회원정보가 존재하지 않습니다.');location.href='http://www.eatsslim.co.kr/mobile/login.jsp';</script>");
	} else {
		//out.println("<script>opener.location.href='http://www.pulmuonecaf.com/mobile';self.close();</script>");
		out.println("<script>location.href='http://www.eatsslim.co.kr/mobile';</script>");
	}
}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_mssql.jsp" %>