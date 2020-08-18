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

// ü��� ���θ���� ���
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

int cartCt                    = 0; //-- ��ٱ��� ��ü��
int cartType1TotalPrice        = 0; //-- ���Ϲ�� ��ǰ�հ�
int cartType2TotalPrice        = 0; //-- �ù��� ��ǰ�հ�
int cartType1Ct                = 0; //-- ���Ϲ�� ��ǰ��
int cartType2Ct                = 0; //-- �ù��� ��ǰ��
int cartTotalPrice            = 0; //-- ��ü��ǰ�հ�
int devlPrice                = 0; //-- ��ۺ�
int cartTotalAmount            = 0; //-- ���������ݾ�

//-- ���Ϲ��
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

//-- �ù���
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

//-- ��ü ��ٱ��ϼ�
cartCt = cartType1Ct + cartType2Ct;

//-- ��ǰ�հ�ݾ�
cartTotalPrice = cartType1TotalPrice + cartType2TotalPrice;

//-- ��ۺ�
/* ��ü ���� ��� ����
if(cartCt > 0 && cartTotalPrice < 40000){
    devlPrice = defaultDevlPrice;
}
*/

//-- �� �����ݾ�
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
                �ֹ�/����
            </h1>
            <div class="pageDepth">
                <span>HOME</span><span>SHOP</span><strong>�ֹ�/����</strong>
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
                            �ֹ�/������ǰ
                            </span>
                        </h4>
                        <!--div class="floatright button dark small">

                        </div-->
                    </div>
                    <table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th>��� ����</th>
                            <th>��ǰ�� / �ɼ���ǰ��</th>
                            <th>��� �Ⱓ</th>
                            <th>ù �����</th>
                            <th>����</th>
                            <th>����</th>
                            <th>�Ǹ� ����</th>
                            <th class="last">�հ�</th>
                        </tr>
                        <%
                        if (cartCt > 0) {
                            int i = 0;
                            ArrayList<String> aryGroupCode = new ArrayList<String>();
                            while (rs.next()) {
                                groupId        = rs.getInt("GROUP_ID");
                                buyQty        = rs.getInt("BUY_QTY");
                                devlType    = (rs.getString("DEVL_TYPE").equals("0001"))? "�Ϲ�" : "�ù�";
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
                                        devlPeriod    = "3��";
                                    } else {
                                        devlPeriod    = devlWeek +"��("+ Integer.parseInt(devlWeek)*Integer.parseInt(devlDay) +"��)";
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

								// ü��� ���θ��
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
                                    productName        += groupName +" �� "+ String.valueOf(i) +"��";
                                }

                                // ���� ����
                                cpWhere                = "  WHERE C.ID = CM.COUPON_ID";
                                cpWhere                += " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
                                cpWhere                += " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

                                // ���� ����
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

                                // ���� ����
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

<%} else {	// 150 ����ƾ��		%>
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

                                if (!promotion.equals("exp") && couponCnt > 0) {// ü��� ���θ���� �ƴϸ鼭 ������ �ִ� ���

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
                                    <option id="fisrt_cp" value="0|0|0">������ �����ϼ���.</option>
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
								
										for(int h=0; h<aryOrderWeek.size(); h++){    // ���� ���� ��ŭ for�� ����
											String s_orderWeek = aryOrderWeek.get(h);
											if( useLimitCnt.get(h) <= buyQty && useLimitPrice.get(h) <= goodsTotalPrice ){
												// 1 ��ü��ǰ�� ���� ��밡��
												if(aryUseGoods.get(h) == 1){
													//System.out.println("aryUseGoods.get(h) == 1");
													if(devlType.equals("�ù�")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
													else if( s_orderWeek.indexOf(devlWeek) > -1 ){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
												}    // the end of 1

												// 2 Ư�� ��ǰ���� ���� ��밡��
												if(aryUseGoods.get(h) == 2){
													//System.out.println("aryUseGoods.get(h) == 2");
													if(devlType.equals("�ù�")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
													else if( s_orderWeek.indexOf(devlWeek) > -1 ){

														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
														<%
														paramPriceB = arySalePrice.get(h);
														paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
													}
												}    // the end of 2

												// 3 �Ϲ� ��ǰ ��ü ��밡��
												if(aryUseGoods.get(h) == 3){
													if(devlType.equals("�Ϲ�")){
														if( s_orderWeek.indexOf(devlWeek) > -1){
															%>
															<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>"  value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
															<%
															paramPriceB = arySalePrice.get(h);
															paramVal = arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId;
														}
													}
												}    // the end of 3

												//   4 �ù� ��ǰ ��ü ��밡��
												if(aryUseGoods.get(h) == 4){
													if(devlType.equals("�ù�")){
														%>
														<option id="cp3_<%=h%>" data="<%=arySaleNum.get(h)%>" value="<%=arySaleNum.get(h)+"|"+arySalePrice.get(h)+"|"+couponId%>" ><%=arySaleName.get(h) +"("+ nf.format(arySalePrice.get(h)) +"�� ����)"%></option>
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
                            ��������
                            <% } %>
                            </td>


                            <td><%=nf.format(price)%>��</td>
                            <td>
                                <div class="itemprice"><%=nf.format(goodsPrice)%>��</div>
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
                            <td>���Ϲ��</td>
                            <td>
                                <div class="orderName">
                                    <img class="thumbleft" src="<%=webUploadDir%>goods/groupCart_0300668.jpg" />
                                    <h4>���ð���</h4>
                                </div>
                            </td>
                            <td>-</td>
                            <td>-</td>
                            <td>1</td>
                            <td><%=nf.format(defaultBagPrice)%>��</td>
                            <td>
                                <div class="itemprice"><%=nf.format(defaultBagPrice)%>��</div>
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
                                // ��� ���� ���� Ȯ��
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

                                // �ֱ� ����� üũ
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
                                cal.setTime(new Date()); //����
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
                                �� �ֹ��ݾ�
                                <span class="won padl50"><%=nf.format(cartTotalAmount)%>��</span>
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
                                        �������� ������ �߱޹����� ���� �̰����� ������ ����� ���� ����ϼ���.
                                    </p>
                                <li>
                                    ���� ���
                                    <input type="text" class="inputfield" name="off_coupon_num" id="off_coupon_num" maxlength="20" />
                                    <span class="button light small" style="margin:0;"><a href="javascript:;" onclick="setCoupon();">���</a></span>
                                    <span class="button darkgreen small" style="margin:0;"><a class="lightbox" href="/shop/popup/couponinfo.jsp?lightbox[width]=560&lightbox[height]=300">��� ��� ���� ></a></span>

                                </li>
                                <div class="divider">
                                </div>
                                <!--li>
                                    ��������
                                    <input type="text" class="inputfield" name="coupon_price_txt" id="coupon_price_txt" readonly />
                                    ��
                                    <span class="button light small" style="margin:0;">
                                    <%if (couponCnt > 0) {%>
                                        <a href="javascript:;" onclick="showCoupons();">��ȸ �� ����</a>
                                    <%} else {%>
                                        <a href="javascript:;" onclick="alert('���밡���� ������ �����ϴ�.');">��ȸ �� ����</a>
                                    <%}%>
                                    </span>
                                    <span class="button light small" style="margin:0;">
                                        <a href="javascript:;" onclick="clearCoupons();">�������</a>
                                    </span>
                                </li-->
                                <div class="divider">
                                </div>
                                <!--li>
                                    ��밡������ <strong class="f22 font-maple"><%=couponCnt%>��</strong>
                                </li-->
                                <% if (groupCode.equals("02444")) { %>
                                <div class="divider">
                                </div>
                                <li>
                                    <span class="f13 font-blue">
                                    ���� ��� �� ���� �ܰ� �� �ñ��Ͻ� ������ �ս��� Ȩ������ 1:1 ���� �Խ��� �Ǵ� ������(080-800-0434)�� �����ּ���.
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
                                <dt>�� ��ǰ�ݾ�</dt>
                                <dd><%=nf.format(cartTotalPrice - bagPrice)%>��</dd>
                            </dl>
                            <dl>
                                <dt>���ð���(�Ϲ��ǰ)</dt>
                                <dd class="acc">����뿩</dd>
                            </dl>
                            <dl>
                                <dt>��۷�(�ù��ǰ)</dt>
                                <dd class="acc"><%=nf.format(devlPrice)%>��</dd>
                            </dl>



                            <dl>
                                <dt>���� ����</dt>
                                <input type="hidden" name="coupon_tprice" id="coupon_tprice" value="0" />
                                <dd class="minus" id="coupon_tprice_txt">0��</dd>
                            </dl>
                            <div class="divider">
                            </div>
                            <div class="floatright">
                                �� ���� �ݾ�
                                <span class="won padl50" id="tprice">
                                <%=nf.format(cartTotalAmount)%>��
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
                            <span class="f18 font-blue">���Ϲ�� ��ǰ ����� ����</span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                �ֹ� �� ������ ����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                �ֱ� �����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
                                �� ����� �Է�
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>�����ô� ��</th>
                                <td><input name="rcv_name" type="text" class="ftfd" required label="�����ôº�" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>��ȭ��ȣ</th>
                                <td><select name="rcv_tel1" id="rcv_tel1" style="width:60px;">
                                        <option value="">����</option>
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
                                <th>�޴��� ��ȣ</th>
                                <td><select name="rcv_hp1" id="rcv_hp1" style="width:60px;" required label="�޴��� ��ȣ">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="rcv_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="�޴��� ��ȣ" maxlength="4">
                                    -
                                    <input name="rcv_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="�޴��� ��ȣ" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>����� �ּ�</th>
                                <td colspan="3">
                                    <input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="�����ȣ" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0001');">�����ȣ �˻�</a></span>
                                    <br />
                                    <input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="�⺻�ּ�" readonly maxlength="50"/>
                                    <input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="���ּ�" maxlength="50">
                                    <input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
                                </td>
                            </tr>
                            <tr>
                                <th>���� ���</th>
                                <td><input name="rcv_type" type="radio" value="01" checked="checked">
                                    ���� �� ��ġ
                                    <input name="rcv_type" type="radio" value="02">
                                    ���� ��Ź ���� </td>
                                <th>���Խ� ��й�ȣ</th>
                                <td>
                                    <input name="rcv_pass_yn" type="radio" value="Y" checked="checked">
                                    ����
                                    <input name="rcv_pass" id="rcv_pass" type="text" class="ftfd" style="width:50px;">
                                    <input name="rcv_pass_yn" type="radio" value="N">
                                    ����
                                    <br><font color="red">* ��й�ȣ ��Ȯ�� �� ����� ����� �� �ֽ��ϴ�.</font></br>
                                </td>
                            </tr>
                            <tr>
                                <th>��� ��û����</th>
                                <td colspan="3"><textarea name="rcv_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>�Է±��ڴ� �ִ� �ѱ� 60��, ����/���� 120�ڱ��� �����մϴ�.</li>
                            <li>�Ϲ� ��ǰ�� ��� 24��~7�ÿ� ��۵ǹǷ�, �������� ����� ���� �ڼ��� �����ּ���. (Ư�̻����� 1:1 �Խ��� �Ǵ� �����ͷ� �����ּ���)</li>
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
                            �ù��ǰ ����� ����
                            </span>
                            <span class="f13">
                            <input name="addr_copy" type="radio" value="Y" onclick="copyAddr();">
                            �Ϲ� ��ǰ�� ����
                            </span>
                            <span class="f13">
                            <input name="addr_copy" type="radio" value="N" onclick="newAddr('T');" checked="checked">
                            �� ����� �Է�
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>�����ôº�</th>
                                <td><input name="tag_name" class="ftfd" type="text" required label="�����ôº�" maxlength="20">
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>��ȭ��ȣ</th>
                                <td><select name="tag_tel1" id="tag_tel1" style="width:60px;">
                                        <option value="">����</option>
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
                                <th>�޴��� ��ȣ</th>
                                <td><select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="�޴��� ��ȣ">
                                        <option value="010">010</option>
                                         <option value="011">011</option>
                                         <option value="016">016</option>
                                         <option value="017">017</option>
                                         <option value="018">018</option>
                                         <option value="019">019</option>
                                    </select>
                                    -
                                    <input name="tag_hp2" type="text" class="ftfd" style="width:70px;" required label="�޴��� ��ȣ" maxlength="4">
                                    -
                                    <input name="tag_hp3" type="text" class="ftfd" style="width:70px;" required label="�޴��� ��ȣ" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>����� �ּ�</th>
                                <td colspan="3">
                                    <input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" required label="�����ȣ" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0002');">�����ȣ �˻�</a></span>
                                    <br />
                                    <input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="�⺻�ּ�" readonly maxlength="50" />
                                    <input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" required label="���ּ�" maxlength="50">
                                </td>
                            </tr>
                            <input type="hidden" name="tag_type" value="01" />
                            <!--tr>
                                <th>���ɹ��</th>
                                <td><input name="tag_type" type="radio" value="01" checked="checked" />
                                    ���� �� ��ġ
                                    <input name="tag_type" type="radio" value="02">
                                    ���� ��Ź ���� </td>
                                <th></th>
                                <td></td>
                            </tr-->
                            <tr>
                                <th>��ۿ�û����</th>
                                <td colspan="3"><textarea name="tag_required" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>�Է±��ڴ� �ִ� �ѱ� 60��, ����/���� 120�ڱ��� �����մϴ�.</li>
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
                            <span class="f18 font-blue">���Ϲ�� ��ǰ ����� ����</span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                �ֹ� �� ������ ����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(rcvName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                �ֱ� �����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('R');" />
                                �� ����� �Է�
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>�����ô� ��</th>
                                <td><input name="rcv_name" type="text" class="ftfd" required label="�����ôº�" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>��ȭ��ȣ</th>
                                <td><select name="rcv_tel1" id="rcv_tel1" style="width:60px;">
                                        <option value="">����</option>
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
                                <th>�޴��� ��ȣ</th>
                                <td><select name="rcv_hp1" id="rcv_hp1" style="width:60px;" required label="�޴��� ��ȣ">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="rcv_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="�޴��� ��ȣ" maxlength="4">
                                    -
                                    <input name="rcv_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="�޴��� ��ȣ" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>����� �ּ�</th>
                                <td colspan="3">
                                    <input name="rcv_zipcode" id="rcv_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="�����ȣ" readonly maxlength="3" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0001');">�����ȣ �˻�</a></span>
                                    <br />
                                    <input name="rcv_addr1" id="rcv_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="�⺻�ּ�" readonly maxlength="50"/>
                                    <input name="rcv_addr2" id="rcv_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="���ּ�" maxlength="50">
                                    <input type="hidden" id="rcv_addr_bcode" name="rcv_addr_bcode" value="<%=memAddrBCode%>" />
                                </td>
                            </tr>
                            <tr>
                                <th>���� ���</th>
                                <td><input name="rcv_type" type="radio" value="01" checked="checked">
                                    ���� �� ��ġ
                                    <input name="rcv_type" type="radio" value="02">
                                    ���� ��Ź ���� </td>
                                <th>���Խ� ��й�ȣ</th>
                                <td>
                                    <input name="rcv_pass_yn" type="radio" value="Y" checked="checked">
                                    ����
                                    <input name="rcv_pass" id="rcv_pass" type="text" class="ftfd" style="width:150px;">
                                    <input name="rcv_pass_yn" type="radio" value="N">
                                    ����
                                    <br><font color="red">* ��й�ȣ ��Ȯ�� �� ����� ����� �� �ֽ��ϴ�.</font></br>
                                </td>
                            </tr>
                            <tr>
                                <th>��ۿ�û����</th>
                                <td colspan="3"><textarea name="rcv_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>�Է±��ڴ� �ִ� �ѱ� 60��, ����/���� 120�ڱ��� �����մϴ�.</li>
                            <li>���Ϲ�� ��ǰ�� ��� 24��~7�ÿ� ��۵ǹǷ�, �������� ����� ���� �ڼ��� �����ּ���. (Ư�̻����� 1:1 �Խ��� �Ǵ� �����ͷ� �����ּ���)</li>
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
                            �ù��ǰ ����� ����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="M" checked="checked" onclick="myAddr();" />
                                �ֹ� �� ������ ����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="O" onclick="<%=(tagName.equals(""))? " recentAddr('n');" : " recentAddr('o');"%>" />
                                �ֱ� �����
                            </span>
                            <span class="f13">
                                <input name="devl_type" type="radio" value="N" onclick="newAddr('T');" />
                                �� ����� �Է�
                            </span>
                        </h4>
                    </div>
                        <table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <th>�����ô� ��</th>
                                <td><input name="tag_name" type="text" class="ftfd" required label="�����ôº�" value="<%=memName%>" maxlength="20" />
                                </td>
                                <th>&nbsp;</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>��ȭ��ȣ</th>
                                <td><select name="tag_tel1" id="tag_tel1" style="width:60px;">
                                        <option value="">����</option>
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
                                <th>�޴��� ��ȣ</th>
                                <td><select name="tag_hp1" id="tag_hp1" style="width:60px;" required label="�޴��� ��ȣ">
                                        <option value="010"<%if(memHp1.equals("010")){out.print(" selected");}%>>010</option>
                                         <option value="011"<%if(memHp1.equals("011")){out.print(" selected");}%>>011</option>
                                         <option value="016"<%if(memHp1.equals("016")){out.print(" selected");}%>>016</option>
                                         <option value="017"<%if(memHp1.equals("017")){out.print(" selected");}%>>017</option>
                                         <option value="018"<%if(memHp1.equals("018")){out.print(" selected");}%>>018</option>
                                         <option value="019"<%if(memHp1.equals("019")){out.print(" selected");}%>>019</option>
                                    </select>
                                    -
                                    <input name="tag_hp2" type="text" class="ftfd" style="width:70px;" value="<%=memHp2%>" required label="�޴��� ��ȣ" maxlength="4">
                                    -
                                    <input name="tag_hp3" type="text" class="ftfd" style="width:70px;" value="<%=memHp3%>" required label="�޴��� ��ȣ" maxlength="4">
                                </td>
                            </tr>
                            <tr>
                                <th>����� �ּ�</th>
                                <td colspan="3">
                                    <input name="tag_zipcode" id="tag_zipcode" type="text" class="ftfd" style="width:100px;" value="<%=memZipcode%>" required label="�����ȣ" readonly maxlength="6" />
                                    <span class="button light small"><a href="javascript:;" onclick="searchAddr('0002');">�����ȣ �˻�</a></span>
                                    <br />
                                    <input name="tag_addr1" id="tag_addr1" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr1%>" required label="�⺻�ּ�" readonly maxlength="50"/>
                                    <input name="tag_addr2" id="tag_addr2" type="text" class="ftfd" style="width:340px; margin-top:5px;" value="<%=memAddr2%>" required label="���ּ�" maxlength="50">
                                </td>
                            </tr>
                            <input type="hidden" name="tag_type" value="01" />
                            <tr>
                                <th>��ۿ�û����</th>
                                <td colspan="3"><textarea name="tag_request" rows="6" style="width:98%;"></textarea></td>
                            </tr>
                        </table>
                        <div class="divider"></div>
                    <div class="guide bg-gray">
                        <ul>
                            <li>�Է±��ڴ� �ִ� �ѱ� 60��, ����/���� 120�ڱ��� �����մϴ�.</li>
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
                          <li><strong>�������� ����</strong></li>
                          <li>
<%
if ( eslMemberId.equals("test0517") ) {
%>
                              <input name="pay_type" type="radio" value="90" required label="�������ܼ���" checked="" />��ȭ����
<%
} else {
%>
                              <input name="pay_type" type="radio" value="10" required label="�������ܼ���" checked="" />�ſ�ī��
                              <input name="pay_type" type="radio" value="20" required label="�������ܼ���" />�ǽð� ������ü
                              <input name="pay_type" type="radio" value="30" required label="�������ܼ���" />�������
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
                        <h4 class="marb10">�ſ�ī�� �̿�ȳ�</h4>
                        <ul class="listSort">
                            <li><a class="lightbox" href="/shop/popup/certificate.jsp?lightbox[width]=780&lightbox[height]=645">���������� �߱޾ȳ�</a></li>
                            <li><a class="lightbox" href="/shop/popup/easeclick.jsp?lightbox[width]=780&lightbox[height]=645">�Ƚ�Ŭ�� ���� �ȳ�</a></li>
                            <li><a class="lightbox" href="/shop/popup/isp.jsp?lightbox[width]=780&lightbox[height]=645">ISP(��������) �߱޹��</a></li>
                        </ul>
                        <div class="divider"></div>
                        <p><strong>�ſ�ī����ǥ</strong> : ī������� ��� ���ݰ�꼭 ������� ���Լ��װ����� ���� �� �ִ� �ſ�ī����ǥ�� ����ǹǷ� ������ ���ݰ�꼭�� �߱޵��� �ʽ��ϴ�.</p>
                    </div>
                    <div id="20" style="display:none;" class="paymethod">
                        <h4 class="marb10">�ǽð� ������ü</h4>
                        <ul class="check">
                            <li>������ �ǽð����� ������ ���¿��� ��ǰ����� �����˴ϴ�.</li>
                            <li>�ǽð� ������ü�� ���� �Ǵ� �������ѿ� ���� �������� �ʿ��մϴ�.</li>
                            <li>�ǽð� ������ü�� ���ະ ���� ���ɽð��� Ȯ�ιٶ��ϴ�.</li>
                            <li>���ݿ������� �ڵ����� �߱޵˴ϴ�.</li>
                        </ul>
                    </div>
                    <div id="30" style="display:none;" class="paymethod">
                        <h4 class="marb10">������� �̿�ȳ�</h4>
                        <p>�������(������ �Ա�)���� �����Ͻ� ���, �����Ͻ� ù ����� D-3�� 15���������� �ԱݿϷḦ ���� �����ø�, �ֹ��� �ڵ� ��ҵ˴ϴ�.</p>
                    </div>
                </div>
            </div>
			-->
            <div class="row">
                <div class="one last col center" id="payBtn">
                    <div class="divider"></div>
                    <div class="button large darkgreen" style="margin:0 10px;">
                        <a href="orderGuide.jsp">�ֹ� ����ϱ�</a>
                    </div>
                    <!--div class="button large dark" style="margin:0 10px;">
                        <a href="cart.jsp">��ٱ��� �ٷΰ���</a>
                    </div-->
                    <div class="button large darkbrown" style="margin:0 10px;" >
                        <!-- <a href="javascript:ckForm('pay')">�ֹ� �����ϱ�</a> -->
						<a href="javascript:goOrder();">�ֹ� �����ϱ�</a>
                    </div>
                </div>
                <div style="text-align:center;padding:10px;color:red;font-size:16px;font-weight:bold;display:none" id="pay_ing">
                    ���� ó�����Դϴ�. ��ø� ��ٷ��ֽʽÿ�...
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
<input type="hidden" name="devlType" value="<%=devlType%>" /> <!-- �ֹ��� ���� "�Ϲ�"/ "�ù�" ���� �� -->
<input type="hidden" id="promotion" name="promotion" value="" /><!-- qü��� ���θ�� -->

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

	if(promotion_gubun == "exp"){// ü��� ���θ��

	}else{	

		$('.selectBox-label').css('width','140px');

		if ($("#devl_check").val() == "N") {
			//alert("������ �Ϲ� ������� ����� �Ұ����� �����Դϴ�.\n���ο� ������� �Է����ּ���.");
			$("input[name=devl_type]")[2].click();
		} 
		$("input[name=rcv_pass_yn]").click(function() {
			var passVal        = $("input[name=rcv_pass_yn]:checked").val();
			if (passVal == "Y") {
				$("#rcv_pass").attr("label","���Խ� ��й�ȣ");
				$("#rcv_pass").attr("required","");
			} else {
				$("#rcv_pass").removeAttr("label","���Խ� ��й�ȣ");
				$("#rcv_pass").removeAttr("required","");
			}
		});
		getCouponPrice();
	}

});

// �������� ���� ū ������ select �����ִ� �Լ�
function fu_couponSelect(gcd, paramH, paramVal){// paramVal ������
   $("#coupon_code_"+ gcd +" option[id=cp3_"+paramH+"]").attr("selected","selected");
   if($("#coupon_code_"+ gcd +" option:checked").val() == "0|0|0"){
		$("#coupon_code_"+ gcd).next().find('.selectBox-label').text("��������");
		$("#coupon_code_"+ gcd).next().css("pointer-events","none");
   }else{
	    $("#coupon_code_"+ gcd).next().find('.selectBox-label').text($("#coupon_code_"+ gcd +" option:checked").text());
   }
   setPrdtCoupon(gcd);
}

function myAddr() {
    var f    = document.frmOrder;

    if ($("#devl_check").val() == "N") {
        alert("������ �Ϲ� ������� ����� �Ұ����� �����Դϴ�.\n���ο� ������� �Է����ּ���.");
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
        alert("�ֱٹ���� ������ �����ϴ�.");
        $("input[name=devl_type]")[2].click();
    } else if ($("#recent_devl_check").val() == "N") {
        alert("������ �ֱ� ������� ���Ϲ���� �Ұ����� �����Դϴ�.\n���ο� ������� �Է����ּ���.");
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
    $(".minus").text("0��");
    var tprice        = parseInt($("#goodsPrice").val()) + parseInt($("#devlPrice").val()) + parseInt($("#bagPrice").val());
    if (tprice < 1) tprice = 0;
    $("#tprice").text(commaSplit(tprice)+"��");
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
                alert("��ϵǾ����ϴ�.");
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
        $("#coupon_"+ gcd).text("0�� ����");
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

        $("#coupon_"+ gcd).text(commaSplit(couponPrice) + "�� ����");
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
    $("#coupon_tprice_txt").text(commaSplit(couponTprice) + "��");

    $("#coupon_ftprice").val(couponTprice);
    var tprice        = parseInt($("#goodsPrice").val()) + parseInt($("#devlPrice").val()) + parseInt($("#bagPrice").val()) - parseInt(couponTprice);
    if (tprice < 1) tprice = 0;
    $("#tprice").text(commaSplit(tprice)+"��");
    $("#pay_price").val(tprice);
}

function searchAddr(str) {
    window.open('/shop/popup/AddressSearchJiPop.jsp?ztype='+ str,'chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');
}


// ü��� ���θ�� �߰��� ������ 2019-01-23
var promotion = '<%=promotion%>';
var groupCode = '<%=groupCode%>';
function goOrder(){

	if(promotion == "exp"){// ü��� �ֹ��� ���
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

	}else{// lg ���� ���� �̵�
		ckForm('pay');
	}
}
</script>
</body>
<%
if ( eslMemberId.equals("test0517") ) {
%>
<!--  xpay.js�� �ݵ�� body �ؿ� �νñ� �ٶ��ϴ�. -->
<script language="javascript" src="https://xpay.uplus.co.kr/ansim-keyin/js/ansim-keyin.js" type="text/javascript"></script>
<%
}
%>
</html>
<%@ include file="/lib/dbclose.jsp"%>