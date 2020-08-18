<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String orderNum		= ut.inject(request.getParameter("ono"));
String reasonType	= "";
String reason		= "";
String instDate		= "";

query		= "SELECT REASON_TYPE, REASON, DATE_FORMAT(INST_DATE, '%Y.%m.%d') INST_DATE";
query		+= " FROM ESL_ORDER_CANCEL";
query		+= " WHERE ORDER_NUM = '"+ orderNum +"'";
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	reasonType		= rs.getString("REASON_TYPE");
	reason			= rs.getString("REASON");
	instDate		= rs.getString("INST_DATE");
}
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
	<title>��� �󼼳���</title>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>��� �󼼳���</h2>
		<p></p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h3>��һ���</h3>
					</div>
					<table class="inputfield" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>��һ���</th>
							<td><%=ut.getCanceReasonType(reasonType)%></td>
							<th>��ҿϷ���</th>
							<td><%=instDate%></td>
						</tr>
						<tr>
							<th>��һ��� �� ��Ÿ��û����</th>
							<td colspan="3">
								<span class="bold7"><%=ut.getCanceReasonType(reasonType)%></span>
								<p><%=ut.isnull(reason)%></p>
							</td>
						</tr>
						<!--tr>
							<th>ȯ�Ұ���</th>
							<td colspan="3">
								<p>
									<label>ȯ�Ұ�������</label>
									<input name="" type="text" class="ftfd" style="width:200px;">
								</p>
								<p>
									<label>ȯ�Ұ��� ������</label>
									<input name="" type="text" class="ftfd" style="width:200px;">
								</p>
								<p>
									<label>ȯ�Ұ��¹�ȣ</label>
									<input name="" type="text" class="ftfd" style="width:200px;">
									<span class="button dark small"><a href="#">�����ȸ</a></span>
								</p>
							</td>
						</tr-->
					</table>
				</div>
			</div>
			<div class="row">
				<div class="one last col center">
					<div class="button large dark">
						<a href="javascript:;" onclick="$.lightbox().close();;">Ȯ��</a>
					</div>
				</div>
			</div>
		</div>
		<!-- End popup columns offset-by-one -->
	</div>
	<!-- End contentpop -->
</div>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>