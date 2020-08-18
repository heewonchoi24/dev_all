<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String addParam		= "";
String mode			= ut.inject(request.getParameter("mode"));
String ctype		= ut.inject(request.getParameter("ctype"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("주문번호 누락");if(true)return;}
String groupCode	= ut.inject(request.getParameter("group_code"));
String subNum		= ut.inject(request.getParameter("sub_num"));
int bagId			= 0;
if (request.getParameter("bag_id") != null && request.getParameter("bag_id").length()>0)
	bagId				= Integer.parseInt(request.getParameter("bag_id"));
int orderCnt		= 0;
if (request.getParameter("order_cnt") != null && request.getParameter("order_cnt").length()>0)
	orderCnt			= Integer.parseInt(request.getParameter("order_cnt"));
String stdate		= ut.inject(request.getParameter("stdate_cancel"));
String ltdate		= ut.inject(request.getParameter("ltdate_cancel"));
int refundFee		= 0;
if (request.getParameter("refund_fee") != null && request.getParameter("refund_fee").length()>0)
	refundFee			= Integer.parseInt(request.getParameter("refund_fee"));
int refundPrice		= 0;
if (request.getParameter("refund_price") != null && request.getParameter("refund_price").length()>0)
	refundPrice			= Integer.parseInt(request.getParameter("refund_price"));
//if (refundPrice < 1) { out.println("환불금액 누락");if(true)return;}
String bankName		= ut.inject(request.getParameter("bank_name")); //환불계좌은행 명
if (bankName != null && bankName.length() > 0) {
	bankName		= new String(bankName.getBytes("8859_1"), "EUC-KR");
}
String bankUser		= ut.inject(request.getParameter("bank_user")); //환불 계좌 예금주
if (bankUser != null && bankUser.length() > 0) {
	bankUser		= new String(bankUser.getBytes("8859_1"), "EUC-KR");
}
String bankAccount	= ut.inject(request.getParameter("bank_account")); //환불계좌번호
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTid		= ut.inject(request.getParameter("pg_tid")); //PG사 거래번호
String LGD_RFPHONE	= ut.inject(request.getParameter("LGD_RFPHONE")); //환불요청자 연락처

String msg			= "";
String addAct		= "";
String chgstate		= "";
String chgstate2	= "";
String TitleText	= "";
String tmpName		= "";
String returnURL	= "";
int chkCnt			= 0;
int ordSeq			= 0;

Calendar cal2 = Calendar.getInstance();
cal2.setTime(new Date()); //오늘
String cDate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(cal2.getTime());

if(mode!=null){
	
	if(mode.equals("cancel")){ //############# 취소처리
		TitleText	= "환불 완료";
		chgstate	= "911";

		query		= "SELECT COUNT(ID) FROM ESL_ORDER_DEVL_DATE ";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
		query		+= " AND STATE < 90";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			chkCnt		= rs.getInt(1);
		}

		rs.close();

		if (chkCnt == orderCnt) {
			chgstate2	= chgstate;
		} else {
			chgstate2	= chgstate+"1";
		}

		if (ctype.equals("bag")) {
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET STATE = '91'";
			query		+= " WHERE ID = "+ bagId;
		} else {
			// 배송일자별 취소
			query		= "UPDATE ESL_ORDER_DEVL_DATE SET STATE = '91'";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ subNum;
			query		+= " AND DEVL_DATE BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
			query		+= " AND GROUP_CODE != '0300668'";
		}
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		query		= "UPDATE ESL_ORDER_GOODS SET ORDER_STATE = '"+ chgstate +"'";
		query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		query		+= " AND GROUP_ID = (SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"')";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		query		= "UPDATE ESL_ORDER SET ORDER_STATE = '"+ chgstate +"' WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		query		= "SELECT COUNT(ID) FROM ESL_ORDER_CANCEL WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			rs			= stmt.executeQuery(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		if (rs.next()) {
			chkCnt		= rs.getInt(1);
		}

		if (chkCnt > 0) {
			// 환불정보 입력
			query		= "UPDATE ESL_ORDER_CANCEL SET ";
			query		+= "		CONFIRM_DATE	= NOW()";
			query		+= "		, BANK_NAME		= '"+ bankName +"'";
			query		+= "		, BANK_ACCOUNT	= '"+ bankAccount +"'";
			query		+= "		, BANK_USER		= '"+ bankUser +"'";
			query		+= "		, REFUND_PRICE	= REFUND_PRICE + "+ refundPrice;
			query		+= "		, REFUND_DATE	= NOW()";
			query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		} else {
			// 환불정보 입력
			query		= "INSERT INTO ESL_ORDER_CANCEL SET ";
			query		+= "		ORDER_NUM		= '"+ orderNum +"'";
			query		+= "		, REASON_TYPE	= '0'";
			query		+= "		, ORDER_STATE	= '"+ chgstate +"'";
			query		+= "		, INST_DATE		= NOW()";
			query		+= "		, CONFIRM_DATE	= NOW()";
			query		+= "		, BANK_NAME		= '"+ bankName +"'";
			query		+= "		, BANK_ACCOUNT	= '"+ bankAccount +"'";
			query		+= "		, BANK_USER		= '"+ bankUser +"'";
			query		+= "		, REFUND_FEE	= "+ refundFee;
			query		+= "		, REFUND_PRICE	= "+ refundPrice;
			query		+= "		, REFUND_DATE	= NOW()";
		}
		try {
			stmt.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}

		// PHI 시퀀스 조회
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

%>
<%@ include file="order_phi_copy_cancel.jsp" %>
<%
		query1		= "UPDATE ESL_ORDER SET ";
		if (ctype.equals("bag")) {
			query1		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n보냉가방 취소("+ refundPrice +"원) ', NOW())";
		} else {
			query1		+= "	ORDER_LOG = CONCAT(ORDER_LOG,'\n부분 취소("+ refundPrice +"원) ', NOW())";
		}
		query1		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
		try {
			stmt1.executeUpdate(query1);
		} catch(Exception e) {
			out.println(e+"=>"+query1);
			if(true)return;
		}

		if(pgTid!=null && pgTid.length()>0){ //pg사 취소
/*
			if(payType.equals("30")){ //가상계좌는 사용자환불정보를 PG가에 넘김
				if(bankAccount!=null && bankAccount.length()>0)bankAccount=bankAccount.replaceAll("-","");
				addParam="&LGD_RFBANKCODE="+ut.getBankCode(bankName)+"&LGD_RFACCOUNTNUM="+bankAccount+"&LGD_RFCUSTOMERNAME="+bankUser+"&LGD_RFPHONE="+LGD_RFPHONE+"";
			}
*/
			if (payType.equals("10") && refundPrice > 0) {
				addAct="window.open('../lgdacom/PartialCancel.jsp?LGD_TID="+pgTid+addParam+"&LGD_CANCELAMOUNT="+refundPrice+"','pgcancel','width=500,height=500');";
			}
		}

		msg=""+TitleText+" 처리 완료";
		returnURL		= "order_view_day.jsp?ordno="+ orderNum +"&subno="+ subNum +"&gcode="+ groupCode +"&tabmenu=3";
	}
}


%>
<script>
	alert("<%=msg%>");
	<%if(returnURL.equals("")){%>
	parent.search();
	<%}else{%>
	parent.location.href="<%=returnURL%>";
	<%}%>
	<%=addAct%>
</script>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>