<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String ref				= ut.inject(request.getParameter("ref"));
String returnUrl		= (ref.equals("") || ref == null)? request.getHeader("REFERER") : ref;
%>
	
	<script type="text/javascript" src="/common/js/common.js"></script>	
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content">
		<div class="loginform bg-gray ui-body">
			<form name="frm_login" method="post" action="login_db.jsp">
				<input type="hidden" name="mode" value="login" />
				<input type="hidden" name="return_url" value="<%=returnUrl%>" />
				<h1><span class="insert logo"></span>�α���</h1>
				<p>
					<label for="member_id">���̵�</label>
					<input type="text" name="member_id" id="member_id" style="width:120px" />
				</p>
				<p>
					<label for="member_pw">��й�ȣ</label>
					<input type="password" name="member_pw" id="member_pw" style="width:120px" />
				</p>
				<button class="logBtn" onclick="" value="�α���"><span class="insert icon-login"></span>�α���</button>
				<div class="divider"></div>
				<p>
					<input type="checkbox" id="save_id" name="save_id" value="Y" />
					<label for="save_id"><span></span>���̵� ����</label>
				</p>
			</form>
		</div>
		<div class="grid-navi">
			<table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="https://member.pulmuone.co.kr/customer/idSearch_R1.jsp?siteno=0002400000" target="_new" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">���̵� ã��</span></span></a></td>
					<td><a href="https://member.pulmuone.co.kr/customer/passSearch_R1.jsp?siteno=0002400000" target="_new" class="ui-btn ui-btn-inline ui-btn-up-d"><span class="ui-btn-inner"><span class="ui-btn-text">��й�ȣ ã��</span></span></a></td>
				</tr>
			</table>
		</div>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="https://member.pulmuone.co.kr/customer/register_R1.jsp?siteno=0002400000" target="_new" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text">ȸ�������ϱ�</span></span></a></td>
				</tr>
			</table>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	var f	= document.frm_login;
	f.member_id.focus();		
	var ck	= getCookie("userLoginId");
	if (ck!="") {
		f.member_id.value	= ck;
		f.save_id.checked	= true;
		f.member_pw.focus();
	} else {
		f.member_id.focus();
	}
});
</script>
</body>
</html>