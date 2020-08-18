<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
String table		= "ESL_GOODS_CATEGORY";
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

if(keyword == null || keyword.equals("")){
	keyword  = "서울";
}
%>
	<script type="text/javascript" src="/common/js/datefield.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				배달지역 안내
			</h1>
			<div class="pageDepth">
				HOME > 배달안내 > <strong>배달지역 안내</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				 <div class="sectionHeader">
				 <h5 class="floatleft">지역을 클릭하면 지역별 배달가능지역을 확인하실 수 있습니다. 자세한 배달가능지역 확인은 "우리집 배달가능여부 확인"을 이용해 주세요.</h5>
				 <span class="floatright button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">우리집 배달가능여부 확인</a></span>
				 <div class="clear"></div>
				 </div>
				      <ul class="deliverybtn_list">
                         <li><a <% if(keyword.equals("서울")){%>class="current"<%}%> href="?keyword=서울">서울</a></li>
                         <li><a <% if(keyword.equals("경기도")){%>class="current"<%}%> href="?keyword=경기도">경기도</a></li>
                         <li><a <% if(keyword.equals("인천")){%>class="current"<%}%> href="?keyword=인천">인천</a></li>
                         <li><a <% if(keyword.equals("강원도")){%>class="current"<%}%> href="?keyword=강원도">강원도</a></li>
                         <li><a <% if(keyword.equals("충청남도")){%>class="current"<%}%> href="?keyword=충청남도">충청남도</a></li>
                         <li><a <% if(keyword.equals("충청북도")){%>class="current"<%}%> href="?keyword=충청북도">충청북도</a></li>
                         <li><a <% if(keyword.equals("세종")){%>class="current"<%}%> href="?keyword=세종">세종</a></li>
                         <li><a <% if(keyword.equals("대전")){%>class="current"<%}%> href="?keyword=대전">대전</a></li>
                         <li><a <% if(keyword.equals("경상북도")){%>class="current"<%}%> href="?keyword=경상북도">경상북도</a></li>
                         <li><a <% if(keyword.equals("대구")){%>class="current"<%}%> href="?keyword=대구">대구</a></li>
                         <li><a <% if(keyword.equals("경상남도")){%>class="current"<%}%> href="?keyword=경상남도">경상남도</a></li>
                         <li><a <% if(keyword.equals("울산")){%>class="current"<%}%> href="?keyword=울산">울산</a></li>
                         <li><a <% if(keyword.equals("부산")){%>class="current"<%}%> href="?keyword=부산">부산</a></li>
                         <li><a <% if(keyword.equals("전라북도")){%>class="current"<%}%> href="?keyword=전라북도">전라북도</a></li>
                         <li><a <% if(keyword.equals("광주")){%>class="current"<%}%> href="?keyword=광주">광주</a></li>
                         <li><a <% if(keyword.equals("전라남도")){%>class="current"<%}%> href="?keyword=전라남도">전라남도</a></li>
                         <li><a <% if(keyword.equals("제주도")){%>class="current"<%}%> href="?keyword=제주도">제주도</a></li>
                      </ul>
				   </div>
				</div>
			</div>
			<!-- End Row -->
            <div class="row">
			    <div class="one last  col">
                    <h4 class="marb5">배달가능지역</h4>
                    <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>배달점명</th>
							<th>점주명</th>
                            <th>관할구역</th>
						</tr>
						<%
						query		= "SELECT DISTINCT P.PARTNERNAME, P.REPRNAME, P.PARTNERID FROM PHIBABY.V_PARTNER P, PHIBABY.V_ZIPCODE Z WHERE P.PARTNERID = Z.PARTNERID AND Z.SIDO LIKE '%"+keyword+"%' AND Z.DLVTYPE = '0001' AND DLVPTNCD = '01' ORDER BY PARTNERNAME";

						pstmt_phi	= conn_phi.prepareStatement(query);
						rs_phi		= pstmt_phi.executeQuery();

						while (rs_phi.next()) {
							parterId		= rs_phi.getString("PARTNERID");
							partnerName		= rs_phi.getString("PARTNERNAME");
							reprName		= rs_phi.getString("REPRNAME");

							query1		= "SELECT DISTINCT GUGUN, DONG FROM PHIBABY.V_ZIPCODE WHERE PARTNERID = '"+ parterId +"' ";
							rs1_phi		= stmt1_phi.executeQuery(query1);
						%>
						<tr>
							<td><%=partnerName%></td>
							<td><%=reprName%></td>
							<td class="last" style="text-align:left;">
								<%
								int i	= 0;
								while (rs1_phi.next()) {
									out.println(rs1_phi.getString("GUGUN") +" "+ rs1_phi.getString("DONG"));
									out.println(", ");
									i++;
								}
								%>
							</td>
						</tr>
						<%
						}
						%>
					</table>
                </div>
            </div>
			
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
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
$(document).ready(function(){
	$(".boardStyle div.post-view").hide();
	$(".boardStyle a").click(function(){
		$(".boardStyle div.post-view").slideUp(200);
		$(this).next("div.post-view").slideToggle(200);	
	})	
})
</script>
</body>
</html>