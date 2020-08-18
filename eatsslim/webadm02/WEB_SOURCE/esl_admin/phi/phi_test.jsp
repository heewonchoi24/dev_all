<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp" %>
<%@ include file="../lib/dbconn_phi.jsp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
int seq1				= 1;
int seq					= 22;
SimpleDateFormat dt		= new SimpleDateFormat("yyyyMMdd");
String instDate			= dt.format(new Date());
SimpleDateFormat dt2	= new SimpleDateFormat("yyMMddHHmmss");
String ordNo			= "ESS" + dt2.format(new Date()) + "001";
String devlDateArr[]	= {"20131004", "20131007", "20131008", "20131009", "20131010", "20131011", "20131014", "20131015", "20131016", "20131017"};

out.println(seq);

for (int i = 1; i < 10; i++) {
	query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
	query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
	query		+= "	VALUES";
	query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
	pstmt_phi					= conn_phi.prepareStatement(query);
	pstmt_phi.setInt(1, seq);
	pstmt_phi.setString(2, instDate);
	pstmt_phi.setString(3, ordNo);
	pstmt_phi.setString(4, "21798793");
	pstmt_phi.setString(5, "I");
	pstmt_phi.setString(6, "김형석");
	pstmt_phi.setString(7, "김형석");
	pstmt_phi.setString(8, "134793");
	pstmt_phi.setString(9, "서울 강동구 상일동");
	pstmt_phi.setString(10, "주공아파트");
	pstmt_phi.setString(11, "070-1234-1234");
	pstmt_phi.setString(12, "010-5044-0275");
	pstmt_phi.setString(13, "khs1157@gmail.com");
	pstmt_phi.setInt(14, 37500);
	pstmt_phi.setInt(15, 37500);
	pstmt_phi.setInt(16, 2500);
	pstmt_phi.setInt(17, 0);
	pstmt_phi.setString(18, "10");
	pstmt_phi.setString(19, "0001");
	pstmt_phi.setString(20, "69293");
	pstmt_phi.setString(21, "테스트 세트 I 외 1건");
	pstmt_phi.setInt(22, seq1);
	pstmt_phi.setString(23, devlDateArr[i]);
	pstmt_phi.setString(24, "0300325");
	pstmt_phi.setInt(25, 1);
	pstmt_phi.setInt(26, 30000);
	pstmt_phi.setInt(27, 30000);
	try {
		pstmt_phi.executeUpdate();
		out.println(i + ": 성공<br />");
	} catch (Exception e) {
		out.println(i + ": 실패 - " + e + "<br />");
	}
	seq++;
	seq1++;
}


query		= "INSERT INTO PHIBABY.P_ORDER_MALL_PHI_ITF";
query		+= "	(ORD_SEQ, ORD_DATE, ORD_NO, PARTNERID, ORD_TYPE, ORD_NM, RCVR_NM, RCVR_ZIPCD, RCVR_ADDR1, RCVR_ADDR2, RCVR_TELNO, RCVR_MOBILENO, RCVR_EMAIL, TOT_SELL_PRICE, TOT_REC_PRICE, TOT_DELV_PRICE, TOT_DC_PRICE, REC_TYPE, DELV_TYPE, AGENCYID, ORD_MEMO, POD_SEQ, DELV_DATE, GOODS_NO, ORD_CNT, SELL_PRICE, REC_PRICE, CREATE_DM)";
query		+= "	VALUES";
query		+= "	(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
pstmt_phi					= conn_phi.prepareStatement(query);
pstmt_phi.setInt(1, 21);
pstmt_phi.setString(2, instDate);
pstmt_phi.setString(3, ordNo);
pstmt_phi.setString(4, "21798793");
pstmt_phi.setString(5, "I");
pstmt_phi.setString(6, "김형석");
pstmt_phi.setString(7, "김형석");
pstmt_phi.setString(8, "134793");
pstmt_phi.setString(9, "서울 강동구 상일동");
pstmt_phi.setString(10, "주공아파트");
pstmt_phi.setString(11, "070-1234-1234");
pstmt_phi.setString(12, "010-5044-0275");
pstmt_phi.setString(13, "khs1157@gmail.com");
pstmt_phi.setInt(14, 37500);
pstmt_phi.setInt(15, 37500);
pstmt_phi.setInt(16, 2500);
pstmt_phi.setInt(17, 0);
pstmt_phi.setString(18, "10");
pstmt_phi.setString(19, "0002");
pstmt_phi.setString(20, "69293");
pstmt_phi.setString(21, "테스트 세트 I 외 1건");
pstmt_phi.setInt(22, seq1);
pstmt_phi.setString(23, instDate);
pstmt_phi.setString(24, "0300319");
pstmt_phi.setInt(25, 1);
pstmt_phi.setInt(26, 5000);
pstmt_phi.setInt(27, 5000);
try {
	pstmt_phi.executeUpdate();
	out.println(": 성공<br />");
} catch (Exception e) {
	out.println(": 실패 - " + e + "<br />");
}
%>