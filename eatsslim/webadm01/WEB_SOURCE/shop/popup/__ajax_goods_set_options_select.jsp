<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
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

String query		= "";
String query1		= "";
String query2		= "";
String query3		= "";
String query4		= "";
int noticeId		= 0;
String topYn		= "";
String title		= "";
String bannerImg 	= "";
String clickLink 	= "";
String content		= "";
String listImg		= "";
int maxLength		= 0;
String imgUrl		= "";
String instDate 	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String cartId		= ut.inject(request.getParameter("cartId"));
String groupId		= ""; // ut.inject(request.getParameter("cartId"));
String devlType		= ""; // ut.inject(request.getParameter("devlType"));
String groupName    = ""; // ut.inject(request.getParameter("groupName"));
String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice	    = 0;  //ut.inject(request.getParameter("groupPrice"));
int totalPrice      = 0;  //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
int salePrice      = 0;

String devlGoodsType			= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";

String[] arrDevlWeek3 = null;
String[] arrDevlWeek5 = null;
boolean isDevlWeek = false;

Map<String, Object> cartMap = new HashMap(); //-- ��ٱ�������
List<Map> infoNoticeList = new ArrayList(); //-- ��ǰ����

Statement stmt1		= null;
ResultSet rs1		= null;
Statement stmt2		= null;
ResultSet rs2		= null;
Statement stmt3		= null;
ResultSet rs3		= null;
Statement stmt4		= null;
ResultSet rs4		= null;
stmt1				= conn.createStatement();
stmt2				= conn.createStatement();
stmt3				= conn.createStatement();
stmt4				= conn.createStatement();
String gubun1	  = "";
// String groupName  = "";
String groupInfo = "";
// String groupInfo1 = "";
String saleTitle    = "";
String aType 	  = "";
String bType 	  = "";
int kalInfo		  = 0;
int groupPrice1   = 0;
// int totalPrice	  = 0;
int bTypeNum	  = 0;
String cartImg	  = "";
String groupImg	  = "";
String groupCode  = "";
String gubun2	  = "";
String tag		  = "";
double dBtype;
int bagCnt			= 0;
int payPrice		= 0;

ArrayList<String> aryOrderWeek = new ArrayList<String>();
ArrayList<Integer> aryUseGoods = new ArrayList<Integer>();
ArrayList<String> aryCouponName = new ArrayList<String>();
ArrayList<String> aryPer = new ArrayList<String>();
ArrayList<String> aryW = new ArrayList<String>();

ArrayList<Integer> useLimitCnt = new ArrayList<Integer>();
ArrayList<Integer> useLimitPrice = new ArrayList<Integer>();

String soldOut            = "";    // Ǯ�� ó��

//-- ��ٱ��� ����
query		= "SELECT ID,  MEMBER_ID,  GROUP_ID,  BUY_QTY,  DEVL_TYPE,  DEVL_DAY,  DEVL_WEEK,  DEVL_DATE,  PRICE,  INST_DATE,  BUY_BAG_YN,  CART_TYPE,  ORDER_YN,  SS_TYPE ";
query		+= " FROM ESL_CART ";
query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ID = "+ cartId;
rs1	= stmt.executeQuery(query);
if(rs1.next()){
	cartMap.put("ID",				rs1.getString("ID"));
	cartMap.put("MEMBER_ID",		rs1.getString("MEMBER_ID"));
	cartMap.put("GROUP_ID",			rs1.getString("GROUP_ID"));
	cartMap.put("BUY_QTY",			rs1.getString("BUY_QTY"));
	cartMap.put("DEVL_TYPE",		rs1.getString("DEVL_TYPE"));
	cartMap.put("DEVL_DAY",			rs1.getString("DEVL_DAY"));
	cartMap.put("DEVL_WEEK",		rs1.getString("DEVL_WEEK"));
	cartMap.put("DEVL_DATE",		rs1.getString("DEVL_DATE"));
	cartMap.put("PRICE",			rs1.getString("PRICE"));
	cartMap.put("BUY_BAG_YN",		rs1.getString("BUY_BAG_YN"));
	groupId = rs1.getString("GROUP_ID");
}
else{
	out.println("��ٱ��� ������ �����ϴ�.");
	return;
}
rs1.close();

//-- ��ǰ����
query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
query		+= " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = "+ groupId;
rs1	= stmt.executeQuery(query);
while(rs1.next()){
	Map noticeMap = new HashMap();
	noticeMap.put("id",rs1.getString("ID"));
	noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
	noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
	infoNoticeList.add(noticeMap);
}
rs1.close();

/*
query4		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
try {
	rs4	= stmt4.executeQuery(query4);
} catch(Exception e) {
	out.println(e+"=>"+query4);
	if(true)return;
}

if (rs4.next()) {
	bagCnt		= rs4.getInt("PURCHASE_CNT");
}
*/

//-- ��ǰ ����
query		= "SELECT ";
query		+= " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query		+= "  GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, SOLD_OUT";
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= "  WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND ID=" + groupId;
rs1 = stmt1.executeQuery(query);
if(rs1.next()){
	saleTitle	= ut.isnull(rs1.getString("SALE_TITLE") );
	aType		= rs1.getString("ATYPE");
	bType		= rs1.getString("BTYPE");
	gubun1		= rs1.getString("GUBUN1");
	groupCode	= rs1.getString("GROUP_CODE");
	groupName   = rs1.getString("GROUP_NAME");
	groupPrice  = rs1.getInt("GROUP_PRICE");
	groupPrice1 = rs1.getInt("GROUP_PRICE1");
	groupInfo	= rs1.getString("GROUP_INFO");
	groupInfo1  = rs1.getString("GROUP_INFO1");
	kalInfo 	= rs1.getInt("KAL_INFO");
	cartImg		= rs1.getString("CART_IMG");
	groupImg	= rs1.getString("GROUP_IMGM");
	gubun2		= rs1.getString("GUBUN2");
	tag			= rs1.getString("TAG");
	devlGoodsType			= ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );
	devlFirstDay		= ut.isnull(rs1.getString("DEVL_FIRST_DAY") );
	devlModiDay			= ut.isnull(rs1.getString("DEVL_MODI_DAY") );
	devlWeek3			= ut.isnull(rs1.getString("DEVL_WEEK3") );
	devlWeek5			= ut.isnull(rs1.getString("DEVL_WEEK5") );
	soldOut                = ut.isnull(rs1.getString("SOLD_OUT") );

	if(!ut.isNaN(devlFirstDay) || "".equals(devlFirstDay) ) devlFirstDay = "0";
	if(!ut.isNaN(devlModiDay) || "".equals(devlModiDay) ) devlModiDay = "0";

	if(!"".equals(devlWeek3)){
		arrDevlWeek3 = devlWeek3.split(",");
		isDevlWeek = true;
	}
	if(!"".equals(devlWeek5)){
		arrDevlWeek5 = devlWeek5.split(",");
		isDevlWeek = true;
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
}

String cpColumns	= " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE, C.ORDERWEEK, C.USE_GOODS, C.USE_LIMIT_CNT, C.USE_LIMIT_PRICE";
String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere		= "";

// ���� ����
cpWhere				= "  WHERE C.ID = CM.COUPON_ID";
cpWhere				+= " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
cpWhere				+= " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

// ���� ����
query        = "SELECT * FROM (";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "        AND USE_GOODS = '01'";
query        += "    UNION";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "        AND USE_GOODS IN ('03','04')";
query        += "    UNION";
query        += "    SELECT "+ cpColumns;
query        += "        FROM "+ cpTable;
query        +=            cpWhere;
query        += "        AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
query        += "        ) X ";
//query1        += " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
//query1        += " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
try {
	rs1 = stmt1.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

String couponSaleType		= "";
String couponMaxSaleType	= "";
String couponName		= "";
int couponeSalePrice	= 0;
int couponPrice			= 0;
int couponTmpPrice		= 0;
int couponMaxPrice		= 0;
while (rs1.next()) {
	couponSaleType	= rs1.getString("SALE_TYPE");
	couponeSalePrice 	= rs1.getInt("SALE_PRICE");
    aryPer.add(String.valueOf(couponeSalePrice));
    aryW.add(couponSaleType);
    aryOrderWeek.add(rs1.getString("ORDERWEEK"));
    aryUseGoods.add(rs1.getInt("USE_GOODS"));
    aryCouponName.add(rs1.getString("COUPON_NAME"));
	useLimitCnt.add(rs1.getInt("USE_LIMIT_CNT"));
	useLimitPrice.add(rs1.getInt("USE_LIMIT_PRICE"));

	if (couponSaleType.equals("W")) {
		couponTmpPrice		= couponeSalePrice;
	} else {
		couponTmpPrice		= Integer.parseInt(String.valueOf(Math.round((double)groupPrice * (double)couponeSalePrice / 100)));
	}
	
	if("02".equals(gubun1)) {
		if (couponMaxPrice < couponTmpPrice) {
			couponMaxPrice = couponTmpPrice;
			couponPrice = couponTmpPrice;
			couponName	= rs1.getString("COUPON_NAME");
			couponMaxSaleType	= rs1.getString("SALE_TYPE");
		}
	} else {
		if (couponSaleType.equals("W")) {
			if (couponMaxPrice < couponTmpPrice) {
				couponMaxPrice = couponTmpPrice;
				couponPrice = couponTmpPrice;
				couponName	= rs1.getString("COUPON_NAME");
				couponMaxSaleType	= rs1.getString("SALE_TYPE");
			}
		} else {
			if ( devlGoodsType.equals("0001") ) {
				if (couponMaxPrice < couponTmpPrice * 10) {
					couponMaxPrice = couponTmpPrice * 10;
					couponPrice = couponTmpPrice;
					couponName	= rs1.getString("COUPON_NAME");
					couponMaxSaleType	= rs1.getString("SALE_TYPE");
				}
			} else {
				if (couponMaxPrice < couponTmpPrice) {
					couponMaxPrice = couponTmpPrice;
					couponPrice = couponTmpPrice;
					couponName	= rs1.getString("COUPON_NAME");
					couponMaxSaleType	= rs1.getString("SALE_TYPE");
				}
			}
		}
	}
}
rs1.close();

if("0300993".equals(groupCode) ){ //-- �̴Ϲ��ϰ�� �ѽļ���,��ļ����� ���Ѵ�.
	//-- �ѽļ���
	query		= "SELECT BUY_CNT ";
	query		+= " FROM ESL_CART_DELIVERY ";
	query		+= " WHERE GROUP_CODE = '0301000' AND CART_ID = "+ cartId;
	rs1	= stmt.executeQuery(query);
	if(rs1.next()){
		cartMap.put("BUY_QTY2",rs1.getString("BUY_CNT"));
	}
	else{
		cartMap.put("BUY_QTY2","0");
	}
	rs1.close();

	//-- ��ļ���
	query		= "SELECT BUY_CNT ";
	query		+= " FROM ESL_CART_DELIVERY ";
	query		+= " WHERE GROUP_CODE = '0301001' AND CART_ID = "+ cartId;
	rs1	= stmt.executeQuery(query);
	if(rs1.next()){
		cartMap.put("BUY_QTY3",rs1.getString("BUY_CNT"));
	}
	else{
		cartMap.put("BUY_QTY3","0");
	}
	rs1.close();

}

DecimalFormat df 	= new DecimalFormat("#,###");

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
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>�ɼ� ����</title>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/dist/images/ico/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;">
</div>
	<div class="pop-wrap ff_noto">
		<div class="headpop">
		    <h2>�ɼ� ����</h2>
		</div>
	    <div class="contentpop">
			<div id="setOptionsCal">
        		<form action="" name="optionForm">
					<!-- 150 ����ƾ�� ���� -->
					<input type="hidden" name="price" id="price" value="<%=groupPrice%>" />
					<input type="hidden" name="p_buy_qty" id="p_buy_2_qty" value="<%=cartMap.get("BUY_QTY")%>" />
					<!-- 150 ����ƾ�� �� -->
			        <input type="hidden" name="devlWeek" id="opt_devlWeek" value="">
			        <input type="hidden" name="devlDay" id="opt_devlDay" value="">
					<input type="hidden" name="devlWeekEnd" id="opt_devlWeekEnd" value="">
			        <input type="hidden" name="groupId" id="opt_groupId" value="<%=groupId%>">
			        <input type="hidden" name="groupCode" id="opt_groupCode" value="<%=groupCode%>">
			        <input type="hidden" name="devlType" id="opt_devlType" value="<%=devlGoodsType%>">
		        	<input type="hidden" name="buyBagYn" id="opt_buyBagYn" value="<%=cartMap.get("BUY_BAG_YN")%>">
		        	<input type="hidden" name="pcAndMobileType" id="opt_pcAndMobileType" value="pc">
					<input type="hidden" name="totalPrice" id="opt_totalPrice" value="">
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
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="3">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="<%=devlWeek3%>">
<%
			}
			else{
%>
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="5">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="<%=devlWeek5%>">
<%
			}
		}
		else{
%>
						<tr>
							<th>��� ����</th>
							<td>
							<div class="opt_select_group selectWrap" id="opt_selectDevlDay" name="selectDevlDay">
								<select name="selectDevlDay" id="opt_selectDevlDay" class="notCustom">
									<% if(arrDevlWeek5 != null){ %><option value="5"<%="5".equals((String)cartMap.get("DEVL_DAY")) ? " selected":"" %>>�� 5ȸ (��~��)</option><% } %>
									<% if(arrDevlWeek3 != null){ %><option value="3"<%="3".equals((String)cartMap.get("DEVL_DAY")) ? " selected":"" %>>�� 3ȸ (��/��/��)</option><% } %>
								</select>
							</div>
							</td>
						</tr>
						<tr>
							<th>��� �Ⱓ</th>
							<td>
							<div class="selectWrap">
							<select name="selectDevlWeek" id="opt_selectDevlWeek" class="notCustom">
<%
			String[] arrFor = null;
			if("5".equals((String)cartMap.get("DEVL_DAY"))){
				arrFor = arrDevlWeek5;
			}
			else{
				arrFor = arrDevlWeek3;
			}
			for(int forCt = 0; forCt < arrFor.length;forCt++){
%>
								<option value="<%=arrFor[forCt]%>"<%=arrFor[forCt].equals((String)cartMap.get("DEVL_WEEK")) ? " selected":"" %>><%=arrFor[forCt]%>��</option>
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
				        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="<%=cartMap.get("BUY_QTY")%>">
				        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
				        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
				        		</div>
							</td>
						</tr>
						<tr>
							<th>ù �����</th>
							<td>
								<div class="inp_datepicker">
									<input type="text" id="opt_day" name="day" class="dp-applied opt-date-pick" readonly value="<%=cartMap.get("DEVL_DATE")%>"/>
								</div>
							</td>
						</tr>
						<% if("0301590".equals(groupCode)){ %>	
						<tr>
							<th>�ָ��Ĵ�</th>
							<td>
								<div class="inp_thermos">
									<input type="checkbox" id="opt_buy_weekend" name="buy_weekend" checked="checked"/>
									<label for="opt_buy_weekend">�� ����</label>
									<p>�ָ��Ĵ��� �ݿ��Ͽ� �Բ� ��۵˴ϴ�.</p>
								</div>
							</td>
						</tr>
						<% } %>
						<tr>
							<th>���ð���</th>
							<td>
								<div class="inp_thermos">

									<p>�ֹ��Ͻ� �Ĵ��� �ս��� ���� �뿩�� ���ð���� �Բ� �ż��ϰ� ��۵˴ϴ�.</p>
								</div>
							</td>
						</tr>
<%
} //if(devlGoodsType.equals("0001")){
else{
%>
						<input type="hidden" name="selectDevlDay" id="opt_selectDevlDay" value="0">
						<input type="hidden" name="selectDevlWeek" id="opt_selectDevlWeek" value="0">
						<tr>
							<th>����</th>
							<td>
				        		<ul>
<% if(!"0301844".equals(groupCode)){ %>
									<li>
										<div class="inp_quantity">
						        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="opt_buyQty" value="<%=cartMap.get("BUY_QTY")%>">
						        			<button type="button" class="inp_qtt_minus" onclick="optQuantityFn.minus();">-</button>
						        			<button type="button" class="inp_qtt_plus" onclick="optQuantityFn.plus();">+</button>
						        		</div>
									</li>
<% } else {	// 150 ����ƾ��
								String pSetName = "";
								String pSetCode = "";
								int pCnt		= 0;
								int pCartId		= 0;
								int pBuyCnt     = 0;

								query1		= " SELECT IFNULL(MAX(ID),0) AS ID FROM ESL_CART WHERE MEMBER_ID = '"+eslMemberId+"' AND GROUP_ID = '"+groupId+"' AND CART_TYPE='C' ";
								try {
									rs1	= stmt1.executeQuery(query1);
									if (rs1.next()) {
										pCartId = rs1.getInt("ID");
									}
									rs1.close();
								} catch(Exception e) {
									out.println(e+"=>"+query);
									if(true)return;
								}
								rs1.close();

								query       = "SELECT SET_NAME, SET_CODE, BUY_CNT FROM ESL_CART_DELIVERY A, ESL_GOODS_SET B where A.CART_ID = '" + pCartId + "' AND B.CATEGORY_ID = 19 AND SET_CODE = P_SET_CODE ";
								pstmt       = conn.prepareStatement(query);
								rs1			= pstmt.executeQuery();
								while(rs1.next()){
									pCnt++;
									pSetName = rs1.getString("SET_NAME");
									pSetCode = rs1.getString("SET_CODE");
									pBuyCnt = rs1.getInt("BUY_CNT");
%>
									<li>
										<div class="opt_title"><%=pSetName%></div>
										<div class="inp_quantity">
											<input type="text" class="inp_qtt_text only_number" name="buy_qty" id="buy_2_qty<%=pCnt%>" value="<%=pBuyCnt%>">
											<input type="hidden" name="p_set_code" id="p_set_code<%=pCnt%>" value=<%=pSetCode%> />
											<button type="button" class="inp_qtt_minus" onclick="setMinus2(<%=pCnt%>);">-</button>
											<button type="button" class="inp_qtt_plus" onclick="setPlus2(<%=pCnt%>);">+</button>
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
					<tfoot>
						<tr>
                            <td colspan="2">
                            <% if (couponPrice > 0) {
                                for(int h=0; h<aryOrderWeek.size(); h++){    // ���� ���� ��ŭ for�� ����
                                        String s_orderWeek = aryOrderWeek.get(h);
                                %>
                                    <span id="cp2_<%=h%>" class="event_area" name="event_area" value="<%=s_orderWeek%>" data="<%=aryPer.get(h)%>" atype="<%=aryW.get(h)%>" uselimitcnt="<%=useLimitCnt.get(h)%>" uselimitprice="<%=useLimitPrice.get(h)%>" usegoods="<%=aryUseGoods.get(h)%>" ><%=aryCouponName.get(h)%></span>
                                <%
                                }
                            }
                            else if(groupPrice != salePrice){ %><span name="event_area" class="event_area"><%=saleTitle%></span> <% } %>
                            </td>
						</tr>
						<tr>
							<td colspan="2">
							<%
							if(couponPrice > 0){
							%>
								<del id="opt_orgPrice">&nbsp;</del><span><strong id="opt_sumPrice">&nbsp;</strong></span>
								<p><span></span></p>
							<%
							}else if(groupPrice == salePrice){
								%>
								<span><strong id="opt_sumPrice">&nbsp;</strong></span>
								<%
							}else{
								%>
								<del id="opt_orgPrice">&nbsp;</del><span><strong id="opt_sumPrice">&nbsp;</strong></span>
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
			<div class="bottom_btn_area">
                    <%
                        if ( "Y".equals(soldOut) ) {
                    %>
                            <span>���� ���Ű� �Ұ����� ��ǰ�Դϴ�.</span>
                    <%
                        } else {
                    %>     
					<button onmouseup="sendCart()" type="button" id="btnOptionForm" class="btn btn_dgray huge">��ٱ��� ���</button>
				    <%
                        }
                    %>   
		</div>
		<!-- End contentpop -->
	</div>
</body>
<script>
var optGroupCode = '<%=groupCode%>';
var optSaleTotalPrice = "";
var optGoodsTotalPrice = "";
var optIsDevlWeek = <%=isDevlWeek%>;
var optSalePrice = <%=salePrice%>;
var optGoodsPrice = <%=groupPrice%>;
var optHour =  new Date().getHours();
var optMinDate = <%=devlFirstDay%>;
var optGubun1 = "<%=gubun1%>";
var CouponeSalePrice = <%=couponPrice%>;
var CouponSaleType = "<%=couponMaxSaleType%>";
var DevlType = "<%=devlGoodsType%>";//    �Ϲ�:0001,�ù�:0002
var Gubun2 = "<%=gubun2%>";

//if(optGroupCode == "0301369"){ //�ﾾ������ 3�� ���ĵǸ� 1���� ���Ѵ�.
	if(optHour >= 15){
		optMinDate += 1;
	}
//}
var groupCode = "<%=groupCode%>";	//	150 ����ƾ��
var fir_pBuyQty = <%=cartMap.get("BUY_QTY")%>;
$(document).ready(function() {

	if(optIsDevlWeek){
		if(optGubun1 != "02"){
			$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
			$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
		}
		else{
			if(Gubun2 == "51"){
			    $("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
				$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
			} else {
				$("#opt_devlDay").val($('#opt_selectDevlDay').val());
		        $("#opt_devlWeek").val($('#opt_selectDevlWeek').val());
			}
		}

		if($("input:checkbox[id='opt_buy_bag']").is(":checked") == true){
			$("#opt_buyBagYn").val("Y");
		}else if($("input:checkbox[id='opt_buy_bag']").is(":checked") == false){
			$("#opt_buyBagYn").val("N");
		}

		if($("input:checkbox[id='opt_buy_weekend']").is(":checked") == true){
			$("#opt_devlWeekEnd").val("1");
		}else if($("input:checkbox[id='opt_buy_weekend']").is(":checked") == false){
			$("#opt_devlWeekEnd").val("0");
		}
	}

	if("0301844" == groupCode){	// 150 ����ƾ��
		$("#p_buy_2_qty").val(fir_pBuyQty);
		$("a").attr("onfocus", "this.blur()");	
		optSalePrice = optSalePrice / 5;
	}

    forCoupon2();
});

// �ֹ��� ��ǰ�� �ش�Ǵ� ���� �����ֱ� �� �ִ� ���� �ݾ� ���
function forCoupon2(){

    //$("event_area").hide();// ��� ��밡���� ���� �����ֱ�
    var orderWeekSize = <%=aryOrderWeek.size()%>;
    var orderWeek  = $("#opt_devlWeek").val(); // ������ ��� �Ⱓ

    var paramVala = 0;
    var paramValb = 0;
	var valueR = -1;

	var buyQty = 0;
	var goodsTotalPrice = 0;

    for(var r=0; r<orderWeekSize; r++){
		$("#cp2_" + r).hide();
        var cp_value = $("#cp2_" + r).attr('value');
        var UseGoods = $("#cp2_" + r).attr('usegoods');
 		var uselimitcnt = $("#cp2_" + r).attr('uselimitcnt');
		var uselimitprice = $("#cp2_" + r).attr('uselimitprice');

		if(optIsDevlWeek && optGubun1 != "02"){
			buyQty = parseInt($("#opt_buyQty").val());
			goodsTotalPrice = optGoodsPrice * parseInt($("#opt_devlWeek").val()) * ( parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val()) ) * parseInt($("#opt_buyQty").val());
		}else{
			if(Gubun2 == "51"){
				buyQty = parseInt($("#opt_buyQty").val());
				goodsTotalPrice = optGoodsPrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val());
			} else if("0301844" == groupCode){	// 150 ����ƾ��
				var pBuyQty		= parseInt($("#p_buy_2_qty").val());
				var pTotalPrice	=  Math.round(parseFloat( parseInt($("#price").val()) / 5 )) * pBuyQty;
				
				buyQty = pBuyQty;
				goodsTotalPrice = pTotalPrice;

			} else {
				buyQty = parseInt($("#opt_buyQty").val());
				goodsTotalPrice = optGoodsPrice * parseInt($("#opt_buyQty").val());
			}
		}

		if( uselimitcnt <= buyQty && uselimitprice <= goodsTotalPrice ){	

			// 1 ��ü��ǰ�� ���� ��밡��
			if(UseGoods == 1){
				if(DevlType == "0002"){    // �ù�
					//$("#cp2_" + r).show();
					//��������
					if($("#cp2_" + r).attr('atype') == "W"){        //��������
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = Math.round( ( optSalePrice * parseInt($("#p_buy_2_qty").val()) * CouponeSalePrice ) / 100 );  
							} else {
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
							}	  
						}
					}            
				}else if(cp_value.indexOf(orderWeek) > -1){    // �Ϲ�
					//$("#cp2_" + r).show();
					//��������
					if($("#cp2_" + r).attr('atype') == "W"){        //��������
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
						
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							} else {
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
							}	 
						}
					}
				}
				else{
					//$("#cp2_" + r).hide();
				}
			}
			// 2 Ư�� ��ǰ���� ���� ��밡��
			if(UseGoods == 2){
				if(DevlType == "0002"){    // �ù�
					//$("#cp2_" + r).show();
					//��������
					if($("#cp2_" + r).attr('atype') == "W"){        //��������
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = Math.round( ( optSalePrice * parseInt($("#p_buy_2_qty").val()) * CouponeSalePrice ) / 100 );   
							} else {
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
							}	  
						}
					}            
				}else if(cp_value.indexOf(orderWeek) > -1){    // �Ϲ�
					//$("#cp2_" + r).show();
					//��������
					if($("#cp2_" + r).attr('atype') == "W"){        //��������
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    //�ۼ�Ʈ����
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							} else {
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
							}	
						}
					}
				}
				else{
				   // $("#cp2_" + r).hide();
				}
			}
			// 3 �Ϲ� ��ǰ ��ü ��밡��
			if(UseGoods == 3){
				if(DevlType == "0001"){// ���û�ǰ�� �Ϲ�
					if(cp_value.indexOf(orderWeek) > -1){
					   // $("#cp2_" + r).show();
						//��������
						if($("#cp2_" + r).attr('atype') == "W"){        //��������
							if(optIsDevlWeek && optGubun1 != "02"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = CouponeSalePrice;
							}else{
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb    = CouponeSalePrice;
							}
						}else{    //�ۼ�Ʈ����
							if(optIsDevlWeek && optGubun1 != "02"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							}else{
								if(Gubun2 == "51"){
									var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
									paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
								} else {
									var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
									paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
								}	
							}
						}
					}
					else{
						//$("#cp2_" + r).hide();
					}
				}
				else{
					//$("#cp2_" + r).hide();
				}
			}
			//  4 �ù� ��ǰ ��ü ��밡��
			if(UseGoods == 4){
				if(DevlType == "0002"){
				   // $("#cp2_" + r).show();
					//��������
					if($("#cp2_" + r).attr('atype') == "W"){        //��������
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}else{
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = CouponeSalePrice;
						}
					}else{    
						if(optIsDevlWeek && optGubun1 != "02"){
							var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
							paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
						}else{
							if(Gubun2 == "51"){
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val()) * CouponeSalePrice) / 100;
							} else if("0301844" == groupCode){	// 150 ����ƾ��
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = Math.round( ( optSalePrice * parseInt($("#p_buy_2_qty").val()) * CouponeSalePrice ) / 100 );   
							} else {
								var CouponeSalePrice = Number($("#cp2_" + r).attr('data'));
								paramValb = ( optSalePrice * parseInt($("#opt_buyQty").val()) * CouponeSalePrice ) / 100;     
							}	  
						}
					}
				}
				else{
					//$("#cp2_" + r).hide();
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
	$("#cp2_" + valueR).show();
    optCalAmount(paramVala);
}

$("#opt_buy_bag").change(function(){
	
	if($(this).is(":checked") == true){
		$("#opt_buyBagYn").val("Y");
	   	forCoupon2();

	}else{
		if (confirm("�ż��� ��ǰ ����� ���ؼ��� ���ð�����\r\n�� �ʿ��մϴ�.\r\nüũ�ڽ��� ���� �Ͻðڽ��ϱ�?")){
			$("#opt_buyBagYn").val("N");
			forCoupon2();
		} else {
			$(this).prop("checked", true);
		}
	}
});

$("#opt_buy_weekend").change(function(){
	
	if($(this).is(":checked") == true){
		$("#opt_devlWeekEnd").val("1");
	   	forCoupon2();
	}else{
		$("#opt_devlWeekEnd").val("0");
		forCoupon2();
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
$(".opt-date-pick").datepick({
    dateFormat: "yyyy.mm.dd",
    minDate: optMinDate,
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
    var optQuantityFn = {
    	onSet : function(i){
    		$("#opt_buyQty").val(i);
    	},
    	plus : function(){
    		var $val = $("#opt_buyQty").val();
    		var i = Number($val)+1;
    		optQuantityFn.onSet(i);
			
		   	forCoupon2();
    	},
    	minus : function(){
    		var $val = $("#opt_buyQty").val();
    		var i = Number($val)-1;
    		if(i < 1) {
    			alert("������ 1�� �̻� �������ּ���.");
    			return false;
   			}else{
   				optQuantityFn.onSet(i);
				
   			   	forCoupon2();
   			}
    	}
    }
    var optQuantityFn2 = {
        	onSet : function(i2){
        		$("#opt_buyQty2").val(i2);
        	},		
        	plus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var i2 = Number($val2)+1;
        		optQuantityFn2.onSet(i2);
				
    		   	forCoupon2();
        	},
        	minus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var $val3 = $("#opt_buyQty3").val();
        		var i2 = Number($val2)-1;
        		var i3 = Number($val3);
        		if(i2 < 0) {
        			i2 = 0;
       			}
				if((i2+i3) < 2) {
        			alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
        			return false;
       			}else{
       				optQuantityFn2.onSet(i2);
					
       			   	forCoupon2();
       			}
        	}
        }
    var optQuantityFn3 = {
        	onSet : function(i3){
        		$("#opt_buyQty3").val(i3);
        	},
        	plus : function(){
        		var $val3 = $("#opt_buyQty3").val();
        		var i3 = Number($val3)+1;
        		optQuantityFn3.onSet(i3);
				
    		   	forCoupon2();
        	},
        	minus : function(){
        		var $val2 = $("#opt_buyQty2").val();
        		var $val3 = $("#opt_buyQty3").val();
        		var i2 = Number($val2);
        		var i3 = Number($val3)-1;
        		if(i3 < 1) {
        			i3 = 0;
       			}
        		if((i2+i3) < 2) {
        			alert("�ּ� �ֹ��� 2Set���� �����մϴ�.");
        			return false;
       			}else{
       				optQuantityFn3.onSet(i3);
					
       			   	forCoupon2();
       			}
        	}
        }

    // 3�� 5�� ����
    var optOptionWeek = {"week3":"<%=devlWeek3%>","week5":"<%=devlWeek5%>"};
   	$('#opt_selectDevlDay').change(function(){
   		var arrOptionWeek = optOptionWeek["week"+$(this).find("option:selected").val()].split(",");
   		$("#opt_selectDevlWeek option").remove();
   		for(var forCt = 0; forCt < arrOptionWeek.length; forCt++){
   			$('#opt_selectDevlWeek').append("<option value='" + arrOptionWeek[forCt] + "'>" + arrOptionWeek[forCt] + "��</option>");
   		}
   		$('#opt_selectDevlWeek > option[value="2"]').attr('selected', 'true');
   		$("#opt_devlWeek").val($("#opt_selectDevlWeek option:selected").val());
   		$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
		
        forCoupon2();
    });

    // ��۱Ⱓ ���ý� ���� �ǽð����� ����
    $('#opt_selectDevlWeek').change(function(){
       $("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
       forCoupon2();
    });

    // ���� ���� �Է½�
    $('#opt_buyQty').on("keyup",function(e) {
        var ct = $(this).val();
        if(isNaN(ct) || 1 > parseInt(ct)){
        	$('#opt_buyQty').val(1);
        }
		
        forCoupon2();
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
    function optCalAmount(paramVal){
		//debugger;
        if(paramVal != "cnt"){
            CouponeSalePrice = paramVal;
        }
        //CouponeSalePrice = paramVal;
    	if(optGroupCode == "0300993"){ //-- �̴Ϲ��ϰ�� �ѽ�,��ļ�Ʈ�� ����
	   		optSaleTotalPrice	= optSalePrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		if(optSalePrice != optGoodsPrice){
		   		optGoodsTotalPrice	= optGoodsPrice * (parseInt($("#opt_buyQty2").val()) + parseInt($("#opt_buyQty3").val()));
	   		}
    	}
    	else{
	    	if(optIsDevlWeek && optGubun1 != "02"){ //-- ����üũ�̸鼭 ���α׷����̾�Ʈ�� �ƴѻ�ǰ
				/*if ( CouponSaleType == "P" ) {
					optSaleTotalPrice	= (optSalePrice-CouponeSalePrice) * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val());
				} else {
					optSaleTotalPrice	= optSalePrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()) - CouponeSalePrice;
				}*/
				optGoodsTotalPrice    = Number(optGoodsPrice * parseInt($("#opt_devlWeek").val()) * (parseInt($("#opt_devlDay").val()) + parseInt($("#opt_devlWeekEnd").val())) * parseInt($("#opt_buyQty").val()));
		   	}else{
				if(Gubun2 == "51") {
					optGoodsTotalPrice    = optGoodsPrice * parseInt($("#opt_devlWeek").val()) * parseInt($("#opt_buyQty").val());
				} else if("0301844" == groupCode){	// 150 ����ƾ��
					optGoodsTotalPrice    = (optGoodsPrice  / 5) * parseInt($("#p_buy_2_qty").val());
				} else {
					optGoodsTotalPrice    = Number(optGoodsPrice * parseInt($("#opt_buyQty").val()));
				}
		   	}
    	}
    	//if($("#opt_buyBagYn").val() == "Y") optSaleTotalPrice += 4000;
		$("#opt_orgPrice").html("");
		$("#opt_sumPrice").html("");

		$("#opt_totalPrice").val(optGoodsTotalPrice);
  
        //if(optSalePrice != optGoodsPrice){
        //    $("#opt_orgPrice").html(totalComma(optGoodsTotalPrice)+"��");
		//	 $("#opt_sumPrice").html(totalComma(optGoodsTotalPrice-CouponeSalePrice)+"��");
        //}
		if(CouponeSalePrice > 0){
             $("#opt_orgPrice").html(totalComma(optGoodsTotalPrice)+"��");
			 $("#opt_sumPrice").html(totalComma(optGoodsTotalPrice-CouponeSalePrice)+"��");
        }else{
			 $("#opt_sumPrice").html(totalComma(optGoodsTotalPrice)+"��");
		}
    }

 	var eslMemberId = '<%=eslMemberId%>';
    $("#btnOptionForm").click(function(){
	   	if(eslMemberId != ""){
		 	if(optIsDevlWeek && $("#opt_day").val() == ""){
		 		alert("������� ������ �ּ���.");
		 	}
		 	else{
		 		if(optIsDevlWeek && optGubun1 != "02"){
		 			$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
		 			$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
		 		}
		 		else{
					if(Gubun2 == "51"){
						$("#opt_devlDay").val($('#opt_selectDevlDay option:selected').val());
						$("#opt_devlWeek").val($('#opt_selectDevlWeek option:selected').val());
					} else {
						$("#opt_devlDay").val($('#opt_selectDevlDay').val());
						$("#opt_devlWeek").val($('#opt_selectDevlWeek').val());
					}	
		 		}

		    	var queryString = $("form[name=optionForm]").serialize() ;

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
    //-- ��ٱ��ϰ� ����
</script>

<!-- 150 ����ƾ�� ���� -->
<script type="text/javascript">
function setPlus2(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_2_qty"+ obj).val());
	if (buyQty < 99) buyQty		+= 1;
	$("#buy_2_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt2();
	forCoupon2();
}

function setMinus2(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_2_qty"+ obj).val());
	if (buyQty > 0) buyQty		= buyQty - 1;
	$("#buy_2_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt2();
	if (tcnt < 5) {
		alert("�ּ� �ֹ��� 5Set���� �����մϴ�.");
		$("#buy_2_qty"+ obj).val(buyQty + 1);
	}
	tcnt	= setTcnt2();
	forCoupon2();
}

function setTcnt2() {
	var tcnt	= parseInt($("#buy_2_qty1").val()) + parseInt($("#buy_2_qty2").val()) + parseInt($("#buy_2_qty3").val()) + parseInt($("#buy_2_qty4").val()) + parseInt($("#buy_2_qty5").val());
	$("#p_buy_2_qty").val(tcnt);

	return tcnt;
}
</script>
<!-- 150 ����ƾ�� �� -->

<!-- Enliple Shop Log Tracker v3.5 start -->
<script type="text/javascript">
<!--
function sendCart(){
  var sh = new EN();      
  // [��ǰ������]

  var mobGroupCode = '<%=groupCode%>';
  var mobGroupName = '<%=groupName %>';
  var mobGroupPrice = '<%=groupPrice1%>';
  var cartImg = '<%=cartImg %>';

  //var imgUrl = 'http://dev.eatsslim.co.kr<%=webUploadDir%>' +'goods/'+ encodeURIComponent(cartImg);
  var imgUrl = 'http://www.eatsslim.co.kr<%=webUploadDir%>' + 'goods/' + encodeURIComponent(cartImg);

  sh.setData("sc", "995f3de777d1894591fafb3feb1a673b");	
  sh.setData("userid", "eatsslim");
  sh.setData("pcode", mobGroupCode);
  sh.setData("price", mobGroupPrice);
  sh.setData("pnm", encodeURIComponent(encodeURIComponent(mobGroupName)));
  sh.setData("img", imgUrl);
  //sh.setData("dcPrice", $("#totalPrice").val()); // �ɼ� 
  //sh.setData("soldOut", mobSoldOut); //�ɼ� 1:ǰ��,2:ǰ���ƴ�
  //sh.setData("mdPcode", "��õ��ǰ�ڵ�1,��õ��ǰ�ڵ�2,��"); //�ɼ� 
  //sh.setData("cate1", encodeURIComponent(encodeURIComponent("ī�װ� �ڵ� �Ǵ� �̸�"))); //�ɼ�
  sh.setSSL(true);
  sh.sendRfShop();
 
  // ��ٱ��� ��ư Ŭ�� �� ȣ�� �޼ҵ�(������� �ʴ� ��� ����)
  sh.sendCart();
} 
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobRfShop()"></script>
<!-- Enliple Shop Log Tracker v3.5 end  -->

</html>