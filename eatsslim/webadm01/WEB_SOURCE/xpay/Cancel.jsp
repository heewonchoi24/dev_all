<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
//request.setCharacterEncoding("euc-kr");
String returnUrl = "";
String msg = "";
String query		= "";
String chgstate = "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code 누락");if(true)return;}
String reasonType	= ut.inject(request.getParameter("reason_type"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTID		= ut.inject(request.getParameter("pgTID")); //PG사 거래번호
String cancelFrom   = ut.inject(request.getParameter("cancelFrom")); //주문취소를 모바일에서 했는지 체크
String mtype	   = ut.inject(request.getParameter("mtype")); //주문취소를 모바일 어느쪽에서 했는지 체크

int price=0,sell_price=0;
Calendar cal2 = Calendar.getInstance();
cal2.setTime(new Date()); //오늘
String cDate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(cal2.getTime());

if(mode!=null){
	
	if(mode.equals("cancel")){ //############# 취소처리

		if(code.equals("CD1")){				
			chgstate="91";
		}

		query		= "UPDATE ESL_ORDER_DEVL_DATE SET STATE = '"+ chgstate +"' WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		query		= "UPDATE ESL_ORDER_GOODS SET ORDER_STATE = '"+ chgstate +"' WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		query		= "UPDATE ESL_ORDER SET ORDER_STATE = '"+ chgstate +"' WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
		
		query		= "UPDATE ESL_COUPON_MEMBER SET USE_YN='N', USE_ORDER_NUM='', USE_DATE=null ";
		query		+= " WHERE USE_ORDER_NUM='"+orderNum+"' AND USE_YN='Y'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}
/////////////////////////////////////////////
	
		////////////////////////

		query		= "UPDATE PHIBABY.P_ORDER_MALL_PHI_ITF SET INTERFACE_FLAG_YN = 'Y' WHERE ORD_NO = '"+ orderNum +"'";
		try {
			stmt_phi.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		int ordSeq			= 0;
		SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
		String instDate		= dt.format(new Date());

		// 시퀀스 조회
		query		= "SELECT MAX(ORD_SEQ) FROM PHIBABY.P_ORDER_MALL_PHI_ITF";
		try {
			rs_phi		= stmt_phi.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs_phi.next()) {
			ordSeq		= rs_phi.getInt(1) + 1;
		}
		rs_phi.close();

		query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
		query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM, SHOP_CD)";
		query		+= "	VALUES";
		if (cancelFrom.equals("mobile")) {
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE, '52')";
		} else {
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE, '51')";
		}
		try {
			stmt_phi.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		// 고객 주문 취소시 어드민에 로그 남기기
		query		= "UPDATE ESL_ORDER SET ";
		query		+= "	ORDER_LOG = CONCAT(ORDER_LOG, '\n 고객 주문 취소 ', NOW())";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}		

		msg = "alert('취소 처리가 완료되었습니다.');";
	}

	if (cancelFrom.equals("mobile")) {
		if (mtype.equals("2")) {
			returnUrl		= "/mobile/shop/mypage/delichange.jsp";
		} else {
			returnUrl		= "/mobile/shop/mypage/delichange.jsp";
		}
	} else {
				returnUrl		= "/shop/mypage/reorderList.jsp";
	}
}
%>

<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>
<script><%=msg%></script>
<script>location.href="<%=returnUrl%>";</script>