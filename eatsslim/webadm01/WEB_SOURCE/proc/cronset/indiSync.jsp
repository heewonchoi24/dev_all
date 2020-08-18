<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi2.jsp"%>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%
String query		= "";
String query1		= "";
Calendar cal = Calendar.getInstance();
cal.setTime(new Date()); //오늘
String cDate=(new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());
String memHp	= "";
String[] tmp			= new String[]{};
String hp1	= "";
String hp2	= "";
String hp3	= "";

query		= "SELECT SEQ, CUSTOMER_NUM, MEMBER_NAME, HP, INQUIRY_CD1, INQUIRY_CD2, INQUIRY_CD3, DBMS_LOB.SUBSTR(CONTENT, 1000, 1) AS CONTENT_TXT, DBMS_LOB.SUBSTR(ANSWER, 1000, 1) AS ANSWER_TXT, TO_CHAR(INST_DATE, 'YYYYMMDD') AS WDATE, TO_CHAR(ANSWER_DATE, 'YYYYMMDD') AS ADATE FROM NBM_INQUIRY WHERE TO_CHAR(INST_DATE, 'YYYYMMDD') >= TO_CHAR(SYSDATE-2, 'YYYYMMDD') ORDER BY SEQ";
try {
	rs_phi2	= stmt_phi2.executeQuery(query);			
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs_phi2.next()) {
	out.println(rs_phi2.getInt("SEQ"));
	out.println(rs_phi2.getString("CUSTOMER_NUM"));
	out.println(rs_phi2.getString("MEMBER_NAME"));
	memHp		= rs_phi2.getString("HP");
	if (memHp != null && memHp.length()>10) {
		tmp			= memHp.split("-");
		hp1		= tmp[0];
		hp2		= tmp[1];
		hp3		= tmp[2];
	}
	out.println(hp1);
	out.println(hp2);
	out.println(hp3);
	out.println(rs_phi2.getString("INQUIRY_CD1"));
	out.println(rs_phi2.getString("INQUIRY_CD2"));
	out.println(rs_phi2.getString("INQUIRY_CD3"));
	out.println(rs_phi2.getString("CONTENT_TXT"));
	out.println(ut.delHtmlTag(ut.isnull(rs_phi2.getString("ANSWER_TXT"))));
	out.println(rs_phi2.getString("WDATE"));
	out.println(rs_phi2.getString("ADATE")+ "<br />");

	query1		= "INSERT INTO TBITF_VOICE_IF";
	query1		+= "	(RECEIPT_ROOT, BOARD_DIV, BOARD_SEQ, CUSTOMER_NUM, CUSTOMER_NAME, CUSTOMER_PHONEAREA, CUSTOMER_PHONEFIRST, CUSTOMER_PHONESECOND,";
	query1		+= "	CUSTOMER_EMAIL, HD_BCODE, HD_SCODE, CLAIM_GUBUN, COUNSEL_DESC, RECEIPT_DATE, PRCS_YN, DEL_YN, ITEM_NAME, REPLY, MODIFY_DATE, SEC_CODE)";
	query1		+= " VALUES";
	query1		+= "	('10001', '1:1 문의', "+ rs_phi2.getInt("SEQ") +", '"+ rs_phi2.getString("CUSTOMER_NUM")  +"', '"+ rs_phi2.getString("MEMBER_NAME") +"', '"+ hp1 +"', '"+ hp2 +"', '"+ hp3 +"',";
	query1		+= "	'', '"+ rs_phi2.getString("INQUIRY_CD1") +"', '"+ rs_phi2.getString("INQUIRY_CD2") +"', '"+ rs_phi2.getString("INQUIRY_CD3") +"', '"+ ut.inject(rs_phi2.getString("CONTENT_TXT")) +"', '"+ rs_phi2.getString("WDATE") +"', 'N', 'N', '베이비밀', '"+ ut.inject(ut.delHtmlTag(ut.isnull(rs_phi2.getString("ANSWER_TXT")))) +"', '"+ ut.isnull(rs_phi2.getString("ADATE")) +"', '953')";
	try {
		stmt_tbr.executeUpdate(query1);
	} catch (Exception e) {
		out.println(e+"=>"+query1);
		if (true) return;
	}

}
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_phi2.jsp"%>
<%@ include file="/lib/dbclose_tbr.jsp" %>