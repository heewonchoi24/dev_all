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
	$('#lnb').menuModel2({hightLight:{level_1:6,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
})
//]]>
</script>
<script type="text/javascript">
	function fnSave(){
		if(confirm("배너정보를 변경하시겠습니까?")){
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 게시판관리 &gt; <strong>배너관리</strong></p>
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
				<h3 class="tit_style1">배너정보</h3>
				<table class="tableView" border="1" cellspacing="0">
					<colgroup>
					<col width="100px" />
					<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><span>메인 배너</span></th>
							<td colspan="3">
								<table style="border:0px;">
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner1%>' style="width:300px;" ></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner1" value="" style="width:308px;" /> &nbsp;권장사이즈 : 999 X 407
									<br />
									제목 : <input type="text" class="input1" name="banner1_title" value="<%=banner1_title%>" style="width:300px;" />
									<br />
									링크 : <input type="text" class="input1" name="banner1_link" value="<%=banner1_link%>" style="width:300px;" />
								</td>
								</tr>
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner2%>' style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner2" value="" style="width:308px;" /> &nbsp;권장사이즈 : 999 X 407
									<br />
									제목 : <input type="text" class="input1" name="banner2_title" value="<%=banner2_title%>" style="width:300px;" />
									<br />
									링크 : <input type="text" class="input1" name="banner2_link" value="<%=banner2_link%>" style="width:300px;" />
								</td>
								</tr>
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner3%>' style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner3" value="" style="width:308px;" /> &nbsp;권장사이즈 : 999 X 407
									<br />
									제목 : <input type="text" class="input1" name="banner3_title" value="<%=banner3_title%>" style="width:300px;" />
									<br />
									링크 : <input type="text" class="input1" name="banner3_link" value="<%=banner3_link%>" style="width:300px;" />
								</td>
								</tr>
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner4%>' style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner4" value="" style="width:308px;" /> &nbsp;권장사이즈 : 999 X 407
									<br />
									제목 : <input type="text" class="input1" name="banner4_title" value="<%=banner4_title%>" style="width:300px;" />
									<br />
									링크 : <input type="text" class="input1" name="banner4_link" value="<%=banner4_link%>" style="width:300px;" />
								</td>
								</tr>
								</table>
							</td>
						</tr>

						<tr>
							<th scope="row"><span>메인 중간 배너</span></th>
							<td colspan="3">
								<table style="border:0px;">
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner5%>'  style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner5" value="" style="width:308px;" /> &nbsp;권장사이즈 : 333 X 295
									<br />
									링크 : <input type="text" class="input1" name="banner5_link" value="<%=banner5_link%>" style="width:300px;" />
								</td>
								</tr>
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner6%>'  style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner6" value="" style="width:308px;" /> &nbsp;권장사이즈 : 333 X 295
									<br />
									링크 : <input type="text" class="input1" name="banner6_link" value="<%=banner6_link%>" style="width:300px;" />
								</td>
								</tr>
								<tr>
								<td><img src='<%=webUploadDir +"banner/"+banner7%>'  style="width:300px;"></td>
								<td><br /><br /><br /><br /><br /><br />
									파일 : <input type="file" name="banner7" value="" style="width:308px;" /> &nbsp;권장사이즈 : 333 X 295
									<br />
									링크 : <input type="text" class="input1" name="banner7_link" value="<%=banner7_link%>" style="width:300px;" />
								</td>
								</tr>
								</table>
							</td>
						</tr>

					</tbody>
				</table>
				<br>
				<p class="btn_center"><a href="javascript:fnSave();" class="function_btn"><span>변경</span></a></p>
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