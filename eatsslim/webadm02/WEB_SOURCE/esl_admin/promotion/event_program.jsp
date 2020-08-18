<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String param		= "";

int pgsize			= 10; //�������� �Խù� ��
int pagelist		= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
int endpage			= 0;
int totalPage		= 0;
int intTotalCnt		= 0;
int number;
int step			= 0;
int curNum			= 0;

String memberName	= "";
String memberId		= "";
String gender		= "";
String birthDate	= "";
String height		= "";
String weight		= "";
String smsYn		= "";
String emailYn		= "";
String kCal			= "";
String recKcal		= "";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));


query		 = "  SELECT COUNT(ID) FROM ESL_MEMBER_INFO ";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
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

query		 = " SELECT * FROM ESL_MEMBER_INFO ORDER BY INST_DATE DESC ";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:10,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���θ�ǰ��� &gt; <strong>8�� ���α׷� ��õ ȸ�� ����Ʈ</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<table class="table02" border="1" cellspacing="0">
					<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10��������</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20��������</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30��������</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100��������</option>
							</select>
						</p>
					</form>
					<colgroup>
						<col width="60px" />
						<col width="150px" />
						<col width="80px" />
						<col width="170px" />
						<col width="170px" />
						<col width="170px" />
						<col width="150px" />
						<col width="150px" />
						<col width="*" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="col"><span>No</span></th>
							<th scope="col"><span>ȸ����</span></th>
							<th scope="col"><span>����</span></th>
							<th scope="col"><span>����⵵</span></th>
							<th scope="col"><span>ü��</span></th>
							<th scope="col"><span>Ű</span></th>
							<th scope="col"><span>SMS���ŵ��ǿ���</span></th>
							<th scope="col"><span>EMAIL���ŵ��ǿ���</span></th>
							<th scope="col"><span>ó�濭��</span></th>
							<th scope="col"><span>��õ����</span></th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							curNum = curNum + 1;

							while (rs.next()) {
								memberName		= rs.getString("MEM_NAME");
								memberId		= rs.getString("MEM_ID");
								gender			= (rs.getString("GENDER").equals("M"))? "��" : "��";
								birthDate		= rs.getString("BIRTH_DATE");
								height			= rs.getString("HEIGHT");
								weight			= rs.getString("WEIGHT");
								smsYn			= rs.getString("SMS_YN");
								emailYn			= rs.getString("EMAIL_YN");
								kCal			= rs.getString("KCAL");
								recKcal			= rs.getString("REC_KCAL");

								curNum--;
						%>
						<tr>
							<td><%=curNum %></td>
							<td><a href="member_view.jsp?id=<%=memberId + param%>"><%=memberName %></td>
							<td><%=gender %></td>
							<td><%=birthDate %></td>
							<td><%=weight %> kg</td>
							<td><%=height %> cm</td>
							<td><%=smsYn %></td>
							<td><%=emailYn %></td>
							<td><%=kCal %> kcal</td>
							<td><%=recKcal %> kcal</td>
						</tr>
						<%
							}
						}else {
						%>
						<tr>
							<td colspan="10">��ϵ� ȸ���� �����ϴ�.</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
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