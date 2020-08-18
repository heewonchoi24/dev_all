<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%@ page import ="java.text.*"%>
<%
request.setCharacterEncoding("euc-kr");
NumberFormat nf		= NumberFormat.getNumberInstance();
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
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">배달지역확인</span></span></h1>
		<div class="grid-navi">
			<table class="navi" border="0" cellspacing="10" cellpadding="0">
				<tr>
					<td><a href="/mobile/delivery/delivery.jsp" class="ui-btn ui-btn-inline ui-btn-up-f"><span class="ui-btn-inner"><span class="ui-btn-text">배달 가능지역</span></span><span class="active"></span></a></td>
					<td><a href="/mobile/delivery/deliveryGuide.jsp" class="ui-btn ui-btn-inline ui-btn-up-f-line"><span class="ui-btn-inner"><span class="ui-btn-text">배달 상세안내</span></span></a></td>
				</tr>
			</table>
		</div>
		<p style="margin: 0 5%;">자세한 배달가능지역 확인은 "우리집 배달가능여부 확인"을 이용해 주세요.</p>
		<div class="marb20" style="width:250px;text-align:center;margin:4em auto;">
			<a href="javascript:;" onclick="window.open('/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0003', 'AddressPop', 'scrollbars=yes,resizable=yes,width=100%,height=auto');" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">우리집 배달가능여부 확인</span></span></a>
			<!-- <a href="javascript:void(0);" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/popup/AddressSearchJiPop.jsp?ztype=0003'});return false;" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">우리집 배달가능여부 확인</span></span></a> -->
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
		alert("검색하실 시도를 선택하세요.");
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
		alert("검색하실 시도를 선택하세요.");
		$("#sido").select();
		return false;
	} else if (!$.trim($("#gugun").val())) {
		alert("검색하실 구군을 선택하세요.");
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