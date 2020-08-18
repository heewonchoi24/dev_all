<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%-- <%@ include file="/mobile/common/include/inc-login-check.jsp"%> --%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
cal.setTime(new Date());
/* cal.add ( Calendar.MONTH, -1 ); */ //1개월전
cal.add ( Calendar.MONTH, -5 ); //10개월전
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
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">		
		<nav class="navigation nbd">
			<h1 class="title">로그인</h1>
		</nav>
		<div class="bx_sso_login">
			<div class="section_sso">
				<div class="section_inner">
					<p>풀무원 통합회원 로그인 페이지로<br>이동하시겠습니까?</p>
					<a href="/sso/single_sso.jsp">
						<img src="/mobile/common/images/common/ico_m_logo.png" alt="">
						<strong>통합회원</strong> <span>로그인</span>
					</a>	
				</div>
			</div>
<!-- 			<div class="section_sns"> -->
<!-- 				<div class="section_inner"> -->
<!-- 					<h3>SNS 로그인</h3> -->
<!-- 					<p>별도의 회원가입없이 소셜계정과<br>연동하여 로그인합니다.</p> -->
<!-- 					<ul> -->
<!-- 						<li><a href="javascript:void(0);"><img src="/mobile/common/images/common/ico_m_naver.png" alt="" /></a></li> -->
<!-- 						<li><a href="javascript:void(0);"><img src="/mobile/common/images/common/ico_m_kakao.png" alt="" /></a></li> -->
<!-- 						<li><a href="javascript:void(0);"><img src="/mobile/common/images/common/ico_m_facebook.png" alt="" /></a></li> -->
<!-- 						<li><a href="javascript:void(0);"><img src="/mobile/common/images/common/ico_m_instagram.png" alt="" /></a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
		<div class="bx_sso_join">
			<p>풀무원 통합회원 아이디가 없으신 분은 풀무원 통합회원에<br>가입 하셔야 주문하기 및 결제를 계속 진행하실 수 있습니다.</p>
			<a href="javascript:void(0);">풀무원 회원가입</a>
		</div>
		
		
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>    