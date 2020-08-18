<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table			= "ESL_ORDER_DEVL_DATE";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String schOrderName		= ut.inject(request.getParameter("sch_order_name"));
String schReasonType	= ut.inject(request.getParameter("sch_reason_type"));
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String orderStdate		= ut.inject(request.getParameter("inst_stdate"));
String orderLtdate		= ut.inject(request.getParameter("inst_ltdate"));
String where			= "";
String param			= "";
String orderNum			= "";
String payDate			= "";
String productName		= "";
String orderName		= "";
String orderState		= "";
int refundId			= 0;
String refundYn			= "";
int refundPrice			= 0;
NumberFormat nf			= NumberFormat.getNumberInstance();

///////////////////////////
int pgsize		= 10; //페이지당 게시물 수
int pagelist	= 10; //화면당 페이지 수
int iPage;			  // 현재페이지 번호
int startpage;		  // 시작 페이지 번호
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

where			= " where devl_date > '2016-07-05'";
where			+= " and devl_type = '0001'";
where			+= " and state < 90";
where			+= " and (agencyid = '' or agencyid = 'null')";
//where			+= " group by order_num";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage			= Integer.parseInt(request.getParameter("page"));
	startpage		= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage			= 1;
	startpage		= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize			= Integer.parseInt(request.getParameter("pgsize"));

if (orderStdate != null && orderStdate.length() > 0) {
	param			+= "&amp;inst_stdate="+ orderStdate;
	where			+= " AND DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') >= '"+ orderStdate +"' ";
}

if (orderLtdate != null && orderLtdate.length() > 0) {
	param			+= "&amp;inst_ltdate="+ orderLtdate;
	where			+= " AND DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') <= '"+ orderLtdate +"' ";
}

query		= "SELECT COUNT(distinct order_num) FROM "+ table + where; //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
if (rs.next()) {
	intTotalCnt = rs.getInt(1); //총 레코드 수
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // 총 페이지 수
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT distinct order_num ";
query		+= " FROM "+ table + where;
//query		+= " ORDER BY ORDER_NUM DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();
///////////////////////////
%>
<%@ include file="../include/inc-cal-script.jsp" %>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:8,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<!-- wrap -->
<div id="wrap">
	<%@ include file="../include/inc-header.jsp" %>
	<!-- container -->
	<div id="container" class="group">
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>환불리스트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<!--table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>

							<tr>
								<th scope="row">
									<span>기간검색</span>
								</th>
								<td>
									<input type="text" name="inst_stdate" id="inst_stdate" class="input1" maxlength="10" readonly="readonly" value="<%=orderStdate%>"/>
									~
									<input type="text" name="inst_ltdate" id="inst_ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=orderLtdate%>" />
								</td>
							</tr>

						</tbody>
					</table-->
					<!--p class="btn_center"><a href="javascript:search()"><image src="../images/common/btn/btn_search.gif" alt="검색" /></a></p-->
					<div class="member_box">
						<p class="search_result">총 <strong><%=intTotalCnt%></strong>개</p>
						<p class="right_box">
							<select name="pgsize" onchange="this.form.submit()">
								<option value="10"<%if(pgsize==10)out.print(" selected");%>>10개씩보기</option>
								<option value="20"<%if(pgsize==20)out.print(" selected");%>>20개씩보기</option>
								<option value="30"<%if(pgsize==30)out.print(" selected");%>>30개씩보기</option>
								<option value="100"<%if(pgsize==100)out.print(" selected");%>>100개씩보기</option>
							</select>
						</p>
					</div>
				</form>
				<form name="frm_list" id="frm_list" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
							<col width="6%" />
							<col width="10%" />
							<col width="20%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>주문번호</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									orderNum	= rs.getString("ORDER_NUM");
							%>
							<tr>
								<td><%=curNum%></td>
								<td><a href="javascript:;" onclick="popup('order_view.jsp?ordno=<%=orderNum%>',900,720,'order_view');"><%=orderNum%></a></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="10">검색 내역이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>

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

	$('#inst_stdate,#order_ltdate').datepick({
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#inst_ltdate,#order_ltdate').datepick({
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function selectAll() {
    var checked = $("#selectall").attr("checked");

    $(".selectable").each(function(){
       var subChecked = $(this).attr("checked");
       if (subChecked != checked)
          $(this).click();
    });
}

function customRange1(dates) {
	if (this.id == 'order_stdate') {
        $('#order_ltdate').datepick('option', 'minDate', dates[0] || null);
    } else {
        $('#order_stdate').datepick('option', 'maxDate', dates[0] || null);
    }
}

function refund(rid) {
	$.post("order_refund_ajax.jsp", {
		mode: "upd",
		rid: rid
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				document.location.reload();
			} else {
				$(data).find('error').each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function refundAll() {
	var chk_del = $(".selectable:checked");

	if(chk_del.length < 1) {
		alert("환불할 메뉴를 선택하세요!");
	} else {
		if (confirm("정말로 환불처리하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();

			$.post("order_refund_ajax.jsp", {
				mode: "updAll",
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find("result").each(function() {
					if ($(this).text() == "success") {
						alert("정상적으로 처리되었습니다.");
						document.location.reload();
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
			return false;

		}
	}

}

function search(){
	var f=document.frm_search;
	//if(f.startDate.value=="" || f.endDate.value==""){alert("검색날짜를 입력하십시오.");f.startDate.focus();return;}
	f.target="";
	f.action="order_refund_list.jsp";
	f.submit();
}

function excelDown(){
	var f	= document.frm_search;
	f.target	= "ifrmHidden";
	f.action	= "order_refund_excel.jsp";
	//f.encoding="application/x-www-form-urlencoded";
	f.submit();
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>
