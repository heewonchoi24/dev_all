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
<div id="wrap" class="expansioncss">
	<%@ include file="/mobile/common/include/inc-header.jsp"%>
	<!-- End header -->
	<div id="container">		
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
<!-- 			<div class="section_sns"> -->
<!-- 				<div class="section_inner"> -->
<!-- 					<h3>SNS �α���</h3> -->
<!-- 					<p>������ ȸ�����Ծ��� �ҼȰ�����<br>�����Ͽ� �α����մϴ�.</p> -->
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
			<p>Ǯ���� ����ȸ�� ���̵� ������ ���� Ǯ���� ����ȸ����<br>���� �ϼž� �ֹ��ϱ� �� ������ ��� �����Ͻ� �� �ֽ��ϴ�.</p>
			<a href="javascript:void(0);">Ǯ���� ȸ������</a>
		</div>
		
		
	</div>
	<!-- End container -->

		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	<!-- End footer -->
</div>
</body>
</html>    