<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query	= "";
String ztype	= ut.inject(request.getParameter("ztype"));
String dong		= ut.inject(request.getParameter("dong"));
String zipcode		= "";
String zipcode1		= "";
String zipcode2		= "";
String sido			= "";
String gugun		= "";
String bunji		= "";
String address		= "";
int cnt			= 0;

if (dong != null && dong.length() > 0) {
	dong		= new String(dong.getBytes("8859_1"), "EUC-KR");

	query		= "SELECT COUNT(*)FROM PHIBABY.V_ZIPCODE";
	query		+= " WHERE DONG LIKE '%"+ dong +"%'";
	if (ztype.equals("1")) {
		query		+= " AND DLVPTNCD = '01' AND DLVYN = 'Y'";
		query		+= " AND DLVTYPE = '000"+ ztype +"'";
	}

	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs_phi.next()) {
		cnt		= rs_phi.getInt(1);
	}


	query		= "SELECT ZIPCODE, SIDO, GUGUN, DONG, BUNJI, DLVTYPE FROM PHIBABY.V_ZIPCODE";
	query		+= " WHERE DONG LIKE '%"+ dong +"%'";
	if (ztype.equals("1")) {
		query		+= " AND DLVPTNCD = '01' AND DLVYN = 'Y'";
		query		+= " AND DLVTYPE = '000"+ ztype +"'";
	}

	try {
		rs_phi		= stmt_phi.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
}
%>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>�����ȣã��</h2>
		<div class="clear"></div>
	</div>
	<div class="contentpop">
		<div class="bg-gray">
			<form name="frm_zipcode" action="zipcode.jsp" method="get">
				<input type="hidden" name="ztype" id="ztype" value="<%=ztype%>" />
				<p>ã�����ϴ� ������ ��/��/��/�� �ǹ����� �Է��ϼ���.</p>
				<p class="guide">(��:����� ������ �Ż�1���� ���, '�Ż�' �Ǵ� '�Ż絿'�� �Է��Ͻø� �˴ϴ�. </p>
				<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="70"><label>�����˻�</label></td>
						<td style="padding-right:20px;"><input type="text" name="dong" id="dong" style="width:100%;"></td>
						<td width="40"><button class="ui-btn ui-mini ui-btn-up-b" onClick="schZipCode();" value="�˻�"><span class="ui-btn-inner"><span class="ui-btn-text">�˻�</span></span></button></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="row">
			<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<th width="60">�����ȣ</th>
				  <th>�ּ�</th>
					<th width="40">����</th>
			  </tr>
				<%
				if (dong != null && dong.length() > 0) {
					if (cnt > 0) {
						while (rs_phi.next()) {
							zipcode		= rs_phi.getString("ZIPCODE");
							sido		= rs_phi.getString("SIDO");
							gugun		= rs_phi.getString("GUGUN");
							dong		= rs_phi.getString("DONG");
							bunji		= (rs_phi.getString("BUNJI") != null)? rs_phi.getString("BUNJI") : "";
							address		= sido +" "+ gugun +" "+ dong +" "+ bunji;
				%>
				<tr>
					<td><%=zipcode%></td>
					<td><%=address%></td>
					<td><a href="javascript:;" onClick="setZipcode('<%=zipcode%>','<%=address%>');">���</a></td>
				</tr>
				<%
						}
					} else {
				%>
				<tr>
					<td colspan="3">�˻��� �����ȣ�� �����ϴ�.</td>
				</tr>
				<%
					}
				}
				%>
			</table>
			<!--div class="divider"></div>
			<div class="marb10" style="text-align:center;">
				<a href="#" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">������</span></span></a>
			</div-->
		</div>
	</div>
	<!-- End contentpop -->
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#dong").focus();
});

function schZipCode() {
	if (!$.trim($("#dong").val())) {
		alert("�˻�� �Է��ϼ���.");
		$("#dong").focus();
		return false;
	}

	document.frm_zipcode.submit();
}

function setZipcode(zip, addr) {
	if ($("#ztype").val() == "1") {
		$("#rcv_zipcode", parent.document).val(zip);
		$("#rcv_addr1", parent.document).val(addr);
	} else {
		$("#tag_zipcode", parent.document).val(zip);
		$("#tag_addr1", parent.document).val(addr);
	}

	parent.$.colorbox.close();
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose_phi.jsp"%>