<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query			= "";
String memberName		= "";
String birthDate		= "";
String email			= "";
String hp				= "";
String tel				= "";
String zipcode			= "";
String address1			= "";
String address2			= "";
String sex				= "";
String param			= "";
String keyword			= "";
String memberId			= ut.inject(request.getParameter("id"));
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String field			= ut.inject(request.getParameter("field"));
String pCnt				= ut.inject(request.getParameter("p_cnt"));
String inStdate			= ut.inject(request.getParameter("in_stdate"));
String inLtdate			= ut.inject(request.getParameter("in_ltdate"));
String payStdate		= ut.inject(request.getParameter("pay_stdate"));
String payLtdate		= ut.inject(request.getParameter("pay_ltdate"));
if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
String userIp			= request.getRemoteAddr();
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (memberId.equals("") || memberId == null) {
	ut.jsBack(out);
	if (true) return;
} else {
	query		= "SELECT MEM_NAME, BIRTH_DATE, EMAIL, HP, TEL, ZIPCODE, ADDRESS, ADDRESS_DETAIL, SEX";
	query		+= " FROM ESL_MEMBER";
	query		+= " WHERE MEM_ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, memberId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		memberName		= rs.getString("MEM_NAME");
		birthDate		= rs.getString("BIRTH_DATE");
		email			= rs.getString("EMAIL");
		hp				= rs.getString("HP");
		tel				= rs.getString("TEL");
		zipcode			= rs.getString("ZIPCODE");
		address1		= rs.getString("ADDRESS");
		address2		= rs.getString("ADDRESS_DETAIL");
		sex				= (rs.getString("SEX").equals("M"))? "��" : "��";
	}
	
	query		= "INSERT INTO ESL_PRIVACY_LOG";
	query		+= "	(WORK_ID, HOST_IP, WORK_CATE1, WORK_CATE2, WORK_URL, WORK_CUST_ID, WORK_ORDER_NUM, WORK_DATE)";
	query		+= " VALUES";
	query		+= "	('"+ eslAdminId +"', '"+ userIp +"',  'ȸ������', 'ȸ������Ʈ', '/esl_admin/member/member_view.jsp', '"+memberId+"', '0', NOW())";
	try {
		stmt.executeUpdate(query);
	} catch(Exception e) {
		out.println(e);
		if(true)return;
	}	
}
%>

	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-member.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ȸ������ &gt; <strong>ȸ�����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<h3>ȸ���⺻����</h3>
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="140px" />
						<col width="40%" />
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span>ȸ����</span></th>
							<td><%=memberName%></td>
							<th scope="row"><span>���̵�</span></th>
							<td><%=memberId%></td>
						</tr>
						<tr>
							<th scope="row"><span>�������</span></th>
							<td><%=birthDate.substring(0,4)+"-"+birthDate.substring(4,6)+"-"+birthDate.substring(6,8)%></td>
							<th scope="row"><span>�̸���</span></th>
							<td><%=email%></td>
						</tr>
						<tr>
							<th scope="row"><span>�ڵ�����ȣ</span></th>
							<td><%=hp%></td>
							<th scope="row"><span>��ȭ��ȣ</span></th>
							<td><%=tel%></td>
						</tr>
						<tr>
							<th scope="row"><span>�ּ�</span></th>
							<td colspan="3">
								<%="("+zipcode+") "+address1+" "+address2%>
							</td>
						</tr>
						<tr>
							<th scope="row"><span>����</span></th>
							<td colspan="3"><%=sex%></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_center">
					<a href="member_list.jsp?<%=param%>" class="function_btn"><span>���</span></a>
				</div>
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