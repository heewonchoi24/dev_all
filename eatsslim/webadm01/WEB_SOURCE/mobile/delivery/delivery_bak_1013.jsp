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
	keyword  = "����";
}

int jj=0;

String array_area[] =  new String[17];
array_area[0] = "����";
array_area[1] = "��⵵";
array_area[2] = "��õ";
array_area[3] = "������";
array_area[4] = "��û����";
array_area[5] = "��û�ϵ�";
array_area[6] = "����";
array_area[7] = "����";
array_area[8] = "���ϵ�";
array_area[9] = "�뱸";
array_area[10] = "��󳲵�";
array_area[11] = "���";
array_area[12] = "�λ�";
array_area[13] = "����ϵ�";
array_area[14] = "����";
array_area[15] = "���󳲵�";
array_area[16] = "���ֵ�";

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
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">�Ϲ� ��۰�������</span></span></h1>
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
                <!-- <h3 class="ui-btn-up-c">��⵵</h3>
                    <div id="accordionlist">
                        <ul class="ui-listview">
                            <li class="ui-li ui-li-static ui-btn-up-e">�Ⱦ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">��õ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">�Ȼ��</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">�ϳ���</li>
                            <li class="ui-li ui-li-static ui-btn-up-e">������</li>
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