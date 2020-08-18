<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%@ include file="../include/inc-cal-script.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int eventId			= 0;
String title		= "";
String stdate		= "";
String ltdate		= "";
int commentCnt		= 0;
int replyId			= 0;
String memberId		= "";
String memberName	= "";
String content		= "";
String goodsName	= "";
String param		= "";
String keyword		= "";
String iPage		= ut.inject(request.getParameter("page"));
String pgsize		= ut.inject(request.getParameter("pgsize"));
String field		= ut.inject(request.getParameter("field"));

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT TITLE, STDATE, LTDATE";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
	}
	rs.close();

	query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY WHERE ID = "+ eventId;
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	
	if (rs.next()) {
		commentCnt		= rs.getInt(1);
	}
	rs.close();

	query		= "SELECT IDX, M_ID, M_NAME, CONTENT, GOODS_NAME FROM ESL_EVENT_REPLY WHERE ID = "+ eventId +" ORDER BY IDX DESC";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>
	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:3,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>이벤트참여현황</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
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
								<span>제목</span>
							</th>
							<td colspan="3"><%=title%></td>
						</tr>
						<tr>
							<th scope="row">
								<span>게시기간</span>
							</th>
							<td><%=stdate%>~<%=ltdate%></td>
							<th scope="row">
								<span>참여자수</span>
							</th>
							<td><%=commentCnt%></td>
						</tr>
					</tbody>
				</table>
				<form name="frm_list" id="frm_list" method="post" action="event_join_db.jsp">
					<input type="hidden" name="mode" id="mode" />
					<input type="hidden" name="del_id" id="del_id" />
					<input type="hidden" name="id" value="<%=eventId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="coupon_id" id="coupon_id" />
					<div id="memberList" style="overflow:auto;height:400px;">
						<table class="table02" border="1" cellspacing="0">
							<colgroup>
								<col width="6%" />
								<col width="10%" />
								<col width="10%" />
								<col width="*" />
								<col width="10%" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="col"><span><input type="checkbox" id="selectall" /></span></td>
									<th scope="col"><span>이름</span></th>
									<th scope="col"><span>아이디</span></th>
									<th scope="col"><span>내용</span></th>
									<th scope="col"><span>삭제</span></th>
								</tr>
								<%
								if (commentCnt > 0) {
									while (rs.next()) {
										replyId		= rs.getInt("IDX");
										memberId	= rs.getString("M_ID");
										memberName	= rs.getString("M_NAME");
										query1		= "SELECT MEM_NAME FROM ESL_MEMBER WHERE MEM_ID = '"+ memberId +"'";
										try {
											rs1		= stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query1);
											if(true)return;
										}

										if (rs1.next()) {
											memberName		= rs1.getString("MEM_NAME");
										}
										content		= rs.getString("CONTENT");
										goodsName	= ut.isnull(rs.getString("GOODS_NAME"));
								%>
								<tr>
									<td><input type="checkbox" name="member_id" class="selectable" value="<%=memberId%>" /></td>
									<td><%=memberName%></td>
									<td><%=memberId%></td>
									<td>
										<%if (!goodsName.equals("")) {%>
										[<%=goodsName%>]
										<%}%>
										<%=content%>
									</td>
									<td><a href="javascript:;" onclick="chkDel(<%=replyId%>);" class="function_btn"><span>삭제</span></a></td>
								</tr>
								<%
									}
								} else {
								%>
								<tr>
									<td colspan="5">등록된 참여자가 없습니다.</td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</form>
				<div class="btn_style1">
					<p class="right_btn">
						<a href="javascript:;" onclick="issueCouponList();" class="function_btn"><span>기존쿠폰지급</span></a>
						<a href="javascript:;" onclick="issueCoupon();" class="function_btn"><span>신규쿠폰발급</span></a>
						<a href="javascript:;" onclick="excelDown();" class="function_btn"><span>엑셀다운로드</span></a>
						<a href="event_join_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</p>
				</div>
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

function chkDel(delId) {
	if (confirm("정말로 삭제하시겠습니까?")) {
		$("#mode").val("del");
		$("#del_id").val(delId);
		document.frm_list.submit();
	}
}

function issueCoupon() {
	var chk_id = $(".selectable:checked");

	if(chk_id.length < 1) {
		alert("쿠폰지급할 회원을 선택하세요!");
	} else {
		document.frm_list.action = "event_join_write.jsp";
		document.frm_list.submit();
	}
}

function issueCouponList() {
	var chk_id = $(".selectable:checked");

	if(chk_id.length < 1) {
		alert("쿠폰지급할 회원을 선택하세요!");
	} else {
		document.frm_list.action = "event_join_db.jsp";
		popup('coupon_search.jsp',470,500,'couponList');
	}
}

function excelDown(){
	var f	= document.frm_list;
	f.target	= "ifrmHidden";
	f.action	= "event_join_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();	
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>