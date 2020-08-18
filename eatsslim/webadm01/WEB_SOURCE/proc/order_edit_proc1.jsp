<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String mode			= ut.inject(request.getParameter("mode"));
String orderNum		= ut.inject(request.getParameter("order_num"));
if(orderNum.equals("")){ out.println("�ֹ���ȣ ����");if(true)return;}
String code			= ut.inject(request.getParameter("code"));
if(code==null){out.println("code ����");if(true)return;}

String reasonType	= ut.inject(request.getParameter("reason_type"));
if (reasonType == null || reasonType.length()==0) reasonType="0";
String bankName		= ut.inject(request.getParameter("bankName")); //ȯ�Ұ������� ��
String bankUser		= ut.inject(request.getParameter("bankUser")); //ȯ�� ���� ������
String bankAccount	= ut.inject(request.getParameter("bankAccount")); //ȯ�Ұ��¹�ȣ
String reason		= ut.inject(request.getParameter("reason"));
String payType		= ut.inject(request.getParameter("pay_type"));
String pgTID		= ut.inject(request.getParameter("pgTID")); //PG�� �ŷ���ȣ
String LGD_RFPHONE	= ut.inject(request.getParameter("LGD_RFPHONE")); //ȯ�ҿ�û�� ����ó

String msg="";
String addAct="";
String chgstate="",chgstate2="";
String TitleText="";
String tmpName="";

String cancelFrom = ut.inject(request.getParameter("cancelFrom")); //�ֹ���Ҹ� ����Ͽ��� �ߴ��� üũ
String mtype	= ut.inject(request.getParameter("mtype")); //�ֹ���Ҹ� ����� ����ʿ��� �ߴ��� üũ

if(cancelFrom.equals("mobile")) {
	reason = "����� �ֹ� ���"; //����Ϸ� �ֹ���ҽ� ��� ���� ����
}

int price=0,sell_price=0;


Calendar cal2 = Calendar.getInstance();
cal2.setTime(new Date()); //����
String cDate2=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(cal2.getTime());

if(mode!=null){
	
	if(mode.equals("cancel")){ //############# ���ó��

		if(code.equals("CD1")){	
			TitleText="��� �Ϸ�";
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

		// ������ ��ȸ
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
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '���', '���', '111111', '���', '���', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE, '52')";
		} else {
			query		+= "	("+ ordSeq +", '"+ instDate +"', '"+ orderNum +"', '00000000', 'D', '���', '���', '111111', '���', '���', '00000000000', '00000000000', 'cancel', 0, 0, 0, 0, '"+ payType +"', '0001', '', '', 1, '"+ instDate +"', '000000', 0, 0, 0, SYSDATE, '51')";
		}
		try {
			stmt_phi.executeUpdate(query);
		} catch(Exception e) {
			out.println(e);
			if(true)return;
		}

		if(code.equals("CD1")){ //��ҿϷ� ��
			if(pgTID!=null && pgTID.length()>0){ //pg�� ���
				if(payType.equals("30")){ //������´� �����ȯ�������� PG���� �ѱ�
					if(bankAccount!=null && bankAccount.length()>0)bankAccount=bankAccount.replaceAll("-","");
					addAct="location.href='../xpay/Cancel.jsp?LGD_TID="+pgTID+"&LGD_RFBANKCODE="+ut.getBankCode(bankName)+"&LGD_RFACCOUNTNUM="+bankAccount+"&LGD_RFCUSTOMERNAME="+bankUser+"&LGD_RFPHONE="+LGD_RFPHONE+"&cancelFrom="+cancelFrom+"&mtype="+mtype+"';";
				}else{
					addAct="location.href='../xpay/Cancel.jsp?LGD_TID="+pgTID+"&cancelFrom="+cancelFrom+"&mtype="+mtype+"';";
				}
			}
		}
		
		msg="alert('"+TitleText+" ó���� �Ϸ�Ǿ����ϴ�.');"+addAct+"";
		if(pgTID!=null && pgTID.length()>0){ //pg�� ���
		}else{

			if(cancelFrom.equals("mobile")) { //����Ϸ� �ֹ���ҽ� �ֹ�����Ʈ�� ���ư�
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