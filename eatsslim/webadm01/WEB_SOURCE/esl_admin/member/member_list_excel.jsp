<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=member_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String table		= "ESL_MEMBER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String pCnt			= ut.inject(request.getParameter("p_cnt"));
String inStdate		= ut.inject(request.getParameter("in_stdate"));
String inLtdate		= ut.inject(request.getParameter("in_ltdate"));
String payStdate	= ut.inject(request.getParameter("pay_stdate"));
String payLtdate	= ut.inject(request.getParameter("pay_ltdate"));
String where		= "";
String param		= "";
String memberName	= "";
String memberId		= "";
String email		= "";
String hp			= "";
String purchaseDate	= "";
int purchasePrice	= 0;
int purchaseCnt		= 0;
String instDate		= "";
int couponCnt		= 0;
int todayCnt		= 0;
int loginCnt		= 0;
NumberFormat nf		= NumberFormat.getNumberInstance();

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE 1=1";

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (pCnt != null && pCnt.length() > 0) {
	param		+= "&amp;p_cnt="+ pCnt;
	if (pCnt.equals("1")) {
		where		+= " AND PURCHASE_CNT > 0";
	} else {
		where		+= " AND PURCHASE_CNT = 0";
	}
}

if (inStdate != null && inStdate.length() > 0) {
	param			+= "&amp;in_stdate="+ inStdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ inStdate +"')";
}

if (inLtdate != null && inLtdate.length() > 0) {
	param			+= "&amp;in_ltdate="+ inLtdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ inLtdate +"')";
}

if (payStdate != null && payStdate.length() > 0) {
	param			+= "&amp;pay_stdate="+ payStdate;
	where			+= " AND (DATE_FORMAT(PURCHASE_DATE, '%Y-%m-%d') >= '"+ payStdate +"')";
}

if (payLtdate != null && payLtdate.length() > 0) {
	param			+= "&amp;pay_stdate="+ payLtdate;
	where			+= " AND (DATE_FORMAT(PURCHASE_DATE, '%Y-%m-%d') <= '"+ payLtdate +"')";
}

query		= "SELECT ID, MEM_NAME, MEM_ID, EMAIL, HP, DATE_FORMAT(INST_DATE, '%Y-%m-%d') INST_DATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";; //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<table border="1" cellspacing="0">					
	<thead>
		<tr>
			<th>회원명</th>
			<th>아이디</th>
			<th>이메일</th>
			<th>핸드폰</th>
			<th>최종구매일</th>
			<th>결제금액</th>
			<th>구매횟수</th>
			<th>가입일</th>
			<th>쿠폰내역</th>
		</tr>
	</thead>
	<tbody>
		<%
		while (rs.next()) {
			memberName		= rs.getString("MEM_NAME");
			memberId		= rs.getString("MEM_ID");
			email			= rs.getString("EMAIL");
			hp				= rs.getString("HP");
			instDate		= rs.getString("INST_DATE");

			query1		= "SELECT COUNT(ID)";
			query1		+= " FROM ESL_COUPON_MEMBER";
			query1		+= " WHERE MEMBER_ID = '"+ memberId +"'";
			try {
				rs1 = stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				couponCnt		= rs1.getInt(1);
			}

			rs1.close();

			query1		= "SELECT COUNT(ORDER_NUM) PURCHASE_CNT, SUM(PAY_PRICE) PURCHASE_TPRICE";
			query1		+= " FROM ESL_ORDER WHERE MEMBER_ID = '"+ memberId +"'";
			query1		+= "  AND ((ORDER_STATE > 0 AND ORDER_STATE < 90) OR ORDER_STATE = '911')";
			try {
				rs1 = stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			if (rs1.next()) {
				purchaseCnt		= rs1.getInt("PURCHASE_CNT");
				purchasePrice	= rs1.getInt("PURCHASE_TPRICE");
			}

			rs1.close();

			if (purchaseCnt > 0) {
				query1		= "SELECT PAY_DATE";
				query1		+= " FROM ESL_ORDER WHERE MEMBER_ID = '"+ memberId +"'";
				query1		+= " AND ((ORDER_STATE > 0 AND ORDER_STATE < 90) OR ORDER_STATE = '911')";
				query1		+= " ORDER BY ORDER_NUM DESC LIMIT 0, 1";
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (rs1.next()) {
					purchaseDate	= ut.isnull(rs1.getString("PAY_DATE"));
				}

				rs1.close();
			} else {
				purchaseDate	= "";
			}

			purchaseDate	= (purchaseDate.equals(""))? "&nbsp;" : purchaseDate.substring(0, 10);
	%>
	<tr>
		<td><%=memberName%></td>
		<td><%=memberId%></td>
		<td><%=email%></td>
		<td><%=hp%></td>
		<td><%=purchaseDate%></td>
		<td><%=nf.format(purchasePrice)%></td>
		<td><%=purchaseCnt%></td>
		<td><%=instDate%></td>
		<td><%=couponCnt%>건</td>
	</tr>
	<%
		}
	%>
	</tbody>
</table>
<%@ include file="../lib/dbclose.jsp" %>