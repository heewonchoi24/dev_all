<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=refund_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String table			= "ESL_ORDER O, ESL_ORDER_CANCEL C";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String schOrderName		= ut.inject(request.getParameter("sch_order_name"));
String schReasonType	= ut.inject(request.getParameter("sch_reason_type"));
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String orderStdate		= ut.inject(request.getParameter("inst_stdate"));
String orderLtdate		= ut.inject(request.getParameter("inst_ltdate"));
int totalCnt			= 0;
String where			= "";
String param			= "";
String orderNum			= "";
String payDate			= "";
String productName		= "";
String orderName		= "";
String orderState		= "";
int refundId			= 0;
String refundYn			= "";
int refundPrice			= 0;
NumberFormat nf			= NumberFormat.getNumberInstance();

where			= " WHERE O.ORDER_NUM = C.ORDER_NUM";
//where			+= " AND ((O.PAY_TYPE = '20' AND O.ORDER_STATE = '911')";
//where			+= " OR (O.PAY_TYPE > '20' AND O.ORDER_STATE IN ('90','901','91','911')))";
where			+= " AND C.BANK_NAME != '' AND O.PAY_YN = 'Y'";
where			+= " AND DATE_FORMAT(C.INST_DATE, '%Y%m%d') > '20140103'";

if (schOrderName != null && schOrderName.length() > 0) {
	schOrderName	= new String(schOrderName.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;sch_order_name="+ schOrderName;
	where			+= " AND ORDER_NAME LIKE '%"+ schOrderName +"%'";
}

if (schReasonType != null && schReasonType.length() > 0) {
	param			+= "&amp;sch_reason_type="+ schReasonType;
	where			+= " AND C.REASON_TYPE = '"+ schReasonType +"'";
}

if (orderStdate != null && orderStdate.length() > 0) {
	param			+= "&amp;inst_stdate="+ orderStdate;
	where			+= " AND DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') >= '"+ orderStdate +"' ";
}

if (orderLtdate != null && orderLtdate.length() > 0) {
	param			+= "&amp;inst_ltdate="+ orderLtdate;
	where			+= " AND DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') <= '"+ orderLtdate +"' ";
}

query		= "SELECT COUNT(O.ID) FROM "+ table;
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	totalCnt	= rs.getInt(1);
}
rs.close();

query		= "SELECT C.ID, O.ORDER_NUM, ORDER_NAME, O.ORDER_STATE, C.BANK_NAME, C.BANK_ACCOUNT, C.BANK_USER, C.REFUND_PRICE,";
query		+= "	C.PG_CANCEL";
query		+= " FROM "+ table + where;
query		+= " ORDER BY O.ORDER_NUM DESC";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>주문자</span></th>
			<th scope="col"><span>주문번호</span></th>
			<th scope="col"><span>주문상품</span></th>
			<th scope="col"><span>주문상태</span></th>
			<th scope="col"><span>환불금액</span></th>
			<th scope="col"><span>환불은행</span></th>
			<th scope="col"><span>환불계좌</span></th>
			<th scope="col"><span>예금주</span></th>
			<th scope="col"><span>환불상태</span></th>
		</tr>
		<%
		if (totalCnt > 0) {
			while (rs.next()) {
				refundId	= rs.getInt("ID");
				orderNum	= rs.getString("ORDER_NUM");
				query1		= "SELECT ";
				query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
				query1		+= "		DEVL_DAY, DEVL_WEEK";
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

				i		= 0;
				while (rs1.next()) {
					if (i > 0) {
						productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
					} else {
						productName	= rs1.getString("GROUP_NAME");
					}
					i++;
				}
				orderName	= rs.getString("ORDER_NAME");
				refundPrice	= rs.getInt("REFUND_PRICE");
				orderState	= rs.getString("ORDER_STATE");
				refundYn	= rs.getString("PG_CANCEL"); 
		%>
		<tr>
			<td><%=orderName%></td>
			<td><%=orderNum%></td>
			<td><%=productName%></td>
			<td><%=ut.getOrderState(orderState)%></td>
			<td><%=nf.format(refundPrice)%></td>
			<td><%=rs.getString("BANK_NAME")%></td>
			<td style="mso-number-format:'@'"><%=rs.getString("BANK_ACCOUNT")%></td>
			<td><%=rs.getString("BANK_USER")%></td>
			<td>
				<%if (refundYn.equals("Y")) {%>
				완료
				<%} else {%>
				미환불
				<%}%>
			</td>
		</tr>
		<%
			}
		}
		%>
	</tbody>
</table>
<%@ include file="../lib/dbclose.jsp" %>