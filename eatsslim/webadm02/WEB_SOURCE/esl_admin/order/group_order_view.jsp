<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String orderSeq		= ut.inject(request.getParameter("ordno"));

if (orderSeq == null || orderSeq.equals("")) {
	out.println("<script>self.close();</script>");
	if (true) return;
}

String query		= "";
String query1		= "";
int tcnt			= 0;
int orderCnt		= 0;
String devlType		= "";
String devlDay		= "";
String devlWeek		= "";
String devlDate		= "";
String devlPeriod	= "";
int price			= 0;
String buyBagYn		= "";
String gubun1		= "";
String groupName	= "";
String cartImg		= "";
String devlCheck	= "";
String osubNum		= "";
String devlDates	= "";
String groupCode	= "";
NumberFormat nf = NumberFormat.getNumberInstance();

String memberId			= "";
String orderName		= "";
String payType			= "";
String orderDate		= "";
String payDate			= "";
String minDate			= "";
String maxDate			= "";
String adminMemo		= "";
String orderLog			= "";
String userIp			= request.getRemoteAddr();

String orderTel			= "";
String orderHp			= "";
String orderRequest		= "";
String rcvType			= "";
String rcvPass			= "";
String rcvPassYN		= "";
String rcvDate			= "";
String rcvName			= "";
String rcvTel			= "";
String rcvHp			= "";
String rcvZipcode		= "";
String rcvAddr1			= "";
String rcvAddr2			= "";
String rcvRequest		= "";

query		= "SELECT ";
query		+= "	ID, ORDER_NAME, ORDER_TEL, ORDER_HP, ORDER_REQUEST, ORDER_DATE, ";
query		+= "	MEMBER_ID, PAY_TYPE, RCV_NAME, RCV_TEL, RCV_HP, RCV_ZIPCODE, RCV_ADDR1, RCV_ADDR2, RCV_REQUEST,";
query		+= "	RCV_PASS_YN, RCV_PASS, RCV_DATE, ADMIN_MEMO";
query		+= " FROM ESL_ORDER_GROUP O WHERE ID = '"+ orderSeq +"'";
try {
	rs			= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	memberId		= rs.getString("MEMBER_ID");
	orderName		= rs.getString("ORDER_NAME");
	orderTel		= rs.getString("ORDER_TEL");
	orderHp			= rs.getString("ORDER_HP");
	orderRequest	= rs.getString("ORDER_REQUEST");
	payType			= rs.getString("PAY_TYPE");
	rcvName			= rs.getString("RCV_NAME");
	rcvTel			= rs.getString("RCV_TEL");
	rcvHp			= rs.getString("RCV_HP");
	rcvZipcode		= rs.getString("RCV_ZIPCODE");
	rcvAddr1		= rs.getString("RCV_ADDR1");
	rcvAddr2		= rs.getString("RCV_ADDR2");
	rcvRequest		= rs.getString("RCV_REQUEST");
	rcvDate			= rs.getString("RCV_DATE");
	orderDate		= rs.getString("ORDER_DATE");
	adminMemo		= rs.getString("ADMIN_MEMO");

	query		= "INSERT INTO ESL_PRIVACY_LOG";
	query		+= "	(WORK_ID, HOST_IP, WORK_CATE1, WORK_CATE2, WORK_URL, WORK_CUST_ID, WORK_ORDER_NUM, WORK_DATE)";
	query		+= " VALUES";
	query		+= "	('"+ eslAdminId +"', '"+ userIp +"',  '단체주문관리', '주문상세정보', '/esl_admin/order/group_order_view.jsp', '"+memberId+"', '"+orderSeq+"', NOW())";
	try {
		//stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}	
}

rs.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>Pulmuone EATSSLIM 관리자시스템</title>

	<link rel="stylesheet" type="text/css" href="../css/styles.css" />
	<style type="text/css">
	html, body { height:auto; background:#fff;}
	</style>

	<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
</head>
<body>
	<!-- popup_wrap -->
	<div class="popup_wrap">
		<h2>단체 주문상세정보</h2>
		<table class="table01 mt_5" border="1" cellspacing="0">
			<colgroup>
				<col width="100px" />
				<col width="36%" />
				<col width="100px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span>주문자</span></th>
					<td><%=orderName%>(<%=memberId%>)</td>
					<th scope="row"><span>주문일시</span></th>
					<td><%=ut.setDateFormat(orderDate, 16)%></td>
				</tr>
				<tr>
					<th scope="row"><span>연락가능번호</span></th>
					<td><%=orderTel%></td>
					<th scope="row"><span>휴대폰</span></th>
					<td><%=orderHp%></td>
				</tr>
				<tr>
					<th scope="row"><span>예약주문내역</span></th>
					<td colspan="3"><%=orderRequest%></td>
				</tr>


				<tr>
					<th scope="row"><span>받는사람</span></th>
					<td><%=orderName%></td>
				</tr>
				<tr>
					<th scope="row"><span>연락가능번호</span></th>
					<td><%=rcvTel%></td>
					<th scope="row"><span>휴대폰</span></th>
					<td><%=rcvHp%></td>
				</tr>

				<tr>
					<th scope="row"><span>희망배송일</span></th>
					<td colspan="3"><%=ut.setDateFormat(rcvDate, 16)%></td>
				</tr>
				<tr>
					<th scope="row"><span>배송주소</span></th>
					<td colspan="3">[<%=rcvZipcode%>] <%=rcvAddr1%> <%=rcvAddr2%></td>
				</tr>
				<tr>
					<th scope="row"><span>수령방법</span></th>
					<td>
						<%
						if (rcvType.equals("01")) {
							out.print("현관 앞 비치");
						} else {
							out.print("경비실 위탁 수령");
						}
						%>
					</td>
					<th scope="row"><span>출입비밀번호</span></th>
					<td>
						<%
						if (rcvPassYN.equals("N")) {
							out.print("없음");
						} else {
							out.println(rcvPass);
						}
						%>
					</td>
				</tr>
				<tr>
					<th><span>배송요청사항</span></th>
					<td colspan="3"><%=rcvRequest%></td>
				</tr>

			</tbody>
		</table>
		
		<div class="order_infor2">
			<form name="frm_memo" method="post" action="group_order_view_db.jsp">
			<input type="hidden" name="mode" value="editAdminMemo" />
			<input type="hidden" name="order_seq" value="<%=orderSeq%>" />	
			
				<table width="100%">
					<tr>
						<td width="40%"><h3>관리메모</h3></td>
						<td width="10%" align="right" style="padding-right:5px"><a href="javascript:chkForm(document.frm_memo)" class="function_btn"><span>저장</span></a></td>
						<td width="50%"><h3>처리내역</h3></td>
					</tr>
					<tr>
						<td colspan="2"><textarea class="input1" cols="" rows="" style="width:96%; height:80px; padding:5px;" name="admin_memo"><%=ut.isnull(adminMemo)%></textarea></td>
						<td><textarea cols="" rows="" style="width:98%; height:80px;padding:5px;background-color:#f9f9f9;border:1px solid #cdcdcd" name="order_log" readonly><%=ut.isnull(orderLog)%></textarea></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- //popup_wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>