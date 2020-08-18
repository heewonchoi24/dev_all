<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>

<%
String goods		= "";// ut.inject(request.getParameter("goods"));
String orderNum		= ut.inject(request.getParameter("jsOrderNum"));
orderNum = orderNum.replaceAll("<","&lt;");
orderNum = orderNum.replaceAll(">","&gt;");
String goodId		= ut.inject(request.getParameter("jsGoodsId"));
goodId = goodId.replaceAll("<","&lt;");
goodId = goodId.replaceAll(">","&gt;");
String gCode 		= ut.inject(request.getParameter("jsGroupCode"));
gCode = gCode.replaceAll("<","&lt;");
gCode = gCode.replaceAll(">","&gt;");
String devlType		= ut.inject(request.getParameter("devlType"));
devlType = devlType.replaceAll("<","&lt;");
devlType = devlType.replaceAll(">","&gt;");
String devlDay		= "";
String devlDates	= "";

int groupId			= 0;

NumberFormat nf		= NumberFormat.getNumberInstance();
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
String tagName		= "";
String orderDate	= "";
String payType 		= "";
String orderState	= "";
String payDate		= "";
String tagZipcode	= "";
String tagAddr1		= "";
String tagAddr2		= "";
String tagHp		= "";
String tagTel		= "";
String tagRequest	= "";
int goodsPrice 		= 0;
int devlPrice 		= 0;
int couponPrice		= 0;
int orderPrice		= 0;
int tcnt			= 0;
int couponTprice	= 0;
int goodsId   		= 0;
int orderCnt  		= 0;
String gubun1 		= "";
String groupName 	= "";
String devlDate 	= "";
String buyBagYn 	= "";
//String devlDay  	= "";
String devlWeek 	= "";
String groupCode 	= "";
String minDate  	= "";
String maxDate  	= "";
//String devlDates 	= "";
String devlPeriod 	= "";
int price	  		= 0;
int dayPrice  		= 0;
int tagPrice  		= 0;
int bagPrice  		= 0;
int goodsTprice 	= 0;
int totalPrice 		= 0;

String pgCardNum = "";
String pgFinanceName = "";

query		= "SELECT ";
query		+= "	O.MEMBER_ID, O.PAY_TYPE, O.RCV_NAME, O.RCV_TEL, O.RCV_HP, O.RCV_ZIPCODE, O.RCV_ADDR1, O.RCV_ADDR2, O.RCV_REQUEST,";
query		+= "	O.TAG_NAME, O.TAG_TEL, O.TAG_HP, O.TAG_ZIPCODE, O.TAG_ADDR1, O.TAG_ADDR2, O.TAG_REQUEST, O.PG_TID, O.PG_CARDNUM,";
query		+= "	O.PG_FINANCENAME, O.PG_ACCOUNTNUM, O.ORDER_STATE, O.ORDER_DATE, O.PAY_DATE, O.DEVL_PRICE, O.COUPON_PRICE, O.ADMIN_MEMO, O.ORDER_LOG,";
query		+= "	O.ORDER_NAME, O.SHOP_TYPE, O.OUT_ORDER_NUM, G.GROUP_NAME, OG.GROUP_ID, OG.DEVL_DATE";
query		+= " FROM ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G, ESL_ORDER O";
query		+= " WHERE OG.GROUP_ID = G.ID";
query		+= "  	AND OG.DEVL_TYPE = ? ";
query		+= "  	AND OG.ORDER_NUM = O.ORDER_NUM";
query		+= "  	AND OG.ORDER_NUM = ? ";
if(devlType.equals("0001")) query		+= "  	AND G.GROUP_CODE = ? ";

try {
    pstmt       = conn.prepareStatement(query);
    pstmt.setString(1, devlType);
    pstmt.setString(2, orderNum);
    if(devlType.equals("0001")){
        pstmt.setString(3, gCode);
    }
    rs            = pstmt.executeQuery();

} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
if(rs.next()){
	groupId			= rs.getInt("GROUP_ID");
	groupName		= rs.getString("GROUP_NAME");

	tagName 		= rs.getString("TAG_NAME");
	orderDate 		= rs.getString("ORDER_DATE");
	payType			= rs.getString("PAY_TYPE");
	orderState		= rs.getString("ORDER_STATE");
	payDate			= (rs.getString("PAY_DATE") == null)? "" : rs.getString("PAY_DATE");
	tagHp			= rs.getString("TAG_HP");
	tagTel			= rs.getString("TAG_TEL");
	tagZipcode		= rs.getString("TAG_ZIPCODE");
	tagAddr1		= rs.getString("TAG_ADDR1");
	tagAddr2		= rs.getString("TAG_ADDR2");
	tagRequest 		= rs.getString("TAG_REQUEST");
	couponTprice	= rs.getInt("COUPON_PRICE");

	pgCardNum 		= rs.getString("PG_CARDNUM");
	pgFinanceName	= rs.getString("PG_FINANCENAME");
}
rs.close();
%>

</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>배송지 확인</h2>
	</div>
	<!-- End header -->
	<div class="contentpop">
		<div class="popup columns offset-by-one ">
			<div class="row">
				<div class="one last col">
<%
if(devlType.equals("0001")){
%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
<%
query		 = "SELECT ";
query		+= "	DEVL_DATE, ";
query		+= "	ORDER_CNT, GROUP_CODE, STATE, ";
query		+= "	RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2 ";
query		+= " FROM ESL_ORDER_DEVL_DATE A";
query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodId;
query		+= " AND STATE in ('01', '02')";
query		+= " AND GROUP_CODE <> '0300668'"; //-- 배송가방은 노출하지 않는다.
query		+= " ORDER BY DEVL_DATE ASC";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	devlDate	= rs.getString("DEVL_DATE");
	tagZipcode		= rs.getString("RCV_ZIPCODE");
	tagAddr1		= rs.getString("RCV_ADDR1");
	tagAddr2		= rs.getString("RCV_ADDR2");
%>
							<tr>
								<th><%=devlDate%></th>
								<td>(<%=tagZipcode%>) <%=tagAddr1%> <%=tagAddr2%></td>
							</tr>
<%
}
rs.close();
%>
						</tbody>
					</table>
<%
}else if(devlType.equals("0002")){
%>
					<table class="line-black paymentinfo" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<th>받으시는분</th>
								<td><%=tagName%></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><%=tagTel%></td>
							</tr>
							<tr>
								<th>휴대폰번호</th>
								<td><%=tagHp%></td>
							</tr>
							<tr>
								<th>배송지주소</th>
								<td>(<%=tagZipcode %>) <%=tagAddr1 %> <%=tagAddr2 %></td>
							</tr>
							<tr>
								<th>배송요청사항</th>
								<td><%=tagRequest%></td>
							</tr>
						</tbody>
					</table>
<%
}
%>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<%@ include file="/lib/dbclose_phi.jsp" %>
<%@ include file="/lib/dbclose.jsp"%>