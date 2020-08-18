<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code 누락");if(true)return;}

String reasonType	= ut.inject(request.getParameter("reason_type"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String bankName		= ut.inject(request.getParameter("bankName")); //환불계좌은행 명
String bankUser		= ut.inject(request.getParameter("bankUser")); //환불 계좌 예금주
String bankAccount	= ut.inject(request.getParameter("bankAccount")); //환불계좌번호
String reason		= ut.inject(request.getParameter("reason"));
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTID		= ut.inject(request.getParameter("pgTID")); //PG사 거래번호
String LGD_RFPHONE	= ut.inject(request.getParameter("LGD_RFPHONE")); //환불요청자 연락처

String msg="";
String addAct="";
String chgstate="",chgstate2="";
String TitleText="";
String tmpName="";

String cancelFrom = ut.inject(request.getParameter("cancelFrom")); //주문취소를 모바일에서 했는지 체크
String mtype	= ut.inject(request.getParameter("mtype")); //주문취소를 모바일 어느쪽에서 했는지 체크

if(cancelFrom.equals("mobile")) {
	reason = "모바일 주문 취소"; //모바일로 주문취소시 취소 사유 설정
}

int price=0,sell_price=0;


Calendar cal2 = Calendar.getInstance();
cal2.setTime(new Date()); //오늘
String cDate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(cal2.getTime());

if(mode!=null){
	
	if(mode.equals("cancel")){ //############# 취소처리

		if(code.equals("CD1")){	
			TitleText="취소 완료";
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

		query		= "INSERT INTO ESL_ORDER_CANCEL SET ";
		query		+= "		ORDER_NUM		= '"+ orderNum +"'";
		query		+= "		, REASON_TYPE	= '"+ reasonType +"'";
		query		+= "		, REASON		= '"+ reason +"'";
		query		+= "		, ORDER_STATE	= '"+ chgstate +"'";
		query		+= "		, INST_DATE		= NOW()";
		query		+= "		, BANK_NAME		= '"+ bankName +"'";
		query		+= "		, BANK_ACCOUNT	= '"+ bankAccount +"'";
		query		+= "		, BANK_USER		= '"+ bankUser +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

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

		if(code.equals("CD1")){ //취소완료 시
			if(pgTID!=null && pgTID.length()>0){ //pg사 취소
				if(payType.equals("30")){ //가상계좌는 사용자환불정보를 PG가에 넘김
					if(bankAccount!=null && bankAccount.length()>0)bankAccount=bankAccount.replaceAll("-","");
					addAct="location.href='../xpay/Cancel.jsp?LGD_TID="+pgTID+"&LGD_RFBANKCODE="+ut.getBankCode(bankName)+"&LGD_RFACCOUNTNUM="+bankAccount+"&LGD_RFCUSTOMERNAME="+bankUser+"&LGD_RFPHONE="+LGD_RFPHONE+"&cancelFrom="+cancelFrom+"&mtype="+mtype+"';";
				}else{
					addAct="location.href='../xpay/Cancel.jsp?LGD_TID="+pgTID+"&cancelFrom="+cancelFrom+"&mtype="+mtype+"';";
				}
			}
		}
		
		msg="alert('"+TitleText+" 처리가 완료되었습니다.');"+addAct+"";
		if(pgTID!=null && pgTID.length()>0){ //pg사 취소
		}else{

			if(cancelFrom.equals("mobile")) { //모바일로 주문취소시 주문리스트로 돌아감
				if (mtype.equals("2")) {
					msg+="location.href = '/mobile2/shop/mypage/orderList.jsp';";
				} else {
					msg+="location.href = '/mobile/shop/mypage/orderList.jsp';";
				}
			}
			else {
				msg+="self.close();";
			}
		}

	}
}


%>
<script><%=msg%></script>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>