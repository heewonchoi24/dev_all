<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_SYSTEM_HOLIDAY";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String schYear			= ut.inject(request.getParameter("sch_year"));
String year				= "";
String where			= "";
String param			= "";
int holidayId			= 0;
String holidayType		= "";
String holiday			= "";
String holidayName		= "";
String instDate			= "";

///////////////////////////
int pgsize		= 10; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum			= 0;
where			= " WHERE 1=1";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (schYear != null && schYear.length() > 0) {
	param		+= "&amp;sch_year="+ schYear;
	where		+= " AND DATE_FORMAT(HOLIDAY, '%Y') = '"+ schYear +"'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs		= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, HOLIDAY_TYPE, HOLIDAY, HOLIDAY_NAME, COMMENT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY HOLIDAY DESC, ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query2); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ��ǰ���� &gt; <strong>�޹��ϰ���</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<%
						query1	= "SELECT DISTINCT DATE_FORMAT(HOLIDAY, '%Y') YEAR FROM ESL_SYSTEM_HOLIDAY ORDER BY ID";
						try {
							rs1 = stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}
						%>
						<tbody>
							<tr>
								<th scope="row">
									<span>�⵵</span>
								</th>
								<td>
									<select name="sch_year" id="sch_year">
										<%
										while (rs1.next()) {
											year		= rs1.getString("YEAR");
										%>
										<option value="<%=year%>"<%if (schYear.equals(year)) { out.println(" selected=\"selected\"");}%>><%=year%></option>
										<%
										}
										%>
									</select>
								</td>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>			
					<div class="member_box">
						<p class="search_result">�� <strong><%=intTotalCnt%></strong>��</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10��������</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20��������</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30��������</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100��������</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<input type="hidden" name="mode" value="updAll" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="14%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>�޹���</span></th>
								<th scope="col"><span>�޹���</span></th>
								<th scope="col"><span>�޹�����</span></th>
								<th scope="col"><span>�����</span></th>
								<th scope="col"><span>����</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									holidayId		= rs.getInt("ID");
									holidayType		= ut.getHolidayType(rs.getString("HOLIDAY_TYPE"));
									holiday			= rs.getString("HOLIDAY");
									holidayName		= rs.getString("HOLIDAY_NAME");
									instDate		= rs.getString("WDATE");
							%>
							<tr>
								<td><%=curNum%></td>
								<td><%=holiday%></td>
								<td><%=holidayName%></td>
								<td><%=holidayType%></td>
								<td><%=instDate%></td>
								<td><a href="holiday_edit.jsp?id=<%=holidayId + param%>" class="function_btn"><span>����</span></a></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">��ϵ� ��Ʈ�� �����ϴ�.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>						
					</p>
					<p class="right_btn">
						<a href="holiday_write.jsp" class="function_btn"><span>���</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging.jsp"%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>