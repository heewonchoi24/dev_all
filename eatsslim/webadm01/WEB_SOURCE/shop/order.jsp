<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import = "javax.servlet.http.HttpUtils"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_bm.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String strUrl = javax.servlet.http.HttpUtils.getRequestURL(request).toString();

/* if(strUrl.indexOf("http://") > -1 ) {
    response.sendRedirect(strUrl.replaceAll("http://","https://") +"?"+ request.getQueryString());
    return;
} */

String query        = "";
String query1        = "";
Statement stmt1        = null;
ResultSet rs1        = null;
stmt1                = conn.createStatement();
String query2        = "";
Statement stmt2        = null;
stmt2        = conn.createStatement();
ResultSet rs2        = null;
String query3        = "";
Statement stmt3        = null;
stmt3        = conn.createStatement();
ResultSet rs3        = null;
String cpColumns    = " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE, C.ORDERWEEK, C.USE_GOODS, C.USE_LIMIT_CNT, C.USE_LIMIT_PRICE";
String cpTable        = " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere        = "";
String mode            = ut.inject(request.getParameter("mode"));
mode = mode.replaceAll("<","&lt;");
mode = mode.replaceAll(">","&gt;");

String oyn            = ut.inject(request.getParameter("oyn"));
oyn = oyn.replaceAll("<","&lt;");
oyn = oyn.replaceAll(">","&gt;");

// 체험단 프로모션일 경우
String promotion            = ut.inject(request.getParameter("promotion"));
promotion = promotion.replaceAll("<","&lt;");
promotion = promotion.replaceAll(">","&gt;");

int buyQty            = 0;
int groupId            = 0;
String devlType        = "";
String devlDay        = "";
String devlWeek        = "";
String devlDate        = "";
String devlPeriod    = "";
int price            = 0;
String buyBagYn        = "";
String gubun1        = "";
String gubun2        = "";
String groupName    = "";
String groupCode    = "";
String cartImg        = "";
int goodsPrice        = 0;
int bagPrice        = 0;
int zipCnt            = 0;
String devlCheck    = "";
String recentDevlCheck    = "";
int couponCnt        = 0;
String pgCloseDate    = "20991231240000";
String pgCloseDtTmp    = "20991231240000";
int devlFirstDay        = 0;

SimpleDateFormat dt    = new SimpleDateFormat("yyMMddHHmmss");
//String orderNum        = "ESS" + dt.format(new Date()) + "001";
String orderNum        = "ESS" + dt.format(new Date()) + ut.randomNumber(3);
SimpleDateFormat cdt    = new SimpleDateFormat("yyyyMMdd");
Date date            = null;

SimpleDateFormat dt2    = new SimpleDateFormat("yyyyMMdd150000");
SimpleDateFormat dt3    = new SimpleDateFormat("yyyyMMdd120000");
SimpleDateFormat cdt2    = new SimpleDateFormat("yyyy.MM.dd");

String memName            = "";
String memEmail            = "";
String memTel            = "";
String memTel1            = "";
String memTel2            = "";
String memTel3            = "";
String memHp            = "";
String memHp1            = "";
String memHp2            = "";
String memHp3            = "";
String memZipcode        = "";
String memAddr1            = "";
String memAddr2            = "";
String memAddrBCode        = "";
String[] tmp            = new String[]{};
NumberFormat nf = NumberFormat.getNumberInstance();
String productName        = "";
String rcvPartner            = "";
int paramVala = 0;
int paramValb = 0;

query        = "SELECT MEM_NAME, EMAIL, ZIPCODE, ADDRESS, ADDRESS_DETAIL, ADDRESS_BUILDINGCODE, HP, TEL FROM ESL_MEMBER WHERE MEM_ID = '"+ eslMemberId +"'";
try {
    rs            = stmt.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

if (rs.next()) {
    memName        = ut.isnull(rs.getString("MEM_NAME"));
    memEmail    = ut.isnull(rs.getString("EMAIL"));
    memTel        = ut.isnull(rs.getString("TEL"));
    if (memTel != null && memTel.length()>10) {
        tmp            = memTel.split("-");
        memTel1        = tmp[0];
        memTel2        = tmp[1];
        memTel3        = tmp[2];
    }
    memHp        = rs.getString("HP");
    if (memHp != null && memHp.length()>10) {
        tmp            = memHp.split("-");
        memHp1        = tmp[0];
        memHp2        = tmp[1];
        memHp3        = tmp[2];
    }
    memZipcode    = ut.isnull(rs.getString("ZIPCODE"));
    memAddr1    = ut.isnull(rs.getString("ADDRESS"));
    memAddr2    = ut.isnull(rs.getString("ADDRESS_DETAIL"));
    memAddrBCode= ut.isnull(rs.getString("ADDRESS_BUILDINGCODE"));
}
rs.close();

String rcvName        = "";
String rcvZipcode    = "";
String rcvAddr1        = "";
String rcvAddr2        = "";
String rcvBuildingNo    = "";
String rcvHp        = "";
String rcvHp1        = "";
String rcvHp2        = "";
String rcvHp3        = "";
String rcvTel        = "";
String rcvTel1        = "";
String rcvTel2        = "";
String rcvTel3        = "";
String tagName        = "";
String tagZipcode    = "";
String tagAddr1        = "";
String tagAddr2        = "";
String tagHp        = "";
String tagHp1        = "";
String tagHp2        = "";
String tagHp3        = "";
String tagTel        = "";
String tagTel1        = "";
String tagTel2        = "";
String tagTel3        = "";
String imgUrl        = "";
String saleType        = "";
int salePrice        = 0;
int couponPrice        = 0;
int couponId        = 0;

query        = "SELECT RCV_NAME, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_HP, RCV_TEL, ifnull(RCV_BUILDINGNO, '') AS RCV_BUILDINGNO, ";
query        += "    TAG_NAME, TAG_ZIPCODE, TAG_ADDR1, TAG_ADDR2, TAG_HP, TAG_TEL, TAG_BUILDINGNO ";
query        += " FROM ESL_ORDER WHERE MEMBER_ID = '"+ eslMemberId +"' ORDER BY ID DESC LIMIT 1";
//query        += " FROM ESL_ORDER WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE = '01' ORDER BY ID DESC LIMIT 1";
try {
    rs            = stmt.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

if (rs.next()) {
    rcvName        = ut.isnull(rs.getString("RCV_NAME"));
    rcvTel        = ut.isnull(rs.getString("RCV_TEL"));
    if (rcvTel != null && rcvTel.length()>10) {
        tmp            = rcvTel.split("-");
        rcvTel1        = tmp[0];
        rcvTel2        = tmp[1];
        rcvTel3        = tmp[2];
    }
    rcvHp        = ut.isnull(rs.getString("RCV_HP"));
    if (rcvHp != null && rcvHp.length()>10) {
        tmp            = rcvHp.split("-");
        rcvHp1        = tmp[0];
        rcvHp2        = tmp[1];
        rcvHp3        = tmp[2];
    }
    rcvZipcode    = ut.isnull(rs.getString("RCV_ZIPCODE"));
    rcvAddr1    = ut.isnull(rs.getString("RCV_ADDR1"));
    rcvAddr2    = ut.isnull(rs.getString("RCV_ADDR2"));
    rcvBuildingNo    = ut.isnull(rs.getString("RCV_BUILDINGNO"));
    tagName        = ut.isnull(rs.getString("RCV_NAME"));
    tagTel        = ut.isnull(rs.getString("RCV_TEL"));
    if (tagTel != null && tagTel.length()>10) {
        tmp            = tagTel.split("-");
        tagTel1        = tmp[0];
        tagTel2        = tmp[1];
        tagTel3        = tmp[2];
    }
    tagHp        = rs.getString("RCV_HP");
    if (tagHp != null && tagHp.length()>10) {
        tmp            = tagHp.split("-");
        tagHp1        = tmp[0];
        tagHp2        = tmp[1];
        tagHp3        = tmp[2];
    }
    tagZipcode    = ut.isnull(rs.getString("RCV_ZIPCODE"));
    tagAddr1    = ut.isnull(rs.getString("RCV_ADDR1"));
    tagAddr2    = ut.isnull(rs.getString("RCV_ADDR2"));
}
rs.close();

int cartCt                    = 0; //-- 장바구니 전체수
int cartType1TotalPrice        = 0; //-- 일일배송 상품합계
int cartType2TotalPrice        = 0; //-- 택배배송 상품합계
int cartType1Ct                = 0; //-- 일일배송 상품수
int cartType2Ct                = 0; //-- 택배배송 상품수
int cartTotalPrice            = 0; //-- 전체상품합계
int devlPrice                = 0; //-- 배송비
int cartTotalAmount            = 0; //-- 결제예정금액

//-- 일일배송
query        = "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0001' AND CART_TYPE = '" + mode + "' AND MEMBER_ID = ? ";
if (oyn.equals("Y")) {
    query        += " AND ORDER_YN = 'Y'";
}
pstmt        = conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs        = pstmt.executeQuery();
if(rs.next()){
    cartType1Ct                 = rs.getInt("CT");
    cartType1TotalPrice         = rs.getInt("TOTAL_PRICE");
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}	

//-- 택배배송
query        = "SELECT COUNT(ID) AS CT,IFNULL(SUM(PRICE),0) AS TOTAL_PRICE FROM ESL_CART WHERE DEVL_TYPE = '0002' AND CART_TYPE = '" + mode + "' AND MEMBER_ID = ? ";
if (oyn.equals("Y")) {
    query        += " AND ORDER_YN = 'Y'";
}
pstmt        = conn.prepareStatement(query);
pstmt.setString(1, eslMemberId);
rs        = pstmt.executeQuery();
if(rs.next()){
    cartType2Ct                 = rs.getInt("CT");
    cartType2TotalPrice         = rs.getInt("TOTAL_PRICE");
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

//-- 전체 장바구니수
cartCt = cartType1Ct + cartType2Ct;

//-- 상품합계금액
cartTotalPrice = cartType1TotalPrice + cartType2TotalPrice;

//-- 배송비
/* 전체 무료 배송 설정
if(cartCt > 0 && cartTotalPrice < 40000){
    devlPrice = defaultDevlPrice;
}
*/

//-- 총 결제금액
cartTotalAmount = cartTotalPrice + devlPrice;

query        = "SELECT C.GROUP_ID, C.BUY_QTY, C.DEVL_TYPE, C.DEVL_DAY, C.DEVL_WEEK, DATE_FORMAT(C.DEVL_DATE, '%Y.%m.%d') WDATE, C.PRICE, C.BUY_BAG_YN, G.GUBUN1, G.GUBUN2, G.GROUP_CODE, G.GROUP_NAME, G.CART_IMG, G.GROUP_IMGM, G.DEVL_FIRST_DAY";
query        += " FROM ESL_CART C, ESL_GOODS_GROUP G";
query        += " WHERE C.GROUP_ID = G.ID AND C.MEMBER_ID = '"+ eslMemberId +"' AND C.CART_TYPE = '"+ mode +"'";
if (oyn.equals("Y")) {
    query        += " AND ORDER_YN = 'Y'";
}
query        += " ORDER BY C.DEVL_TYPE";
pstmt        = conn.prepareStatement(query);
rs            = pstmt.executeQuery();

//System.out.println(query);

%>
    <!-- <script type="text/javascript" src="/common/js/common.js"></script> -->
    <script type="text/javascript" src="/common/js/order.js"></script>

<script type="text/javascript">
_TRK_PI="ODF";
</script>
</head>
<script>
  fbq('track', 'InitiateCheckout');
</script>
<body>
<form name="frmOrder" method="post">
<input type="hidden" name="name" value="<%=memName%>" />
<div id="wrap">
    <div id="header">
        <%@ include file="/common/include/inc-header.jsp"%>
    </div>
    <!-- End header -->
    <div class="container">
        <div class="maintitle">
            <h1>
                주문/결제
            </h1>
            <div class="pageDepth">
                <span>HOME</span><span>SHOP</span><strong>주문/결제</strong>
            </div>
            <div class="clear">
            </div>
        </div>
        <div class="sixteen columns offset-by-one ">
            <div class="row">
                <div class="one last col">
                    <ul class="order-step">
                        <li class="step1">
                        </li>
                        <li class="line">
                        </li>
                        <li class="step2 current">
                        </li>
                        <li class="line">
                        </li>
                        <li class="step3">
                        </li>
                    </ul>
                </div>
            </div>
            <!-- End row -->
            <div class="row">
                <div class="one last col">
                    <div class="sectionHeader">
                        <h4>
                            <span class="f18 font-blue">
                            주문/결제상품
                            </span>
                        </h4>
                        <!--div class="floatright button dark small">

                        </div-->
                    </div>
                    <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th>배송 구분</th>
                            <th>상품명 / 옵션제품명</th>
                            <th>배송 기간</th>
                            <th>첫 배송일</th>
                            <th>수량</th>
                            <th>쿠폰</th>
                            <th>판매 가격</th>
                            <th class="last">합계</th>
                        </tr>
                        <%
                        if (cartCt > 0) {
                            int i = 0;
                            ArrayList<String> aryGroupCode = new ArrayList<String>();
                            while (rs.next()) {
                                groupId        = rs.getInt("GROUP_ID");
                                buyQty        = rs.getInt("BUY_QTY");
                                devlType    = (rs.getString("DEVL_TYPE").equals("0001"))? "일배" : "택배";
                                gubun1        = rs.getString("GUBUN1");
                                gubun2        = rs.getString("GUBUN2");
                                groupName    = rs.getString("GROUP_NAME");
                                groupCode    = rs.getString("GROUP_CODE");

                                aryGroupCode.add(rs.getString("GROUP_CODE"));

					            if (gubun1.equals("01") || gubun1.equals("02") || rs.getString("DEVL_TYPE").equals("0001")) {


                                    devlDate    = rs.getString("WDATE");
                                    buyBagYn    = rs.getString("BUY_BAG_YN");
                                    devlDay        = rs.getString("DEVL_DAY");
                                    devlWeek    = rs.getString("DEVL_WEEK");
                                    devlFirstDay    = rs.getInt("DEVL_FIRST_DAY");

                                    if (gubun2.equals("26")) {
                                        devlPeriod    = "3일";
                                    } else {
                                        devlPeriod    = devlWeek +"주("+ Integer.parseInt(devlWeek)*Integer.parseInt(devlDay) +"일)";
                                    }
                                    price        = rs.getInt("PRICE");
                                    if (buyBagYn.equals("Y")) {
                                        price -= defaultBagPrice;
                                    }
//                                     goodsPrice    = price * buyQty;
                                    goodsPrice    = price;
                                    price = (price / buyQty);

                                    date            = cdt2.parse(devlDate);
                                    Calendar cal    = Calendar.getInstance();
                                    cal.setTime(date);
                                    cal.add(Calendar.DATE, -devlFirstDay);
                                    pgCloseDtTmp    = dt2.format(cal.getTime());

                                    if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) < Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
                                        pgCloseDate = pgCloseDtTmp;
                                    }
                                } else {
                                    devlDate    = "-";
                                    buyBagYn    = "N";
                                    devlPeriod    = "-";
                                    price        = rs.getInt("PRICE");
                                    goodsPrice    = price;
									price = (price / buyQty);
                                }

								// 체험단 프로모션
								if(promotion.equals("exp")){
									devlPeriod    = "-";
									price = 0;
									goodsPrice = price;
									devlPrice = 1000;
									cartTotalPrice = goodsPrice;
									cartTotalAmount = cartTotalPrice + devlPrice;
								}

                                cartImg        = rs.getString("GROUP_IMGM");
                                if (cartImg.equals("") || cartImg == null) {
                                    imgUrl        = "/images/order_sample.jpg";
                                } else {
                                    imgUrl        = webUploadDir +"goods/"+ cartImg;
                                }
                                if (i == 0) productName        = groupName;
                                if (i > 0) {
                                    productName        += groupName +" 외 "+ String.valueOf(i) +"건";
                                }

                                // 쿠폰 조건
                                cpWhere                = "  WHERE C.ID = CM.COUPON_ID";
                                cpWhere                += " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
                                cpWhere                += " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

                                // 쿠폰 개수
                                query1        = "SELECT COUNT(COUPON_NUM) COUPON_CNT FROM (";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND USE_GOODS = '01'";
                                query1        += "    UNION";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND USE_GOODS IN ('03','04')";
                                query1        += "    UNION";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
                                query1        += "        ) X ";
                                //query1        += " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
                                //query1        += " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
                                try {
                                    rs1 = stmt1.executeQuery(query1);
                                } catch(Exception e) {
                                    out.println(e+"=>"+query1);
                                    if(true)return;
                                }

                                if (rs1.next()) {
                                    couponCnt        += rs1.getInt("COUPON_CNT");
                                }
								//System.out.println("query1: " +query1);
                                rs1.close();

                                // 쿠폰 개수
                                query1        = "SELECT * FROM (";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND USE_GOODS = '01'";
                                query1        += "    UNION";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND USE_GOODS IN ('03','04')";
                                query1        += "    UNION";
                                query1        += "    SELECT "+ cpColumns;
                                query1        += "        FROM "+ cpTable;
                                query1        +=            cpWhere;
                                query1        += "        AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
                                query1        += "        ) X ";
                                //query1        += " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
                                //query1        += " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
                                try {
                                    rs1 = stmt1.executeQuery(query1);
                                } catch(Exception e) {
                                    out.println(e+"=>"+query1);
                                    if(true)return;
                                }
                        %>
                        <tr>
                            <td><%=devlType%></td>
                            <td>
                                <div class="orderName">
                                    <img class="thumbleft" src="<%=imgUrl%>" width="90" />
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

<% if(!groupCode.equals("0301844")){ %>
                            <td><%=buyQty%></td>

<%} else {	// 150 프로틴밀		%>
								<td>	
								<%
								String pSetName = "";
								String pSetCode = "";
								int pCnt		= 0;
								int pCartId		= 0;
								int pBuyCnt     = 0;

								query2		= " SELECT IFNULL(MAX(ID),0) AS ID FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND GROUP_ID = '"+groupId+"' AND CART_TYPE='"+mode+"' ";
								try {
									rs2	= stmt2.executeQuery(query2);
								} catch(Exception e) {
									out.println(e+"=>"+query2);
									if(true)return;
								}
								if (rs2.next()) {
									pCartId = rs2.getInt("ID");
								}
								rs2.close();

								query3       = "SELECT SET_NAME, SET_CODE, BUY_CNT FROM ESL_CART_DELIVERY A, ESL_GOODS_SET B where A.CART_ID = '" + pCartId + "' AND B.CATEGORY_ID = 19 AND SET_CODE = P_SET_CODE ";
								try {
									rs3	= stmt2.executeQuery(query3);
								} catch(Exception e) {
									out.println(e+"=>"+query3);
									if(true)return;
								}
								while(rs3.next()){
									pCnt++;
									pSetName = rs3.getString("SET_NAME");
									pSetCode = rs3.getString("SET_CODE");
									pBuyCnt = rs3.getInt("BUY_CNT");

									if(pBuyCnt > 0){
									%>
										<div><%=pSetName%> - <%=pBuyCnt%></div><br>
									<%
									}
%>
								<%
								}
								rs3.close();
}
%>
							</td>
                            <td>
                            <%
                                int couponMaxPrice = 0;
                                String couponNum = "";

                                if (!promotion.equals("exp") && couponCnt > 0) {// 체험단 프로모션이 아니면서 쿠폰이 있는 경우

                                    ArrayList<Integer> arySalePrice = new ArrayList<Integer>();
                                    ArrayList<String> arySaleType = new ArrayList<String>();
                                    ArrayList<String> arySaleNum = new ArrayList<String>();
                                    ArrayList<String> arySaleName = new ArrayList<String>();
                                    ArrayList<String> aryOrderWeek = new ArrayList<String>();
                                    ArrayList<Integer> aryUseGoods = new ArrayList<Integer>();

									ArrayList<Integer> useLimitCnt = new ArrayList<Integer>();
									ArrayList<Integer> useLimitPrice = new ArrayList<Integer>();

                                    int maxIdx = 0;
                                    int cntIdx = 0;
                                    String orderWeek = "";
                                    int useGoods = 0;

                                    while (rs1.next()) {

                                        saleType    = rs1.getString("SALE_TYPE");
                                        salePrice   = rs1.getInt("SALE_PRICE");
                                        //useGoods    = rs1.getInt("USE_GOODS");
                                        //orderWeek   = rs1.getString("ORDERWEEK");

                                        if (saleType.equals("W")) {
                                            couponPrice        = salePrice;
                                        } else {
                                            couponPrice        = Integer.parseInt(String.valueOf(Math.round((double)goodsPrice * (double)salePrice / 100)));
                                        }

                                        arySalePrice.add(couponPrice);
                                        arySaleNum.add(rs1.getString("COUPON_NUM"));
                                        arySaleName.add(rs1.getString("COUPON_NAME"));
                                        aryOrderWeek.add(rs1.getString("ORDERWEEK"));
                                        aryUseGoods.add(rs1.getInt("USE_GOODS"));
										useLimitCnt.add(rs1.getInt("USE_LIMIT_CNT"));
										useLimitPrice.add(rs1.getInt("USE_LIMIT_PRICE"));

                                        if ( couponPrice > couponMaxPrice ) {
                                            couponMaxPrice = couponPrice;
                                            couponNum = rs1.getString("COUPON_NUM");
                                            maxIdx = cntIdx;
                                        }
                                        cntIdx++;
                                    }
                            %>
                                <select name="coupon_code_<%=groupCode%>" id="coupon_code_<%=groupCode%>" onchange="setPrdtCoupon('<%=groupCode%>')" class="coupon_val" style="width: 170px;">
                                    <option id="fisrt_cp" value="0|0|0">쿠폰을 선택하세요.</option>
                                    <% 

										int paramPriceA = 0;
										int paramPriceB = 0;
										int paramH = 0;
										String paramVal = "";

										//int buy_Qty = 0;
										int goodsTotalPrice = 0;

										//buy_Qty = buyQty;
										goodsTotalPrice = goodsPrice;

										//System.out.println("buyQty: " + buyQty);
										//System.out.println("goodsTotalPrice: " + goodsTotalPrice);
								
										for(int h=0; h<aryOrderWeek.size(); h++){    // 쿠폰 개수 만큼 for문 돈다
											String s_orderWeek = aryOrderWeek.get(h);
											if( useLimitCnt.get(h) <= buyQty && useLimitPrice.get(h) <= goodsTotalPrice ){
												// 1 전체상품에 쿠폰 사용가능
												if(aryUseGoods.get(h) == 1){
													//System.out.println("aryUseGoods.get(h) == 1");
													if(devlType.equals("택배")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
													else if( s_orderWeek.indexOf(devlWeek) > -1 ){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
												}    // the end of 1

												// 2 특정 상품에만 쿠폰 사용가능
												if(aryUseGoods.get(h) == 2){
													//System.out.println("aryUseGoods.get(h) == 2");
													if(devlType.equals("택배")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
													else if( s_orderWeek.indexOf(devlWeek) > -1 ){

														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
												}    // the end of 2

												// 3 일배 상품 전체 사용가능
												if(aryUseGoods.get(h) == 3){
													if(devlType.equals("일배")){
														if( s_orderWeek.indexOf(devlWeek) > -1){
															%>
															<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>"  value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
															<%
															paramPriceB = arySalePrice.get(h);
															paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
														}
													}
												}    // the end of 3

												//   4 택배 상품 전체 사용가능
												if(aryUseGoods.get(h) == 4){
													if(devlType.equals("택배")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"원 할인)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
												}    // the end of 4
											}

											if(paramPriceA < paramPriceB){
												paramPriceA = paramPriceB;
												paramH = h;
												paramVal = paramVal;
											}

											if(h == aryOrderWeek.size()-1){
												%>
												<script>
												//alert("<%=paramVal%>");
												$(document).ready(function(){});
													$(function(){
														fu_couponSelect("<%=groupCode%>","<%=paramH%>","<%=paramVal%>");
													});
												</script>
												<%
											}

										}// the end of for
										

                                    %>
                                </select>
                                <input type="hidden" id="coupon_price_<%=groupCode%>" class="coupon_price" value="<%=paramVala%>" />
                            <% } else { %>
                            쿠폰없음
                            <% } %>
                            </td>


                            <td><%=nf.format(price)%>원</td>
                            <td>
                                <div class="itemprice"><%=nf.format(goodsPrice)%>원</div>
                            </td>
                        </tr>
                        <input type="hidden" name="group_code" value="<%=groupCode%>" />
                        <input type="hidden" name="coupon_price" id="coupon_fprice_<%=groupCode%>" class="fprice" value="<%=paramVala%>" />
                        <input type="hidden" name="coupon_num" id="coupon_fnum_<%=groupCode%>" class="fnum" value="<%=couponNum%>" />
                        <%
                                if (buyBagYn.equals("Y")) {
                                    bagPrice += defaultBagPrice;
                        %>
                        <tr>
                            <td>일일배달</td>
                            <td>
                                <div class="orderName">
                                    <img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
                                    <h4>보냉가방</h4>
                                </div>
                            </td>
                            <td>-</td>
                            <td>-</td>
                            <td>1</td>
                            <td><%=nf.format(defaultBagPrice)%>원</td>
                            <td>
                                <div class="itemprice"><%=nf.format(defaultBagPrice)%>원</div>
                            </td>
                        </tr>
                        <%
                                }
                                i++;
                            }

                            rs.close();

                            if (cartType1TotalPrice > 0) {

                                if (!rcvBuildingNo.equals("") && rcvBuildingNo != null) {
                                    query        = "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE GM_NO= '"+ rcvBuildingNo +"' AND DELIVERY_YN = 'Y' AND SATURDAY_YN = 'Y' AND ROWNUM = 1 ";
                                    try {
                                        rs_bm        = stmt_bm.executeQuery(query);
                                    } catch(Exception e) {
                                        out.println(e+"=>"+query);
                                        if(true)return;
                                    }

                                    if (rs_bm.next()) {
                                        rcvPartner        = rs_bm.getString("JISA_CD");
                                    }
                                    rs_bm.close();

                                    if (rcvPartner == null || rcvPartner.equals("") ) {
                                        devlCheck        = "N";
                                    } else {
                                        devlCheck        = "Y";
                                    }

                                } else {

                                    query        = "SELECT JISA_CD FROM CM_ZIP_NEW_M WHERE (ZIP= '"+ memZipcode +"' OR POST = '"+ memZipcode +"')  AND JISA_CD IS NOT NULL AND ROWNUM = 1 ";
                                    try {
                                        rs_bm        = stmt_bm.executeQuery(query);
                                    } catch(Exception e) {
                                        out.println(e+"=>"+query);
                                        if(true)return;
                                    }

                                    if (rs_bm.next()) {
                                        rcvPartner        = rs_bm.getString("JISA_CD");
                                    }
                                    rs_bm.close();

                                    if (rcvPartner == null || rcvPartner.equals("") ) {
                                        devlCheck        = "N";
                                    } else {
                                        devlCheck        = "Y";
                                    }

                                }

                                /*
                                // 배송 가능 지역 확인
                                //query        = "SELECT COUNT(SEQNO) FROM PHIBABY.V_ZIPCODE_OLD_5 WHERE ZIPCODE = '"+ memZipcode +"' AND DLVPTNCD = '01' AND DLVYN = 'Y' AND DLVTYPE = '0001'";
                                query        = "SELECT COUNT(*) FROM CM_ZIP_NEW_M WHERE (ZIP = '"+ memZipcode +"' OR POST = '"+ memZipcode +"') AND DELIVERY_YN = 'Y' AND SATURDAY_YN = 'Y' ";
                                rs_bm        = stmt_bm.executeQuery(query);

                                if (rs_bm.next()) {
                                    zipCnt        = rs_bm.getInt(1);
                                }

                                rs_bm.close();

                                if (zipCnt < 1) {
                                    devlCheck        = "N";
                                } else {
                                    devlCheck        = "Y";
                                }
                                */

                                // 최근 배송지 체크
                                query        = "SELECT COUNT(*) FROM CM_ZIP_NEW_M WHERE (ZIP = '"+ rcvZipcode +"' OR POST = '"+ rcvZipcode +"') AND DELIVERY_YN = 'Y' AND SATURDAY_YN = 'Y' ";
                                rs_bm        = stmt_bm.executeQuery(query);

                                if (rs_bm.next()) {
                                    zipCnt        = rs_bm.getInt(1);
                                }

                                rs_bm.close();

                                if (zipCnt < 1) {
                                    recentDevlCheck        = "N";
                                } else {
                                    recentDevlCheck        = "Y";
                                }

                            }

                            if (cartType2TotalPrice > 0) {
                                Calendar cal        = Calendar.getInstance();
                                cal.setTime(new Date()); //오늘
                                cal.add(Calendar.DATE, 1);
                                pgCloseDtTmp        = cdt.format(cal.getTime()) + "120000";

                                if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) < Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
                                    pgCloseDate = pgCloseDtTmp;
                                }
                            } /*else {
                                query    = "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_CART ";
                                query    += " WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'";
                                try {
                                    rs = stmt.executeQuery(query);
                                } catch(Exception e) {
                                    out.println(e+"=>"+query);
                                    if(true)return;
                                }

                                if (rs.next()) {
                                    devlDate        = rs.getString("DEVL_DATE");
                                    date            = cdt.parse(devlDate);
                                    Calendar cal    = Calendar.getInstance();
                                    cal.setTime(date);
                                    cal.add(Calendar.DATE, -3);
                                    pgCloseDate        = cdt.format(cal.getTime()) + "120000";

                                }
                            } */

                        }
                        rs.close();
                        %>
                        <tr>
                            <td colspan="8" class="totalprice">
                                총 주문금액
                                <span class="won padl50"><%=nf.format(cartTotalAmount)%>원</span>
                            </td>
                        </tr>
                    </table>
                    <!-- End orderList -->
                </div>
            </div>
            <!-- End row -->
            <div class="row">
                <div class="one last col">
                    <div class="impor-wrap f16">
                        <div class="floatleft half">
                            <ul>
                                    <p class="f12">
                                        오프라인 쿠폰을 발급받으신 분은 이곳에서 쿠폰을 등록한 다음 사용하세요.
                                    </p>
                                <li>
                                    쿠폰 등록
                                    <input type="text" class="inputfield" name="off_coupon_num" id="off_coupon_num" maxlength="20" />
                                    <span class="button light small" style="margin:0;"><a href="javascript:;" onclick="setCoupon();">등록</a></span>
                                    <span class="button darkgreen small" style="margin:0;"><a class="lightbox" href="/shop/popup/couponinfo.jsp?lightbox[width]=560&lightbox[height]=300">등록 방법 보기 ></a></span>

                                </li>
                                <div class="divider">
                                </div>
                                <!--li>
                                    쿠폰할인
                                    <input type="text" class="inputfield" name="coupon_price_txt" id="coupon_price_txt" readonly />
                                    원
                                    <span class="button light small" style="margin:0;">
                                    <%if (couponCnt > 0) {%>
                                        <a href="javascript:;" onclick="showCoupons();">조회 및 적용</a>
                                    <%} else {%>
                                        <a href="javascript:;" onclick="alert('적용가능한 쿠폰이 없습니다.');">조회 및 적용</a>
                                    <%}%>
                                    </span>
                                    <span class="button light small" style="margin:0;">
                                        <a href="javascript:;" onclick="clearCoupons();">적용취소</a>
                                    </span>
                                </li-->
                                <div class="divider">
                                </div>
                                <!--li>
                                    사용가능쿠폰 <strong class="f22 font-maple"><%=couponCnt%>장</strong>
                                </li-->
                                <% if (groupCode.equals("02444")) { %>
                                <div class="divider">
                                </div>
                                <li>
                                    <span class="f13 font-blue">
                                    쿠폰 사용 및 결제 단계 시 궁금하신 사항은 잇슬림 홈페이지 1:1 문의 게시판 또는 고객센터(080-800-0434)로 문의주세요.
                                    </span>
                                </li>
                                <% } %>
                            </ul>
                        </div>
                        <input type="hidden" id="goodsPrice" value="<%=(cartTotalPrice - bagPrice)%>" />
                        <input type="hidden" id="devlPrice" value="<%=devlPrice%>" />
                        <input type="hidden" id="bagPrice" value="<%=bagPrice%>" />
                        <div class="couponchart half floatright">
                            <dl>
                                <dt>총 상품금액</dt>
                                <dd><%=nf.format(cartTotalPrice - bagPrice)%>원</dd>
                            </dl>
                            <dl>
                                <dt>보냉가방(일배상품)</dt>
                                <dd class="acc">무료대여</dd>
                            </dl>
                            <dl>
                                <dt>배송료(택배상품)</dt>
                                <dd class="acc"><%=nf.format(devlPrice)%>원</dd>
                            </dl>



                            <dl>
                                <dt>할인 혜택</dt>
                                <input type="hidden" name="coupon_tprice" id="coupon_tprice" value="0" />
                                <dd class="minus" id="coupon_tprice_txt">0원</dd>
                            </dl>
                            <div class="divider">
                            </div>
                            <div class="floatright">
                                총 결제 금액
                                <span class="won padl50" id="tprice">
                                <%=nf.format(cartTotalAmount)%>원
                                </span>
                            </div>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
            <!-- End row -->
            <% if (cartType1TotalPrice > 0 && cartType2TotalPrice > 0) { %>
            <div class="row">
                <div class="one last col">
                    <div class="sectionHeader">
                        <h4>
                            <span class="f18 font-blue">일일배달 상품 배송지 정보</span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                주문 고객 정보와 동일
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                최근 배송지
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
                                새 배송지 입력
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>받으시는 분</th>
                                <td><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><select name="rcv_tel1" id="rcv_tel1" style="width:60px;">
                                        <option value="">선택</option>
                                         <option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
                                         <option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
                                         <option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
                                         <option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
                                         <option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
                                        <option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
                                         <option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
                                         <option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
                                         <option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
                                         <option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
                                         <option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
                                         <option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
                                         <option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
                                        <option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
                                         <option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
                                         <option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
                                    </select>
                                    -
                                    <input name="rcv_tel2" type="text" class="ftfd" style="width:70px;" value="<%=memTel2%>" maxlength="4">
                                    -
                                    <input name="rcv_tel3" type="text" class="ftfd" style="width:70px;" value="<%=memTel3%>" maxlength="4">
                                </td>
                                <th>휴대폰 번호</th>
                                <td><select name="rcv_hp1" id="rcv_hp1" style="width:60px;" required label="휴대폰 번호">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="rcv_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
                                    -
                                    <input name="rcv_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>배송지 주소</th>
                                <td colspan="3">
                                    <input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0001');">우편번호 검색</a></span>
                                    <br />
                                    <input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
                                    <input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
                                    <input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
                                </td>
                            </tr>
                            <tr>
                                <th>수령 방법</th>
                                <td><input name="rcv_type" type="radio" value="01" checked="checked">
                                    현관 앞 비치
                                    <input name="rcv_type" type="radio" value="02">
                                    경비실 위탁 수령 </td>
                                <th>출입시 비밀번호</th>
                                <td>
                                    <input name="rcv_pass_yn" type="radio" value="Y" checked="checked">
                                    있음
                                    <input name="rcv_pass" id="rcv_pass" type="text" class="ftfd" style="width:50px;">
                                    <input name="rcv_pass_yn" type="radio" value="N">
                                    없음
                                    <br><font color="red">* 비밀번호 미확인 시 배송이 어려울 수 있습니다.</font></br>
                                </td>
                            </tr>
                            <tr>
                                <th>배송 요청사항</th>
                                <td colspan="3"><textarea name="rcv_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</li>
                            <li>일배 상품의 경우 24시~7시에 배송되므로, 새벽출입 방법에 대해 자세히 적어주세요. (특이사항은 1:1 게시판 또는 고객센터로 연락주세요)</li>
                        </ul>
                    </div>
                    <!-- End Table -->
                </div>
            </div>
            <!-- End row -->
            <div class="row">
                <div class="one last col">
                    <div class="sectionHeader">
                        <h4>
                            <span class="f18 font-green">
                            택배상품 배송지 정보
                            </span>
                            <span class="f13">
                            <input name="addr_copy" type="radio" value="Y" onclick="copyAddr();">
                            일배 상품과 동일
                            </span>
                            <span class="f13">
                            <input name="addr_copy" type="radio" value="N" onclick="newAddr('T');" checked="checked">
                            새 배송지 입력
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>받으시는분</th>
                                <td><input name="tag_name" class="ftfd" type="text" required label="받으시는분" maxlength="20">
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><select name="tag_tel1" id="tag_tel1" style="width:60px;">
                                        <option value="">선택</option>
                                         <option value="02">02</option>
                                         <option value="031">031</option>
                                         <option value="032">032</option>
                                         <option value="033">033</option>
                                         <option value="041">041</option>
                                        <option value="042">042</option>
                                         <option value="043">043</option>
                                         <option value="051">051</option>
                                         <option value="052">052</option>
                                         <option value="053">053</option>
                                         <option value="054">054</option>
                                         <option value="055">055</option>
                                         <option value="061">061</option>
                                        <option value="063">063</option>
                                         <option value="064">064</option>
                                         <option value="070">070</option>
                                    </select>
                                    -
                                    <input name="tag_tel2" type="text" class="ftfd" style="width:70px;" maxlength="4">
                                    -
                                    <input name="tag_tel3" type="text" class="ftfd" style="width:70px;" maxlength="4">
                                </td>
                                <th>휴대폰 번호</th>
                                <td><select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="휴대폰 번호">
                                        <option value="010">010</option>
                                         <option value="011">011</option>
                                         <option value="016">016</option>
                                         <option value="017">017</option>
                                         <option value="018">018</option>
                                         <option value="019">019</option>
                                    </select>
                                    -
                                    <input name="tag_hp2" type="text" class="ftfd" style="width:70px;" required label="휴대폰 번호" maxlength="4">
                                    -
                                    <input name="tag_hp3" type="text" class="ftfd" style="width:70px;" required label="휴대폰 번호" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>배송지 주소</th>
                                <td colspan="3">
                                    <input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" required label="우편번호" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0002');">우편번호 검색</a></span>
                                    <br />
                                    <input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="기본주소" readonly maxlength="50" />
                                    <input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="상세주소" maxlength="50">
                                </td>
                            </tr>
                            <input type="hidden" name="tag_type" value="01" />
                            <!--tr>
                                <th>수령방법</th>
                                <td><input name="tag_type" type="radio" value="01" checked="checked" />
                                    현관 앞 비치
                                    <input name="tag_type" type="radio" value="02">
                                    경비실 위탁 수령 </td>
                                <th></th>
                                <td></td>
                            </tr-->
                            <tr>
                                <th>배송요청사항</th>
                                <td colspan="3"><textarea name="tag_required" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</li>
                        </ul>
                    </div>
                    <!-- End Table -->
                </div>
            </div>
            <% }
            else if (cartType1TotalPrice > 0) { %>
            <div class="row">
                <div class="one last col">
                    <div class="sectionHeader">
                        <h4>
                            <span class="f18 font-blue">일일배달 상품 배송지 정보</span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                주문 고객 정보와 동일
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                최근 배송지
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
                                새 배송지 입력
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>받으시는 분</th>
                                <td><input name="rcv_name" type="text" class="ftfd" required label="받으시는분" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><select name="rcv_tel1" id="rcv_tel1" style="width:60px;">
                                        <option value="">선택</option>
                                         <option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
                                         <option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
                                         <option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
                                         <option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
                                         <option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
                                        <option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
                                         <option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
                                         <option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
                                         <option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
                                         <option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
                                         <option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
                                         <option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
                                         <option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
                                        <option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
                                         <option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
                                         <option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
                                    </select>
                                    -
                                    <input name="rcv_tel2" type="text" class="ftfd" style="width:70px;" value="<%=memTel2%>" maxlength="4">
                                    -
                                    <input name="rcv_tel3" type="text" class="ftfd" style="width:70px;" value="<%=memTel3%>" maxlength="4">
                                </td>
                                <th>휴대폰 번호</th>
                                <td><select name="rcv_hp1" id="rcv_hp1" style="width:60px;" required label="휴대폰 번호">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="rcv_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
                                    -
                                    <input name="rcv_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>배송지 주소</th>
                                <td colspan="3">
                                    <input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="3" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0001');">우편번호 검색</a></span>
                                    <br />
                                    <input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
                                    <input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
                                    <input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
                                </td>
                            </tr>
                            <tr>
                                <th>수령 방법</th>
                                <td><input name="rcv_type" type="radio" value="01" checked="checked">
                                    현관 앞 비치
                                    <input name="rcv_type" type="radio" value="02">
                                    경비실 위탁 수령 </td>
                                <th>출입시 비밀번호</th>
                                <td>
                                    <input name="rcv_pass_yn" type="radio" value="Y" checked="checked">
                                    있음
                                    <input name="rcv_pass" id="rcv_pass" type="text" class="ftfd" style="width:150px;">
                                    <input name="rcv_pass_yn" type="radio" value="N">
                                    없음
                                    <br><font color="red">* 비밀번호 미확인 시 배송이 어려울 수 있습니다.</font></br>
                                </td>
                            </tr>
                            <tr>
                                <th>배송요청사항</th>
                                <td colspan="3"><textarea name="rcv_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</li>
                            <li>일일배달 상품의 경우 24시~7시에 배송되므로, 새벽출입 방법에 대해 자세히 적어주세요. (특이사항은 1:1 게시판 또는 고객센터로 연락주세요)</li>
                        </ul>
                    </div>
                    <!-- End Table -->
                </div>
            </div>
            <%}
            else if (cartType2TotalPrice > 0) {%>
            <!-- End row -->
            <div class="row">
                <div class="one last col">
                    <div class="sectionHeader">
                        <h4>
                            <span class="f18 font-green">
                            택배상품 배송지 정보
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                주문 고객 정보와 동일
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(tagName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                최근 배송지
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('T');" />
                                새 배송지 입력
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>받으시는 분</th>
                                <td><input name="tag_name" type="text" class="ftfd" required label="받으시는분" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td><select name="tag_tel1" id="tag_tel1" style="width:60px;">
                                        <option value="">선택</option>
                                         <option value="02"<%if(memTel1.equals("02")){out.print(" selected");}%>>02</option>
                                         <option value="031"<%if(memTel1.equals("031")){out.print(" selected");}%>>031</option>
                                         <option value="032"<%if(memTel1.equals("032")){out.print(" selected");}%>>032</option>
                                         <option value="033"<%if(memTel1.equals("033")){out.print(" selected");}%>>033</option>
                                         <option value="041"<%if(memTel1.equals("041")){out.print(" selected");}%>>041</option>
                                        <option value="042"<%if(memTel1.equals("042")){out.print(" selected");}%>>042</option>
                                         <option value="043"<%if(memTel1.equals("043")){out.print(" selected");}%>>043</option>
                                         <option value="051"<%if(memTel1.equals("051")){out.print(" selected");}%>>051</option>
                                         <option value="052"<%if(memTel1.equals("052")){out.print(" selected");}%>>052</option>
                                         <option value="053"<%if(memTel1.equals("053")){out.print(" selected");}%>>053</option>
                                         <option value="054"<%if(memTel1.equals("054")){out.print(" selected");}%>>054</option>
                                         <option value="055"<%if(memTel1.equals("055")){out.print(" selected");}%>>055</option>
                                         <option value="061"<%if(memTel1.equals("061")){out.print(" selected");}%>>061</option>
                                        <option value="063"<%if(memTel1.equals("063")){out.print(" selected");}%>>063</option>
                                         <option value="064"<%if(memTel1.equals("064")){out.print(" selected");}%>>064</option>
                                         <option value="070"<%if(memTel1.equals("070")){out.print(" selected");}%>>070</option>
                                    </select>
                                    -
                                    <input name="tag_tel2" type="text" class="ftfd" style="width:70px;" value="<%=memTel2%>" maxlength="4">
                                    -
                                    <input name="tag_tel3" type="text" class="ftfd" style="width:70px;" value="<%=memTel3%>" maxlength="4">
                                </td>
                                <th>휴대폰 번호</th>
                                <td><select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="휴대폰 번호">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="tag_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="휴대폰 번호" maxlength="4">
                                    -
                                    <input name="tag_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="휴대폰 번호" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>배송지 주소</th>
                                <td colspan="3">
                                    <input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="우편번호" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0002');">우편번호 검색</a></span>
                                    <br />
                                    <input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="기본주소" readonly maxlength="50"/>
                                    <input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="상세주소" maxlength="50">
                                </td>
                            </tr>
                            <input type="hidden" name="tag_type" value="01" />
                            <tr>
                                <th>배송요청사항</th>
                                <td colspan="3"><textarea name="tag_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>입력글자는 최대 한글 60자, 영문/숫자 120자까지 가능합니다.</li>
                        </ul>
                    </div>
                    <!-- End Table -->
                </div>
            </div>
            <%}%>
            <!-- End row -->
            <div class="row">
                <div class="one last col">
                <div class="divider" style="margin-bottom:20px;"></div>
                    <div class="method-wrap">
                        <ul>
                          <li><strong>결제수단 선택</strong></li>
                          <li>
<%
if ( eslMemberId.equals("test0517") ) {
%>
                              <input name="pay_type" type="radio" value="90" required label="결제수단선택" checked="" />전화결제
<%
} else {
%>
                              <input name="pay_type" type="radio" value="10" required label="결제수단선택" checked="" />신용카드
                              <input name="pay_type" type="radio" value="20" required label="결제수단선택" />실시간 계좌이체
                              <input name="pay_type" type="radio" value="30" required label="결제수단선택" />가상계좌
<%
}
%>
                          </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- End row -->
			<!--
            <div class="row">
                <div class="one last col">
                    <div id="10" style="display:none;" class="paymethod">
                        <h4 class="marb10">신용카드 이용안내</h4>
                        <ul class="listSort">
                            <li><a class="lightbox" href="/shop/popup/certificate.jsp?lightbox[width]=780&lightbox[height]=645">공인인증서 발급안내</a></li>
                            <li><a class="lightbox" href="/shop/popup/easeclick.jsp?lightbox[width]=780&lightbox[height]=645">안심클릭 서비스 안내</a></li>
                            <li><a class="lightbox" href="/shop/popup/isp.jsp?lightbox[width]=780&lightbox[height]=645">ISP(안전결제) 발급방법</a></li>
                        </ul>
                        <div class="divider"></div>
                        <p><strong>신용카드전표</strong> : 카드결제의 경우 세금계산서 대용으로 매입세액공제를 받을 수 있는 신용카드전표가 발행되므로 별도의 세금계산서는 발급되지 않습니다.</p>
                    </div>
                    <div id="20" style="display:none;" class="paymethod">
                        <h4 class="marb10">실시간 계좌이체</h4>
                        <ul class="check">
                            <li>결제시 실시간으로 고객님의 계좌에서 상품대금이 차감됩니다.</li>
                            <li>실시간 계좌이체시 범용 또는 은행제한용 공인 인증서가 필요합니다.</li>
                            <li>실시간 계좌이체시 은행별 서비스 가능시간을 확인바랍니다.</li>
                            <li>현금영수증이 자동으로 발급됩니다.</li>
                        </ul>
                    </div>
                    <div id="30" style="display:none;" class="paymethod">
                        <h4 class="marb10">가상계좌 이용안내</h4>
                        <p>가상계좌(무통장 입금)으로 선택하신 경우, 지정하신 첫 배송일 D-3일 15시이전까지 입금완료를 하지 않으시면, 주문이 자동 취소됩니다.</p>
                    </div>
                </div>
            </div>
			-->
            <div class="row">
                <div class="one last col center" id="payBtn">
                    <div class="divider"></div>
                    <div class="button large darkgreen" style="margin:0 10px;">
                        <a href="orderGuide.jsp">주문 취소하기</a>
                    </div>
                    <!--div class="button large dark" style="margin:0 10px;">
                        <a href="cart.jsp">장바구니 바로가기</a>
                    </div-->
                    <div class="button large darkbrown" style="margin:0 10px;" >
                        <!-- <a href="javascript:ckForm('pay')">주문 결제하기</a> -->
						<a href="javascript:goOrder();">주문 결제하기</a>
                    </div>
                </div>
                <div style="text-align:center;padding:10px;color:red;font-size:16px;font-weight:bold;display:none" id="pay_ing">
                    결제 처리중입니다. 잠시만 기다려주십시오...
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
<input type="hidden" name="mode" value="<%=mode%>" />
<input type="hidden" name="oyn" value="<%=oyn%>" />
<input type="hidden" name="order_num" value="<%=orderNum%>" />
<input type="hidden" id="goods_price" name="goods_price" value="<%=cartTotalPrice%>" />
<input type="hidden" name="pay_price" id="pay_price" value="<%=cartTotalAmount%>"/>
<input type="hidden" name="coupon_ftprice" id="coupon_ftprice" />
<input type="hidden" name="email" value="<%=memEmail%>" />
<input type="hidden" name="devl_price" value="<%=devlPrice%>"/>
<input type="hidden" name="memid" value="<%=eslMemberId%>" />
<input type="hidden" name="devlType" value="<%=devlType%>" /> <!-- 주문에 따른 "일배"/ "택배" 구분 값 -->
<input type="hidden" id="promotion" name="promotion" value="" /><!-- q체험단 프로모션 -->

<input type="hidden" name="LGD_TID" value="" />
<input type="hidden" name="LGD_CARDNUM" value="" />
<input type="hidden" name="LGD_FINANCECODE" value="" />
<input type="hidden" name="LGD_FINANCENAME" value="" />
<input type="hidden" name="LGD_ACCOUNTNUM" value="" />
<input type="hidden" name="LGD_FINANCEAUTHNUM" value="" />
<input type="hidden" name="LGD_CLOSEDATE" value="<%=pgCloseDate%>" />

</form>

<input type="hidden" id="devl_check" value="<%=devlCheck%>" />
<input type="hidden" id="recent_devl_check" value="<%=recentDevlCheck%>" />

<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>

<%
if ( eslMemberId.equals("test0517") ) {
%>
<%@ include file="/xpay/order.payreq.ansimkeyin.jsp"%>
<%
} else {
%>
<%@ include file="/xpay/order.payreq.jsp"%>
<%
}
%>
<script type="text/javascript">
$(document).ready(function() {

	var promotion_gubun = '<%=promotion%>';

	if(promotion_gubun == "exp"){// 체험단 프로모션

	}else{	

		$('.selectBox-label').css('width','140px');

		if ($("#devl_check").val() == "N") {
			//alert("고객님의 일배 배송지는 배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
			$("input[name=devl_type]")[2].click();
		} 
		$("input[name=rcv_pass_yn]").click(function() {
			var passVal        = $("input[name=rcv_pass_yn]:checked").val();
			if (passVal == "Y") {
				$("#rcv_pass").attr("label","출입시 비밀번호");
				$("#rcv_pass").attr("required","");
			} else {
				$("#rcv_pass").removeAttr("label","출입시 비밀번호");
				$("#rcv_pass").removeAttr("required","");
			}
		});
		getCouponPrice();
	}

});

// 할인율이 가장 큰 쿠폰을 select 시켜주는 함수
function fu_couponSelect(gcd, paramH, paramVal){// paramVal 사용안함
   $("#coupon_code_"+ gcd +" option[id=cp3_"+paramH+"]").attr("selected","selected");
   if($("#coupon_code_"+ gcd +" option:checked").val() == "0|0|0"){
		$("#coupon_code_"+ gcd).next().find('.selectBox-label').text("쿠폰없음");
		$("#coupon_code_"+ gcd).next().css("pointer-events","none");
   }else{
	    $("#coupon_code_"+ gcd).next().find('.selectBox-label').text($("#coupon_code_"+ gcd +" option:checked").text());
   }
   setPrdtCoupon(gcd);
}

function myAddr() {
    var f    = document.frmOrder;

    if ($("#devl_check").val() == "N") {
        alert("고객님의 일배 배송지는 배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
        $("input[name=devl_type]")[2].click();
    } else {
        if (f.rcv_name) {
            f.rcv_name.value        = "<%=memName%>";
            f.rcv_hp1.value            = "<%=memHp1%>";
            f.rcv_hp2.value            = "<%=memHp2%>";
            f.rcv_hp3.value            = "<%=memHp3%>";
            f.rcv_tel1.value        = "<%=memTel1%>";
            f.rcv_tel2.value        = "<%=memTel2%>";
            f.rcv_tel3.value        = "<%=memTel3%>";
            f.rcv_zipcode.value        = "<%=memZipcode%>";
            f.rcv_addr1.value        = "<%=memAddr1%>";
            f.rcv_addr2.value        = "<%=memAddr2%>";
            f.rcv_addr_bcode.value        = "<%=memAddrBCode%>";
        } else if (f.tag_name) {
            f.tag_name.value        = "<%=memName%>";
            f.tag_hp1.value            = "<%=memHp1%>";
            f.tag_hp2.value            = "<%=memHp2%>";
            f.tag_hp3.value            = "<%=memHp3%>";
            f.tag_tel1.value        = "<%=memTel1%>";
            f.tag_tel2.value        = "<%=memTel2%>";
            f.tag_tel3.value        = "<%=memTel3%>";
            f.tag_zipcode.value        = "<%=memZipcode%>";
            f.tag_addr1.value        = "<%=memAddr1%>";
            f.tag_addr2.value        = "<%=memAddr2%>";
        }
    }
}

function recentAddr(str) {
    var f    = document.frmOrder;

    if (str == 'n') {
        alert("최근배송지 정보가 없습니다.");
        $("input[name=devl_type]")[2].click();
    } else if ($("#recent_devl_check").val() == "N") {
        alert("고객님의 최근 배송지는 일일배송이 불가능한 지역입니다.\n새로운 배송지를 입력해주세요.");
        $("input[name=devl_type]")[2].click();
    } else {
        if (f.rcv_name) {
            f.rcv_name.value        = "<%=rcvName%>";
            f.rcv_hp1.value            = "<%=rcvHp1%>";
            f.rcv_hp2.value            = "<%=rcvHp2%>";
            f.rcv_hp3.value            = "<%=rcvHp3%>";
            f.rcv_tel1.value        = "<%=rcvTel1%>";
            f.rcv_tel2.value        = "<%=rcvTel2%>";
            f.rcv_tel3.value        = "<%=rcvTel3%>";
            f.rcv_zipcode.value        = "<%=rcvZipcode%>";
            f.rcv_addr1.value        = "<%=rcvAddr1%>";
            f.rcv_addr2.value        = "<%=rcvAddr2%>";
            f.rcv_addr_bcode.value        = "<%=rcvBuildingNo%>";
        } else if (f.tag_name) {
            f.tag_name.value        = "<%=tagName%>";
            f.tag_hp1.value            = "<%=tagHp1%>";
            f.tag_hp2.value            = "<%=tagHp2%>";
            f.tag_hp3.value            = "<%=tagHp3%>";
            f.tag_tel1.value        = "<%=tagTel1%>";
            f.tag_tel2.value        = "<%=tagTel2%>";
            f.tag_tel3.value        = "<%=tagTel3%>";
            f.tag_zipcode.value        = "<%=tagZipcode%>";
            f.tag_addr1.value        = "<%=tagAddr1%>";
            f.tag_addr2.value        = "<%=tagAddr2%>";
        }
    }
}

function copyAddr() {
    var f    = document.frmOrder;

    f.tag_name.value        = f.rcv_name.value;
    f.tag_hp1.value            = f.rcv_hp1.value;
    f.tag_hp2.value            = f.rcv_hp2.value;
    f.tag_hp3.value            = f.rcv_hp3.value;
    f.tag_tel1.value        = f.rcv_tel1.value;
    f.tag_tel2.value        = f.rcv_tel2.value;
    f.tag_tel3.value        = f.rcv_tel3.value;
    f.tag_zipcode.value        = f.rcv_zipcode.value;
    f.tag_addr1.value        = f.rcv_addr1.value;
    f.tag_addr2.value        = f.rcv_addr2.value;
}

function newAddr(str) {
    var f    = document.frmOrder;

    if (str == "T") {
        f.tag_name.value        = "";
        $("#tag_hp1").selectBox();
        f.tag_hp2.value            = "";
        f.tag_hp3.value            = "";
        f.tag_tel1.value        = "";
        f.tag_tel2.value        = "";
        f.tag_tel3.value        = "";
        f.tag_zipcode.value        = "";
        f.tag_addr1.value        = "";
        f.tag_addr2.value        = "";
    } else {
        f.rcv_name.value        = "";
        $("#rcv_hp1").selectBox();
        f.rcv_hp2.value            = "";
        f.rcv_hp3.value            = "";
        f.rcv_tel1.value        = "";
        f.rcv_tel2.value        = "";
        f.rcv_tel3.value        = "";
        f.rcv_zipcode.value        = "";
        f.rcv_addr1.value        = "";
        f.rcv_addr2.value        = "";
        f.rcv_addr_bcode.value = "";
    }
}

/*
function viewDiv(idx){
    var x    = document.getElementsByTagName('div');
    for (i=0; i<x.length; i++) {
        if (x[i].className=='paymethod') {
            x[i].style.display    = 'none';
        }
    }
    document.getElementById(idx).style.display='block';
}
*/

function clearCoupons() {
    $(".fprice").each(function() {
        gcdArr            = $(this).attr("id").split("_");
        gcd                = gcdArr[2];
        $("#coupon_fprice_"+ gcd).val(0);
        $("#coupon_fnum_"+ gcd).val("");
    });
    $("#coupon_price_txt").val("");
    $("#coupon_ftprice").val(0);
    $(".minus").text("0원");
    var tprice        = parseInt($("#goodsPrice").val()) + parseInt($("#devlPrice").val()) + parseInt($("#bagPrice").val());
    if (tprice < 1) tprice = 0;
    $("#tprice").text(commaSplit(tprice)+"원");
    $("#pay_price").val(tprice);
}

function showCoupons() {
    clearCoupons();

    window.open('/shop/popup/couponCheck_a.jsp?&mode=<%=mode%>&oyn=<%=oyn%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=780,height=520');
}

function setCoupon() {
    $.post("order_ajax.jsp", {
        mode: "setCoupon",
        couponNum: $("#off_coupon_num").val()
    },
    function(data) {
        $(data).find("result").each(function() {
            if ($(this).text() == "success") {
                alert("등록되었습니다.");
                document.location.reload();
            } else {
                $(data).find("error").each(function() {
                    alert($(this).text());
                });
            }
        });
    }, "xml");
    return false;
}

function setPrdtCoupon(gcd) {
    var selectVal        = $("#coupon_code_"+ gcd).val();
    if (!selectVal) {
        $("#coupon_"+ gcd).text("0원 할인");
        $("#coupon_code_"+ gcd).val("");
        $("#coupon_price_"+ gcd).val(0);
        $("#coupon_fprice_"+ gcd).val(0);
        $("#coupon_fnum_"+ gcd).val("");
        getCouponPrice(gcd);
        return false;
    } else {
        var i            = 0;
        var selectArr    = selectVal.split("|");
        var couponPrice        = selectArr[1];

        $("#coupon_"+ gcd).text(commaSplit(couponPrice) + "원 할인");
        $("#coupon_price_"+ gcd).val(couponPrice);
        $("#coupon_fprice_"+ gcd).val(couponPrice);
        $("#coupon_fnum_"+ gcd).val(selectArr[0]);

        getCouponPrice(gcd);
    }
}

function getCouponPrice(gcd) {
    var couponTprice    = 0;
    $(".coupon_price").each(function() {
        couponTprice = parseInt(couponTprice) + parseInt($(this).val());
    });
    //$("#coupon_tprice").val(couponTprice);
    $("#coupon_tprice_txt").text(commaSplit(couponTprice) + "원");

    $("#coupon_ftprice").val(couponTprice);
    var tprice        = parseInt($("#goodsPrice").val()) + parseInt($("#devlPrice").val()) + parseInt($("#bagPrice").val()) - parseInt(couponTprice);
    if (tprice < 1) tprice = 0;
    $("#tprice").text(commaSplit(tprice)+"원");
    $("#pay_price").val(tprice);
}

function searchAddr(str) {
    window.open('/shop/popup/AddressSearchJiPop.jsp?ztype='+ str,'chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');
}


// 체험단 프로모션 추가로 수정됨 2019-01-23
var promotion = '<%=promotion%>';
var groupCode = '<%=groupCode%>';
function goOrder(){

	if(promotion == "exp"){// 체험단 주문일 경우
		$("#goods_price").val(1000);
		$("#pay_price").val(1000);
		$("#devl_price").val(0);
		$("#promotion").val("exp");

		var queryString = "promotion=exp&groupCode=" + groupCode;

		$.ajax({
			url : "experience_ajax2.jsp",
			type : 'post',
			data : queryString,
			dataType : "json",
			async : true,
			cache : false,
			success : function(data){
				if(data.code == "success"){
					ckForm('pay');
				}
				else{
					alert(data.data);
					location.href = '/shop/experience.jsp';
				}
			},
			error : function(a,b,c){
				alert('error : ' + c);
				moving = false;
			}
		});

	}else{// lg 결제 모듈로 이동
		ckForm('pay');
	}
}
</script>
</body>
<%
if ( eslMemberId.equals("test0517") ) {
%>
<!--  xpay.js는 반드시 body 밑에 두시기 바랍니다. -->
<script language="javascript" src="https://xpay.uplus.co.kr/ansim-keyin/js/ansim-keyin.js" type="text/javascript"></script>
<%
}
%>
</html>
<%@ include file="/lib/dbclose.jsp"%>