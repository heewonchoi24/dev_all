<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.text.SimpleDateFormat,java.util.*,java.util.Date"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ page import="lgdacom.XPayClient.XPayClient"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="/xpay/config.jsp" %>

<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code 누락");if(true)return;}
String reasonType	= ut.inject(request.getParameter("reasonType"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String reason		= ut.inject(request.getParameter("reason"));
String bankName		= ut.inject(request.getParameter("bankName")); //환불계좌은행 명
String bankUser		= ut.inject(request.getParameter("bankUser")); //환불 계좌 예금주
String bankAccount	= ut.inject(request.getParameter("bankAccount")); //환불계좌번호
String payType		= ut.inject(request.getParameter("pay_type"));

String msg="";
String chgstate="";
String TitleText="";

String payYn		= ut.inject(request.getParameter("payYn"));
String pgTID		= ut.inject(request.getParameter("pgTID"));


if(payYn.equals("Y")){

    /*
     * [결제취소 요청 페이지]
     *
     * LG유플러스으로 부터 내려받은 거래번호(LGD_TID)를 가지고 취소 요청을 합니다.(파라미터 전달시 POST를 사용하세요)
     * (승인시 LG유플러스으로 부터 내려받은 PAYKEY와 혼동하지 마세요.)
     */                                                                                        //상점아이디(자동생성)
    String LGD_TID              = pgTID;                      //cd log	

	System.out.println("LGD_TID: " + LGD_TID);

	LGD_MID              = "eatsslim1"; 

	if(LGD_TID==null || LGD_TID.length()==0){
		out.println("오류 : 거래번호(LGD_TID) 누락");if(true)return;
	}

    /*String configPath 			= "C:/lgdacom";  										//LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf") 위치 지정.
	if(request.getServerName().equals("183.101.223.86") || request.getServerName().equals("p.tmap4.com")){ // case developServer
		configPath="C:\\Program Files\\Apache Software Foundation\\Tomcat 6.0\\webapps\\Admin\\lgdacom";
	} else { //case realServer
		configPath="/www/Admin/lgdacom";
	}*/
	
    LGD_TID     				= ( LGD_TID == null )?"":LGD_TID; 

    XPayClient xpay = new XPayClient();
    xpay.Init(configPath, CST_PLATFORM);
	if (LGD_TID.indexOf("201612") != -1) {
		xpay.Init_TX("eatsslim");
	} else {
		xpay.Init_TX(LGD_MID);
	}

    xpay.Set("LGD_TXNAME", "Cancel");
    xpay.Set("LGD_TID", LGD_TID);
	//---------------
    /*
     * 1. 결제취소 요청 결과처리
     *
     * 취소결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
	 *
	 * [[[중요]]] 고객사에서 정상취소 처리해야할 응답코드
	 * 1. 신용카드 : 0000, AV11  
	 * 2. 계좌이체 : 0000, RF00, RF10, RF09, RF15, RF19, RF23, RF25 (환불진행중 응답건-> 환불결과코드.xls 참고)
	 * 3. 나머지 결제수단의 경우 0000(성공) 만 취소성공 처리
	 *
     */
    if (xpay.TX()) {

        //1)결제취소결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)
        //out.println("결제 취소요청이 완료되었습니다.  <br>");
        //out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
        //out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");
		//out.println("<script>self.close();</script>");

		if(xpay.m_szResCode.equals("0000") || xpay.m_szResCode.equals("RF24")){

			///////////////////////////////PG 취소결과 저장		
			//out.println("결제 취소요청이 성공하였습니다.  <br>");
			//out.println( "TX Response_code = " + xpay.m_szResCode + "<br>");
			//out.println( "TX Response_msg = " + xpay.m_szResMsg + "<p>");

			System.out.println(xpay.m_szResCode);

			String pgcancel="N", pgcancel_code="", pgcancel_msg="";
			String[] arrResCode = new String[] {"0000", "AV11", "RF00", "RF10", "RF09", "RF15", "RF19", "RF23", "RF25"};

			for( int ii = 0; ii < arrResCode.length; ii++ ){
				if(arrResCode[ii].equals(xpay.m_szResCode)){
					pgcancel="Y";
				}
			}
			pgcancel_code=xpay.m_szResCode;// 0000
			pgcancel_msg=xpay.m_szResMsg;// 취소성공
			
			query		= "UPDATE ESL_ORDER SET ";
			query		+= "		PG_CANCEL			= '"+ pgcancel +"'";
			query		+= "		, PG_CANCEL_CODE	= '"+ pgcancel_code +"'";
			query		+= "		, PG_CANCEL_MSG		= '"+ pgcancel_msg +"'";
			query		+= " WHERE PG_TID = '"+ LGD_TID +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e); if(true)return;
			}

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

					query		= "UPDATE ESL_COUPON_MEMBER SET USE_YN='N', USE_ORDER_NUM='', USE_DATE=null ";
					query		+= " WHERE USE_ORDER_NUM='"+orderNum+"' AND USE_YN='Y'";
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
					query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
					query		+= "	VALUES";
					query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE)";
					try {
						stmt_phi.executeUpdate(query);
					} catch(Exception e) {
						out.println(e);
						if(true)return;
					}

					query		= "UPDATE ESL_ORDER SET ";
					query		+= "	ORDER_LOG = CONCAT(ORDER_LOG, '\nBOS 담당자 주문 취소 ', ' || 담당자: "+ eslAdminName +" ', NOW())";
					query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
					try {
						stmt.executeUpdate(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}	

					msg="alert('"+TitleText+" 처리가 완료되었습니다.');";
					msg+="self.close();";
					msg+="location.href='/order/order_view.jsp?ordno="+orderNum+"';";

				}
			}
		}
	}
}
else{// 결제전/주문접수상태

	

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

			query		= "UPDATE ESL_COUPON_MEMBER SET USE_YN='N', USE_ORDER_NUM='', USE_DATE=null ";
			query		+= " WHERE USE_ORDER_NUM='"+orderNum+"' AND USE_YN='Y'";
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
			query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
			query		+= "	VALUES";
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '취소', '취소', '111111', '취소', '취소', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE)";
			try {
				stmt_phi.executeUpdate(query);
			} catch(Exception e) {
				out.println(e);
				if(true)return;
			}

			query		= "UPDATE ESL_ORDER SET ";
			query		+= "	ORDER_LOG = CONCAT(ORDER_LOG, '\nBOS 담당자 주문 취소 ', ' || 담당자: "+ eslAdminName +" ', NOW())";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
			try {
				stmt.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}	

			msg="alert('"+TitleText+" 처리가 완료되었습니다.');";
			msg+="self.close();";
			msg+="location.href='/order/order_view.jsp?ordno="+orderNum+"';";

		}
	}
}
%>
<script><%=msg%></script>
<%@ include file="../lib/dbclose.jsp" %>
<%@ include file="../lib/dbclose_phi.jsp" %>