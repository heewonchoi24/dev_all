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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���������� &gt; <strong>���ι�� ����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<form name="fm" method="post" action="banner_proc.jsp" enctype="multipart/form-data">
			<input type="hidden" name="banner1_" value="<%=banner1%>" />
			<input type="hidden" name="banner2_" value="<%=banner2%>" />
			<input type="hidden" name="banner3_" value="<%=banner3%>" />
			<input type="hidden" name="banner4_" value="<%=banner4%>" />
			<input type="hidden" name="banner5_" value="<%=banner5%>" />
			<input type="hidden" name="banner6_" value="<%=banner6%>" />
			<input type="hidden" name="banner7_" value="<%=banner7%>" />

			<div id="contents">
				<table class="table02" border="1" cellspacing="0">
					<colgroup>
						<col width="12%"/>
						<col width="18.75%"/>
						<col width="25%"/>
						<col width="25%"/>
						<col width="13%"/>
						<col width="18.75%"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><span>��ȣ</span></th>
							<th scope="col"><span>�̹���</span></th>
							<th scope="col"><span>��ʸ�</span></th>
							<th scope="col"><span>�ԽñⰣ</span></th>
							<th scope="col"><span>����</span></th>
							<th scope="col"><span>����</span></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>3</td>
							<td><img src="http://placehold.it/250x55" alt="" /></td>
							<td>Ī�� �̺�Ʈ</td>
							<td>18.01.01 ~ 18.01.01</td>
							<td><div class="sort_posts"><button type="button" class="btn_sort_up">�� �Խñ� ���� �̵�</button><button type="button" class="btn_sort_down">�� �Խñ� �Ʒ��� �̵�</button></div></td>
							<td>
								<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
								<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td><img src="http://placehold.it/250x55" alt="" /></td>
							<td>Ī�� �̺�Ʈ</td>
							<td>18.01.01 ~ 18.01.01</td>
							<td><div class="sort_posts"><button type="button" class="btn_sort_up">�� �Խñ� ���� �̵�</button><button type="button" class="btn_sort_down">�� �Խñ� �Ʒ��� �̵�</button></div></td>
							<td>
								<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
								<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
							</td>
						</tr>
						<tr>
							<td>1</td>
							<td><img src="http://placehold.it/250x55" alt="" /></td>
							<td>Ī�� �̺�Ʈ</td>
							<td>18.01.01 ~ 18.01.01</td>
							<td><div class="sort_posts"><button type="button" class="btn_sort_up">�� �Խñ� ���� �̵�</button><button type="button" class="btn_sort_down">�� �Խñ� �Ʒ��� �̵�</button></div></td>
							<td>
								<a href="javascript:;" onclick="chkEdit();" class="function_btn"><span>����</span></a>
								<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
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