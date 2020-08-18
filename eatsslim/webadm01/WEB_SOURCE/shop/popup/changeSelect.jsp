<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));

String table		= "ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
String query		= "";
int tcnt			= 0;
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
int goodsTprice		= 0;
int orderPrice		= 0;
int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
String where		= " WHERE OG.GROUP_ID = G.ID AND O.ORDER_NUM = OG.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
where		+= " AND DEVL_TYPE = '0002'";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT COUNT(*) FROM "+ table +" "+ where; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.ORDER_STATE, O.DEVL_PRICE, OG.COUPON_PRICE";
query		+= " FROM "+ table +" "+ where;
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>��ȯ��ǰ ����</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>��ȯ��ǰ ����</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4><span class="f18 font-blue">������ �����Ͻ� ��ǰ</span></h4>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th class="none">����</th>
							<th class="none">��۱���</th>
							<th>��ǰ��</th>
							<th>����</th>
							<th>��ǰ�ݾ�</th>
							<th class="last">�ֹ�����</th>
						</tr>
						<tr>
							<td><input name="" type="checkbox" value=""></td>
							<td>�ù�</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="/images/order_sample.jpg" />
									<p class="catetag">���̾�Ʈ ���α׷�</p>
									<h4>3��(����A+����B+�˸���� COOL)</h4>
								</div>
							</td>
							<td>1</td>
							<td>104,400��</td>
							<td><div class="font-blue">��ۿϷ�</div></td>
						</tr>
					</table>
					<p class="font-gray">*��ȯ�� ������ ��ǰ���� ��ȯ�� �����մϴ�.</p>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="button large dark" style="margin:0 10px;"><a class="lightbox" href="/shop/popup/changeRequest.jsp?lightbox[width]=700&lightbox[height]=550">���û�ǰ ��ȯ</a></div>
					<div class="button large light" style="margin:0 10px;"><a class="lightbox" href="/shop/popup/changeRequest.jsp?lightbox[width]=700&lightbox[height]=550">��ü��ȯ</a></div>
				</div>
			</div>
			<!-- End row --> 
		</div>
		<!-- End popup columns offset-by-one --> 
	</div>
	<!-- End contentpop --> 
</div>
</body>
</html>