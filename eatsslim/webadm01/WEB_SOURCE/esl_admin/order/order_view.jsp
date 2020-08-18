<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderNum		= ut.inject(request.getParameter("ordno"));

if (orderNum == null || orderNum.equals("")) {
	out.println("<script>self.close();</script>");
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
String osubNum		= "";
String devlDates	= "";
String groupCode	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String memberId			= "";
String memberName		= "";
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
String tagZipcode1		= "";
String tagZipcode2		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
String pgTid			= "";
String pgCardNum		= "";
String pgFinanceName	= "";
String pgAccountNum		= "";
String orderState		= "";
String orderDate		= "";
String payDate			= "";
String minDate			= "";
String maxDate			= "";
int couponTprice		= 0;
String linkUrl			= "";
String adminMemo		= "";
String orderLog			= "";
String shopType			= "";
String outOrderNum		= "";
int goodsId				= 0;
String userIp			= request.getRemoteAddr();

query		= "SELECT ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	TAG_NAME, TAG_TEL, TAG_HP, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_REQUEST, PG_TID, PG_CARDNUM,";
query		+= "	PG_FINANCENAME, PG_ACCOUNTNUM, ORDER_STATE, ORDER_DATE, PAY_DATE, DEVL_PRICE, COUPON_PRICE, ADMIN_MEMO, ORDER_LOG,";
query		+= "	ORDER_NAME, SHOP_TYPE, OUT_ORDER_NUM";
query		+= " FROM ESL_ORDER O WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memberId		= rs.getString("MEMBER_ID");
	memberName		= rs.getString("ORDER_NAME");
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
	pgTid			= (rs.getString("PG_TID") == null)? "" : rs.getString("PG_TID");
	pgCardNum		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
	pgAccountNum	= rs.getString("PG_ACCOUNTNUM");
	orderState		= rs.getString("ORDER_STATE");
	orderDate		= rs.getString("ORDER_DATE");
	payDate			= rs.getString("PAY_DATE");
	devlPrice		= rs.getInt("DEVL_PRICE");
	couponTprice	= rs.getInt("COUPON_PRICE");
	adminMemo		= rs.getString("ADMIN_MEMO");
	orderLog		= rs.getString("ORDER_LOG");
	shopType		= rs.getString("SHOP_TYPE");
	outOrderNum		= ut.isnull(rs.getString("OUT_ORDER_NUM"));

	query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
	query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE != '0300578'";
	try {
		rs1			= stmt.executeQuery(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}

	if (rs1.next()) {
		minDate			= rs1.getString("MIN_DATE");
		maxDate			= rs1.getString("MAX_DATE");
		devlDates		= ut.isnull(minDate) +"~"+ ut.isnull(maxDate);
	} else {
		devlDates		= "-";
	}

	rs1.close();
	
	query		= "INSERT INTO ESL_PRIVACY_LOG";
	query		+= "	(WORK_ID, HOST_IP, WORK_CATE1, WORK_CATE2, WORK_URL, WORK_CUST_ID, WORK_ORDER_NUM, WORK_DATE)";
	query		+= " VALUES";
	query		+= "	('"+ eslAdminId +"', '"+ userIp +"',  '주문관리', '주문상세정보', '/esl_admin/order/order_view.jsp', '"+memberId+"', '"+orderNum+"', NOW())";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}	
}

rs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>일배 주문상세정보</h2>
		<table class="table01 mt_5" border="1" cellspacing="0">
			<colgroup>
				<col width="100px" />
				<col width="36%" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>주문번호</span></th>
					<td colspan="3"><%=orderNum%></td>
				</tr>
				<tr>
					<th scope="row"><span>주문자</span></th>
					<td><%=memberName%>(<%=memberId%>)</td>
					<th scope="row"><span>연락처</span></th>
					<td><%=rcvHp%>/<%=rcvTel%></td>
				</tr>
				<tr>
					<th scope="row"><span>배송주소</span></th>
					<td colspan="3">[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
				</tr>
				<tr>
					<th scope="row"><span>주문일시</span></th>
					<td><%=ut.setDateFormat(orderDate, 16)%></td>
					<th scope="row"><span>주문상태</span></th>
					<td>
						<%
						if (payType.equals("10") && Integer.parseInt(orderState)==0) {
							out.print("결제실패");
						} else {
							out.println(ut.getOrderState(orderState));
						}
						%>
					</td>
				</tr>
				<tr>
					<th scope="row"><span>입금일시</span></th>
					<td><%=ut.setDateFormat(payDate, 16)%></td>
					<th scope="row"><span>결제수단</span></th>
					<td><%=ut.getPayType(payType)%></td>
				</tr>
				<tr>
					<th scope="row"><span>배송기간</span></th>
					<td><%=devlDates%></td>
					<th scope="row"><span>거래번호</span></th>
					<td><%=pgTid%></td>
				</tr>
				<tr>
					<th scope="row"><span>판매 SHOP</span></th>
					<td><%=ut.getShopType(shopType)%></td>
					<th scope="row"><span>외부몰 주문번호</span></th>
					<td><%=outOrderNum%></td>
				</tr>
			</tbody>
		</table>
		<%if (tagName.length() > 0) {%>
		<br />
		<h2>택배 주문상세정보</h2>
		<table class="table01 mt_5" border="1" cellspacing="0">
			<colgroup>
				<col width="100px" />
				<col width="36%" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>주문자</span></th>
					<td><%=memberName%>(<%=memberId%>)</td>
					<th scope="row"><span>연락처</span></th>
					<td><%=tagHp%>/<%=tagTel%></td>
				</tr>
				<tr>
					<th scope="row"><span>배송주소</span></th>
					<td colspan="3">[<%=tagZipcode%>] <%=tagAddr1%> <%=tagAddr2%></td>
				</tr>
			</tbody>
		</table>
		<%}%>
		<div class="tab_con tab_style2"><!-------------------------------------->
			<h3 class="tit_style1 mt_25">주문내역</h3>
			<table class="table02 mt_5" border="1" cellspacing="0">
				<colgroup>
					<col width="4%" />
					<col width="*" />
					<col width="12%" />
					<col width="12%" />
					<col width="6%" />
					<col width="6%" />
					<col width="6%" />
					<col width="6%" />
					<col width="10%" />
					<col width="*" />
					<col width="8%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><span>배송<br />구분</span></th>
						<th scope="col"><span>Sub주문번호</span></th>
						<th scope="col"><span>주문기간</span></th>
						<th scope="col"><span>주문상품</span></th>
						<th scope="col"><span>주/일</span></th>
						<th scope="col"><span>수량</span></th>
						<th scope="col"><span>정가</span></th>
						<th scope="col"><span>판매가</span></th>
						<th scope="col"><span>상품쿠폰<br />할인금액</span></th>
						<th scope="col"><span>주문금액</span></th>
						<th scope="col"><span>상품상태</span></th>
					</tr>
				</thead>
				<tbody>
				<%
				query		= "SELECT COUNT(ID) FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'"; //out.print(query1); if(true)return;
				rs			= stmt.executeQuery(query);
				if (rs.next()) {
					tcnt		= rs.getInt(1); //총 레코드 수		
				}
				rs.close();

				query		= "SELECT OG.ID, OG.ORDER_CNT, OG.DEVL_TYPE, OG.DEVL_DAY, OG.DEVL_WEEK, OG.ORDER_STATE,";
				query		+= "	DATE_FORMAT(OG.DEVL_DATE, '%Y.%m.%d') WDATE, OG.PRICE, OG.BUY_BAG_YN,";
				query		+= "	G.GUBUN1, G.GROUP_NAME, G.GROUP_CODE, G.CART_IMG, OG.COUPON_PRICE, G.GROUP_CODE, O.PAY_TYPE";
				query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
				query		+= " WHERE OG.GROUP_ID = G.ID";
				query		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
				query		+= " AND OG.ORDER_NUM = '"+ orderNum +"'";
				query		+= " ORDER BY OG.DEVL_TYPE";
				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();

				if (tcnt > 0) {
					i	= 1;
					while (rs.next()) {
						goodsId		= rs.getInt("ID");
						osubNum		= orderNum +"-" +i;
						orderCnt	= rs.getInt("ORDER_CNT");
						devlType	= (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
						gubun1		= rs.getString("GUBUN1");
						groupName	= rs.getString("GROUP_NAME");
						groupCode	= rs.getString("GROUP_CODE");
						couponPrice	= rs.getInt("COUPON_PRICE");
						if (rs.getString("DEVL_TYPE").equals("0001")) {
							devlDate	= rs.getString("WDATE");
							buyBagYn	= rs.getString("BUY_BAG_YN");
							devlDay		= rs.getString("DEVL_DAY");
							devlWeek	= rs.getString("DEVL_WEEK");
							devlPeriod	= devlWeek +"주("+ devlDay +"일)";
							price		= rs.getInt("PRICE");
							goodsPrice	= price * orderCnt;
							dayPrice += goodsPrice;

							query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
							query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
							query1		+= " AND GOODS_ID = '"+ goodsId +"'";
							try {
								rs1			= stmt.executeQuery(query1);
							} catch(Exception e) {
								out.println(e+"=>"+query1);
								if(true)return;
							}

							if (rs1.next()) {
								minDate			= rs1.getString("MIN_DATE");
								maxDate			= rs1.getString("MAX_DATE");
							}

							devlDates		= ut.isnull(minDate) +"<br />~<br />"+ ut.isnull(maxDate);
						} else {
							devlDate	= "-";
							buyBagYn	= "N";
							devlPeriod	= "-";
							price		= rs.getInt("PRICE");
							goodsPrice	= price * orderCnt;
							tagPrice	+= goodsPrice;
							devlDates	= "-";
						}
						orderPrice	= goodsPrice - couponPrice;
						payType		= rs.getString("PAY_TYPE");
						orderState	= rs.getString("ORDER_STATE");

						if (buyBagYn.equals("Y")) {
							bagPrice	+= defaultBagPrice * orderCnt;
						}

						if (rs.getString("DEVL_TYPE").equals("0001")) {
							linkUrl		= "order_view_day";
						} else {
							linkUrl		= "order_view_tag";
						}
				%>
					<tr>
						<td><%=devlType%></td>
						<td>
							<%if ((payType.equals("10") && Integer.parseInt(orderState)==0) || Integer.parseInt(orderState)==0 || Integer.parseInt(orderState)==91) {%>
							<%=osubNum%>
							<%} else {%>
							<a href="javascript:;" onclick="popup('<%=linkUrl%>.jsp?ordno=<%=orderNum%>&subno=<%=goodsId%>&gcode=<%=groupCode%>&seq=<%=i%>',900,720,'<%=linkUrl%>');"><%=osubNum%></a>
							<%}%>
						</td>
						<td><%=devlDates%></td>
						<td><%=ut.getGubun1Name(gubun1)%><br /><%=groupName%></td>
						<td><%=devlPeriod%></td>
						<td><%=orderCnt%></td>
						<td><%=nf.format(price)%></td>
						<td><%=nf.format(goodsPrice)%></td>
						<td><%=nf.format(couponPrice)%></td>
						<td><%=nf.format(orderPrice)%></td>
						<td>
							<%
							if (payType.equals("10") && Integer.parseInt(orderState)==0) {
								out.print("결제실패");
							} else {
								out.println(ut.getOrderState(orderState));
							}
							%>
						</td>
					</tr>
				<%
						i++;
					}

					orderPrice		= dayPrice + tagPrice + bagPrice;
					goodsTprice		= dayPrice + tagPrice;

					totalPrice		= orderPrice + devlPrice - couponTprice;

					if (totalPrice < 0) totalPrice = 0;
				}
				%>
				</tbody>
			</table>
			<div class="price_infor">
				<ul class="price">
					<li class="first">상품금액<br /><%=nf.format(goodsTprice)%>원</li>
					<li>
						<div class="ico_box"><img src="../images/common/ico/ico_plus.gif" alt="" /></div>
						<p class="txt">배송비<br /><%=nf.format(devlPrice)%>원</p>
					</li>
					<li>
						<div class="ico_box"><img src="../images/common/ico/ico_plus.gif" alt="" /></div>
						<p class="txt">보냉가방<br /><%=nf.format(bagPrice)%>원</p>
					</li>
					<li>
						<div class="ico_box"><img src="../images/common/ico/ico_minus.gif" alt="" /></div>
						<p class="txt">상품쿠폰<br /><%=nf.format(couponTprice)%>원</p>
					</li>
				</ul>
				<div class="result" style="width:200px;">
					<div class="ico_box"><img src="../images/common/ico/ico_result.gif" alt="" /></div>
					<p>최종결제금액<br /><%=nf.format(totalPrice)%>원</p>
				</div>
			</div>
		</div>
		<div class="order_infor2">
			<form name="frm_memo" method="post" action="order_view_db.jsp">
			<input type="hidden" name="mode" value="editAdminMemo" />
			<input type="hidden" name="order_num" value="<%=orderNum%>" />	
			
				<table width="100%">
					<tr>
						<td width="40%"><h3>관리메모</h3></td>
						<td width="10%" align="right" style="padding-right:5px"><a href="javascript:chkForm(document.frm_memo)" class="function_btn"><span>저장</span></a></td>
						<td width="50%"><h3>처리내역</h3></td>
					</tr>
					<tr>
						<td colspan="2"><textarea class="input1" cols="" rows="" style="width:96%; height:80px; padding:5px;" name="admin_memo"><%=ut.isnull(adminMemo)%></textarea></td>
						<td><textarea cols="" rows="" style="width:98%; height:80px;padding:5px;background-color:#f9f9f9;border:1px solid #cdcdcd" name="order_log" readonly><%=ut.isnull(orderLog)%></textarea></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- //popup_wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>