<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table		= "ESL_FAQ";
String query		= "";
String field		= ut.inject(request.getParameter("field"));
String keyword		= ut.inject(request.getParameter("keyword"));
String where		= "";
String param		= "";
int faqId			= 0;
String schType		= ut.inject(request.getParameter("sch_type"));
String faqType		= "";
String title		= "";
int hitCnt			= 0;
String instDate		= "";

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

if (schType != null && schType.length()>0) {
	param		+= "&amp;sch_type="+ schType;
	where		+= " AND FAQ_TYPE = "+ schType;
}

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
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

query		= "SELECT ID, FAQ_TYPE, TITLE, HIT_CNT, DATE_FORMAT(INST_DATE, '%Y.%m.%d') WDATE";
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
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-board.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="Ȩ" /> &gt; �Խ��ǰ��� &gt; <strong>FAQ</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="105px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>
										<select style="width:80px;" name="sch_type" onchange="this.form.keyword.focus()">
											<option value="01"<%if(schType.equals("01")){out.print(" selected=\"selected\"");}%>>��ȯ/ȯ��</option>
											<option value="02"<%if(schType.equals("02")){out.print(" selected=\"selected\"");}%>>ȸ������</option>
											<option value="03"<%if(schType.equals("03")){out.print(" selected=\"selected\"");}%>>�������</option>
											<option value="04"<%if(schType.equals("04")){out.print(" selected=\"selected\"");}%>>��۰���</option>
											<option value="09"<%if(schType.equals("09")){out.print(" selected=\"selected\"");}%>>��Ÿ</option>
										</select>
									</span>
								</th>
								<th scope="row">
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="TITLE"<%if(field.equals("TITLE")){out.print(" selected=\"selected\"");}%>>����</option>
											<option value="CONTENT"<%if(field.equals("CONTENT")){out.print(" selected=\"selected\"");}%>>����</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()"/></td>
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
				<form name="frm_list" id="frm_list" method="post" action="faq_db.jsp">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="6%" />
							<col width="6%" />
							<col width="*" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
								<th scope="col"><span>��ȣ</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>����</span></th>
								<th scope="col"><span>��ȸ��</span></th>
								<th scope="col"><span>�����</span></th>
								<th scope="col"><span>����</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									faqId		= rs.getInt("ID");
									faqType		= ut.getFaqType(rs.getString("FAQ_TYPE"));
									title		= rs.getString("TITLE");
									hitCnt		= rs.getInt("HIT_CNT");
									instDate	= rs.getString("WDATE");
							%>
							<tr>
								<td><input type="checkbox" class="selectable" value="<%=faqId%>" /></td>
								<td><%=curNum%></td>
								<td><%=faqType%></td>
								<td><%=title%></td>
								<td><%=hitCnt%></td>
								<td><%=instDate%></td>
								<td>
									<a href="faq_edit.jsp?id=<%=faqId + param%>" class="function_btn"><span>����</span></a>
								</td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="7">��ϵ� FAQ�� �����ϴ�.</td>
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
					<p class="right_btn">
						<a href="faq_write.jsp" class="function_btn"><span>���</span></a>
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
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>