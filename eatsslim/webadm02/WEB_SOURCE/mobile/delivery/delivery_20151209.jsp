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

query		= "SELECT DISTINCT SIDO FROM PHIBABY.V_ZIPCODE_OLD ORDER BY SIDO";
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
			<li class="current"><a href="/mobile/delivery/delivery.jsp">배달 가능지역</a></li>
			<li><a href="/mobile/delivery/deliveryGuide.jsp">배달 상세안내</a></li>
		</ul>
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" style="margin-top:135px;">
		<p>자세한 배달가능지역 확인은 "우리집 배달가능여부 확인"을 이용해 주세요.</p>
		<div class="marb20" style="width:170px;text-aling:center;margin:0 auto 15px;">
			<a href="/mobile/shop/popup/deliverypossi.jsp" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c iframe"><span class="ui-btn-inner"><span class="ui-btn-text">우리집 배달가능여부 확인</span></span></a>
		</div>
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">일일배달 가능지역</span></span></h1>
		<form name="frmZipcode" id="frmZipcode" method="get">
			<input type="hidden" name="mode" value="getGugun" />
			<div class="row bg-gray">
				<p class="guide">* 검색하실 지역을 선택하세요.</p>
				<ul class="form-line ui-inline2">
					<li style="margin-right:5px;width:47%;">
						<div class="select-box">
							<select name="sido" id="sido">
								<option value="">선택</option>
								<%
								while (rs_phi.next()) {
									sido		= rs_phi.getString("SIDO");
								%>
								<option value="<%=sido%>"<%if (schSido.equals(sido)) out.println(" selected=\"selected\"");%>><%=sido%></option>
								<%
								}

								rs_phi.close();
								%>
							</select>
						</div>
					</li>
					<li style="width:47%;">
						<div class="select-box">
							<select name="gugun" id="gugun">
								<option value="">선택</option>
								<%
								if (mode.equals("schZipcode")) {
									query		= "SELECT DISTINCT GUGUN FROM PHIBABY.V_ZIPCODE_OLD ";
									query		+= " WHERE SIDO LIKE '%"+ schSido +"%'";
									query		+= " ORDER BY GUGUN";
									try {
										rs_phi	= stmt_phi.executeQuery(query);
									} catch(Exception e) {
										out.println(e+"=>"+query);
										if(true)return;
									}

									while (rs_phi.next()) {
										gugun		= rs_phi.getString("GUGUN");
								%>
								<option value="<%=gugun%>"<%if (schGugun.equals(gugun)) out.println(" selected=\"selected\"");%>><%=gugun%></option>
								<%
									}
								}
								%>
							</select>
						</div>
					</li>
					<div class="clear"></div>
				</ul>
			</div>
			<ul class="deli-result">
				<%
				if (mode.equals("schZipcode")) {
					query		= "SELECT DISTINCT P.PARTNERNAME, P.REPRNAME, P.PARTNERID";
					query		+= " FROM PHIBABY.V_PARTNER P, PHIBABY.V_ZIPCODE_OLD Z";
					query		+= " WHERE P.PARTNERID = Z.PARTNERID";
					query		+= " AND Z.SIDO = '"+schSido+"' AND Z.GUGUN = '"+schGugun+"'";
					query		+= " AND Z.DLVTYPE = '0001' AND DLVPTNCD = '01' ORDER BY PARTNERNAME";
					try {
						rs_phi	= stmt_phi.executeQuery(query);
					} catch(Exception e) {
						out.println(e+"=>"+query);
						if(true)return;
					}				

					while (rs_phi.next()) {
						parterId		= rs_phi.getString("PARTNERID");
						partnerName		= rs_phi.getString("PARTNERNAME");
						reprName		= rs_phi.getString("REPRNAME");

						query1		= "SELECT DISTINCT GUGUN, DONG FROM PHIBABY.V_ZIPCODE_OLD WHERE PARTNERID = '"+ parterId +"' ";
						rs1_phi		= stmt1_phi.executeQuery(query1);
				%>
				<li>
					<div class="location-title">
						<h3 class="floatleft"><%=partnerName%></h3>
						<p class="floatright"><%=reprName%></p>
						<div class="clear"></div>
					</div>
					<div class="location-list">
				<%
						while (rs1_phi.next()) {
							if (rs1_phi.getString("GUGUN").indexOf(schGugun) >= 0) {
								out.println(rs1_phi.getString("GUGUN") +" "+ rs1_phi.getString("DONG"));
								out.println(", ");
								i++;
							}
						}
				%>
					</div>
				</li>
				<%
					}
				}
				if (i < 1) {
				%>
				<li>
					<div class="location-title">
						<h3 class="floatleft">&nbsp;</h3>
						<p class="floatright">&nbsp;</p>
						<div class="clear"></div>
					</div>
					<div class="location-list">해당 지역에는 배달점이 없습니다.</div>
				</li>
				<%}%>
			</ul>
		</form>
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