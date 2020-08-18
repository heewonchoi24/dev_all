<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1_phi	= null; 
ResultSet rs1_phi	= null; 
stmt1_phi			= conn_phi.createStatement();
String code			= "";
String data			= "";
String mode			= ut.inject(request.getParameter("mode"));
String schDong		= ut.inject(request.getParameter("dong"));
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
String keyword	= ut.inject(request.getParameter("keyword"));
keyword			= new String(keyword.getBytes("8859_1"), "EUC-KR");
%>
	<script type="text/javascript" src="/common/js/datefield.js"></script>
    <!-- Flash-->
    <script language="javascript">	
	function flashInsertWEB(FlashIDName, FlashFileName, FlashWidth, FlashHeight){
		document.write('<OBJECT CLASSID="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"');
		document.write('CODEBASE="//fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" ');
		document.write(' ID="'+FlashIDName+'" WIDTH="' + FlashWidth + '" HEIGHT="' + FlashHeight + '" ALIGN="center">');
		document.write('<PARAM NAME="movie" VALUE="'+ FlashFileName +'" />');
		document.write('<PARAM NAME="quality" VALUE="high" />');
		document.write('<PARAM NAME="bgcolor" VALUE="#FFFFFF" />');
		document.write('<param name="allowFullScreen" value="false" />');
		document.write('<PARAM NAME="wmode" VALUE="transparent" />');
		document.write('<PARAM NAME="allowScriptAccess" VALUE="sameDomain" />');
		document.write('<param name="base" value="." />');
		document.write('<EMBED SRC="'+ FlashFileName +'"  NAME="'+FlashIDName+'"');
		document.write(' WIDTH="' + FlashWidth + '" HEIGHT="' + FlashHeight + '" QUALITY="high" BGCOLOR="#FFFFFF"');
		document.write(' ALLOWSCRIPTACCESS="sameDomain" allowFullScreen="false" ALIGN="center" WMODE="window" TYPE="application/x-shockwave-flash" ');
		document.write(' PLUGINSPAGE="//www.macromedia.com/go/getflashplayer" >');
		document.write('</EMBED>');
		document.write('</OBJECT>');
	}	
	</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>배달지역 안내</h1>
			<div class="pageDepth">
				HOME &gt; 배달안내 &gt; <strong>배달지역 안내</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h5 class="floatleft">지역을 클릭하면 지역별 배달가능지역을 확인하실 수 있습니다. 자세한 배달가능지역 확인은 "우리집 배달가능여부 확인"을 이용해 주세요.</h5>
						<span class="floatright button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">우리집 배달가능여부 확인</a></span>
						<div class="clear"></div>
					</div>
					<div id="maindiv" style="height:519px;">
						<script type="text/javascript">
						flashInsertWEB('main', '/images/swf/flash_map.swf?city_link=/images/swf/xml/map_city.xml&area_link=/images/swf/xml/map_area.xml&state=city&chknum1=&chknum2=-1&', '999px', '519px');
						</script>
					</div>                     
				</div>
			</div>
		</div>
		<!-- End Row -->
		<div class="row">
			<div class="one last col">
				<h4 class="marb5">배달가능지역</h4>
				<table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="15%" />
						<col width="10%" />
						<col width="*" />
					</colgroup>
					<tr>
						<th>배달점명</th>
						<th>점주명</th>
						<th>관할구역</th>
					</tr>
					<tbody id="devlList">
					<%
					if (keyword != null && !keyword.equals("")) {

						query		= "SELECT DISTINCT P.PARTNERNAME, P.REPRNAME, P.PARTNERID FROM PHIBABY.V_PARTNER P, PHIBABY.V_ZIPCODE_LD Z WHERE P.PARTNERID = Z.PARTNERID AND Z.GUGUN LIKE '%"+keyword+"%' AND Z.DLVTYPE = '0001' AND DLVPTNCD = '01' ORDER BY PARTNERNAME";

						pstmt_phi	= conn_phi.prepareStatement(query);
						rs_phi		= pstmt_phi.executeQuery();

						while (rs_phi.next()) {
							parterId		= rs_phi.getString("PARTNERID");
							partnerName		= rs_phi.getString("PARTNERNAME");
							reprName		= rs_phi.getString("REPRNAME");

							query1		= "SELECT DISTINCT GUGUN, DONG FROM PHIBABY.V_ZIPCODE_OLD WHERE PARTNERID = '"+ parterId +"' ";
							rs1_phi		= stmt1_phi.executeQuery(query1);
					%>
					<tr>
						<td><%=partnerName%></td>
						<td><%=reprName%></td>
						<td class="last" style="text-align:left;">
					<%
							int i	= 0;
							while (rs1_phi.next()) {
								if (rs1_phi.getString("GUGUN").indexOf(keyword) >= 0) {
									out.println(rs1_phi.getString("GUGUN") +" "+ rs1_phi.getString("DONG"));
									out.println(", ");
									i++;
								}
							}
					%>
						</td>
					</tr>
					<%
						}
					}
					%>
					</tbody>
				</table>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
<script type="text/javascript">
function showZipcode(sido, gugun) {
	ifrmHidden.location.href = "delivery_ajax.jsp?sido="+ sido +"&gugun="+ gugun;
}
</script>
<iframe id="ifrmHidden" name="ifrmHidden" src="about:blank" style="width:100%;height:200px;display:none"></iframe>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>