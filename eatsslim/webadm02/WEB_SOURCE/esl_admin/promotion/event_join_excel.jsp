<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=event_join_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int eventId			= 0;
String title		= "";
String stdate		= "";
String ltdate		= "";
int commentCnt		= 0;
int replyId			= 0;
String memberId		= "";
String memberName	= "";
String content		= "";
int tprice			= 0;
String address		= "";
String hp			= "";
String goodsName	= "";

eventId	= Integer.parseInt(request.getParameter("id"));

query		= "SELECT TITLE, STDATE, LTDATE";
query		+= " FROM ESL_EVENT";
query		+= " WHERE ID = ?";
pstmt		= conn.prepareStatement(query);
pstmt.setInt(1, eventId);
rs			= pstmt.executeQuery();

if (rs.next()) {
	title			= rs.getString("TITLE");
	stdate			= rs.getString("STDATE");
	ltdate			= rs.getString("LTDATE");
}
rs.close();

query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY WHERE ID = "+ eventId;
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	commentCnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT IDX, M_ID, M_NAME, CONTENT, GOODS_NAME FROM ESL_EVENT_REPLY WHERE ID = "+ eventId +" ORDER BY ID DESC";
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
			<th scope="row">
				<span>제목</span>
			</th>
			<td colspan="5"><%=title%></td>
		</tr>
		<tr>
			<th scope="row">
				<span>게시기간</span>
			</th>
			<td colspan="2"><%=stdate%>~<%=ltdate%></td>
			<th scope="row">
				<span>참여자수</span>
			</th>
			<td colspan="2"><%=commentCnt%></td>
		</tr>
	</tbody>
</table>
<table border="0" cellspacing="0">
	<tr>
		<th scope="row">&nbsp;</th>
		<td colspan="4">&nbsp;</td>
	</tr>
</table>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>이름</span></th>
			<th scope="col"><span>아이디</span></th>
			<th scope="col"><span>내용</span></th>
			<th scope="col"><span>총주문금액</span></th>
			<th scope="col"><span>기본주소</span></th>
			<th scope="col"><span>핸드폰번호</span></th>
		</tr>
		<%
		if (commentCnt > 0) {
			while (rs.next()) {
				replyId		= rs.getInt("IDX");
				memberId	= rs.getString("M_ID");
				memberName	= rs.getString("M_NAME");
				content		= rs.getString("CONTENT");
				tprice		= 0;
				address		= "";
				hp			= "";
				goodsName	= ut.isnull(rs.getString("GOODS_NAME"));
				
				query1		= "SELECT MEM_NAME, PURCHASE_TPRICE, ZIPCODE, ADDRESS, ADDRESS_DETAIL, HP FROM ESL_MEMBER";
				query1		+= " WHERE MEM_ID = '"+ memberId +"'";
				try {
					rs1		= stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				if (rs1.next()) {
					memberName	= rs1.getString("MEM_NAME");
					tprice		= rs1.getInt("PURCHASE_TPRICE");
					address		= "["+ rs1.getString("ZIPCODE") + "] "+ rs1.getString("ADDRESS") +" "+ rs1.getString("ADDRESS_DETAIL");
					hp			= rs1.getString("HP");
				}
		%>
		<tr>
			<td><%=memberName%></td>
			<td><%=memberId%></td>
			<td>
				<%if (!goodsName.equals("")) {%>
				[<%=goodsName%>]
				<%}%>
				<%=content%>
			</td>
			<td><%=tprice%></td>
			<td><%=address%></td>
			<td><%=hp%></td>
		</tr>
		<%
			}
		}
		%>
	</tbody>
</table>
<%@ include file="../lib/dbclose.jsp" %>