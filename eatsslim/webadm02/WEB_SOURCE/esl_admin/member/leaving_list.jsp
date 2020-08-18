<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String table		= "ESL_MEMBER_LEAVE";
String query		= "";
Statement stmt1		= null;
rs		= null;
stmt1				= conn.createStatement();
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";

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
int curNum		= 0;

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

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where + " AND SNS_ACCESS_KEY != '' "; //out.print(query1); if(true)return;
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

query		=  " SELECT MEM_ID, MEM_NAME, DATE_FORMAT(INST_DATE, '%Y-%m-%d %I:%i:%s') AS INST_DATE, INCONVENIENT_DETAILS, COMMENT_DETAILS ";
query		+= " FROM "+ table + where;
query		+= " AND SNS_ACCESS_KEY != '' ";
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-member.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ȸ������ &gt; <strong>ȸ������Ʈ</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="105px" />
							<col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="MEM_ID"<%if(field.equals("MEM_ID")){out.print(" selected=\"selected\"");}%>>���̵�</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
							</tr>
						</tbody>
					</table>
					<div class="btn_style1">
						<p class="btn_center">
							<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif"></input></p>
						</p>
					</div>
					<div class="member_box">
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
				<table class="table02" border="1" cellspacing="0">
					<colgroup>
						<col width="7%" />
						<col width="15%" />
						<col width="15%" />
						<col width="15%" />
						<col width="" />
						<col width="" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="col"><span>��ȣ</span></th>
							<th scope="col"><span>���̵�</span></th>
							<th scope="col"><span>Ż����</span></th>
							<th scope="col"><span>�������</span></th>
							<th scope="col"><span>�ڸ�Ʈ</span></th>
						</tr>
						<!-- ====================================== Ż�� ȸ�� ����Ʈ ���� ========================================== -->
						<%
						int memberCnt = 1;	// ȸ�� ����Ʈ ���� ���� ����
						String memId = "";
						String memName = "";
						String exitDate = "";
						String inconvenientDetails = "";
						String commentDetails = "";
						if (intTotalCnt > 0) {
							while (rs.next()) {
								memId				= rs.getString("MEM_ID");	// ȸ�����̵�	
								memName  			= rs.getString("MEM_NAME");	// ȸ���̸�
								exitDate			= rs.getString("INST_DATE");	// Ż��¥
								inconvenientDetails	= rs.getString("INCONVENIENT_DETAILS");	// �������
								commentDetails		= rs.getString("COMMENT_DETAILS");// �ڸ�Ʈ
						%>
						<tr>
							<td scope="col"><span><%=memberCnt %></span></td>
							<td scope="col"><span><%=memId %></span></td>
							<td scope="col"><span><%=exitDate %></span></td>
							<td scope="col"><span><%=inconvenientDetails %></span></td>
							<td scope="col"><span><%=commentDetails %></span></td>
						</tr>
						<%
								memberCnt++;
							}
						}
						%>
						<!-- ========================================= Ż�� ȸ�� ����Ʈ �� ======================================= -->
						<%
						if (intTotalCnt == 0) {
						%>
						<tr>
							<td colspan="5">��ϵ� ȸ���� �����ϴ�.</td>
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
<script type="text/javascript">
$(document).ready(function() {
	$('#in_stdate,#in_ltdate').datepick({
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#pay_stdate,#pay_ltdate').datepick({
		onSelect: customRange2,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function customRange1(dates) {
	if (this.id == 'in_stdate') {
        $('#in_ltdate').datepick('option', 'minDate', dates[0] || null);
    } else {
        $('#in_stdate').datepick('option', 'maxDate', dates[0] || null);
    }
}

function customRange2(dates) {
	if (this.id == 'pay_stdate') {
        $('#pay_ltdate').datepick('option', 'minDate', dates[0] || null);
    } else {
        $('#pay_stdate').datepick('option', 'maxDate', dates[0] || null);
    }
}

function excelDown(){
	<%if(intTotalCnt==0){%>alert("�˻��� ȸ���� �����ϴ�.");return;<%}%>
	var f	= document.frm_search;
	f.target	= "ifrmHidden";
	f.action	= "member_list_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>