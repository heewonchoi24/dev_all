<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

if (eslMemberId == null || eslMemberId.equals("")) {
%>
<script type="text/javascript">
alert("�α����� ���ּ���.");
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
// �Ϲ� ��� ����
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
String rcvType		= ut.inject(request.getParameter("rcv_type"));
String rcvPassYn	= ut.inject(request.getParameter("rcv_pass_yn"));
String rcvPass		= ut.inject(request.getParameter("rcv_pass"));
String rcvRequest	= ut.inject(request.getParameter("rcv_request"));

// �ù� ��� ����
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
String payType		= ut.inject(request.getParameter("pay_type")); //��������
int payPrice		= 0; //�����ݾ�
int goodsPrice		= 0; //���ֹ��ݾ�
int devlPrice		= 0; //��ۺ�
if (request.getParameter("pay_price") != null && request.getParameter("pay_price").length()>0)
	payPrice		= Integer.parseInt(request.getParameter("pay_price"));
if (request.getParameter("goods_price") != null && request.getParameter("goods_price").length()>0)
	goodsPrice		= Integer.parseInt(request.getParameter("goods_price"));
if (request.getParameter("devl_price") != null && request.getParameter("devl_price").length()>0)
	devlPrice		= Integer.parseInt(request.getParameter("devl_price"));

String couponTprice	= ut.inject(request.getParameter("coupon_ftprice")); //��ǰ���� ���� �ѱݾ�
int couponPrice		= 0; //��ǰ������ �ݾ�
String couponNum	= ""; //��ǰ������ ������ȣ
String groupCodes[]	= request.getParameterValues("group_code"); //��ǰ���� ���� ��ǰ��ȣ
String couponNums[]	= request.getParameterValues("coupon_num"); //��ǰ���� ���� �ڵ�
String couponPrices[]= request.getParameterValues("coupon_price"); //��ǰ�� ���� ���� �ݾ�

String orderDate	= ""; //������
String orderState	= ""; //�ֹ�����
String payYn		= ""; //������������

String pgTID		= ut.inject(request.getParameter("LGD_TID")); //PG �ŷ���ȣ
String pgCardNo		= ut.inject(request.getParameter("LGD_CARDNUM")); //PG �ſ�ī���ȣ
String pgCardFno	= ut.inject(request.getParameter("LGD_FINANCECODE")); //PG ī���ڵ�
String pgCardName	= ut.inject(request.getParameter("LGD_FINANCENAME")); //PG ī���
String pgVAccNo		= ut.inject(request.getParameter("LGD_ACCOUNTNUM")); //�Ա��� ���� (�������)
String pgAppNo		= ut.inject(request.getParameter("LGD_FINANCEAUTHNUM")); //PG ���ι�ȣ

String orderEnv		= ut.inject(request.getParameter("orderEnv")); //�ֹ���PCȯ��
if (orderEnv == null || orderEnv.length()==0) orderEnv = "P";
String payMode		= ut.inject(request.getParameter("payMode")); //�������(test,mobile,...)
String userIp		= request.getRemoteAddr();
String mode			= ut.inject(request.getParameter("mode"));
String oyn			= ut.inject(request.getParameter("oyn"));
String ssType		= "";

String minDate			= "";
String maxDate			= "";
String productName 		= "";

if( orderNum.equals("")) {
	out.println("�ֹ���ȣ ����");
	if(true)return;
}

String returnURL	= "";
orderDate			= "NOW()";
orderState			= "01";
payYn				= "Y";
if(orderEnv.equals("M")){ //������ֹ��� ���
	returnURL="location.href='/mobile/shop/payment.jsp?ono="+orderNum+"'";
}else{
	returnURL="parent.location.href='/shop/payment.jsp?ono="+orderNum+"'";
}

//��ǰ��
query1		= "SELECT GROUP_NAME, RCV_HP";
query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
query1		+= " WHERE G.ID = OG.GROUP_ID";
query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
query1		+= " ORDER BY O.ID DESC";
try {
	rs1 = stmt1.executeQuery(query1);
} catch(Exception e) {
	out.println(e+"=>"+query1);
	if(true)return;
}

int i		= 0;
while (rs1.next()) {
	if (i > 0) {
		productName	= rs1.getString("GROUP_NAME")+" �� "+ i +"��";
	} else {
		productName	= rs1.getString("GROUP_NAME");
	}
	//rcvHp			= rs.getString("RCV_HP");
	i++;
}

query1		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
query1		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"' AND GROUP_CODE != '0300578'";
try {
	rs1			= stmt.executeQuery(query1);
} catch(Exception e) {
	out.println(e+"=>"+query1);
	if(true)return;
}

if (rs1.next()) {
	minDate			= ut.isnull(rs1.getString("MIN_DATE"));
	maxDate			= ut.isnull(rs1.getString("MAX_DATE"));
}
rs1.close();


if (payType.equals("30")) { //������´� �ֹ�������
	orderState			= "00";
	payYn				= "N";
	orderDate			= "null";
	
	query		= "INSERT INTO uds_msg (";
	query		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query		+= " ) VALUES (";
	query		+= "	5, now()+0, now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���] \""+orderNum+"\" \""+ productName + "\" �ֹ��Ϸ�! �Աݱ����� ������ �ڵ� �ֹ� ��ҵǿ��� �� ���ѳ��� �Աݺ�Ź�帳�ϴ�. ^^')";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
} else {

	query		= "INSERT INTO uds_msg (";
	query		+= "	MSG_TYPE, CMID, REQUEST_TIME, SEND_TIME, DEST_PHONE, SEND_PHONE, SUBJECT, MSG_BODY";
	query		+= " ) VALUES (";
	query		+= "	5, now()+0, now(), now(), '"+ rcvHp +"', '02-6411-8322', '[Ǯ�����ս���]', '[Ǯ�����ս���] �ս��� �ֹ��� �Ϸ�Ǿ����ϴ�. \""+ productName + "\" \"" + minDate + "~" +maxDate + "\"���� ��� �����Դϴ�. �Ĵ� �ȳ� : �ս��� �̴��� �Ĵ� ������ URL �ȳ� ( http://www.eatsslim.co.kr/mobile/intro/schedule.jsp ) ����� ������ �����ô� �� 3�������� �ս��� Ȩ������ \"�����ս���>�ֹ�/���>������ں���\" �Ǵ� 1:1�����ϱ� ���Ͽ� �����մϴ�. �����մϴ�.')";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
}

//============�ֹ��� ���� (ESL_ORDER)
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

//===================================��ǰ���� ���� ���
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

query		= "DELETE FROM ESL_CART WHERE MEMBER_ID='"+ eslMemberId +"' AND CART_TYPE = '"+ mode +"'"; //��ٱ��� ����
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
<%@ include file="/lib/dbclose_phi.jsp" %>