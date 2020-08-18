<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1_phi	= null; 
ResultSet rs1_phi	= null; 
stmt1_phi			= conn_phi.createStatement();
String mode			= ut.inject(request.getParameter("mode"));
String schSido		= ut.inject(request.getParameter("sido"));
if (schSido != null && schSido.length() > 0) {
	schSido				= new String(schSido.getBytes("8859_1"), "EUC-KR");
}
String schGugun		= ut.inject(request.getParameter("gugun"));
if (schGugun != null && schGugun.length() > 0) {
	schGugun			= new String(schGugun.getBytes("8859_1"), "EUC-KR");
}
String zipcode		= "";
String sido			= "";
String gugun		= "";
String dong			= "";
String bunji		= "";
String address		= "";
int cnt				= 0;
String parterId		= "";
String partnerName	= "";
String reprName		= "";
int i				= 0;

query		= "SELECT DISTINCT SIDO FROM PHIBABY.V_ZIPCODE ORDER BY SIDO";
try {
	rs_phi	= stmt_phi.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
%>
</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li class="current"><a href="/mobile/delivery/delivery.jsp">��� ��������</a></li>
			<li><a href="/mobile/delivery/deliveryGuide.jsp">��� �󼼾ȳ�</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" style="margin-top:135px;">
		<p>�ڼ��� ��ް������� Ȯ���� "�츮�� ��ް��ɿ��� Ȯ��"�� �̿��� �ּ���.</p>
		<div class="marb20" style="width:170px;text-aling:center;margin:0 auto 15px;">
			<a href="javascript:;" onclick="window.open('/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0003', 'AddressPop', 'scrollbars=yes,resizable=yes,width=100%,height=auto');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">�츮�� ��ް��ɿ��� Ȯ��</span></span></a>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#sido").change(getGugun);
	$("#gugun").change(showZipcode);
});

function getGugun() {
	if (!$.trim($("#sido").val())) {
		alert("�˻��Ͻ� �õ��� �����ϼ���.");
		$("#sido").select();
		return false;
	} else {
		var f	= document.frmZipcode;
		f.action	= "delivery_ajax.jsp";
		f.target	= "ifrmHidden";
		f.submit();
	}	
}

function showZipcode() {
	if (!$.trim($("#sido").val())) {
		alert("�˻��Ͻ� �õ��� �����ϼ���.");
		$("#sido").select();
		return false;
	} else if (!$.trim($("#gugun").val())) {
		alert("�˻��Ͻ� ������ �����ϼ���.");
		$("#gugun").select();
		return false;
	} else {
		var f	= document.frmZipcode;
		f.mode.value	= "schZipcode";
		f.action		= "delivery.jsp";
		f.target		= "";
		f.submit();
	}
}
</script>
<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none;"></iframe>
</body>
</html>
<%@ include file="/lib/dbclose_phi.jsp"%>