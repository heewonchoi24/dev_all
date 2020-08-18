<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_bm.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="/lib/dbconn_kakao.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
alert("로그인을 해주세요.");
parent.document.location.href = "/index.jsp";
</script>
<%
	if (true) return;
}

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String query2		= "";
Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();
Statement stmt2_phi	= null;
ResultSet rs2_phi	= null;
stmt2_phi			= conn_phi.createStatement();
String orderNum		= ut.inject(request.getParameter("order_num"));
String orderName	= eslMemberName;
String email		= ut.inject(request.getParameter("email"));
// 일배 배송 정보
String rcvName		= ut.inject(request.getParameter("rcv_name"));
String rcvHp1		= ut.inject(request.getParameter("rcv_hp1"));
String rcvHp2		= ut.inject(request.getParameter("rcv_hp2"));
String rcvHp3		= ut.inject(request.getParameter("rcv_hp3"));
String rcvHp		= "";
if (rcvHp1 != null && rcvHp1.length() > 0) {
	rcvHp				= rcvHp1 +"-"+ rcvHp2 +"-"+ rcvHp3;
}
String rcvTel		= "";
String rcvTel1		= ut.inject(request.getParameter("rcv_tel1"));
String rcvTel2		= ut.inject(request.getParameter("rcv_tel2"));
String rcvTel3		= ut.inject(request.getParameter("rcv_tel3"));
if (rcvTel1 != null && rcvTel1.length() > 0) {
	rcvTel				= rcvTel1 +"-"+ rcvTel2 +"-"+ rcvTel3;
}
String rcvZipcode	= ut.inject(request.getParameter("rcv_zipcode"));
String rcvAddr1		= ut.inject(request.getParameter("rcv_addr1"));
String rcvAddr2		= ut.inject(request.getParameter("rcv_addr2"));
String rcvBuildingNo	= "";
String rcvType		= ut.inject(request.getParameter("rcv_type"));
String rcvPassYn	= ut.inject(request.getParameter("rcv_pass_yn"));
String rcvPass		= ut.inject(request.getParameter("rcv_pass"));
String rcvRequest	= ut.inject(request.getParameter("rcv_request"));

// 택배 배송 정보
String tagName		= ut.inject(request.getParameter("tag_name"));
String tagHp1		= ut.inject(request.getParameter("tag_hp1"));
String tagHp2		= ut.inject(request.getParameter("tag_hp2"));
String tagHp3		= ut.inject(request.getParameter("tag_hp3"));
String tagHp		= "";
if (tagHp1 != null && tagHp1.length() > 0) {
	tagHp				= tagHp1 +"-"+ tagHp2 +"-"+ tagHp3;
}
String tagTel		= "";
String tagTel1		= ut.inject(request.getParameter("tag_tel1"));
String tagTel2		= ut.inject(request.getParameter("tag_tel2"));
String tagTel3		= ut.inject(request.getParameter("tag_tel3"));
if (tagTel1 != null && tagTel1.length() > 0) {
	tagTel				= tagTel1 +"-"+ tagTel2 +"-"+ tagTel3;
}
String tagZipcode	= ut.inject(request.getParameter("tag_zipcode"));
String tagAddr1		= ut.inject(request.getParameter("tag_addr1"));
String tagAddr2		= ut.inject(request.getParameter("tag_addr2"));
String tagType		= ut.inject(request.getParameter("tag_type"));
String tagRequest	= ut.inject(request.getParameter("tag_request"));
String payType		= ut.inject(request.getParameter("pay_type")); //결제수단
int payPrice		= 0; //결제금액
int goodsPrice		= 0; //총주문금액
int devlPrice		= 0; //배송비
if (request.getParameter("pay_price") != null && request.getParameter("pay_price").length()>0)
	payPrice		= Integer.parseInt(request.getParameter("pay_price"));
if (request.getParameter("goods_price") != null && request.getParameter("goods_price").length()>0)
	goodsPrice		= Integer.parseInt(request.getParameter("goods_price"));
if (request.getParameter("devl_price") != null && request.getParameter("devl_price").length()>0)
	devlPrice		= Integer.parseInt(request.getParameter("devl_price"));

String couponTprice	= ut.inject(request.getParameter("coupon_ftprice")); //상품할인 쿠폰 총금액
int couponPrice		= 0; //상품쿠폰별 금액
String couponNum	= ""; //상품쿠폰별 쿠폰번호
String groupCodes[]	= request.getParameterValues("group_code"); //상품할인 쿠폰 상품번호
String couponNums[]	= request.getParameterValues("coupon_num"); //상품할인 쿠폰 코드
String couponPrices[]= request.getParameterValues("coupon_price"); //상품별 할인 쿠폰 금액

String orderDate	= ""; //결제일
String orderState	= ""; //주문상태
String payYn		= ""; //결제성공여부

String pgTID		= ut.inject(request.getParameter("LGD_TID")); //PG 거래번호
String pgCardNo		= ut.inject(request.getParameter("LGD_CARDNUM")); //PG 신용카드번호
String pgCardFno	= ut.inject(request.getParameter("LGD_FINANCECODE")); //PG 카드코드
String pgCardName	= ut.inject(request.getParameter("LGD_FINANCENAME")); //PG 카드명
String pgVAccNo		= ut.inject(request.getParameter("LGD_ACCOUNTNUM")); //입금할 계좌 (가상계좌)
String pgAppNo		= ut.inject(request.getParameter("LGD_FINANCEAUTHNUM")); //PG 승인번호

String orderEnv		= ut.inject(request.getParameter("orderEnv")); //주문자PC환경
if (orderEnv == null || orderEnv.length()==0) orderEnv = "P";
String payMode		= ut.inject(request.getParameter("payMode")); //결제방식(test,mobile,...)
String userIp		= request.getRemoteAddr();
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
String ssType		= "";


String minDate22			= "";
String maxDate			= "";
String productName 		= "";

String devlDate22		= "";
String devlType22		= "";
int groupId			= 0;

SimpleDateFormat dt		= new SimpleDateFormat("MM/dd");
SimpleDateFormat dt222	= new SimpleDateFormat("yyyyMMdd150000");
SimpleDateFormat dt3	= new SimpleDateFormat("yyyyMMdd120000");
SimpleDateFormat cdt2	= new SimpleDateFormat("yyyy-MM-dd");
String pgCloseDate	= "20991231240000";
String pgCloseDtTmp	= "20991231240000";



if( orderNum.equals("")) {
	out.println("주문번호 누락");
	if(true)return;
}

String returnURL	= "";
orderDate			= "NOW()";
orderState			= "01";
payYn				= "Y";
if(orderEnv.equals("M")){ //모바일주문일 경우
	returnURL="location.href='/mobile/shop/payment.jsp?ono="+orderNum+"'";
}else{
	returnURL="parent.location.href='/shop/payment.jsp?ono="+orderNum+"'";
}


//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
//System.out.println("returnURL : " + returnURL);
//상품명
query1		= "SELECT GROUP_ID, GROUP_NAME, RCV_HP, DEVL_DATE, DEVL_TYPE";
query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
query1		+= " WHERE G.ID = OG.GROUP_ID";
query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
query1		+= " ORDER BY O.ID DESC";
//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
//System.out.println("1 : " + query1);
try {
	rs1 = stmt1.executeQuery(query1);
} catch(Exception e) {
	out.println(e+"=>"+query1);
	if(true)return;
}

int i		= 0;
int closeDateType	= 0;
int devlType1Count = 0;
while (rs1.next()) {
	devlType22		= rs1.getString("DEVL_TYPE");
	devlDate22		= rs1.getString("DEVL_DATE");
	groupId			= rs1.getInt("GROUP_ID");
	
	Date date		= cdt2.parse(devlDate22);
	Calendar cal	= Calendar.getInstance();
	cal.setTime(date);
	
	if (devlType22.equals("0001")) {
		devlType1Count++;
		if ( groupId == 89 ) {
			cal.add(Calendar.DATE, -2);
			pgCloseDtTmp	= dt222.format(cal.getTime());
		} else if ( closeDateType != 1 && (groupId == 32 || groupId == 40 || groupId == 69 || groupId == 92) ) {
			cal.add(Calendar.DATE, -3);
			pgCloseDtTmp	= dt3.format(cal.getTime());
		} else {
			cal.add(Calendar.DATE, -5);
			pgCloseDtTmp	= dt3.format(cal.getTime());		
		}
		
		if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) < Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
			pgCloseDate = pgCloseDtTmp;
		}
	} else {
		Calendar cal2		= Calendar.getInstance();
		SimpleDateFormat cdt	= new SimpleDateFormat("yyyyMMdd");
		cal2.setTime(new Date()); //오늘
		cal2.add(Calendar.DATE, 1);
		pgCloseDtTmp		= cdt.format(cal2.getTime()) + "120000";
		
		if ( Integer.parseInt(pgCloseDtTmp.substring(0, 10)) > Integer.parseInt(pgCloseDate.substring(0, 10)) ) {
			pgCloseDate = pgCloseDtTmp;
		}
	}

	if (i > 0) {
		productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
	} else {
		productName	= rs1.getString("GROUP_NAME");
	}
	//rcvHp			= rs.getString("RCV_HP");
	i++;
}

query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE not in ( '0300578', '0070817' )";
//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
//System.out.println("2 : " + query1);
try {
	rs1			= stmt.executeQuery(query1);
} catch(Exception e) {
	out.println(e+"=>"+query1);
	if(true)return;
}

if (rs1.next()) {
	minDate22			= ut.isnull(rs1.getString("MIN_DATE"));
	maxDate			= ut.isnull(rs1.getString("MAX_DATE"));
}
rs1.close();


if (payType.equals("30")) { //가상계좌는 주문접수로
	orderState			= "00";
	payYn				= "N";
	orderDate			= "null";
	if(rcvHp != null && rcvHp.length() > 0){
		query		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
		query		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
		query		+= " ,SEND_MESSAGE";
		query		+= " ,SUBJECT";
		query		+= " ,BACKUP_MESSAGE";
		query		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
		query		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
		query		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
		query		+= " ) VALUES (";
		query		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
		query		+= " ,'[풀무원잇슬림] \""+orderNum+"\" \""+ productName + "\" 주문완료! " + pgCloseDate.substring(4, 6) + "/" + pgCloseDate.substring(6, 8) + " " + pgCloseDate.substring(8, 10) + "시까지" + " 입금기한이 지나면 자동 주문 취소되오니 꼭 기한내에 입금부탁드립니다. ^^\r풀무원 잇슬림 카카토오톡을 통해 이달의 이벤트 및 식단 확인이 가능하시며, 주문 완료 후 고객님의 주문 정보/배송 일정/배송지 변경 등을 진행 하실 수 있습니다. 감사합니다.'";
		query		+= " ,'[풀무원잇슬림] 주문완료'";
		query		+= " ,'[풀무원잇슬림] \""+orderNum+"\" \""+ productName + "\" 주문완료! " + pgCloseDate.substring(4, 6) + "/" + pgCloseDate.substring(6, 8) + " " + pgCloseDate.substring(8, 10) + "시까지" + " 입금기한이 지나면 자동 주문 취소되오니 꼭 기한내에 입금부탁드립니다. ^^'";
		query		+= " ,'001','002','004','"+rcvHp+"'";
		query		+= " ,'02-6411-8322','R00',SYSDATE,'eat1',SYSDATE";
		query		+= " ,'kakao_es','N','잇슬림바로가기','http://www.eatsslim.co.kr','','')";
		//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
		//System.out.println("3-1 : " + query);
		
		
		try {
			stmt_kakao.executeUpdate(query);
		} catch(Exception e) {
			out.println(e+"=>"+query);
			if(true)return;
		}
	}
	
} else {
	if(rcvHp != null && !"".equals(rcvHp)){
		System.out.println("휴대폰 :" + rcvHp);
		String snsLogin = session.getAttribute("esl_member_code") == null ? "" : (String)session.getAttribute("esl_member_code");
		if("U".equals(snsLogin)){ //-- 통합로그인
			query		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
			query		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
			query		+= " ,SEND_MESSAGE";
			query		+= " ,SUBJECT";
			query		+= " ,BACKUP_MESSAGE";
			query		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
			query		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
			query		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
			query		+= " ) VALUES (";
			query		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
			query		+= " ,'[풀무원잇슬림] 잇슬림 주문이 완료되었습니다. 주문하신 잇슬림 \""+ productName + "\"이 \"" + minDate22 + "~" +maxDate + "\" 동안 배달 예정입니다.\r\r- 이달의 식단 안내 : http://www.eatsslim.co.kr/mobile/intro/schedule.jsp\r- 상세 주문 조회 및 배송 일정/배송지 변경 등을 원하실 경우 아래 링크된 풀무원고객기쁨센터를 통해 조정 가능하십니다. 감사합니다.'";
			query		+= " ,'[풀무원잇슬림] 배송안내'";
			query		+= " ,'[풀무원잇슬림] 잇슬림 주문이 완료되었습니다. \""+ productName + "\" \"" + minDate22 + "~" +maxDate + "\"동안 배달 예정입니다. 식단 안내 : 잇슬림 이달의 식단 스케쥴 URL 안내 ( http://www.eatsslim.co.kr/mobile/intro/schedule.jsp ) 배송일 변경은 받으시는 날 3일전까지 잇슬림 홈페이지 \"마이페이지>주문/배송>배송일자변경\" 또는 1:1문의하기 통하여 가능합니다. 감사합니다.'";
			query		+= " ,'001','002','004','"+rcvHp+"'";
			query		+= " ,'02-6411-8322','R00',SYSDATE,'eat6',SYSDATE";
			query		+= " ,'kakao_es','N','고객기쁨센터바로가기','http://plus.kakao.com/talk/home/@pmo_cs','','')";
			//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
			//System.out.println("3-2 : " + query);
			System.out.println(" SSO 문자 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");		
			System.out.println(query);
			System.out.println(" SSO 문자 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
			
			try {
				stmt_kakao.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
				//System.out.println("3-3 : " + e+"=>"+query);
				
				if(true)return;
			}
		}
		else{ //--SNS 로그인
			//-- 일배상품만 배송
			if(devlType1Count > 0){
				query		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
				query		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
				query		+= " ,SEND_MESSAGE";
				query		+= " ,SUBJECT";
				query		+= " ,BACKUP_MESSAGE";
				query		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
				query		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
				query		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
				query		+= " ) VALUES (";
				query		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
				query		+= " ,'[풀무원 잇슬림]\r\r잇슬림 주문이 완료되었습니다.\r\r▶ 주문제품 : \""+ productName + "\"\r\r▶ 배송기간 : \"" + minDate22 + "~" +maxDate + "\"\r\r※ 주문조회/ 배송 일정/ 배송지 변경은 잇슬림 홈페이지(www.eatsslim.co.kr) 에서 가능합니다.'";
				query		+= " ,'[풀무원잇슬림] 배송안내'";
				query		+= " ,'[풀무원 잇슬림]\r\r잇슬림 주문이 완료되었습니다.\r\r▶ 주문제품 : \""+ productName + "\"\r\r▶ 배송기간 : \"" + minDate22 + "~" +maxDate + "\"\r\r※ 주문조회/ 배송 일정/ 배송지 변경은 잇슬림 홈페이지(www.eatsslim.co.kr) 에서 가능합니다.'";
				query		+= " ,'001','002','004','"+rcvHp+"'";
				query		+= " ,'02-6411-8322','R00',SYSDATE,'eat6',SYSDATE";
				query		+= " ,'kakao_es','N','고객기쁨센터바로가기','http://plus.kakao.com/talk/home/@pmo_cs','','')";
				
			}
			else{
				query		= "INSERT INTO CUST_DELV_ALL.TSMS_AGENT_MESSAGE (";
				query		+= " MESSAGE_SEQNO, SERVICE_SEQNO";
				query		+= " ,SEND_MESSAGE";
				query		+= " ,SUBJECT";
				query		+= " ,BACKUP_MESSAGE";
				query		+= " ,BACKUP_PROCESS_CODE,MESSAGE_TYPE,CONTENTS_TYPE,RECEIVE_MOBILE_NO";
				query		+= " ,CALLBACK_NO,JOB_TYPE,SEND_RESERVE_DATE,TEMPLATE_CODE,REGISTER_DATE";
				query		+= " ,REGISTER_BY, SEND_FLAG, KKO_BTN_NAME, KKO_BTN_URL, TAX_LEVEL1_NM ,TAX_LEVEL2_NM";
				query		+= " ) VALUES (";
				query		+= " CUST_DELV_ALL.TSMS_MESSAGE_SEQ.nextval ,'1710002662'";
				query		+= " ,'[풀무원 잇슬림]\r\r잇슬림 주문이 완료되었습니다.\r\r▶ 주문제품 : \""+ productName + "\"\r\r▶배송일 : \"" + minDate22 + "\"\r\r배송일은 주말, 공휴일, 택배사 사정 등에 따라 일부 지연될 수 있습니다.\r\r\r\r※ 주문조회/ 배송 일정/ 배송지 변경은 잇슬림 홈페이지(www.eatsslim.co.kr) 에서 가능합니다.'";
				query		+= " ,'[풀무원잇슬림] 배송안내'";
				query		+= " ,'[풀무원 잇슬림]\r\r잇슬림 주문이 완료되었습니다.\r\r▶ 주문제품 : \""+ productName + "\"\r\r▶배송일 : \"" + minDate22 + "\"\r\r배송일은 주말, 공휴일, 택배사 사정 등에 따라 일부 지연될 수 있습니다.\r\r\r\r※ 주문조회/ 배송 일정/ 배송지 변경은 잇슬림 홈페이지(www.eatsslim.co.kr) 에서 가능합니다.'";
				query		+= " ,'001','002','004','"+rcvHp+"'";
				query		+= " ,'02-6411-8322','R00',SYSDATE,'eat6',SYSDATE";
				query		+= " ,'kakao_es','N','고객기쁨센터바로가기','http://plus.kakao.com/talk/home/@pmo_cs','','')";
				
			}
			System.out.println(" SNS 문자 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");		
			System.out.println(query);
			System.out.println(" SNS 문자 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
			
			try {
				stmt_kakao.executeUpdate(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				//System.out.println("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
				//System.out.println("3-3 : " + e+"=>"+query);
				
				if(true)return;
			}
			
		}
	}
	else{
		System.out.println("휴대폰 번호 없음 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
	}
		
	
	
}

//============주문서 저장 (ESL_ORDER)
query		= "UPDATE ESL_ORDER SET ";
query		+= "	PG_TID				= '"+ pgTID +"'";
query		+= "	,PG_CARDNUM			= '"+ pgCardNo +"'";
query		+= "	,PG_FINANCECODE		= '"+ pgCardFno +"'";
query		+= "	,PG_FINANCEAUTHNUM	= '"+ pgAppNo +"'";
query		+= "	,PG_FINANCENAME		= '"+ pgCardName +"'";
query		+= "	,PG_ACCOUNTNUM		= '"+ pgVAccNo +"'";
query		+= "	,PAY_YN				= '"+ payYn +"'";
query		+= "	,PAY_DATE			= "+ orderDate;
query		+= "	,ORDER_STATE		= '"+ orderState +"'";
query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

query		= "UPDATE ESL_ORDER_GOODS SET ORDER_STATE='"+ orderState +"' WHERE ORDER_NUM = '"+ orderNum +"'";	
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

//===================================상품할인 쿠폰 사용
query		= "SELECT COUPON_NUM, GROUP_ID, COUPON_PRICE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

while (rs.next()) {
	query1		= "UPDATE ESL_COUPON_MEMBER SET USE_YN='Y', USE_ORDER_NUM = '"+ orderNum +"', USE_DATE=NOW() ";
	query1		+= " WHERE COUPON_NUM='"+rs.getString("COUPON_NUM")+"' AND MEMBER_ID='"+eslMemberId+"' AND USE_YN='N'";
	try {
		stmt1.executeUpdate(query1);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}
}
rs.close();

if (payType.equals("10") || payType.equals("20")) {

	//================PHI 연동
	//int i				= 1;
	i				= 1;
	int k				= 0;
	int maxK			= 0;
	int ordSeq			= 0;
	String rcvPartner	= "";
	String tagPartner	= "";
	//SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
	dt	= new SimpleDateFormat("yyyy-MM-dd");
	Date date			= null;
	String groupCode	= "";
	int orderCnt		= 0;
	int orderCnt1		= 0;
	String devlType		= "";
	String devlDay		= "";
	String devlWeek		= "";
	String devlDate		= "";
	String devlDatePhi	= "";
	int price			= 0;
	String buyBagYn		= "";
	String customerNum	= "";
	String gubun1		= "";
	String gubun2		= "";
	String gubun3		= "";
	int week			= 1;
	int chkCnt			= 0;
	String shopType		= "52";
	String gubunCode	= "";
	int goodsId			= 0;

%>
<%@ include file="/lib/phi_insert_query.jsp"%>
<%
}

query		= "DELETE FROM ESL_CART WHERE MEMBER_ID='"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'"; //장바구니 삭제
if (oyn.equals("Y")) {
	query		+= " AND ORDER_YN = 'Y'";
}
try {
	stmt.executeUpdate(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

//================================================================================
out.println("<script type='text/javascript'>"+returnURL+"</script>");
%>
<%@ include file="/lib/dbclose.jsp" %>
<%@ include file="/lib/dbclose_bm.jsp" %>
<%@ include file="/lib/dbclose_phi.jsp" %>