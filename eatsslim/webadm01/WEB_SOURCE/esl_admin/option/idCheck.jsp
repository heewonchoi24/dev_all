<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String adminId		= ut.inject(request.getParameter("admin_id"));

query		= "SELECT COUNT(*) FROM ESL_ADMIN WHERE ADMIN_ID = '"+ adminId +"'";
//out.println(query);if(true)return;
rs = stmt.executeQuery(query);
if(rs.next()){
	if (rs.getInt(1) > 0) {
%>
	<script type="text/javascript">
		$("#resultID", parent.document).text("사용 불가능한 아이디입니다.");
		$("#hiddenID", parent.document).val("");
	</script>
<%}else{%>
	<script type="text/javascript">
		$("#resultID", parent.document).text("사용 가능한 아이디입니다.");
		$("#hiddenID", parent.document).val("<%=adminId%>");
	</script>
<%}
}
%>
<%@ include file="../lib/dbclose.jsp" %>