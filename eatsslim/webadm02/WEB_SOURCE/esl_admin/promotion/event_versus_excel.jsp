<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=event_versus_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String table		= "ESL_EVENT_VERSUS";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
String memberId		= "";
String memberName	= "";
String versus		= "";
String hp			= "";
String instDate		= "";
String updtDate		= "";
int versus1			= 0;
int versus2			= 0;
int intTotalCnt		= 0;

///////////////////////////
where			= " WHERE 1=1";

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

query		= "SELECT ID, MEMBER_ID, VERSUS, CNT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE, DATE_FORMAT(UPDT_DATE, '%Y.%m.%d') UPDT_DATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>번호</span></th>
			<th scope="col"><span>아이디</span></th>
			<th scope="col"><span>핸드폰</span></th>
			<th scope="col"><span>이름</span></th>
			<th scope="col"><span>투표한 사람</span></th>
			<th scope="col"><span>투표횟수</span></th>
			<th scope="col"><span>1차등록일</span></th>
			<th scope="col"><span>2차등록일</span></th>
		</tr>
		<%
		while (rs.next()) {
			memberId	= rs.getString("MEMBER_ID");
			versus		= (rs.getString("VERSUS").equals("1"))? "최과장" : "이대리";
			cnt			= rs.getInt("CNT");
			instDate	= rs.getString("INST_DATE");
			updtDate	= ut.isnull(rs.getString("UPDT_DATE"));
			updtDate	= (updtDate.equals(""))? "&nbsp;" : updtDate;
			hp			= "";

			query1		= "SELECT HP, MEM_NAME FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
			try {
				rs1		= stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if (true) return;
			}

			if (rs1.next()) {
				hp				= rs1.getString("HP");
				memberName		= rs1.getString("MEM_NAME");
			}
		%>
		<tr>
			<td><%=intTotalCnt%></td>
			<td><%=memberId%></td>
			<td><%=hp%></td>
			<td><%=memberName%></td>
			<td><%=versus%></td>
			<td><%=cnt%></td>
			<td><%=instDate%></td>
			<td><%=updtDate%></td>
		</tr>
		<%
			intTotalCnt--;
		}
		%>
	</tbody>
</table>
<%@ include file="../lib/dbclose.jsp" %>