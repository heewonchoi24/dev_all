<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.*"%>
<%@ include file="/lib/dbconn_phi2.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn_phi2.createStatement();
String customerNum	= "";
String rcvHp		= "";
String memNm		= "";
String prdNm		= "";
String lastDate		= "";
int i				= 1;
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //오늘
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
cal.add(Calendar.DATE, 3);
lastDate			= dt.format(cal.getTime());

query		= "SELECT M.MEM_NM,";
query		+= "	DECODE(O.GOODS_GROUP_ID,'0001','초기','0002','중기','0003','후기','0004','병행','0005','완료','0007','요리','0008','성찬','0009','요리+성찬','0010','퓨레','0011','보양밥','0012','보양국','0013','완료기3입', '0016','6개월부터', '0017', '8개월부터','8001','가방') AS PRD_NM, ";
query		+= "	M.ORD_MOBILENO";
query		+= "	FROM BM_MEAL_ORDER M,";
query		+= "	BM_ORDER_DELIVERY O"; 
query		+= " WHERE M.ORD_NO = O.ORDER_NO";
query		+= " AND O.GOODS_GROUP_ID != '8001'"; 
query		+= " AND M.PAY_FL = 'Y'"; 
query		+= " AND O.STATUS = '0001'"; 
query		+= " AND M.ORD_NO not like 'S%'";
query		+= " AND O.GOODS_GROUP_ID != '0015'"; 
query		+= " AND (SELECT MIN(DELIVERY_DATE) FROM BM_ORDER_DELIVERY MO WHERE MO.ORDER_NO = M.ORD_NO) = TO_CHAR(SYSDATE, 'YYYYMMDD')";
query		+= " AND (SELECT COUNT(MO2.ORD_NO)";
query		+= "         FROM BM_MEAL_ORDER MO2";
query		+= "        WHERE MO2.MEM_ID = M.MEM_ID";
query		+= "              AND MO2.ORD_DT < TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
query		+= "              AND MO2.ORD_STAT_CD IN ('0002', '0007')";
query		+= "       ) <= 0";
query		+= " GROUP BY M.ORD_NO,"; 
query		+= "		  O.GOODS_GROUP_ID,"; 
query		+= "		  M.ORD_MOBILENO,";
query		+= "		  M.MEM_NM";
try {
	rs_phi2	= stmt_phi2.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
while (rs_phi2.next()) {
	memNm			= rs_phi2.getString("MEM_NM");
	prdNm			= rs_phi2.getString("PRD_NM");
	rcvHp			= rs_phi2.getString("ORD_MOBILENO");

	query1		= "INSERT INTO UDS_MSG (";
	query1		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query1		+= " ) VALUES (";
	query1		+= "	5, TO_CHAR(SYSDATE+"+i+"/(24*60*60), 'yyyymmddHH24MISS'), SYSDATE, SYSDATE, '"+ rcvHp +"', '02-6411-8321', '신규고객 안내 문자', '[풀무원베이비밀]\""+ memNm +"\"고객님. 금일 \""+ prdNm +"\"이유식은 잘 받으셨나요? 풀무원 베이비밀 이용 고객이라면 이것만은 알고가자! Step 1. 이유식은 꺼내 바로 냉장보관 하기 (냉장보관 : 7일 / 냉동보관 30일 / 개봉 후에는 가급적 빨리먹을 수 있도록해주세요!) Step 2. 보냉가방과 아이스젤은 그대로 현관문고리에 걸어두기 (아이스젤은 배달시마다 얼린것으로 교체해드려요!) Step 3. 잘 먹는 우리 아이 안아주기 (잘 안먹더라도 천천히 꾸준히 진행) 우리 아이들의 바른식습관 형성과 건강한 먹거리 제공을 위해 더 노력하겠습니다. 건강하세요:)";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e+"=>"+query1);
		if(true)return;
	}
}
%>
<%@ include file="/lib/dbclose_phi2.jsp" %>