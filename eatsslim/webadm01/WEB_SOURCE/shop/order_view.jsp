<%@page import="javax.swing.text.StyledEditorKit.ForegroundAction"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import="java.util.List,java.util.ArrayList,java.util.Map,java.util.HashMap"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css">
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
<%
request.setCharacterEncoding("euc-kr");
String temp_no = (String)session.getAttribute("esl_customer_num");
if(temp_no!=null){
    if(temp_no.equals("1")){//����ȸ�� sso���� ������� ���� ����� ȸ�����ǼҸ�
        session.setAttribute("esl_member_idx","");
        session.setAttribute("esl_member_id",null);
        session.setAttribute("esl_member_name","");
        session.setAttribute("esl_customer_num","");
        session.setAttribute("esl_member_code",""); //����ȸ�� ����
        response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
    }
}

List<Map> infoNoticeList		 = new ArrayList(); //-- ��ǰ����
List<Map> productNoticeList		 = new ArrayList(); //-- ��ǰ���
List<Map> deliveryNoticeList     = new ArrayList(); //-- ��۰��

ArrayList<String> aryOrderWeek   = new ArrayList<String>();
ArrayList<Integer> aryUseGoods   = new ArrayList<Integer>();
ArrayList<String> aryCouponName  = new ArrayList<String>();
ArrayList<String> aryPer		 = new ArrayList<String>();
ArrayList<String> aryW			 = new ArrayList<String>();

ArrayList<Integer> useLimitCnt   = new ArrayList<Integer>();
ArrayList<Integer> useLimitPrice = new ArrayList<Integer>();

String query          = "";
String title          = "";
String bannerImg      = "";
String clickLink      = "";
String content        = "";
String listImg        = "";
int maxLength         = 0;
String imgUrl         = "";
String instDate       = "";
SimpleDateFormat dt   = new SimpleDateFormat("yyyy-MM-dd");
String today          = dt.format(new Date());
//String cateCode     = ut.inject(request.getParameter("cateCode") );
String pramType       = ut.inject(request.getParameter("pramType"));
String groupId        = ut.inject(request.getParameter("cartId") );
String devlType       = ""; // ut.inject(request.getParameter("devlType"));
//String groupName    = ""; // ut.inject(request.getParameter("groupName"));
//String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice        = 0;  //ut.inject(request.getParameter("groupPrice"));
//int totalPrice      = 0; //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
int salePrice         = 0;

String devlGoodsType  = "";
String devlFirstDay   = "";
String devlModiDay    = "";
String devlWeek3      = "";
String devlWeek5      = "";
String cateCode       = "";

String[] arrDevlWeek3 = null;
String[] arrDevlWeek5 = null;
String[] arrCateCode  = null;

boolean isDevlWeek	  = false;
boolean isCateCode    = false;

Statement stmt1       = null;
ResultSet rs1         = null;
stmt1                 = conn.createStatement();

Statement stmt2       = null;
ResultSet rs2         = null;
stmt2                 = conn.createStatement();

int count             = 0;
int bagCnt            = 0;
String gubun1         = "";
String groupName      = "";
String groupInfo      = "";
String groupInfo1     = "";
String saleTitle      = "";
String aType          = "";
String bType          = "";
int kalInfo           = 0;
int groupPrice1       = 0;
int totalPrice        = 0;
int bTypeNum          = 0;
String cartImg        = "";
String groupImg       = "";
String groupCode      = "";
String gubun2         = "";
String tag            = "";
double dBtype;
String soldOut        = "";    // Ǯ�� ó��

/*
query        = "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
try {
    rs1    = stmt1.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

if (rs1.next()) {
    bagCnt        = rs1.getInt("PURCHASE_CNT");
}
rs1.close();
*/

/* ��ǰ�� ��õ��ǰ ���� */
int rec_cnt = 0;
List<String> recNameList  = new ArrayList<String>(); //-- ��õ ��ǰ��
List<String> recgImgList  = new ArrayList<String>(); //-- ��õ ��ǰ�� �̹���
List<String> recImgNo     = new ArrayList<String>(); //-- ��õ ��ǰ�� �̹��� ��ȣ
List<String> recgSubCode  = new ArrayList<String>(); //-- ��õ ��ǰ�� �׷��ڵ�
List<String> reccCodeList = new ArrayList<String>(); //-- ��õ ��ǰ�� CATE_CODE
List<Integer> recgId	  = new ArrayList<Integer>(); //-- ���� ��ǰ�� �׷��ڵ�
/* ��ǰ�� ��õ��ǰ �� */


//-- ��ǰ ����
query        = "SELECT ";
query        += " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query        += " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query        += " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query        += " GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, SOLD_OUT";
query        += " FROM ESL_GOODS_GROUP EGG ";
query        += "  WHERE USE_YN = 'Y' ";
query        += " AND LIST_VIEW_YN = 'Y' ";
query        += " AND ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
if(rs1.next()){
    saleTitle           = ut.isnull(rs1.getString("SALE_TITLE") );
    aType               = ut.isnull(rs1.getString("ATYPE") );
    bType               = ut.isnull(rs1.getString("BTYPE") );
    gubun1              = ut.isnull(rs1.getString("GUBUN1") );
    groupCode           = ut.isnull(rs1.getString("GROUP_CODE") );
    groupName           = ut.isnull(rs1.getString("GROUP_NAME") );
    groupPrice          = rs1.getInt("GROUP_PRICE");
    groupPrice1         = rs1.getInt("GROUP_PRICE1");
    groupInfo           = ut.isnull(rs1.getString("GROUP_INFO") );
    groupInfo1          = ut.isnull(rs1.getString("GROUP_INFO1") );
    kalInfo             = rs1.getInt("KAL_INFO");
    cartImg             = ut.isnull(rs1.getString("CART_IMG") );
    groupImg            = ut.isnull(rs1.getString("GROUP_IMGM") );
    gubun2              = ut.isnull(rs1.getString("GUBUN2") );
    tag                 = ut.isnull(rs1.getString("TAG") );
    devlGoodsType       = ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );
    devlFirstDay        = ut.isnull(rs1.getString("DEVL_FIRST_DAY") );
    devlModiDay         = ut.isnull(rs1.getString("DEVL_MODI_DAY") );
    devlWeek3           = ut.isnull(rs1.getString("DEVL_WEEK3") );
    devlWeek5           = ut.isnull(rs1.getString("DEVL_WEEK5") );
    cateCode            = ut.isnull(rs1.getString("CATE_CODE") );
	soldOut             = ut.isnull(rs1.getString("SOLD_OUT") );

    if(!ut.isNaN(devlFirstDay) || "".equals(devlFirstDay) ) devlFirstDay = "0";
    if(!ut.isNaN(devlModiDay) || "".equals(devlFirstDay) ) devlModiDay = "0";

    if(!"".equals(devlWeek3)){
        arrDevlWeek3 = devlWeek3.split(",");
        isDevlWeek = true;
    }
    if(!"".equals(devlWeek5)){
        arrDevlWeek5 = devlWeek5.split(",");
        isDevlWeek = true;
    }
    if(!"".equals(cateCode)){
        arrCateCode = cateCode.split(",");
        isCateCode = true;
    }

    salePrice = groupPrice;
    if(bType != null){
        if(aType.equals("P")){
            dBtype = Integer.parseInt(bType)/100.0;
            salePrice = groupPrice - (int)(groupPrice * dBtype); // %���� ���
        }else if(aType.equals("W")){
            salePrice = groupPrice - Integer.parseInt(bType);
        }
    }

    String setProductHistory = ut.getCook(request ,"PRODUCT_HISTORY");
    if("".equals(setProductHistory)){
        setProductHistory = "," + groupId + ",";
        ut.setCook(response ,"PRODUCT_HISTORY",setProductHistory);
    }
    else{
        if(setProductHistory.indexOf(","+groupId+",") == -1){
            setProductHistory += groupId + ",";
            ut.setCook(response ,"PRODUCT_HISTORY",setProductHistory);
        }
    }
}
else{
%>
<script>
alert("��ǰ�� ��ȸ�� �� �����ϴ�.");
history.back();
</script>
<%
}
rs1.close();

/* ��ǰ�� ��õ��ǰ ���� */
int groupId2      = Integer.parseInt(groupId);
try {
	query         = " SELECT E.ID, E.CATE_CODE, E.GROUP_NAME, E.GROUP_IMGM, ER.IMG_NO, ER.GROUP_SUB_CODE ";
	query        += " FROM ESL_GOODS_GROUP_RECIMG ER, ESL_GOODS_GROUP E ";
	query        += " WHERE E.GROUP_CODE = ER.GROUP_SUB_CODE ";
	query        += " AND ER.GROUP_SUB_ID = ? ";
	query        += " ORDER BY IMG_NO ";
	pstmt        = conn.prepareStatement(query);
	pstmt.setInt(1, groupId2);
	rs    = pstmt.executeQuery();
	//System.out.println(pstmt);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
while (rs.next()) {
	recgId.add(rs.getInt("ID"))	;
	reccCodeList.add(ut.isnull(rs.getString("CATE_CODE")));
	recNameList.add(ut.isnull(rs.getString("GROUP_NAME")));
	recgImgList.add(ut.isnull(rs.getString("GROUP_IMGM")));
	recImgNo.add(ut.isnull(rs.getString("IMG_NO")));
	recgSubCode.add(ut.isnull(rs.getString("GROUP_SUB_CODE")));
}
rs.close();	
//System.out.println(recNameList.size());
/* ��ǰ�� ��õ��ǰ �� */

String cpColumns      = " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE, C.ORDERWEEK, C.USE_GOODS, C.USE_LIMIT_CNT, C.USE_LIMIT_PRICE ";
String cpTable        = " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere        = "";

// ���� ����
cpWhere                += "  WHERE C.ID = CM.COUPON_ID";
cpWhere                += " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
cpWhere                += " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

// ���� ����
query        = "SELECT * FROM (";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "         AND USE_GOODS = '01'";
query        += "    UNION";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "         AND USE_GOODS IN ('03','04')";
query        += "    UNION";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "         AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
query        += "        ) X ";
//query1        += " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
//query1        += " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
//System.out.println("######### : ["+query+"]");
try {
    rs1 = stmt.executeQuery(query);
} catch(Exception e) {
    %>
		<script>alert("��ǰ ���� �ҷ����⸦ �����߽��ϴ�.");</script>
    <%
    out.println(e+"=>"+query);
    if(true)return;
}

String couponSaleType            = "";
String couponMaxSaleType            = "";
String couponName        = "";
int couponeSalePrice        = 0;
int couponPrice        = 0;
int couponMaxPrice    = 0;
while (rs1.next()) {
    couponSaleType    = rs1.getString("SALE_TYPE");
    couponeSalePrice  = rs1.getInt("SALE_PRICE");
	aryOrderWeek.add(rs1.getString("ORDERWEEK"));
	aryUseGoods.add(rs1.getInt("USE_GOODS"));
	aryCouponName.add(rs1.getString("COUPON_NAME"));
    aryPer.add(String.valueOf(couponeSalePrice));
    aryW.add(couponSaleType);
	useLimitCnt.add(rs1.getInt("USE_LIMIT_CNT"));
	useLimitPrice.add(rs1.getInt("USE_LIMIT_PRICE"));

    if (couponSaleType.equals("W")) {    // ��ǰ�Ǹ�	������ ~�� ����
        couponPrice           = couponeSalePrice;
    } else {    // ��ǰ�ǸŰ����� ~% ����
        couponPrice			  = Integer.parseInt(String.valueOf(Math.round((double)groupPrice * (double)couponeSalePrice / 100)));
    }

    if("02".equals(gubun1)) {    // ����1(01: �Ļ���̾�Ʈ, 02: ���α׷����̾�Ʈ, 03: Ÿ�Ժ����̾�Ʈ)
            couponMaxPrice	  = couponPrice;
            couponName		  = rs1.getString("COUPON_NAME");
            couponMaxSaleType = rs1.getString("SALE_TYPE");

    } else {
        if (couponMaxPrice < couponPrice * 10) {
            couponMaxPrice	  = couponPrice;
            couponName		  = rs1.getString("COUPON_NAME");
            couponMaxSaleType = rs1.getString("SALE_TYPE");
        }
    }
}
rs1.close();

//-- ��ǰ����
query        = "SELECT ID, NOTICE_TITLE,    NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    infoNoticeList.add(noticeMap);
}
rs1.close();

//-- ��ǰ���
query        = "SELECT ID, NOTICE_TITLE,    NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='PRODUCT' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    productNoticeList.add(noticeMap);
}
rs1.close();

//-- ��۰��
query        = "SELECT ID, NOTICE_TITLE,    NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='DELIVERY' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    deliveryNoticeList.add(noticeMap);
}
rs1.close();

//-- �޹�������
query       = "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME";
query       += " FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY_TYPE = '02' ";
query       += " ORDER BY HOLIDAY DESC, ID DESC";
pstmt       = conn.prepareStatement(query);
rs        = pstmt.executeQuery();

ArrayList<String> holiDay = new ArrayList();
while (rs.next()) {
    holiDay.add(rs.getString("HOLIDAY"));
}
rs.close();

%>

</head>
<body>
<div style="display: none;">
    <img id="calImg" src="/dist/images/ico/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;">
</div>
<div id="wrap" class="added">
    <div id="header">
    <%@ include file="/common/include/inc-header.jsp"%>
    </div>
    <!-- End header -->
    <div id="container">
    <form action="" name="productViewForm" id="productViewForm">
		<!-- 150 ����ƾ�� ���� -->
		<input type="hidden" name="price" id="price" value="<%=groupPrice%>" />
		<input type="hidden" name="p_buy_qty" id="p_buy_qty" value="5" />
		<!-- 150 ����ƾ�� �� -->
        <div class="order_view_contain ff_noto">
            <div class="path">
                <span>HOME</span><span>SHOP</span><strong><%=ut.getGubun1Name(gubun1)%></strong>
            </div>
            <div class="goods_frame">
                <div class="goods_thumbnail">
                    <%
                        if(tag != ""){
                    %>
                    <div class="goods_badge">
                        <%
                            if(tag.indexOf("01") != -1){
                                %>
                                <span class="b_event"></span>
                                <%
                            }
                            if(tag.indexOf("02") != -1){
                                %>
                                <span class="b_special"></span>
                                <%
                            }
                            if(tag.indexOf("03") != -1){
                                %>
                                <span class="b_sale"></span>
                                <%
                            }
                            if(tag.indexOf("04") != -1){
                                %>
                                <span class="b_new"></span>
                                <%
                            }
                            if(tag.indexOf("05") != -1){
                                %>
                                <span class="b_rcmd"></span>
                                <%
                            }
                            if(tag.indexOf("06") != -1){
                                %>
                                <span class="b_best"></span>
                                <%
                            }
                        %>
                    </div>
                    <%
                        }
                    %>
                    <img src="/data/goods/<%=groupImg%>" onerror='this.src="/dist/images/sample_order_view.jpg"'>
                </div>
                <div class="goods_info">

                    <div class="goods_title">
                        <p><%=groupInfo1 %></p>
                        <h2><%=groupName %></h2>
                    </div>
                    <div class="section">
                        <input type="hidden" name="devlWeek" id="devlWeek" value="">
                        <input type="hidden" name="devlDay" id="devlDay" value="">
                        <input type="hidden" name="groupId" id="groupId" value="<%=groupId%>">
                        <input type="hidden" name="groupCode" id="groupCode" value="<%=groupCode%>">
                        <input type="hidden" name="devlType" id="devlType" value="<%=devlGoodsType%>">
                        <input type="hidden" name="buyBagYn" id="buyBagYn" value="">
                        <input type="hidden" name="devlWeekEnd" id="devlWeekEnd" value="">
                        <input type="hidden" name="pcAndMobileType" id="pcAndMobileType" value="pc">
                        <input type="hidden" name="totalPrice" id="totalPrice" value="">
<%
if(infoNoticeList != null && !infoNoticeList.isEmpty() ){
%>
                            <div class="prd_info">
                                <div class="title">��ǰ����</div>
                                <div class="tableBox">
                                    <table>
                                        <colgroup>
                                            <col width="29.5%"/>
                                            <col width="*"/>
                                        </colgroup>
                                        <tbody>
<%
    for(Map nMap : infoNoticeList){
%>
                                            <tr>
                                                <th><%=nMap.get("title") %></th>
                                                <td><%=nMap.get("content") %></td>
                                            </tr>
<%
    }
%>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
<%
}
%>

                            <table>
                                <colgroup>
                                    <col width="29.5%">
                                    <col width="*">
                                </colgroup>
                                <tbody>
<%
if(devlGoodsType.equals("0001")){
    if(isDevlWeek){//-- ���Ϲ�� �����Ұ��� �ִٸ�
        if("02".equals(gubun1) && !"51".equals(gubun2)){ //-- ���α׷� ���̾�Ʈ�� ���ϰ� �Ⱓ�� ������ �ִ�.
            if(!"".equals(devlWeek3)){
%>
                                <input type="hidden" name="selectDevlDay" id="selectDevlDay" value="3">
                                <input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="<%=devlWeek3%>">
<%
            }
            else{
%>
                                <input type="hidden" name="selectDevlDay" id="selectDevlDay" value="5">
                                <input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="<%=devlWeek5%>">
<%
            }
        }
        else{
%>
                                <tr>
                                    <th>��� ����</th>
                                    <td>
                                    <div class="select_group selectWrap" id="selectDevlDay" name="selectDevlDay">
                                        <select name="selectDevlDay" id="selectDevlDay" class="notCustom">
                                            <% if(arrDevlWeek5 != null){ %><option value="5">�� 5ȸ (��~��)</option><% } %>
                                            <% if(arrDevlWeek3 != null){ %><option value="3">�� 3ȸ (��/��/��)</option><% } %>
                                        </select>
                                    </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>��� �Ⱓ</th>
                                    <td>
                                    <div class="selectWrap">
                                    <select name="selectDevlWeek" id="selectDevlWeek" class="notCustom">

<%
            String[] arrFor = null;
            if(arrDevlWeek5 != null){
                arrFor = arrDevlWeek5;
            }
            else{
                arrFor = arrDevlWeek3;
            }
            for(int forCt = 0; forCt < arrFor.length;forCt++){
%>
                                        <option value="<%=arrFor[forCt]%>"><%=arrFor[forCt]%>��</option>

<%

            }

%>
                                    </select>
                                    </div>
                                    </td>
                                </tr>
<%
        } //if("02".equals(gubun1)){} else
    } //if(isDevlWeek){ %>
                                <tr>
                                    <th>����</th>
                                    <td>
                                        <div class="inp_quantity">
                                            <input type="text" class="inp_qtt_text only_number" name="buyQty" id="buyQty" value="1">
                                            <button type="button" class="inp_qtt_minus" onclick="QuantityFn.minus();">-</button>
                                            <button type="button" class="inp_qtt_plus" onclick="QuantityFn.plus();">+</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>ù �����</th>
                                    <td>
                                        <div class="inp_datepicker">
                                            <input type="text" id="day" name="day" class="dp-applied date-pick" readonly/>
                                        </div>
                                    </td>
                                </tr>
<% if("0301590".equals(groupCode)){ %>
                                <tr>
                                    <th>�ָ��Ĵ�</th>
                                    <td>
                                        <div class="inp_thermos">
                                            <input type="checkbox" id="buy_weekend" name="buy_weekend" checked="checked" /> <label for="buy_bag">�� ����</label>
                                            <p>�ָ��Ĵ� ���� �� �� ��ǰ(2��)�� �߰��Ǿ� �ݿ��Ͽ� �Բ� ��۵˴ϴ�.</p>
                                        </div>
                                    </td>
                                </tr>
<% } %>
                                <tr>
                                    <th>���ð���</th>
                                    <td>
                                        <div class="inp_thermos">
                                            <p>�ֹ��Ͻ� �Ĵ��� �ս��� ���� �뿩�� ���ð���� �Բ� �ż��ϰ� ��۵˴ϴ�</p>
                                        </div>
                                    </td>
                                </tr>

<%
} //if(devlGoodsType.equals("0001")){
else{
%>
                                <input type="hidden" name="selectDevlDay" id="selectDevlDay" value="0">
                                <input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="0">
                                <tr>
                                    <th>����</th>
                                    <td>
                                        <ul>
<% if(!"0301844".equals(groupCode)){%>
                                            <li>
                                                <div class="inp_quantity">
                                                    <input type="text" class="inp_qtt_text only_number" name="buyQty" id="buyQty" value="1">
                                                    <button type="button" class="inp_qtt_minus" onclick="QuantityFn.minus();">-</button>
                                                    <button type="button" class="inp_qtt_plus" onclick="QuantityFn.plus();">+</button>
                                                </div>
                                            </li>
<% } else {	// 150 ����ƾ��  
										
										String pSetName = "";
										String pSetCode = "";
										int pCnt = 0;

										query       = "SELECT SET_NAME, SET_CODE FROM ESL_GOODS_SET WHERE CATEGORY_ID = 19;";
										pstmt       = conn.prepareStatement(query);
										rs1			= pstmt.executeQuery();
										while(rs1.next()){
											pCnt++;
											pSetName = rs1.getString("SET_NAME");
											pSetCode = rs1.getString("SET_CODE");
										%>
                                            <li>
                                                <div class="title"><%=pSetName%></div>
                                                <div class="inp_quantity">
                                                    <input type="text" class="inp_qtt_text only_number" name="buy_qty" id="buy_qty<%=pCnt%>" value="1">
     											    <input type="hidden" name="p_set_code" id="p_set_code<%=pCnt%>" value=<%=pSetCode%> />
                                                    <button type="button" class="inp_qtt_minus" onclick="setMinus(<%=pCnt%>);">-</button>
                                                    <button type="button" class="inp_qtt_plus" onclick="setPlus(<%=pCnt%>);">+</button>
                                                </div>
                                            </li>
										<%
										}
										rs1.close();
%>
											<li>
												<p style="color:#623a1e; font-weight:bold;">
													<br />
													�ּ� �ֹ��� 5Set���� �����մϴ�.
												</p>
											</li>
<% } %>
                                        </ul>
                                    </td>
                                </tr>
<%
}
%>
                            </tbody>
                            </table>
                            <table class="tfoot">
                                <tfoot>
                                    <tr>
                                        <th style="width:100px">�� �ֹ��ݾ�</th>
                                        <td id="coupon_list">
                                        <%
                                        if (couponMaxPrice > 0) {
                                            for(int h=0; h<aryOrderWeek.size(); h++){    // ���� ���� ��ŭ for�� ����
                                                String s_orderWeek = aryOrderWeek.get(h);
                                        %>
                                            <span id="cp_<%=h%>" class="event_area" value="<%=s_orderWeek%>" data="<%=aryPer.get(h)%>" atype="<%=aryW.get(h)%>" usegoods="<%=aryUseGoods.get(h)%>"  uselimitcnt="<%=useLimitCnt.get(h)%>" uselimitprice="<%=useLimitPrice.get(h)%>"><%=aryCouponName.get(h)%></span>

                                        <%
                                            }

                                        } else if(groupPrice != salePrice){
                                        %>

                                            <span class="event_area"><%=saleTitle%></span>

                                        <%
                                        }
                                        %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                        <%
                                        if(couponMaxPrice > 0){
                                            %>
                                            <del id="orgPrice">&nbsp;</del><span><strong id="sumPrice">&nbsp;</strong></span>
                                            <p><span></span></p>
                                            <%
                                        } else if(groupPrice == salePrice){
                                            %>
                                            <span><strong id="sumPrice">&nbsp;</strong></span>
                                            <%
                                        }else{
                                            %>
                                            <del id="orgPrice">&nbsp;</del><span><strong id="sumPrice">&nbsp;</strong></span>
                                            <p><span></span></p>
                                            <!-- (3�� Ư�� ������ �̺�Ʈ��) -->
                                            <%
                                        }
                                        %>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </form>
                    </div>
                    <div class="footer">
                        <div class="btn_group ta-l">
                    <%
                        if ( "Y".equals(soldOut) ) {
                    %>
                            <span>���� ���Ű� �Ұ����� ��ǰ�Դϴ�.</span>
                    <%
                        } else {
					%>
							<button type="button" id="btnProductViewForm" class="btn" onclick="">��ٱ��� ���</button>
							<button type="button" class="btn_go_order">�ֹ��ϱ�</button>
					<%
	                       }
                    %>
                        </div>
                        <!-- <div class="btn_share">
                            <p>SHARE THIS</p>
                            <ul>
                                <li class="facebook"><a href="http://www.facebook.com/share.php?u=http://www.eatsslim.co.kr/shop/order_view.jsp"><img src="/dist/images/ico/ico_share_facebook.png" alt=""></a></li>
                                <li class="twitter"><a href="http://twitter.com/share?url=http://www.eatsslim.co.kr/shop/dietMeal.jsp&text=eatsslim diet"><img src="/dist/images/ico/ico_share_twitter.png" alt=""></a></li>
                            </ul>
                        </div> -->
                    </div>
                </div>
            </div>
            <div class="goods_detail">
                <!-- <div class="detail_inner cbg">
                    <dl>
                        <dt>�⺻����</dt>
                        <dd class="goods_detail1">
                            <div class="desc_title">
                                <div class="calorie">
                                    <span>��� 250kcal</span>
                                </div>
                                <div class="tt">
                                    One-dish Style�� �����ε�<br><strong>�˶��� ����</strong>
                                </div>
                                <p>������ �ʰ� ������ �Ļ�</p>
                            </div>
                            <div class="desc_list">
                                <ul>
                                    <li><span><img src="/dist/images/ico/ico_goods_detail1_1.png" alt="" /></span>�� 10���� �پ��� �޴��� <strong>������ �ʴ� ��ſ� �Ļ�!</strong></li>
                                    <li><span><img src="/dist/images/ico/ico_goods_detail1_2.png" alt="" /></span>Ǯ���� �Ĺ�ȭ ������ ���� �ڹ����� <strong>�������̰� ü������ ���缳��!</strong></li>
                                    <li><span><img src="/dist/images/ico/ico_goods_detail1_3.png" alt="" /></span>������ �ʰ� �����ϰ� <strong>���� ��𼭳� ���� ����</strong></li>
                                    <li><span><img src="/dist/images/ico/ico_goods_detail1_4.png" alt="" /></span>Ǯ���� �ؽż���۽ý������� <strong>�����ϰ� �ż��� ���� ���!</strong></li>
                                </ul>
                            </div>
                        </dd>
                    </dl>
                </div> -->
				<!-- ��ǰ�� ��õ��ǰ ���� -->
                <div class="detail_inner">
					<% 
					if(recImgNo.size() > 0){
					%>
                    <dl>
                        <dt>Related Product</dt>
						 <dd class="goods_inventory related">
						  <ul>
						<%
						for(int g=0; g<recImgNo.size(); g++){ 
						%>
							<li>
								<a href="/shop/order_view.jsp?cateCode=<%=reccCodeList.get(g)%>&cartId=<%=recgId.get(g)%>&groupCode=<%=recgSubCode.get(g)%>&pramType=list" class="img">
									<div class="centered">
										<img src="/data/goods/<%=recgImgList.get(g)%>" alt="" onerror="this.src='/dist/images/order/sample_order_list1.jpg'">
									</div>
									<div class="badge">
										<span class="b_rcmd"></span>
									</div>
								</a>
								<div class="info">
									<p class="title"><%=recNameList.get(g)%></p>
								</div>
							</li>
						<% 
						}
						%>
							</ul>
                        </dd>
                    </dl>
					<%
					} 
					%>
                    <script type="text/javascript">
                    	$('.goods_inventory.related ul').slick({
							infinite: false,
							slidesToShow: 3,
							slidesToScroll: 3
						});
                    </script>
                </div>
				<!-- ��ǰ�� ��õ��ǰ �� -->
                <div class="detail_inner">
                    <dl>
                        <dt>��ǰ ������</dt>
                        <dd class="goods_detail3">
                            <!-- <img src="/dist/images/ms03_1_03.gif" alt="" /> -->
                            <%=groupInfo%>
                        </dd>
                    </dl>
                </div>
<%
if(isCateCode){
%>
                <%-- <div class="set_list_wrap">
                                <div class="title_area">
                                    <h3><%=groupNm %></h3>
                                </div>
                                <div class="set_list">
                                    <ul>
                                        <%
                                        String setName = "";
                                        String kal     = "";
                                        String thumbImg= "";
                                        int setID       = 0;
                                        while(rs1.next()){
                                        setName = rs1.getString("SET_NAME");
                                        kal        = rs1.getString("CALORIE");
                                        thumbImg= rs1.getString("THUMB_IMG");
                                        setID    = rs1.getInt("ID");
                                        %>
                                        <li>
                                            <a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>">
                                                <div class="img">
                                                    <img src="/data/goods/<%=thumbImg %>" alt="ĳ���� �ҳ��Ľ�Ÿ������" />
                                                </div>
                                                <div class="info">
                                                <%
                                                    if(!kal.equals("")){
                                                        %>
                                                        <p class="calorie"><%=kal %>kcal</p>
                                                        <%
                                                    }
                                                %>
                                                    <p class="name"><%=setName%></p>
                                                </div>
                                            </a>
                                        </li>
                                        <%
                                        }
                                        %>
                                    </ul>
                                </div>
                            </div> --%>

                <div class="detail_inner">
                    <dl>
                        <dt>�Ĵܱ��� <p>�� �Ʒ� ��ǰ �̹����� Ŭ���Ͻø�, �� ���������� Ȯ���Ͻ� �� ������, ���ظ� �������� �������� �� ��ǰ�� ���̰� ���� �� �ֽ��ϴ�.</p></dt>
                        <dd class="goods_detail2">
<%
    for(int forCt = 0; forCt < arrCateCode.length; forCt++){
        int categoryId = 0;
        String categoryName = "";
        query        = "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE='" + arrCateCode[forCt] + "'";
        //System.out.println(query);
        rs1 = stmt1.executeQuery(query);
        if(rs1.next() ){
            categoryId = rs1.getInt("ID");
            categoryName = ut.isnull(rs1.getString("CATE_NAME") );
        }
        rs1.close();

        if(categoryId > 0){
            query        = "SELECT a.CATEGORY_ID, a.ID, a.SET_CODE, a.SET_NAME, a.SET_PRICE, a.SET_INFO, a.MAKE_DATE, a.THUMB_IMG, a.BIG_IMG,";
            query        += "    a.BIGO, a.USE_YN, b.PORTION_SIZE, b.CALORIE, b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P,";
            query        += "    b.PROTEIN_G, b.PROTEIN_P, b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G,";
            query        += "    b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P";
            query        += " FROM ESL_GOODS_SET a, ESL_GOODS_SET_CONTENT b";
            query        += " WHERE a.ID = b.SET_ID ";
            query        += " AND a.USE_YN = 'Y'";
            query        += " AND a.CATEGORY_ID = " + categoryId;
            //System.out.println(query);
            try {
                rs1 = stmt1.executeQuery(query);
            } catch(Exception e) {
                System.out.println(e+"=>"+query);
                if(true)return;
            }
%>
                            <div class="set_list_wrap">
                                <div class="title_area">
                                    <h3><%=categoryName%></h3>
                                </div>
                                <div class="set_list">
                                    <ul>
<%
            String setName = "";
            String kal     = "";
            String thumbImg= "";
            int setID       = 0;
            String setCode = "";

            while(rs1.next()){
                setName = rs1.getString("SET_NAME");
                kal        = rs1.getString("CALORIE");
                //thumbImg= rs1.getString("THUMB_IMG");
                thumbImg= rs1.getString("BIG_IMG");
                setID    = rs1.getInt("ID");
                setCode = rs1.getString("SET_CODE");

                query        = "SELECT CATEGORY_CODE FROM ESL_GOODS_CATEGORY_SCHEDULE";
                query        += " WHERE SET_CODE = '"+setCode+"'";
                query        += " LIMIT 1";
                //System.out.println(query);
                try {
                    rs2 = stmt2.executeQuery(query);
                } catch(Exception e) {
                    //System.out.println(e+"=>"+query);
                    if(true)return;
                }
                String caregoryCode = "";
                if(rs2.next()){
                    caregoryCode = rs2.getString("CATEGORY_CODE");
                }
                rs2.close();
%>
                                        <li>
                                            <a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>&caregoryCode=<%=caregoryCode%>">
                                                <div class="img">
                                                    <img src="/data/goods/<%=thumbImg %>" alt="<%=setName%>" />
                                                </div>
                                                <div class="info">
                                                    <p class="calorie">
                                                <%
                                                    if(!kal.equals("")){
                                                        %>
                                                        <%=kal %>kcal
                                                        <%
                                                    }
                                                %>
                                                    </p>
                                                    <p class="name"><%=setName%></p>
                                                </div>
                                            </a>
                                        </li>
<%
            } //-- while(rs1.next()){
%>
                                    </ul>
                                </div>
                            </div>
<%
        } //-- if(categoryId > 0){
    } //-- for(int forCt = 0; forCt < arrCateCode.length;forCt++){
%>
                        <%--
                            <div class="set_list_wrap">
                                <div class="title_area">
                                    <h3><%=groupNm %></h3>
                                </div>
                                <div class="set_list">
                                    <ul>
                                        <%
                                        String setName = "";
                                        String kal     = "";
                                        String thumbImg= "";
                                        int setID       = 0;
                                        while(rs1.next()){
                                        setName = rs1.getString("SET_NAME");
                                        kal        = rs1.getString("CALORIE");
                                        thumbImg= rs1.getString("THUMB_IMG");
                                        setID    = rs1.getInt("ID");
                                        %>
                                        <li>
                                            <a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>">
                                                <div class="img">
                                                    <img src="/data/goods/<%=thumbImg %>" alt="ĳ���� �ҳ��Ľ�Ÿ������" />
                                                </div>
                                                <div class="info">
                                                <%
                                                    if(!kal.equals("")){
                                                        %>
                                                        <p class="calorie"><%=kal %>kcal</p>
                                                        <%
                                                    }
                                                %>
                                                    <p class="name"><%=setName%></p>
                                                </div>
                                            </a>
                                        </li>
                                        <%
                                        }
                                        %>
                                    </ul>
                                </div>
                            </div> --%>


                        </dd>
                    </dl>
                </div>
<%
}//-- if(isCateCode){
%>
                </form>
<%
if(deliveryNoticeList != null && !deliveryNoticeList.isEmpty() ){
%>
                <div class="detail_inner cbg">
                    <dl>
                        <dt>��۾ȳ�</dt>
                        <dd class="goods_detail4">
                            <table>
                                <colgroup>
                                    <col width="23%"/>
                                    <col width="*"/>
                                </colgroup>
                                <tbody>
<%
    for(Map nMap : deliveryNoticeList){
%>
                                    <tr>
                                        <th><%=nMap.get("title") %></th>
                                        <td><%=nMap.get("content") %></td>
                                    </tr>
<%
    }
%>
                                </tbody>
                            </table>
                        </dd>
                    </dl>
                </div>
<%
}
if(productNoticeList != null && !productNoticeList.isEmpty() ){
%>
                <div class="detail_inner cbg">
                    <dl>
                        <dt>��ǰ���� �������</dt>
                        <dd class="goods_detail5">
                            <table>
                                <colgroup>
                                    <col width="23%"/>
                                    <col width="*"/>
                                </colgroup>
                                <tbody>
<%
    for(Map nMap : productNoticeList){
%>
                                    <tr>
                                        <th><%=nMap.get("title") %></th>
                                        <td><%=nMap.get("content") %></td>
                                    </tr>
<%
    }
%>
                                </tbody>
                            </table>
                        </dd>
                    </dl>
                </div>
<%
}
%>
            </div>
        </div>
    </div>
    <!-- End container -->
    <%@ include file="/common/include/inc-cart.jsp"%>
    <div id="footer">
        <%@ include file="/common/include/inc-footer.jsp"%>
    </div>
    <!-- End footer -->
    <div id="floatMenu" class="ov">
        <%@ include file="/common/include/inc-floating.jsp"%>
    </div>
</div>

</body>
<script>
var GroupCode = '<%=groupCode%>';
var SaleTotalPrice = "";
var GoodsTotalPrice = "";
var IsDevlWeek = <%=isDevlWeek%>;
var SalePrice = <%=salePrice%>;
var GoodsPrice = <%=groupPrice%>;
var CouponeSalePrice = <%=couponeSalePrice%>;
var CouponSaleType = "<%=couponMaxSaleType%>";
var Hour =  new Date().getHours();
var MinDate = <%=devlFirstDay%>;
var Gubun1 = "<%=gubun1%>";
var Gubun2 = "<%=gubun2%>";
var DevlType = "<%=devlGoodsType%>";//    �Ϲ�:0001,�ù�:0002

//if(GroupCode == "0301369" || GroupCode == "0301590" || GroupCode == "0301079"){ // 3�� ���ĵǸ� 1���� ���Ѵ�.
    if(Hour >= 15){
        MinDate += 1;
    }
//}

var groupCode = "<%=groupCode%>";	//	150 ����ƾ��
$(document).ready(function() {

    if(IsDevlWeek){
        /* 170624 : ��û�� ���� ��ü��ǰ ���� */
        if(true || GroupCode != "0331"){
            $('#selectDevlWeek > option[value="2"]').attr('selected', 'true');
        }

        if(Gubun1 != "02"){
            $("#devlDay").val($('#selectDevlDay option:selected').val());
            $("#devlWeek").val($('#selectDevlWeek option:selected').val());
        }
        else{
			if(Gubun2 == "51"){
				$("#devlDay").val($('#selectDevlDay option:selected').val());
				$("#devlWeek").val($('#selectDevlWeek option:selected').val());
			} else {
				$("#devlDay").val($('#selectDevlDay').val());
				$("#devlWeek").val($('#selectDevlWeek').val());
			}
        }

        if($("input:checkbox[id='buy_bag']").is(":checked") == true){
            $("#buyBagYn").val("Y");
        }else if($("input:checkbox[id='buy_bag']").is(":checked") == false){
            $("#buyBagYn").val("N");
        }

        if($("input:checkbox[id='buy_weekend']").is(":checked") == true){
            $("#devlWeekEnd").val("1");
        }else if($("input:checkbox[id='buy_weekend']").is(":checked") == false){
            $("#devlWeekEnd").val("0");
        }
    }

	if("0301844" == groupCode){	// 150 ����ƾ��
		$("a").attr("onfocus", "this.blur()");	
		SalePrice = SalePrice / 5;
		setBuyQtyVal();
	}

    forCoupon();
});


// �ֹ��� ��ǰ�� �ش�Ǵ� ���� �����ֱ� �� �ִ� ���� �ݾ� ���
function forCoupon(){
    $(".event_area").hide();// ��� ��밡���� ���� �����ֱ�
    var orderWeekSize = <%=aryOrderWeek.size()%>;
    var orderWeek  = $("#selectDevlWeek").val(); // ������ ��� �Ⱓ

    var paramVala = 0;
    var paramValb = 0;	// ���ΰ���
    var valueR = 0;

	var buyQty = 0;
	var goodsTotalPrice = 0;

    for(var r=0; r<orderWeekSize; r++){
        var cp_value = $("#cp_" + r).attr('value');// ���� �ֹ� �Ⱓ
        var UseGoods = $("#cp_" + r).attr('usegoods');// ���� ����(��ü, Ư��, �Ϲ�, �ù�)

		var uselimitcnt = $("#cp_" + r).attr('uselimitcnt');// ���� ��밡�� ���� ����
		var uselimitprice = $("#cp_" + r).attr('uselimitprice');// ���� ��밡�� ���� ����

		if(IsDevlWeek && Gubun1 != "02"){
			buyQty = parseInt($("#buyQty").val());
			goodsTotalPrice = GoodsPrice * parseInt($("#devlWeek").val()) * ( parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val()) ) * parseInt($("#buyQty").val());
		}else{
			if(Gubun2 == "51"){
				buyQty = parseInt($("#buyQty").val());
				goodsTotalPrice = GoodsPrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val());
			} else if("0301844" == groupCode){	// 150 ����ƾ��
				var pBuyQty		= parseInt($("#p_buy_qty").val());
				var pTotalPrice	=  Math.round(parseFloat( parseInt($("#price").val()) / 5 )) * pBuyQty;
				
				buyQty = pBuyQty;
				goodsTotalPrice = pTotalPrice;

			} else {
				buyQty = parseInt($("#buyQty").val());
				goodsTotalPrice = GoodsPrice * parseInt($("#buyQty").val());
			}
		}

		if( uselimitcnt <= buyQty && uselimitprice <= goodsTotalPrice ){
			// 1 ��ü��ǰ�� ���� ��밡��
			if(UseGoods == 1){
				if(DevlType == "0002"){    // �ù�
					//$("#cp_" + r).show();
					//��������
					if($("#cp_" + r).attr('atype') == "W"){        //��������
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = Math.round( ( SalePrice * parseInt($("#p_buy_qty").val()) * CouponeSalePrice ) / 100 );   
							} else {
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
							}
						}
					}            
				}else if(cp_value.indexOf(orderWeek) > -1){    // �Ϲ�
					//$("#cp_" + r).show();
					//��������
					if($("#cp_" + r).attr('atype') == "W"){        //��������
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
						
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							} else {
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
							}
						}
					}
				}
				else{
					//$("#cp_" + r).hide();
				}
			}
			// 2 Ư�� ��ǰ���� ���� ��밡��
			if(UseGoods == 2){
				if(DevlType == "0002"){    // �ù�
					//$("#cp_" + r).show();
					//��������
					if($("#cp_" + r).attr('atype') == "W"){        //��������
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = Math.round( ( SalePrice * parseInt($("#p_buy_qty").val()) * CouponeSalePrice ) / 100 );   
							} else {
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
							} 
						}
					}            
				}else if(cp_value.indexOf(orderWeek) > -1){    // �Ϲ�
					//$("#cp_" + r).show();
					//��������
					if($("#cp_" + r).attr('atype') == "W"){        //��������
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;					
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							} else {
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
							}
						}
					}
				}
				else{
					//$("#cp_" + r).hide();
				}
			}
			// 3 �Ϲ� ��ǰ ��ü ��밡��
			if(UseGoods == 3){
				if(DevlType == "0001"){// ���û�ǰ�� �Ϲ�
					if(cp_value.indexOf(orderWeek) > -1){
						//$("#cp_" + r).show();
						//��������
						if($("#cp_" + r).attr('atype') == "W"){        //��������
							if(IsDevlWeek && Gubun1 != "02"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = CouponeSalePrice;
							}else{
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb    = CouponeSalePrice;
							}
						}else{    //�ۼ�Ʈ����
							if(IsDevlWeek && Gubun1 != "02"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							}else{
								if(Gubun2 == "51"){
									var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
									paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
								} else {
									var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
									paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
								} 
							}
						}
					}
					else{
						//$("#cp_" + r).hide();
					}
				}
				else{
					//$("#cp_" + r).hide();
				}
			}
			//  4 �ù� ��ǰ ��ü ��밡��
			if(UseGoods == 4){
				if(DevlType == "0002"){
					//$("#cp_" + r).show();
					//��������
					if($("#cp_" + r).attr('atype') == "W"){        //��������
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    
						if(IsDevlWeek && Gubun1 != "02"){
							var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
							paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = Math.round( ( SalePrice * parseInt($("#p_buy_qty").val()) * CouponeSalePrice ) / 100 );   
							} else {
								var CouponeSalePrice = Number($("#cp_" + r).attr('data'));
								paramValb = ( SalePrice * parseInt($("#buyQty").val()) * CouponeSalePrice ) / 100;    
							}  
						}
					}
				}
				else{
					//$("#cp_" + r).hide();
				}
			}
		}

        // �� ��
        if(paramVala < paramValb){
            paramVala = paramValb;
            valueR = r;
		}
    }    // the end of for

    //���ȣ��
	if(paramVala > 0){
		$("#cp_" + valueR).show();
	}
	CalAmount(paramVala);
        
}
//////////////

$("#buy_bag").change(function(){
   
    if($(this).is(":checked") == true){
        $("#buyBagYn").val("Y");
           forCoupon();
    }else{
        if (confirm("�ż��� ��ǰ ����� ���ؼ��� ���ð�����\r\n�� �ʿ��մϴ�.\r\nüũ�ڽ��� ���� �Ͻðڽ��ϱ�?")){
            $("#buyBagYn").val("N");
            forCoupon();
        } else {
            $(this).prop("checked", true);
        }
    }
});

$("#buy_weekend").change(function(){
    if($(this).is(":checked") == true){
        $("#devlWeekEnd").val("1");
           forCoupon();

    }else{
        $("#devlWeekEnd").val("0");
        forCoupon();
    }
});

Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};


var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
    holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
$(".date-pick").datepick({
    dateFormat: "yyyy.mm.dd",
    minDate: MinDate,
    showTrigger: '#calImg',
    showAnim: 'slideDown',
    changeMonth: false,
    onDate: function(date) {
        var currentYear = date.getFullYear(),
            currentMonth = date.getMonth()+1,
            currentDate = date.getDate(),
               currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);

           for (i = 0; i < holiDays.length; i++) {
               if (currentToday == holiDays[i]) {
                   return {dateClass: '-holiday-', selectable: false};
               }
           }
        return {};
    }
});

        //     $('#pop_scheduler').data('datepicker');
    $(":input").filter(".only_number").css("imeMode", "disabled").keypress(function(event){
        if (event.which && (event.which < 48 || event.which > 57)){
            event.preventDefault();
        }
    });


    // �ɼǺ��� ��������
    var QuantityFn = {
        onSet : function(i){
            $("#buyQty").val(i);
        },
        plus : function(){
            var $val = $("#buyQty").val();
            var i = Number($val)+1;
            QuantityFn.onSet(i);
               forCoupon();
        },
        minus : function(){
            var $val = $("#buyQty").val();
            var i = Number($val)-1;
            if(i < 1) {
                alert("������ 1�� �̻� �������ּ���.");
                return false;
               }else{
                   QuantityFn.onSet(i);
               
                      forCoupon();
               }
        }
    }
    var QuantityFn2 = {
            onSet : function(i2){
                $("#buyQty2").val(i2);
            },
            plus : function(){
                var $val2 = $("#buyQty2").val();
                var i2 = Number($val2)+1;
                QuantityFn2.onSet(i2);
               
                   forCoupon();
            },
            minus : function(){
                var $val2 = $("#buyQty2").val();
                var $val3 = $("#buyQty3").val();
                var i2 = Number($val2)-1;
                var i3 = Number($val3);
                if(i2 < 1) {
                    i2 = 0;
                   }
                if((i2+i3) < 2) {
                    alert("�ּ� �ֹ��� 5Set���� �����մϴ�.");
                    return false;
                   }else{
                       QuantityFn2.onSet(i2);
                   
                          forCoupon();
                   }
            }
        }
    var QuantityFn3 = {
            onSet : function(i3){
                $("#buyQty3").val(i3);
            },
            plus : function(){
                var $val3 = $("#buyQty3").val();
                var i3 = Number($val3)+1;
                QuantityFn3.onSet(i3);
               
                   forCoupon();
            },
            minus : function(){
                var $val2 = $("#buyQty2").val();
                var $val3 = $("#buyQty3").val();
                var i2 = Number($val2);
                var i3 = Number($val3)-1;
                if(i3 < 0) {
                    i3 = 0;
                   }
                if((i2+i3) < 2) {
                    alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
                    return false;
                   }else{
                       QuantityFn3.onSet(i3);
                   
                          forCoupon();
                   }
            }
        }

    // 3�� 5�� ����
    var OptionWeek = {"week3":"<%=devlWeek3%>","week5":"<%=devlWeek5%>"};
       $('#selectDevlDay').change(function(){
           var arrOptionWeek = OptionWeek["week"+$(this).find("option:selected").val()].split(",");
           $("#selectDevlWeek option").remove();
           for(var forCt = 0; forCt < arrOptionWeek.length; forCt++){
               $('#selectDevlWeek').append("<option value='" + arrOptionWeek[forCt] + "'>" + arrOptionWeek[forCt] + "��</option>");
           }
           $('#selectDevlWeek > option[value="2"]').attr('selected', 'true');
           $("#devlWeek").val($("#selectDevlWeek option:selected").val());
           $("#devlDay").val($('#selectDevlDay option:selected').val());
        forCoupon();
    });

    // ��۱Ⱓ ���ý� ���� �ǽð����� ����
    $('#selectDevlWeek').change(function(){
       $("#devlWeek").val($('#selectDevlWeek option:selected').val());
        forCoupon();
    });

    // ���� ���� �Է½�
    $('#buyQty').on("keyup",function(e) {
        var ct = $(this).val();
        if(isNaN(ct) || 1 > parseInt(ct)){
            $('#buyQty').val(1);
        }
       
        forCoupon();
    });

    //�޸� ���� �ٿ��ֱ�
    function totalComma(total){
        total = total + "";
        point = total.length % 3 ;
        len = total.length;
        str = total.substring(0, point);
        while (point < len) {
            if (str != "") str += ",";
            str += total.substring(point, point + 3);
            point += 3;
        }
        return str;
    }

    //-- �ݾ��� ����Ѵ�.
    function CalAmount(paramVal){

        if(paramVal != "cnt"){
            CouponeSalePrice = paramVal;
        }
        if(GroupCode == "0300993"){ //-- �̴Ϲ��ϰ�� �ѽ�,��ļ�Ʈ�� ����
               SaleTotalPrice    = SalePrice * (parseInt($("#buyQty2").val()) + parseInt($("#buyQty3").val()));
               if(SalePrice != GoodsPrice){
                   GoodsTotalPrice    = GoodsPrice * (parseInt($("#buyQty2").val()) + parseInt($("#buyQty3").val()));
               }
        }
        else{
            if(IsDevlWeek && Gubun1 != "02"){ //-- ����üũ�̸鼭 ���α׷����̾�Ʈ�� �ƴѻ�ǰ
                /*if ( CouponSaleType == "P" ) {
                    SaleTotalPrice    = (SalePrice- CouponeSalePrice) * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val());
                } else {
                    SaleTotalPrice    = SalePrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val()) - CouponeSalePrice;
                }*/
				GoodsTotalPrice    = GoodsPrice * parseInt($("#devlWeek").val()) * (parseInt($("#devlDay").val()) + parseInt($("#devlWeekEnd").val())) * parseInt($("#buyQty").val());
		   }else{
				if(Gubun2 == "51") {
					GoodsTotalPrice    = GoodsPrice * parseInt($("#devlWeek").val()) * parseInt($("#buyQty").val());
				} else if("0301844" == groupCode){	// 150 ����ƾ��
					GoodsTotalPrice    = (GoodsPrice  / 5) * parseInt($("#p_buy_qty").val());
				} else {
					GoodsTotalPrice    = GoodsPrice * parseInt($("#buyQty").val());
				}				
		   }
        }
        $("#totalPrice").val(GoodsTotalPrice);

        $("#orgPrice").html("");
        $("#sumPrice").html("");
  
//        if(SalePrice != GoodsPrice){
//            $("#orgPrice").html(totalComma(GoodsTotalPrice)+"��");
//            $("#sumPrice").html(totalComma(GoodsTotalPrice-CouponeSalePrice)+"��");
//        }
		if(CouponeSalePrice > 0){
            $("#orgPrice").html(totalComma(GoodsTotalPrice)+"��");
             $("#sumPrice").html(totalComma(GoodsTotalPrice-CouponeSalePrice)+"��");
        }else{
             $("#sumPrice").html(totalComma(GoodsTotalPrice)+"��");
        }
    }

    var eslMemberId = '<%=eslMemberId%>';
    $("#btnProductViewForm").click(function(){	// ��ٱ��� ���
           if(eslMemberId != ""){
             if(IsDevlWeek && $("#day").val() == ""){
                 alert("������� ������ �ּ���.");
             }
             else{
                 if(IsDevlWeek && Gubun1 != "02"){
                     $("#devlDay").val($('#selectDevlDay option:selected').val());
                     $("#devlWeek").val($('#selectDevlWeek option:selected').val());
                 }
                 else{
					if(Gubun2 == "51"){
						$("#devlDay").val($('#selectDevlDay option:selected').val());
						$("#devlWeek").val($('#selectDevlWeek option:selected').val());
					} else {
						$("#devlDay").val($('#selectDevlDay').val());
						$("#devlWeek").val($('#selectDevlWeek').val());
					}					 
                 }

                var queryString = $("form[name=productViewForm]").serialize() ;

                $.ajax({
                    url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp",
                    type : 'post',
                    data : queryString,
                    dataType : "json",
                    async : true,
                    success : function(data){
                        if(data.code == "success"){
                            top.location.reload();
                            //$(".jquery-lightbox-button-close").click();
                        }
                        else{
                            alert(data.data);
                        }
                    },
                    error : function(a,b,c){
                        alert('error : ' + c);
                        moving = false;
                    }
                })
             }
           }else{
               alert("�α����� ���� �Ͻñ� �ٶ��ϴ�.");
               var url = "/shop/popup/loginCheck.jsp";
               $.lightbox(url, {
                width  : 640,
                height : 740
            });
           }

    });

    $(".btn_go_order").click(function(){
           if(eslMemberId != ""){
             if(IsDevlWeek && $("#day").val() == ""){
                 alert("������� ������ �ּ���.");
             }
             else{

                 if(IsDevlWeek && Gubun1 != "02"){
                     $("#devlDay").val($('#selectDevlDay option:selected').val());
                     $("#devlWeek").val($('#selectDevlWeek option:selected').val());
                 }
                 else{
					if(Gubun2 == "51"){
						$("#devlDay").val($('#selectDevlDay option:selected').val());
						$("#devlWeek").val($('#selectDevlWeek option:selected').val());
					} else {
						$("#devlDay").val($('#selectDevlDay').val());
						$("#devlWeek").val($('#selectDevlWeek').val());
					}
                 }

                var queryString = $("form[name=productViewForm]").serialize() ;

                $.ajax({
                    url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp?cart_type=L",
                    type : 'post',
                    data : queryString,
                    dataType : "json",
                    async : true,
                    success : function(data){
                        if(data.code == "success"){
                            location.href='/shop/order.jsp?mode=L';
                            //$(".jquery-lightbox-button-close").click();
                        }
                        else{
                            alert(data.data);
                        }
                    },
                    error : function(a,b,c){
                        alert('error : ' + c);
                        moving = false;
                    }
                })
             }
           }else{
               alert("�α����� ���� �Ͻñ� �ٶ��ϴ�.");
               var url = "/shop/popup/loginCheck.jsp";
               $.lightbox(url, {
                width  : 640,
                height : 740
            });
           }

    });

</script>

<!-- 150 ����ƾ�� ���� -->
<script type="text/javascript">
function setPlus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty < 99) buyQty		+= 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	forCoupon();
}

function setMinus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty > 0) buyQty		= buyQty - 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	if (tcnt < 5) {
		alert("�ּ� �ֹ��� 5Set���� �����մϴ�.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}
	tcnt	= setTcnt();
	forCoupon();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val()) + parseInt($("#buy_qty3").val()) + parseInt($("#buy_qty4").val()) + parseInt($("#buy_qty5").val());
	$("#p_buy_qty").val(tcnt);

	return tcnt;
}

// ���� 1�� �ʱ�ȭ
function setBuyQtyVal() {
	$("input[name='buy_qty']").each(function() {
	   $(this).val('1');
	});
}
</script>
<!-- 150 ����ƾ�� �� -->

<!-- Enliple Shop Log Tracker v3.5 start -->
<script type="text/javascript">
<!--
function mobRfShop(){
  var sh = new EN();      
  // [��ǰ������]

  var soldOut = '<%=soldOut %>';
  var mobSoldOut;
  if(soldOut == 'Y'){
	mobSoldOut = 1;
  }else{
	mobSoldOut = 2;
  }
  var mobGroupName = '<%=groupName %>';
  var cartImg = '<%=cartImg %>';
  
  //var imgUrl = 'http://dev.eatsslim.co.kr<%=webUploadDir%>' +'goods/'+ encodeURIComponent(cartImg);
  var imgUrl = 'http://www.eatsslim.co.kr<%=webUploadDir%>' + 'goods/' + encodeURIComponent(cartImg);

  sh.setData("sc", "995f3de777d1894591fafb3feb1a673b");
  sh.setData("userid", "eatsslim");
  sh.setData("pcode", $("#groupCode").val());
  sh.setData("price", $("#price").val());
  sh.setData("pnm", encodeURIComponent(encodeURIComponent(mobGroupName)));
  sh.setData("img", imgUrl);
  //sh.setData("dcPrice", $("#totalPrice").val()); // �ɼ� 
  sh.setData("soldOut", mobSoldOut); //�ɼ� 1:ǰ��,2:ǰ���ƴ�
  //sh.setData("mdPcode", "��õ��ǰ�ڵ�1,��õ��ǰ�ڵ�2,��"); //�ɼ� 
  //sh.setData("cate1", encodeURIComponent(encodeURIComponent("ī�װ� �ڵ� �Ǵ� �̸�"))); //�ɼ�
  sh.setSSL(true);
  sh.sendRfShop();
 
  // ��ٱ��� ��ư Ŭ�� �� ȣ�� �޼ҵ�(������� �ʴ� ��� ����)
  document.getElementById("btnProductViewForm").onmouseup = sendCart;
  function sendCart() {
    sh.sendCart();
  }
  // ��,Wish ��ư Ŭ�� �� ȣ�� �޼ҵ�(������� �ʴ� ��� ����)
  //document.getElementById("wishBtn").onmouseup = sendWish;
  //function sendWish() {
  //  sh.sendWish();
  //}

} 
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobRfShop()"></script>
<!-- Enliple Shop Log Tracker v3.5 end  -->

</html>



