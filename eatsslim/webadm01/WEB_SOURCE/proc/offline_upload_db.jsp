<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="/lib/dbconn_bm.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String mode				= "";
String upfile			= "";
SimpleDateFormat dt1	= new SimpleDateFormat("yyMMddHHmmss");
String num				= "";
String orderNum			= "";
String customerNum		= "";
String memberId			= "";
String orderName		= "";
// 일배 배송 정보
String rcvName			= "";
String rcvHp			= "";
String rcvTel			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvPassYn		= "";
String rcvPass			= "";
String rcvRequest		= "";
// 택배 배송 정보
String tagName			= "";
String tagHp			= "";
String tagTel			= "";
String tagZipcode		= "";
String tagAddr1			= "";
String tagAddr2			= "";
String tagRequest		= "";
int payPrice			= 0;
int goodsPrice			= 0;
int devlPrice			= 0;
int couponTprice		= 0;
String payType			= "";
String orderDate		= "";
String groupCode		= "";
String devlType			= "";
int orderCnt			= 0;
String devlDate			= "";
String devlDay			= "";
String devlWeek			= "";
String buyBagYn			= "";
String ssType			= "";
String outOrderNum		= "";
String shopType			= "";
String rcvPartner	= "";
int groupId				= 0;
int groupPrice			= 0;
int price				= 0;
int errorCnt			= 0;
String tmpNum			= "";
String userIp			= request.getRemoteAddr();
int rows				= 0;
int cnt					= 0;
int i					= 0;

query = "SELECT * FROM PHIBABY.P_ORDER_PHIFD_ITF WHERE INTFAC_YN = 'N' ";
pstmt_phi		= conn_phi.prepareStatement(query);
rs_phi			= pstmt_phi.executeQuery();

cnt		= 1;

while (rs_phi.next()) {

	if (cnt < 10) {
		num		= "00" + Integer.toString(cnt);
	} else if (cnt < 100) {
		num		= "0" + Integer.toString(cnt);
	} else {
		num		= Integer.toString(cnt);
	}
	tmpNum		= dt1.format(new Date()) + num;
	orderNum	= "ESS" + tmpNum;

	memberId	= "0";
	customerNum		= "0";

	orderName		= rs_phi.getString("ORD_NM");
	devlType		= rs_phi.getString("DELV_TYPE");
	if (devlType.equals("0001")) {
		rcvName			= rs_phi.getString("RCVR_NM");
		rcvZipcode		= rs_phi.getString("RCVR_ZIPCD");
		rcvZipcode		= rcvZipcode.replace("-", "");
		rcvAddr1		= rs_phi.getString("RCVR_ADDR1");
		rcvAddr2		= rs_phi.getString("RCVR_ADDR2");
		rcvHp			= rs_phi.getString("RCVR_MOBILE_NO");
		rcvTel			= rs_phi.getString("RCVR_TELNO");
		if (rcvHp.equals("") || rcvHp == null) {
			rcvHp			= "--";
		}
		if (rcvTel.equals("") || rcvTel == null) {
			rcvTel			= "--";
		}
		rcvRequest		= ut.inject(rs_phi.getString("ORD_MEMO"));
		tagName			= "";
		tagZipcode		= "";
		tagAddr1		= "";
		tagAddr2		= "";
		tagHp			= "";
		tagTel			= "";
		tagRequest		= "";
	} else {
		rcvName			= "";
		rcvZipcode		= "";
		rcvAddr1		= "";
		rcvAddr2		= "";
		rcvHp			= "";
		rcvTel			= "";
		rcvRequest		= "";
		tagName			= rs_phi.getString("RCVR_NM");
		tagZipcode		= rs_phi.getString("RCVR_ZIPCD");
		tagZipcode		= tagZipcode.replace("-", "");
		tagAddr1		= rs_phi.getString("RCVR_ADDR1");
		tagAddr2		= rs_phi.getString("RCVR_ADDR2");
		tagHp			= rs_phi.getString("RCVR_MOBILE_NO");
		tagTel			= rs_phi.getString("RCVR_TELNO");
		if (tagHp.equals("") || tagHp == null) {
			tagHp			= "--";
		}
		if (tagTel.equals("") || tagTel == null) {
			tagTel			= "--";
		}
		tagRequest		= ut.inject(rs_phi.getString("ORD_MEMO"));
	}

	if (devlType.equals("0001") || devlType.equals("0002")) {
		goodsPrice		= rs_phi.getInt("TOT_SELL_PRICE");
		devlPrice		= rs_phi.getInt("TOT_DELV_PRICE");
		couponTprice	= rs_phi.getInt("TOT_DC_PRICE");
		payPrice		= rs_phi.getInt("TOT_REC_PRICE");

		payType			= rs_phi.getString("REC_TYPE");
		orderDate		= rs_phi.getString("ORD_DATE");
		if (orderDate.length() == 8) {
			orderDate		= orderDate.substring(0, 4) +"-"+ orderDate.substring(4, 6) +"-"+ orderDate.substring(6, 8) +" 00:00:00";
		} else {
			orderDate		= orderDate +"00:00:00";
		}
		groupCode		= rs_phi.getString("GOODS_NO");
		if (groupCode.equals("0300601")) {
			groupCode		= "0300717";
		} else if (groupCode.equals("0300602")) {
			groupCode		= "0300718";
		} else if (groupCode.equals("0300603")) {
			groupCode		= "0300719";
		} else if (groupCode.equals("0300604")) {
			groupCode		= "0300720";
		} else if (groupCode.equals("0300605")) {
			groupCode		= "0300721";
		} else if (groupCode.equals("0300606")) {
			groupCode		= "0300722";
		} else if (groupCode.equals("0300607")) {
			groupCode		= "0300723";
		} else if (groupCode.equals("0300608")) {
			groupCode		= "0300724";
		} else {
			groupCode		= groupCode;
		}
		orderCnt		= rs_phi.getInt("ORD_CNT");
		devlDate		= rs_phi.getString("DELV_DATE");
		if (devlDate.length() == 8) {
			devlDate		= devlDate.substring(0, 4) +"-"+ devlDate.substring(4, 6) +"-"+ devlDate.substring(6, 8);
		} else {
			devlDate		= devlDate;
		}
		devlDay			= rs_phi.getString("DELV_PTRN");
		devlWeek		= rs_phi.getString("DELV_WEEK");
		query			= "SELECT ID, GROUP_PRICE FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"'";
		try {
			rs = stmt.executeQuery(query);
		}catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			groupId		= rs.getInt("ID");
			groupPrice	= rs.getInt("GROUP_PRICE");
		} else {
			groupId		= 0;
			groupPrice	= 0;
		}
		rs.close();
		if (groupCode.equals("02244") || groupCode.equals("02252") || groupCode.equals("02261") || groupCode.equals("0300978")) {
			price			= groupPrice;
		} else {
			price			= (devlDay.equals("0") || devlDay.equals("0"))? groupPrice : groupPrice * Integer.parseInt(devlDay) * Integer.parseInt(devlWeek);
		}
		buyBagYn		= rs_phi.getString("BAG_FL");
		ssType			= "";
		outOrderNum		= rs_phi.getString("ORD_NO");
		if (outOrderNum.equals("") || outOrderNum == null) {
			outOrderNum		= "EXP" + tmpNum;
		}
		shopType		= rs_phi.getString("SHOP_CD");
		rcvPartner			= Integer.toString(rs_phi.getInt("PRTN_ID"));

		if (groupId > 0) {
			query		= "INSERT INTO ESL_ORDER SET ";
			query		+= "	ORDER_NUM		= '"+ orderNum +"'";
			query		+= "	,CUSTOMER_NUM	= '"+ customerNum +"'";
			query		+= "	,MEMBER_ID		= '"+ memberId +"'";
			query		+= "	,ORDER_NAME		= '"+ orderName +"'";
			query		+= "	,RCV_NAME		= '"+ rcvName +"'";
			query		+= "	,RCV_ZIPCODE	= '"+ rcvZipcode +"'";
			query		+= "	,RCV_ADDR1		= '"+ rcvAddr1 +"'";
			query		+= "	,RCV_ADDR2		= '"+ rcvAddr2 +"'";
			query		+= "	,RCV_HP			= '"+ rcvHp +"'";
			query		+= "	,RCV_TEL		= '"+ rcvTel +"'";
			query		+= "	,RCV_TYPE		= '01'";
			query		+= "	,RCV_PASS_YN	= 'N'";
			query		+= "	,RCV_PASS		= ''";
			query		+= "	,RCV_REQUEST	= '"+ rcvRequest +"'";
			query		+= "	,TAG_NAME		= '"+ tagName +"'";
			query		+= "	,TAG_ZIPCODE	= '"+ tagZipcode +"'";
			query		+= "	,TAG_ADDR1		= '"+ tagAddr1 +"'";
			query		+= "	,TAG_ADDR2		= '"+ tagAddr2 +"'";
			query		+= "	,TAG_HP			= '"+ tagHp +"'";
			query		+= "	,TAG_TEL		= '"+ tagTel +"'";
			query		+= "	,TAG_TYPE		= '01'";
			query		+= "	,TAG_REQUEST	= '"+ tagRequest +"'";
			query		+= "	,GOODS_PRICE	= '"+ goodsPrice +"'";
			query		+= "	,DEVL_PRICE		= '"+ devlPrice +"'";
			query		+= "	,COUPON_PRICE	= '"+ couponTprice +"'";
			query		+= "	,PAY_PRICE		= '"+ payPrice +"'";
			query		+= "	,PAY_TYPE		= '"+ payType +"'";
			query		+= "	,PAY_YN			= 'Y'";
			query		+= "	,PAY_DATE		= '"+ orderDate +"'";
			query		+= "	,ORDER_DATE		= '"+ orderDate +"'";
			query		+= "	,ORDER_STATE	= '01'";
			query		+= "	,ORDER_ENV		= 'P'";
			query		+= "	,ORDER_IP		= '"+ userIp +"'";
			query		+= "	,ORDER_LOG		= ''";
			query		+= "	,SHOP_TYPE		= '"+ shopType +"'";
			query		+= "	,OUT_ORDER_NUM	= '"+ outOrderNum +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			query		= "INSERT INTO ESL_ORDER_GOODS SET ";
			query		+= "	ORDER_NUM		= '"+ orderNum +"'";
			query		+= "	,GROUP_ID		= "+ groupId;
			query		+= "	,DEVL_TYPE		= '"+ devlType +"'";
			query		+= "	,ORDER_CNT		= '"+ orderCnt +"'";
			query		+= "	,DEVL_DATE		= '"+ devlDate +"'";
			query		+= "	,DEVL_DAY		= '"+ devlDay +"'";
			query		+= "	,DEVL_WEEK		= '"+ devlWeek +"'";
			query		+= "	,PRICE			= '"+ price +"'";
			query		+= "	,BUY_BAG_YN		= '"+ buyBagYn +"'";
			query		+= "	,COUPON_NUM		= ''";
			query		+= "	,COUPON_PRICE	= 0";
			query		+= "	,ORDER_STATE	= '01'";
			query		+= "	,SS_TYPE		= '"+ ssType +"'";
			try {
				stmt.executeUpdate(query);				
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
%>
<%@ include file="outmall_phi.jsp"%>
<%

			query		= "UPDATE PHIBABY.P_ORDER_PHIFD_ITF ";
			query		+= "	SET INTFAC_YN = 'Y', INTFAC_DATE = sysdate ";
			query		+= "	WHERE ORD_SEQ = "+ rs_phi.getInt("ORD_SEQ");
	
			try {
				stmt_phi.executeUpdate(query);				
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}

			cnt++;
		}
	}

	//cnt			= cnt - 1;
	//ut.jsAlert(out, "총 "+ cnt +"건의 데이타가 등록되었습니다.");
	//ut.jsRedirect(out, "outmall_upload.jsp");
}


%>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>