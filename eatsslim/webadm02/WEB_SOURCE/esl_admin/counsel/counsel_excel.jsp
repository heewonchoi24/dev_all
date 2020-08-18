<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%@ include file="/lib/dbconn_tbr.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

response.setHeader("Content-Disposition", "attachment; filename=counsel_list.xls"); 
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setHeader("Content-Type", "application/vnd.ms-excel; name='excel', text/html; charset=euc-kr");
response.setContentType("text/plain;charset=euc-kr");

String table		= "ESL_COUNSEL";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String regStdate	= ut.inject(request.getParameter("reg_stdate"));
String regLtdate	= ut.inject(request.getParameter("reg_ltdate"));
String where		= "";
String param		= "";
String memberId		= "";
String memberName	= "";
String versus		= "";
String hp			= "";
String instDate		= "";
String ansrDate		= "";
String cate1		= "";
String cate2		= "";
String cate3		= "";
String title		= "";
String state		= "";
String passDay		= "";
int versus1			= 0;
int versus2			= 0;
int intTotalCnt		= 0;

String catnm1="",catnm2="",catnm3="";
///////////////////////////
where			= " WHERE 1=1";

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (regStdate != null && regStdate.length() > 0) {
	param			+= "&amp;reg_stdate="+ regStdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') >= '"+ regStdate +"')";
}

if (regLtdate != null && regLtdate.length() > 0) {
	param			+= "&amp;reg_ltdate="+ regLtdate;
	where			+= " AND (DATE_FORMAT(INST_DATE, '%Y-%m-%d') <= '"+ regLtdate +"')";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

query		= "SELECT INST_DATE";
query+="    , TIMESTAMPDIFF(hour,INST_DATE,ifnull(ANSWER_DATE,now())) as passHour";
query+="    , TIMESTAMPDIFF(minute,INST_DATE,ifnull(ANSWER_DATE,now()))%60 as passMinute ";
query+="	, COUNSEL_TYPE, COUNSEL_TYPE, COUNSEL_TYPE, NAME, MEMBER_ID, TITLE, ANSWER_DATE, ANSWER_YN ";
query+="	, ECS_CATE1, ECS_CATE2, ECS_CATE3 ";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<table border="1" cellspacing="0">
	<tbody>
		<tr>
			<th scope="col"><span>문의일</span></th>
			<th scope="col"><span>경과시간</span></th>
			<th scope="col"><span>문의분류1</span></th>
			<th scope="col"><span>문의분류2</span></th>
			<th scope="col"><span>문의분류3</span></th>
			<th scope="col"><span>이름</span></th>
			<th scope="col"><span>아이디</span></th>
			<th scope="col"><span>제목</span></th>
			<th scope="col"><span>답변완료일</span></th>
			<th scope="col"><span>상태</span></th>
		</tr>
		<%
		while (rs.next()) {
			instDate	= rs.getString("INST_DATE");
			memberId	= rs.getString("MEMBER_ID");
			cate1		= rs.getString("ECS_CATE1");
			cate2		= rs.getString("ECS_CATE2");
			cate3		= rs.getString("ECS_CATE3");
			title		= rs.getString("TITLE");
			if(rs.getString("ANSWER_YN").equals("N")){
				state="대기중";
				//passDay=rs.getString("passDay")+"일 경과";
			}else{
				state="답변완료";
				//passDay="&nbsp;";
			}
			passDay=rs.getString("passHour")+"시간 "+rs.getString("passMinute")+"분";
			ansrDate	= rs.getString("ANSWER_DATE");

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
			
			catnm1="";
			catnm2="";
			catnm3="";
			query="select codename from v_claim_gb where code_level = 1 and use_yn = 'Y' and code ='"+cate1+"'";
			try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
			if(rs_tbr.next()){
				catnm1=rs_tbr.getString("codename");
			}
			rs_tbr.close();
			
			query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 2 and parentcode='"+cate1+"' and USE_YN = 'Y' and code ='"+cate2+"' order by code asc";
			try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
			if(rs_tbr.next()){
				catnm2=rs_tbr.getString("codename");
			}
			rs_tbr.close();

			query="select code, codename from V_CLAIM_GB where CODE_LEVEL = 3 and parentcode='"+cate1+"' and PARENTCODE2 = '"+cate2+"' and USE_YN = 'Y' and code ='"+cate3+"' order by code asc";
			try{rs_tbr = stmt_tbr.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
			if(rs_tbr.next()){
				catnm3=rs_tbr.getString("codename");
			}
			rs_tbr.close();
			
			
		%>
		<tr>
			<td><%=instDate%></td>
			<td><%=passDay%></td>
			<td><%=catnm1%></td>
			<td><%=catnm2%></td>
			<td><%=catnm3%></td>
			<td><%=memberName%></td>
			<td><%=memberId%></td>
			<td><%=title%></td>
			<td><%=ansrDate%></td>
			<td><%=state%></td>
		</tr>
		<%
			intTotalCnt--;
		}
		%>
	</tbody>
</table>
<%@ include file="/lib/dbclose_tbr.jsp"%>
<%@ include file="../lib/dbclose.jsp" %>