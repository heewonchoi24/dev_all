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
	keyword  = "����";
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
				������� �ȳ�
			</h1>
			<div class="pageDepth">
				HOME > ��޾ȳ� > <strong>������� �ȳ�</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
			    <div class="one last  col">
				 <div class="sectionHeader">
				 <h5 class="floatleft">������ Ŭ���ϸ� ������ ��ް��������� Ȯ���Ͻ� �� �ֽ��ϴ�. �ڼ��� ��ް������� Ȯ���� "�츮�� ��ް��ɿ��� Ȯ��"�� �̿��� �ּ���.</h5>
				 <span class="floatright button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">�츮�� ��ް��ɿ��� Ȯ��</a></span>
				 <div class="clear"></div>
				 </div>
				      <ul class="deliverybtn_list">
                         <li><a <% if(keyword.equals("����")){%>class="current"<%}%> href="?keyword=����">����</a></li>
                         <li><a <% if(keyword.equals("��⵵")){%>class="current"<%}%> href="?keyword=��⵵">��⵵</a></li>
                         <li><a <% if(keyword.equals("��õ")){%>class="current"<%}%> href="?keyword=��õ">��õ</a></li>
                         <li><a <% if(keyword.equals("������")){%>class="current"<%}%> href="?keyword=������">������</a></li>
                         <li><a <% if(keyword.equals("��û����")){%>class="current"<%}%> href="?keyword=��û����">��û����</a></li>
                         <li><a <% if(keyword.equals("��û�ϵ�")){%>class="current"<%}%> href="?keyword=��û�ϵ�">��û�ϵ�</a></li>
                         <li><a <% if(keyword.equals("����")){%>class="current"<%}%> href="?keyword=����">����</a></li>
                         <li><a <% if(keyword.equals("����")){%>class="current"<%}%> href="?keyword=����">����</a></li>
                         <li><a <% if(keyword.equals("���ϵ�")){%>class="current"<%}%> href="?keyword=���ϵ�">���ϵ�</a></li>
                         <li><a <% if(keyword.equals("�뱸")){%>class="current"<%}%> href="?keyword=�뱸">�뱸</a></li>
                         <li><a <% if(keyword.equals("��󳲵�")){%>class="current"<%}%> href="?keyword=��󳲵�">��󳲵�</a></li>
                         <li><a <% if(keyword.equals("���")){%>class="current"<%}%> href="?keyword=���">���</a></li>
                         <li><a <% if(keyword.equals("�λ�")){%>class="current"<%}%> href="?keyword=�λ�">�λ�</a></li>
                         <li><a <% if(keyword.equals("����ϵ�")){%>class="current"<%}%> href="?keyword=����ϵ�">����ϵ�</a></li>
                         <li><a <% if(keyword.equals("����")){%>class="current"<%}%> href="?keyword=����">����</a></li>
                         <li><a <% if(keyword.equals("���󳲵�")){%>class="current"<%}%> href="?keyword=���󳲵�">���󳲵�</a></li>
                         <li><a <% if(keyword.equals("���ֵ�")){%>class="current"<%}%> href="?keyword=���ֵ�">���ֵ�</a></li>
                      </ul>
				   </div>
				</div>
			</div>
			<!-- End Row -->
            <div class="row">
			    <div class="one last  col">
                    <h4 class="marb5">��ް�������</h4>
                    <table class="termstable" width="100%" border="0" cellspacing="0" cellpadding="0">
						<colgroup>
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th>�������</th>
							<th>���ָ�</th>
                            <th>���ұ���</th>
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