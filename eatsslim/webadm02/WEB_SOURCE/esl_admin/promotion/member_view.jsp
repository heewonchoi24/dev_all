<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%viewPage	= true;%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String memberName	= "";
String birthDate	= "";
String email		= "";
String hp			= "";
String tel			= "";
String zipcode		= "";
String address1		= "";
String address2		= "";
String sex			= "";
String param		= "";
String keyword		= "";
String memberId		= ut.inject(request.getParameter("id"));
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String userIp		= request.getRemoteAddr();
param				= "page="+ iPage +"&pgsize="+ pgsize;

if (memberId.equals("") || memberId == null) {
	ut.jsBack(out);
	if (true) return;
} else {
	query		= "SELECT MEM_NAME, BIRTH_DATE, EMAIL, HP, TEL, ZIPCODE, ADDRESS, ADDRESS_DETAIL, SEX ";
	query		+= " FROM ESL_MEMBER ";
	query		+= " WHERE MEM_ID = ? ";
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, memberId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		memberName		= ut.inject(rs.getString("MEM_NAME"));
		birthDate		= ut.inject(rs.getString("BIRTH_DATE"));
		email			= ut.inject(rs.getString("EMAIL"));
		hp				= ut.inject(rs.getString("HP"));
		tel				= ut.inject(rs.getString("TEL"));
		zipcode			= ut.inject(rs.getString("ZIPCODE"));
		address1		= ut.inject(rs.getString("ADDRESS"));
		address2		= ut.inject(rs.getString("ADDRESS_DETAIL"));
		sex				= (rs.getString("SEX").equals("M"))? "남" : "여";
	}
}
%>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:10,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 회원관리 &gt; <strong>회원목록</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<h3>회원기본정보</h3>
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
						<col width="140px" />
						<col width="40%" />
						<col width="140px" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span>회원명</span></th>
							<td><%=memberName%></td>
							<th scope="row"><span>아이디</span></th>
							<td><%=memberId%></td>
						</tr>
						<tr>
							<th scope="row"><span>생년월일</span></th>
							<td><%=birthDate.substring(0,4)+"-"+birthDate.substring(4,6)+"-"+birthDate.substring(6,8)%></td>
							<th scope="row"><span>이메일</span></th>
							<td><%=email%></td>
						</tr>
						<tr>
							<th scope="row"><span>핸드폰번호</span></th>
							<td><%=hp%></td>
							<th scope="row"><span>전화번호</span></th>
							<td><%=tel%></td>
						</tr>
						<tr>
							<th scope="row"><span>주소</span></th>
							<td colspan="3">
								<%="("+zipcode+") "+address1+" "+address2%>
							</td>
						</tr>
						<tr>
							<th scope="row"><span>성별</span></th>
							<td colspan="3"><%=sex%></td>
						</tr>
					</tbody>
				</table>
				<div class="btn_center">
					<a href="event_program.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
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