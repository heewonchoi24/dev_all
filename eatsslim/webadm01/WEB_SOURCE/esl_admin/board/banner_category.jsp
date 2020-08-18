<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");


String query		= "";

String banner1 = "";
String banner2 = "";
String banner3 = "";
String banner4 = "";
String banner5 = "";
String banner6 = "";
String banner7 = "";
String banner1_link = "";
String banner2_link = "";
String banner3_link = "";
String banner4_link = "";
String banner5_link = "";
String banner6_link = "";
String banner7_link = "";
String banner1_title = "";
String banner2_title = "";
String banner3_title = "";
String banner4_title = "";

query = "SELECT * FROM ESL_BANNER_TEMP where no=2";
try{rs = stmt.executeQuery(query);}catch(Exception e){out.println(e+"=>"+query);if(true)return;}
if(rs.next()){
	banner1=rs.getString("banner1");
	banner2=rs.getString("banner2");
	banner3=rs.getString("banner3");
	banner4=rs.getString("banner4");
	banner5=rs.getString("banner5");
	banner6=rs.getString("banner6");
	banner7=rs.getString("banner7");
	banner1_link=rs.getString("banner1_link");
	banner2_link=rs.getString("banner2_link");
	banner3_link=rs.getString("banner3_link");
	banner4_link=rs.getString("banner4_link");
	banner5_link=rs.getString("banner5_link");
	banner6_link=rs.getString("banner6_link");
	banner7_link=rs.getString("banner7_link");
	banner1_title=rs.getString("banner1_title");
	banner2_title=rs.getString("banner2_title");
	banner3_title=rs.getString("banner3_title");
	banner4_title=rs.getString("banner4_title");
}
%>
<script type="text/javascript" src="../js/sub.js"></script>
<script type="text/javascript" src="../js/left.js"></script>
<script type="text/javascript">
//<![CDATA[
$(function(){
	$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
	$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
})
//]]>
</script>
<script type="text/javascript">
	function fnSave(){
		if(confirm("��������� �����Ͻðڽ��ϱ�?")){
			document.fm.submit();
		}
	}
</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���������� &gt; <strong>ī�װ� ��� ����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="130px" />
							<col width="40%" />
							<col width="130px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>ī�װ�</span>
								</th>
								<td>
									<select name="sch_gubun1" id="sch_gubun1" onchange="getGubun2()">
										<option value="">����1</option>
										<option value="01">�Ļ���̾�Ʈ</option>
										<option value="02">���α׷����̾�Ʈ</option>
										<option value="03">Ÿ�Ժ����̾�Ʈ</option>
										<option value="50">Ǯ��Ÿ�Ǳ��</option>
									</select>
									<select name="sch_gubun2" id="sch_gubun2">
										<option value="">����</option>
										<option value="11">1��</option>
										<option value="12">2��</option>
										<option value="13">3��</option>
										<option value="14">2��+����</option>
										<option value="15">3��+����</option>
									</select>
								</td>
								<th scope="row">
									<span>����</span>
								</th>
								<td>
									<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
										<option value="">��ü</option>
										<option value="">��Ʈ�׷��</option>
										<option value="">��Ʈ�׷��ڵ�</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>			
					<div class="member_box">
						<p class="search_result">�� <strong>1</strong>��</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="12%"/>
							<col width="18.75%"/>
							<col width="20%"/>
							<col width="20%"/>
							<col width="10.5%"/>
							<col width="18.75%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>�̹���</span></th>
								<th scope="col"><span>ī�װ�</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>�����</span></th>
								<th scope="col"><span>����</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>3</td>
								<td><img src="http://placehold.it/250x55" alt="" /></td>
								<td>�Ļ� ���̾�Ʈ > ����</td>
								<td>GNB</td>
								<td>18.01.01 ~ 18.01.01</td>
								<td>
									<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
									<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
								</td>
							</tr>
							<tr>
								<td>2</td>
								<td><img src="http://placehold.it/250x55" alt="" /></td>
								<td>�Ļ� ���̾�Ʈ > ����</td>
								<td>GNB</td>
								<td>18.01.01 ~ 18.01.01</td>
								<td>
									<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
									<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
								</td>
							</tr>
							<tr>
								<td>1</td>
								<td><img src="http://placehold.it/250x55" alt="" /></td>
								<td>�Ļ� ���̾�Ʈ > ����</td>
								<td>GNB</td>
								<td>18.01.01 ~ 18.01.01</td>
								<td>
									<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
									<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>