<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp"%>
<%
String table		= "ESL_GOODS_CATEGORY";
String query		= "";
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


String PARTNERNAME = "";
String pt_id = "";
String keyword		= ut.inject(request.getParameter("keyword"));
keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");

if(keyword == null || keyword.equals("")){
	keyword  = "서울";
}

int jj=0;

String array_area[] =  new String[17];
array_area[0] = "서울";
array_area[1] = "경기도";
array_area[2] = "인천";
array_area[3] = "강원도";
array_area[4] = "충청남도";
array_area[5] = "충청북도";
array_area[6] = "세종";
array_area[7] = "대전";
array_area[8] = "경상북도";
array_area[9] = "대구";
array_area[10] = "경상남도";
array_area[11] = "울산";
array_area[12] = "부산";
array_area[13] = "전라북도";
array_area[14] = "광주";
array_area[15] = "전라남도";
array_area[16] = "제주도";

%>
     <script>
	  $(function() {
		$( "#accordion" ).accordion({
		  collapsible: true
		});
	  });
	  </script>
</head>
<body>
<div id="wrap">
    <div class="ui-header ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">일배 배송가능지역</span></span></h1>
            <div id="accordion" class="row">

			
				<% for(jj=0;jj<17;jj++){ %>
                <h3 class="ui-btn-up-c"><%=array_area[jj]%></h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">


						<%
						String array_d[] = new String[999];
						String array_d2[] = new String[999];
						String array_d3[] = new String[999];

						query		= "SELECT DISTINCT P.PARTNERNAME, P.REPRNAME, P.PARTNERID FROM PHIBABY.V_PARTNER P, PHIBABY.V_ZIPCODE Z WHERE P.PARTNERID = Z.PARTNERID AND Z.SIDO LIKE '%"+array_area[jj]+"%' AND Z.DLVTYPE = '0001' ORDER BY PARTNERNAME";

						//out.print(query);
						pstmt_phi	= conn_phi.prepareStatement(query);
						rs_phi		= pstmt_phi.executeQuery();
						
						int i = 0;
						while (rs_phi.next()) {
							

							array_d[i] = rs_phi.getString("PARTNERID");
							array_d2[i] = rs_phi.getString("PARTNERNAME");
							array_d3[i] = rs_phi.getString("REPRNAME");

							
							i++;

						}
						%>

						<% for(i=0;i<100;i++){ %>
							<% if(array_d[i] !="" && array_d[i] != null){ %>
							<%
									query		= "SELECT DISTINCT GUGUN, DONG FROM PHIBABY.V_ZIPCODE WHERE PARTNERID = '"+ array_d[i] +"' ";
									pstmt_phi	= conn_phi.prepareStatement(query);
									rs_phi		= pstmt_phi.executeQuery();

									while (rs_phi.next()) {
							%>
                            <li class="ui-li ui-li-static ui-btn-up-e"><%=array_d2[i]%>&nbsp;&nbsp;&nbsp;&nbsp;<%=array_d3[i]%>&nbsp;&nbsp;&nbsp;&nbsp; <%=rs_phi.getString("GUGUN")%> <%=rs_phi.getString("DONG")%></li>
							<%	} %>
							<% } %>
						<% } %>

                        </ul>
                    </div>
					<% } %>
                <!-- <h3 class="ui-btn-up-c">경기도</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">안양시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">수원시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">과천시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">안산시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">하남시</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">성남시</li>
                        </ul>
                    </div> -->
            </div>
  </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>
</body>
</html>