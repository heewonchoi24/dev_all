<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table		= "ESL_COUNSEL";
String query		= "";
String schAnswerYn	= ut.inject(request.getParameter("sch_answer_yn"));
String schCtype		= ut.inject(request.getParameter("sch_ctype"));
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int counselId		= 0;
String memberId		= "";
String counselType	= "";
String title		= "";
int hitCnt			= 0;
String instDate		= "";
String ansDate		= "";
String answerYn		= "";
String content		= "";
String name			= "";
String ansInterval	= "";

///////////////////////////
int pgsize		= 10; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " WHERE 1=1";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (schAnswerYn != null && schAnswerYn.length() > 0) {
	param		+= "&amp;sch_answer_yn="+ schAnswerYn;
	where		+= " AND ANSWER_YN = '"+ schAnswerYn +"'";
}

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
}

if (schCtype != null && schCtype.length() > 0) {
	param		+= "&amp;sch_counsel_type="+ schCtype;
	where		+= " AND COUNSEL_TYPE = '"+ schCtype +"'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��		
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT ID, MEMBER_ID, NAME, COUNSEL_TYPE, TITLE, DATE_FORMAT(INST_DATE, '%Y-%m-%d %H:%i') WDATE, DATE_FORMAT(ANSWER_DATE, '%Y-%m-%d %H:%i') ADATE,";
query		+= "	ANSWER_YN, CONTENT, TIME_FORMAT(TIMEDIFF(ANSWER_DATE, INST_DATE), '%H') INTERVAL_HOUR, TIME_FORMAT(TIMEDIFF(ANSWER_DATE, INST_DATE), '%i') INTERVAL_MIN";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:1,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-counsel.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; ���/���ǰ��� &gt; <strong>1:1 ����</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="40%" />
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>�亯����</span>
								</th>
								<td>
									<select style="width:80px;" name="sch_answer_yn">
										<option value="">����</option>
										<option value="Y"<%if(schAnswerYn.equals("Y")){out.print(" selected=\"selected\"");}%>>�亯�Ϸ�</option>
										<option value="N"<%if(schAnswerYn.equals("N")){out.print(" selected=\"selected\"");}%>>�̴亯</option>
									</select>
								</td>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="MEMBER_ID"<%if(field.equals("MEMBER_ID")){out.print(" selected=\"selected\"");}%>>���̵�</option>
											<option value="NAME"<%if(field.equals("NAME")){out.print(" selected=\"selected\"");}%>>�̸�</option>
											<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>����</option>
											<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>����</option>
											<option value="HP"<%if(field.equals("HP")){out.print(" selected=\"selected\"");}%>>����ó</option>
											<option value="EMAIL"<%if(field.equals("EMAIL")){out.print(" selected=\"selected\"");}%>>�̸���</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>��������</span>
								</th>
								<td colspan="3">
									<select name="sch_ctype" style="width:230px;">
										<option value=""<%if(schCtype.equals("")) out.println(" selected");%>>����</option>
										<option value="01"<%if(schCtype.equals("01")) out.println(" selected");%>>���</option>
										<option value="02"<%if(schCtype.equals("02")) out.println(" selected");%>>���</option>
										<option value="03"<%if(schCtype.equals("03")) out.println(" selected");%>>��ǰ�̿�</option>
										<option value="04"<%if(schCtype.equals("04")) out.println(" selected");%>>�ֹ�����</option>
										<option value="05"<%if(schCtype.equals("05")) out.println(" selected");%>>���񽺰���</option>
										<option value="09"<%if(schCtype.equals("09")) out.println(" selected");%>>��Ÿ</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="�˻�" /></p>			
					<div class="member_box">
						<p class="search_result">�� <strong><%=intTotalCnt%></strong>��</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10��������</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20��������</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30��������</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100��������</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post" action="counsel_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="6%" />
							<col width="14%" />
							<col width="*" />
							<col width="8%" />
							<col width="8%" />
							<col width="12%" />
							<col width="8%" />
							<col width="8%" />
							<col width="8%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>��������</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>���̵�</span></th>
								<th scope="col"><span>�̸�</span></th>
								<th scope="col"><span>�������<br />�亯����</span></th>
								<th scope="col"><span>�亯�ҿ�ð�</span></th>
								<th scope="col"><span>�亯����</span></th>
								<th scope="col"><span>�亯</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									counselId	= rs.getInt("ID");
									memberId	= rs.getString("MEMBER_ID");
									name		= rs.getString("NAME");
									counselType	= rs.getString("COUNSEL_TYPE");
									title		= rs.getString("TITLE");
									instDate	= rs.getString("WDATE");
									ansDate		= ut.isnull(rs.getString("ADATE"));
									answerYn	= (rs.getString("ANSWER_YN").equals("Y"))? "�亯�Ϸ�" : "�̴亯";
									content		= rs.getString("CONTENT");
									ansInterval	= (rs.getString("ANSWER_YN").equals("Y"))? rs.getString("INTERVAL_HOUR") +":"+ rs.getString("INTERVAL_MIN") : "-";
							%>
							<tr>
								<td><input type="checkbox" class="selectable" value="<%=counselId%>" /></td>
								<td><%=curNum%></td>
								<td><%=ut.getCounselType(counselType)%></td>
								<td><a href="javascript:;" onclick="showContent(<%=counselId%>)"><%=ut.cutString(120, title, "..")%></a></td>
								<td><%=memberId%></td>
								<td><%=name%></td>
								<td><%=instDate%><br /><%=ansDate%></td>
								<td><%=ansInterval%></td>
								<td><%=answerYn%></td>
								<td>
									<a href="counsel_edit.jsp?id=<%=counselId + param%>" class="function_btn"><span>�亯�ϱ�</span></a>
								</td>
							</tr>
							<tr id="content_<%=counselId%>" class="view_content hidden">
								<td colspan="10"><%=ut.nl2br(content)%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="10">��ϵ� 1:1���ǰ� �����ϴ�.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>����</span></a>						
					</p>
					<p class="right_btn" style="display:none;">
						<a href="counsel_write.jsp" class="function_btn"><span>���</span></a>
					</p>
				</div>
				<%@ include file="../include/inc-paging.jsp"%>
			</div>
			<!-- //contents -->
		</div>
		<!-- //incon -->
	</div>
	<!-- //container -->
</div>
<!-- //wrap -->
<script type="text/javascript">
$(document).ready(function() {
	$("#selectall").click(selectAll);
});

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function chkDel() {
	var chk_del = $(".selectable:checked");

	if(chk_del.length < 1) {
		alert("������ �Խù��� �����ϼ���!");
	} else {
		if (confirm("������ �����Ͻðڽ��ϱ�?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			
			$("#del_ids").val(del_ids_val);
			document.frm_list.submit();
		}
	}
}

function showContent(cid) {
	if ($("#content_"+ cid).hasClass("hidden")) {
		$(".view_content").addClass("hidden");
		$("#content_"+ cid).removeClass("hidden");
	} else {
		$("#content_"+ cid).addClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>