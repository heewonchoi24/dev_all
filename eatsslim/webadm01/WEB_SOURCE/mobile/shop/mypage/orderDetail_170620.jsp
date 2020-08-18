<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ut.inject(request.getParameter("odate"));

if (orderNum == null || orderNum.equals("")) {
	ut.jsRedirect(out, "/mobile/index.jsp");
	if (true) return;
}

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
/*int orderPrice		= 0;*/
//int payPrice		= 0;
int totalPrice		= 0;
int dayPrice		= 0;
int tagPrice		= 0;
int goodsPrice		= 0;
int devlPrice		= 0;
int bagPrice		= 0;
int couponPrice		= 0;
int zipCnt			= 0;
String devlCheck	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderDateFrom	= "";
String orderDateTo		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String param			= "";
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize;
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
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�ֹ������ȸ</span></span></h1>
			<dl class="itemlist">
				<dt>�ֹ���ȣ</dt>
				<dd><%=orderNum%></dd>
				<dt>�ֹ���</dt>
				<dd><%=orderDate%></dd>
			</dl>
			<a href="orderInfo.jsp?ono=<%=orderNum%>" class="ui-btn ui-mini ui-btn-up-b floatright"><span class="ui-btn-inner"><span class="ui-btn-text">��������</span></span></a>			
			<div class="divider"></div>			
			<%
			query		= "SELECT COUNT(*)";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0001'";
			query		+= " ORDER BY OG.DEVL_TYPE";
			rs			= stmt.executeQuery(query);
			if (rs.next()) {
				tcnt		= rs.getInt(1); //�� ���ڵ� ��		
			}
			rs.close();

			query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0001'";
			query		+= " ORDER BY OG.DEVL_TYPE";
			pstmt		= conn.prepareStatement(query);
			rs			= pstmt.executeQuery();

			if (tcnt > 0) {
			%>
			<h2 class="ui-title">�Ϲ��ǰ �������<span class="ui-icon-right"></span></h2>
			<dl class="itemlist">
			<%
				while (rs.next()) {
					orderCnt	= rs.getInt("ORDER_CNT");
					gubun1		= rs.getString("GUBUN1");
					groupName	= rs.getString("GROUP_NAME");
					couponPrice	= rs.getInt("COUPON_PRICE");
					if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
						devlDate	= rs.getString("WDATE");
						buyBagYn	= rs.getString("BUY_BAG_YN");
						devlDay		= rs.getString("DEVL_DAY");
						devlWeek	= rs.getString("DEVL_WEEK");
						devlPeriod	= devlWeek +"��("+ devlDay +"��)";
						price		= rs.getInt("PRICE");
						goodsPrice	= price * orderCnt;
						dayPrice += goodsPrice;
					} else {
						devlDate	= "-";
						buyBagYn	= "N";
						devlPeriod	= "-";
						price		= rs.getInt("PRICE");
						goodsPrice	= price * orderCnt;
						tagPrice	+= goodsPrice;
					}
			%>
				<dt>�ֹ���ǰ</dt>
				<dd><%=ut.getGubun1Name(gubun1)%> / <%=groupName%> <%=orderCnt%>��</dd>
				<dt>�ֹ��ݾ�</dt>
				<dd><%=nf.format(price)%>��</dd>
			<%
				if (buyBagYn.equals("Y")) {
			%>
				<dt>�ֹ���ǰ</dt>
				<dd>���ð��� 1��</dd>
				<dt>�ֹ��ݾ�</dt>
				<dd><%=nf.format(defaultBagPrice)%>��</dd>
			<%
					bagPrice	+= defaultBagPrice;
					}
				}
				rs.close();
			

				query		= "SELECT ";
				query		+= "	PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
				query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_CARDNUM,";
				query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE";
				query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
				try {
					rs			= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					payType			= rs.getString("PAY_TYPE");
					rcvName			= rs.getString("RCV_NAME");
					rcvTel			= rs.getString("RCV_TEL");
					rcvHp			= rs.getString("RCV_HP");
					rcvZipcode		= rs.getString("RCV_ZIPCODE");
					rcvAddr1		= rs.getString("RCV_ADDR1");
					rcvAddr2		= rs.getString("RCV_ADDR2");
					rcvRequest		= rs.getString("RCV_REQUEST");
					tagName			= rs.getString("TAG_NAME");
					tagTel			= rs.getString("TAG_TEL");
					tagHp			= rs.getString("TAG_HP");
					tagZipcode		= rs.getString("TAG_ZIPCODE");
					tagAddr1		= rs.getString("TAG_ADDR1");
					tagAddr2		= rs.getString("TAG_ADDR2");
					tagRequest		= rs.getString("TAG_REQUEST");
					pgCardNum		= rs.getString("PG_CARDNUM");
					pgFinanceName	= rs.getString("PG_FINANCENAME");
					pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
				}
			%>
				<dt>������</dt>
				<dd><%=rcvName%></dd>
				<dt>�ڵ���</dt>
				<dd><%=rcvHp%></dd>
				<dt>��ȭ��ȣ</dt>
				<dd><%=rcvTel%></dd>
				<dt>�ּ�</dt>
				<dd style="text-align:left;">[<%=rcvZipcode%>]<%=rcvAddr1%> <%=rcvAddr2%></dd>
				<dt>������ǻ���</dt>
				<dd style="text-align:left;"><%=rcvRequest%></dd>
			</dl>
			<%}%>
			<div class="divider"></div>
			<%
			query		= "SELECT COUNT(*)";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0002'";
			query		+= " ORDER BY OG.DEVL_TYPE";
			rs			= stmt.executeQuery(query);
			if (rs.next()) {
				tcnt		= rs.getInt(1); //�� ���ڵ� ��		
			}
			rs.close();

			query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.CART_IMG, O.COUPON_PRICE";
			query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
			query		+= " WHERE OG.GROUP_ID = G.ID";
			query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
			query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
			query		+= " AND OG.DEVL_TYPE = '0002'";
			query		+= " ORDER BY OG.DEVL_TYPE";
			pstmt		= conn.prepareStatement(query);
			rs			= pstmt.executeQuery();

			if (tcnt > 0) {
			%>
			<h2 class="ui-title">�ù��ǰ �������<span class="ui-icon-right"></span></h2>
			<dl class="itemlist">
			<%
				while (rs.next()) {
					orderCnt	= rs.getInt("ORDER_CNT");
					gubun1		= rs.getString("GUBUN1");
					groupName	= rs.getString("GROUP_NAME");
					couponPrice	= rs.getInt("COUPON_PRICE");
					if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {
						devlDate	= rs.getString("WDATE");
						buyBagYn	= rs.getString("BUY_BAG_YN");
						devlDay		= rs.getString("DEVL_DAY");
						devlWeek	= rs.getString("DEVL_WEEK");
						devlPeriod	= devlWeek +"��("+ devlDay +"��)";
						price		= rs.getInt("PRICE");
						goodsPrice	= price * orderCnt;
						dayPrice += goodsPrice;
					} else {
						devlDate	= "-";
						buyBagYn	= "N";
						devlPeriod	= "-";
						price		= rs.getInt("PRICE");
						goodsPrice	= price * orderCnt;
						tagPrice	+= goodsPrice;
					}
			%>
				<dt>�ֹ���ǰ</dt>
				<dd><%=ut.getGubun1Name(gubun1)%> / <%=groupName%> <%=orderCnt%>��</dd>
				<dt>�ֹ��ݾ�</dt>
				<dd><%=nf.format(price)%>��</dd>

			<%
				}
				rs.close();

			query		= "SELECT ";
			query		+= "	PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
			query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_CARDNUM,";
			query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE";
			query		+= "	,DATE_FORMAT(ORDER_DATE, '%Y%m%d') ORDER_DATE_FROM, DATE_FORMAT(DATE_ADD(ORDER_DATE, INTERVAL 1 MONTH), '%Y%m%d') ORDER_DATE_TO";
			query		+= " FROM ESL_ORDER WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				rs			= stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			if (rs.next()) {
				payType			= rs.getString("PAY_TYPE");
				rcvName			= rs.getString("RCV_NAME");
				rcvTel			= rs.getString("RCV_TEL");
				rcvHp			= rs.getString("RCV_HP");
				rcvZipcode		= rs.getString("RCV_ZIPCODE");
				rcvAddr1		= rs.getString("RCV_ADDR1");
				rcvAddr2		= rs.getString("RCV_ADDR2");
				rcvRequest		= rs.getString("RCV_REQUEST");
				tagName			= rs.getString("TAG_NAME");
				tagTel			= rs.getString("TAG_TEL");
				tagHp			= rs.getString("TAG_HP");
				tagZipcode		= rs.getString("TAG_ZIPCODE");
				tagAddr1		= rs.getString("TAG_ADDR1");
				tagAddr2		= rs.getString("TAG_ADDR2");
				tagRequest		= rs.getString("TAG_REQUEST");
				pgCardNum		= rs.getString("PG_CARDNUM");
				pgFinanceName	= rs.getString("PG_FINANCENAME");
				pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
				orderDateFrom	= rs.getString("ORDER_DATE_FROM");
				orderDateTo		= rs.getString("ORDER_DATE_TO");
			}
			%>
				<dt>������</dt>
				<dd><%=tagName%></dd>
				<dt>�ڵ���</dt>
				<dd><%=tagHp%></dd>
				<dt>��ȭ��ȣ</dt>
				<dd><%=tagTel%></dd>
				<dt>�ּ�</dt>
				<dd style="text-align:left;">[<%=tagZipcode%>]<%=tagAddr1%> <%=tagAddr2%></dd>
				<dt>������ǻ���</dt>
				<dd style="text-align:left;"><%=tagRequest%></dd>
			</dl>
			<a href="javascript:;" onclick="window.open('http://www.doortodoor.co.kr/tracking/jsp/cmn/Tracking_new.jsp?QueryType=1&pOrderNo=<%=orderNum%>1&pFromDate=<%=orderDateFrom%>&pToDate=<%=orderDateTo%>&pCustId=0010049837','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=800,height=600')" class="ui-btn ui-mini ui-btn-up-b floatright"><span class="ui-btn-inner"><span class="ui-btn-text">�������</span></span></a>
			<div class="divider"></div>		
			<%}%>
			<!--
			<a href="/mobile/shop/mypage/orderList.jsp" class="ui-btn ui-mini ui-btn-up-b floatright"><span class="ui-btn-inner"><span class="ui-btn-text">�����ȸ</span></span></a>
			
			<div class="divider"></div>
			
			<h2 class="ui-title">�����������<span class="ui-icon-right"></span></h2>
			
			<dl class="itemlist bg-gray">
				<dt>ó���Ͻ�</dt>
					<dd>2013.10.5</dd>
				<dt>ó�����</dt>
					<dd>����TML</dd> 
				<dt>��ȭ��ȣ</dt>
					<dd>02-774-2345</dd>
				<dt>����</dt>
					<dd>�����(�԰�)</dd>
				<dt>���</dt>
					<dd>���ֿ�</dd>
			</dl>
			
			<div class="divider"></div>
			-->
			
		</div>
		<!-- End Content -->
		
		<div class="ui-footer">
			<%@ include file="/mobile/common/include/inc-footer.jsp"%>
		</div>
	</div>

</div>

</body>
</html>