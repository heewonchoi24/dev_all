<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String orderNum			= ut.inject(request.getParameter("ono"));
int goodsPrice			= 0;
int payPrice			= 0;
int couponPrice			= 0;
int devlPrice			= 0;
String payType			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDate		= "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT DATE_FORMAT(ORDER_DATE, '%Y.%m.%d %H:%i') ORDER_DATE, GOODS_PRICE, PAY_PRICE, ";
query		+= "	COUPON_PRICE, DEVL_PRICE, PAY_TYPE, PG_CARDNUM, PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE";
query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
try {
rs			= stmt.executeQuery(query);
} catch(Exception e) {
out.println(e+"=>"+query);
if(true)return;
}

if (rs.next()) {
	goodsPrice		= rs.getInt("GOODS_PRICE");
	payPrice		= rs.getInt("PAY_PRICE");
	couponPrice		= rs.getInt("COUPON_PRICE");
	devlPrice		= rs.getInt("DEVL_PRICE");
	payType			= rs.getString("PAY_TYPE");
	pgCardNum		= ut.isnull(rs.getString("PG_CARDNUM"));
	pgFinanceName	= ut.isnull(rs.getString("PG_FINANCENAME"));
	pgAccountNum	= ut.isnull(rs.getString("PG_ACCOUNTNUM"));
	orderDate		= rs.getString("ORDER_DATE");
}
%>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">��������</span></span></h1>
		<dl class="itemlist">
			<dt>�������</dt>
			<dd><%=ut.getPayType(payType)%></dd>
			<%if (payType.equals("30")) {%>
			<dt style="width:70%;">�Աݰ��¹�ȣ</dt>
			<dd style="width:30%;"><%=pgFinanceName%> <%=pgAccountNum%></dd>
			<%} else if (payType.equals("10")) {%>
			<dt style="width:70%;">�ſ�ī��</dt>
			<dd style="width:30%;"><%=pgFinanceName%> <%=pgCardNum%></dd>
			<%}%>
			<dt>�ֹ��Ͻ�</dt>
			<dd><%=orderDate%></dd>
			<div class="divider-line"></div>
			<dt>��ǰ�ݾ�</dt>
			<dd><%=nf.format(goodsPrice)%>��</dd>
			<dt>��ǰ����</dt>
			<dd>(-)<%=nf.format(couponPrice)%>��</dd>
			<!--p class="guide">���̾�Ʈ�Ļ� 3�� ��ǰ���� 3,000��</p>
			<dt>������������</dt>
			<dd>(-)1,000��</dd>
			<p class="guide">������������ 1,000��</p-->
			<dt>��ۺ�</dt>
			<dd>(+)<%=nf.format(devlPrice)%>��</dd>
		</dl>
		<div class="divider"></div>
		<dl class="itemlist redline">
			<dt class="f16">�� �����ݾ�</dt>
			<dd class="f16 font-orange"><%=nf.format(payPrice)%>��</dd>
		</dl>
		<div class="divider"></div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>