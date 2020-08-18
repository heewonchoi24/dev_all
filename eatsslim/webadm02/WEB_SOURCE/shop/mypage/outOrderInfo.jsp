<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ono"));
String orderDate	= ut.inject(request.getParameter("odate"));

if (orderNum == null || orderNum.equals("")) {
	ut.jsRedirect(out, "/index.jsp");
	if (true) return;
}

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
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
String imgUrl		= "";
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
NumberFormat nf = NumberFormat.getNumberInstance();

String payType			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvZipcode1		= "";
String rcvZipcode2		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";
String tagName			= "";
String tagTel			= "";
String tagHp			= "";
String tagZipcode		= "";
String tagZipcode1		= "";
String tagZipcode2		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String maxDevlDate		= "";
String minDevlDate		= "";
String groupCode		= "";
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String param			= "";
param		= "&amp;page="+ iPage +"&pgsize="+ pgsize +"&amp;field="+ field +"&amp;keyword="+ keyword;

query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
rs			= stmt.executeQuery(query);
if (rs.next()) {
	tcnt		= rs.getInt(1); //�� ���ڵ� ��		
}
rs.close();

query		= "SELECT OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN, G.GUBUN1, G.GROUP_NAME, G.GROUP_CODE, G.CART_IMG, O.COUPON_PRICE, O.PAY_PRICE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
query		+= " ORDER BY OG.DEVL_TYPE";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> �ֹ��� </h1>
			<div class="pageDepth">
				HOME &gt; My Eatsslim &gt; <strong>�ֹ���</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one ">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4>
							<span class="f14">�ֹ���ȣ</span>
							<span class="f18 font-blue" style="padding-right:20px;"><%=orderNum%></span>
							<span class="f14">�ֹ�����</span>
							<span class="f18 font-blue"><%=orderDate%></span>
						</h4>
						<!--div class="floatright button dark small">
							
						</div-->
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>��۱���</th>
							<th>��ǰ��/�ɼ���ǰ��</th>
							<th>�Ļ�Ⱓ</th>
							<th>��۱Ⱓ</th>
							<th>����</th>
							<th>�ǸŰ���</th>
							<th class="last">�հ�</th>
						</tr>
						<%
						if (tcnt > 0) {
							while (rs.next()) {
								orderCnt		= rs.getInt("ORDER_CNT");
								devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
								gubun1		= rs.getString("GUBUN1");
								groupName	= rs.getString("GROUP_NAME");
								groupCode	= rs.getString("GROUP_CODE");
								payPrice	= rs.getInt("PAY_PRICE");
								couponPrice	= rs.getInt("COUPON_PRICE");
								if (rs.getString("DEVL_TYPE").equals("0001")) {
									devlDate	= rs.getString("WDATE");
									buyBagYn	= rs.getString("BUY_BAG_YN");
									devlDay		= rs.getString("DEVL_DAY");
									devlWeek	= rs.getString("DEVL_WEEK");
									devlPeriod	= devlWeek +"��("+ devlDay +"��)";
									price		= rs.getInt("PRICE");
									price		= (payPrice == 0)? 0 : price;
									goodsPrice	= price * orderCnt;
									dayPrice += goodsPrice;

									query1		= "SELECT MIN(DEVL_DATE) MIN_DEVL_DATE, MAX(DEVL_DATE) MAX_DEVL_DATE FROM ESL_ORDER_DEVL_DATE";
									query1		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
									if (groupCode.length() < 7) {
										query		+= " AND (GROUP_CODE IN (SELECT DISTINCT GROUP_CODE FROM ESL_PG_DELIVERY_SCHEDULE))";
									} else {
										query		+= " AND GROUP_CODE = '"+ groupCode +"'";
									}
									try {
										rs1	= stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									if (rs1.next()) {
										minDevlDate		= rs1.getString("MIN_DEVL_DATE");
										maxDevlDate		= rs1.getString("MAX_DEVL_DATE");
										devlDate		= minDevlDate +"~<br />"+ maxDevlDate;
									}
								} else {
									devlDate	= "-";
									buyBagYn	= "N";
									devlPeriod	= "-";
									price		= rs.getInt("PRICE");
									price		= (payPrice == 0)? 0 : price;
									goodsPrice	= price * orderCnt;
									tagPrice	+= goodsPrice;
								}
								cartImg		= rs.getString("CART_IMG");
								if (cartImg.equals("") || cartImg == null) {
									imgUrl		= "/images/order_sample.jpg";
								} else {										
									imgUrl		= webUploadDir +"goods/"+ cartImg;
								}
						%>
						<tr>
							<td><%=devlType%></td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=imgUrl%>" />
									<p class="catetag">
										<%=ut.getGubun1Name(gubun1)%>
									</p>
									<h4>
										<%=groupName%>
									</h4>
								</div>
							</td>
							<td><%=devlPeriod%></td>
							<td><%=devlDate%></td>
							<td><%=orderCnt%></td>
							<td><%=nf.format(price)%>��</td>
							<td>
								<div class="itemprice"><%=nf.format(goodsPrice)%>��</div>
							</td>
						</tr>
						<%
								if (buyBagYn.equals("Y")) {
									defaultBagPrice	= (payPrice == 0)? 0 : 7000;
									bagPrice	+= defaultBagPrice * orderCnt;	
						%>
						<tr>
							<td>�Ϲ�</td>
							<td>
								<div class="orderName">
									<img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
									<h4>���ð���</h4>
								</div>
							</td>
							<td>-</td>
							<td>-</td>
							<td><%=orderCnt%></td>
							<td><%=nf.format(defaultBagPrice)%>��</td>
							<td>
								<div class="itemprice"><%=nf.format(bagPrice)%>��</div>
							</td>
						</tr>
						<%
								}
							}

							rs.close();

							orderPrice		= dayPrice + tagPrice + bagPrice;
							goodsTprice		= dayPrice + tagPrice;
							if (tagPrice > 0 && tagPrice < 40000) {
								devlPrice		= defaultDevlPrice;
							} else {
								devlPrice		= 0;
							}

							totalPrice		= orderPrice + devlPrice - couponPrice;

							if (totalPrice < 1) totalPrice = 0;
						}
						%>
						<tr>
							<td colspan="7" class="totalprice">
								<span class="font-maple" style="padding-right:15px;">�� �����ݾ� �հ�</span>
								<span>��ǰ�ݾ� <strong class="font-blue"><%=nf.format(goodsTprice)%></strong> ��</span> + 
								<span>��۷� <strong class="font-blue"><%=nf.format(devlPrice)%></strong> ��</span> +
								<span>���ð��� <strong class="font-blue"><%=nf.format(bagPrice)%></strong> ��</span> -
								<span>�������� <strong class="font-blue"><%=nf.format(couponPrice)%></strong> ��</span> =
								<span class="font-blue" style="padding-left:15px;">�� �����ݾ�</span>
								<span class="won padl50"><%=nf.format(totalPrice)%>��</span>
							</td>
						</tr>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="divider"></div>
			<%
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
				if (rcvZipcode.length() == 6) {
					rcvZipcode1	= rcvZipcode.substring(0,3);
					rcvZipcode2	= rcvZipcode.substring(3,6);
				}
				rcvAddr1		= rs.getString("RCV_ADDR1");
				rcvAddr2		= rs.getString("RCV_ADDR2");
				rcvRequest		= rs.getString("RCV_REQUEST");
				tagName			= rs.getString("TAG_NAME");
				tagTel			= rs.getString("TAG_TEL");
				tagHp			= rs.getString("TAG_HP");
				tagZipcode		= rs.getString("TAG_ZIPCODE");
				if (tagZipcode.length() == 6) {
					tagZipcode1	= tagZipcode.substring(0,3);
					tagZipcode2	= tagZipcode.substring(3,6);
				}
				tagAddr1		= rs.getString("TAG_ADDR1");
				tagAddr2		= rs.getString("TAG_ADDR2");
				tagRequest		= rs.getString("TAG_REQUEST");
				pgCardNum		= rs.getString("PG_CARDNUM");
				pgFinanceName	= rs.getString("PG_FINANCENAME");
				pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
			}
			%>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4> <span class="f18"> ����� ���� </span> </h4>
					</div>
					<%if (!rcvName.equals("") && rcvName != null) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-blue"> �Ϲ��ǰ ����� ���� </span> </h4>
						<div class="floatright button dark small">
							<!--a href="/shop/mypage/orderList.jsp">���������</a-->
						</div>
					</div>
					<table class="paymentinfo line-blue marb30" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�����ôº�</th>
							<td colspan="3"><%=rcvName%></td>
						</tr>
						<tr>
							<th>��ȭ��ȣ</th>
							<td><%=rcvTel%></td>
							<th>�޴�����ȣ</th>
							<td><%=rcvHp%></td>
						</tr>
						<tr>
							<th>������ּ�</th>
							<td colspan="3">(<%=rcvZipcode1%>-<%=rcvZipcode2%>) <%=rcvAddr1%> <%=rcvAddr2%></td>
						</tr>
						<tr>
							<th>��ۿ�û����</th>
							<td colspan="3"><%=rcvRequest%></td>
						</tr>
					</table>
					<%}%>
					<%if (!tagName.equals("") && tagName != null) {%>
					<div class="sectionHeader">
						<h4> <span class="f18 font-green"> �ù��ǰ ����� ���� </span> </h4>
						<div class="floatright button dark small">
							<a href="#">���������</a>
						</div>
					</div>
					<table class="paymentinfo line-green" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�����ôº�</th>
							<td colspan="3"><%=tagName%></td>
						</tr>
						<tr>
							<th>��ȭ��ȣ</th>
							<td><%=tagTel%></td>
							<th>�޴�����ȣ</th>
							<td><%=tagHp%></td>
						</tr>
						<tr>
							<th>������ּ�</th>
							<td colspan="3">(<%=tagZipcode1%>-<%=tagZipcode2%>) <%=tagAddr1%> <%=tagAddr2%></td>
						</tr>
						<tr>
							<th>��ۿ�û����</th>
							<td colspan="3"><%=tagRequest%></td>
						</tr>
					</table>
					<%}%>
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col center">
					<div class="divider"></div>
					<div class="button large darkgreen" style="margin:0 10px;">
						<a href="javascript:print();">�μ��ϱ�</a>
					</div>
					<div class="button large dark" style="margin:0 10px;">
						<a href="outmallOrder.jsp?<%=param%>">�������</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>