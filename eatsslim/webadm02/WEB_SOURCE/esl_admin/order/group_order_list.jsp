<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String table			= "ESL_ORDER_GROUP";
String query			= "";
String query1			= "";
String schOrderNum		= ut.inject(request.getParameter("sch_order_num"));
String schName			= ut.inject(request.getParameter("sch_name"));
String stdate			= ut.inject(request.getParameter("stdate"));
String ltdate			= ut.inject(request.getParameter("ltdate"));
String addr1			= ut.inject(request.getParameter("addr1"));
String hp				= ut.inject(request.getParameter("hp"));
String tel				= ut.inject(request.getParameter("tel"));
String orderStdate		= ut.inject(request.getParameter("order_stdate"));
String orderLtdate		= ut.inject(request.getParameter("order_ltdate"));
String schOrderState	= "";
String schOrderEnv		= "";
String schPayType		= "";
String[] schOrderStates;
String[] schOrderEnvs;
String[] schPayTypes;
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String where			= "";
String param			= "";
String orderNum			= "";
String orderDate		= "";
String orderName		= "";
String orderTel			= "";
String orderProduct	= "";
String orderCnt		= "";
String payType			= "";
String orderState		= "";
String orderEnv			= "";
String shopType			= "";
NumberFormat nf			= NumberFormat.getNumberInstance();
int orderSeq			= 0;
String rcvDate			= "";
String rcvTime			= "";

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

where			= " WHERE 1=1 ";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage			= Integer.parseInt(request.getParameter("page"));
	startpage		= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage			= 1;
	startpage		= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize			= Integer.parseInt(request.getParameter("pgsize"));

if (field != null && field.length() > 0 && keyword != null && keyword.length() > 0) {
	keyword		= new String(keyword.getBytes("8859_1"), "EUC-KR");
	param		+= "&amp;field="+ field +"&amp;keyword="+ keyword;
	if (field.equals("RCV_NAME")) {
		where			+= " AND RCV_NAME LIKE '%"+ keyword +"%'";
	} else {
		where		+= " AND "+ field +" LIKE '%"+ keyword +"%'";
	}
}

if (schName != null && schName.length() > 0) {
	schName			= new String(schName.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;sch_name="+ schName;
	where			+= " AND RCV_NAME LIKE '%"+ schName +"%'";
}

if (stdate != null && stdate.length() > 0) {
	param			+= "&amp;stdate="+ stdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') >= '"+ stdate +"')";
}

if (ltdate != null && ltdate.length() > 0) {
	param			+= "&amp;ltdate="+ ltdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') <= '"+ ltdate +"')";
}

if (addr1 != null && addr1.length() > 0) {
	addr1			= new String(addr1.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;addr1="+ addr1;
	where			+= " AND RCV_ADDR1 LIKE '%"+ addr1 +"%' OR RCV_ADDR2 LIKE '%"+ addr1 +"%'";
}

if (hp != null && hp.length() > 0) {
	param			+= "&amp;hp="+ hp;
	where			+= " AND RCV_HP LIKE '%"+ hp +"%'";
}

if (tel != null && tel.length() > 0) {
	param			+= "&amp;tel="+ tel;
	where			+= " AND RCV_TEL LIKE '%"+ tel +"%'";
}

if (orderStdate != null && orderStdate.length() > 0) {
	param			+= "&amp;order_stdate="+ orderStdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') >= '"+ orderStdate +"')";
}

if (orderLtdate != null && orderLtdate.length() > 0) {
	param			+= "&amp;order_ltdate="+ orderLtdate;
	where			+= " AND (DATE_FORMAT(ORDER_DATE, '%Y-%m-%d') <= '"+ orderLtdate +"')";
}

if (request.getParameter("sch_pay_type") != null) {
	schPayType		= "'"+ request.getParameter("sch_pay_type") +"'";
	param += "&sch_pay_type=" + request.getParameter("sch_pay_type");
} else if (request.getParameterValues("sch_pay_type") != null){
	schPayTypes	= request.getParameterValues("sch_pay_type");
	for( i = 0; i < schPayTypes.length; i++ ){
		if (i==0) {
			schPayType	= "'"+ schPayTypes[i] +"'";
		} else {
			schPayType	+= ",'"+ schPayTypes[i] +"'";
		}
	}
	param += "&sch_pay_type=" + schPayType;
}

if (!schPayType.equals("")) where += " AND PAY_TYPE IN ("+schPayType+")";

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query); if(true)return;
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

query		= "SELECT ID, ORDER_NAME, ORDER_HP, ORDER_PRODUCT, ORDER_CNT, PAY_TYPE, ORDER_ENV, RCV_DATE, RCV_TIME, ORDER_DATE ";
query		+= " FROM "+ table + where;
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
		$('#lnb').menuModel2({hightLight:{level_1:7,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
		leftcon();
	})
	//]]>
	</script><link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>	
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
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
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; <strong>주문상세관리</strong></p>
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
									<span>
										<select style="width:80px;" name="field" onchange="this.form.keyword.focus()">
											<option value="RCV_NAME"<%if(field.equals("RCV_NAME")){out.print(" selected=\"selected\"");}%>>주문자명</option>
											<option value="MEMBER_ID"<%if(field.equals("MEMBER_ID")){out.print(" selected=\"selected\"");}%>>아이디</option>
										</select>
									</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="keyword" value="<%=keyword%>" onfocus="this.select()" /></td>
							</tr>
							<tr>
								<th scope="row">
									<span>연락가능번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="hp" value="<%=hp%>" onfocus="this.select()"/></td>
								<th scope="row">
									<span>휴대폰번호</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="tel" value="<%=tel%>" onfocus="this.select()"/></td>
							</tr>							
							<tr>
								<th scope="row">
									<span>주문일</span>
								</th>
								<td>
									<input type="text" name="order_stdate" id="order_stdate" class="input1" maxlength="10" readonly="readonly" />
									~
									<input type="text" name="order_ltdate" id="order_ltdate" class="input1" maxlength="10" readonly="readonly" />
								</td>
								<th scope="row">
									<span>희망 배송일</span>
								</th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="10" readonly="readonly" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="10" readonly="readonly" value="<%=ltdate%>" />
								</td>
							</tr>

							<tr>
								<th scope="row">
									<span>결제수단</span>
								</th>
								<td>
									<input type="checkbox" name="sch_pay_type" value="10"<%=ut.getArrCheck(schPayType, "10", " checked=\"checked\"")%> />
									신용카드
									<input type="checkbox" name="sch_pay_type" value="20"<%=ut.getArrCheck(schPayType, "20", " checked=\"checked\"")%> />
									계좌이체
									<input type="checkbox" name="sch_pay_type" value="30"<%=ut.getArrCheck(schPayType, "30", " checked=\"checked\"")%> />
									가상계좌(무통장)
								</td>
							</tr>
						</tbody>
					</table>
					<p class="btn_center"><input type="image" src="../images/common/btn/btn_search.gif" alt="검색" /></p>
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
				<form name="frm_list" id="frm_list" method="post" action="order_list_ajax.jsp">
					<input type="hidden" name="mode" value="del" />
					<input type="hidden" name="del_ids" id="del_ids" />
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>주문자</span></th>
								<th scope="col"><span>주문일시</span></th>
								<th scope="col"><span>수령일</span></th>
								<th scope="col"><span>수령시간</span></th>
								<th scope="col"><span>예약주문내역</span></th>
								<th scope="col"><span>예약주문수량</span></th>
								<th scope="col"><span>결제수단</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {

									orderSeq	= rs.getInt("ID");
									orderName	= rs.getString("ORDER_NAME");
									orderTel	= rs.getString("ORDER_HP");
									orderDate	= rs.getString("ORDER_DATE");
									payType		= rs.getString("PAY_TYPE");
									orderProduct= rs.getString("ORDER_PRODUCT");
									orderCnt= rs.getString("ORDER_CNT");
									orderEnv	= (rs.getString("ORDER_ENV").equals("P"))? "PC" : "Mobile";
									
									rcvDate			= rs.getString("RCV_DATE");
									rcvTime			= rs.getString("RCV_TIME");
									
							%>
							<tr>
								<td><%=curNum%></td>
								<td><a href="javascript:;" onclick="popup('group_order_view.jsp?ordno=<%=orderSeq%>',900,720,'group_order_view');"><%=orderName%></a></td>
								<td><%=ut.setDateFormat(orderDate, 10)%></td>
								<td><%=ut.setDateFormat(rcvDate, 10)%></td>
								<td><%=rcvTime%>시</td>
								<td><%=ut.getGroupProductName(orderProduct)%></td>
								<td><%=orderCnt%></td>
								<td><%=ut.getPayType(payType)%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="10">등록된 주문내역이 없습니다.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</form>
				<!--div class="btn_style1">
					<p class="left_btn">
						<a href="javascript:;" onclick="chkDel();" class="function_btn"><span>삭제</span></a>						
					</p>
				</div-->
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
	
	$('#order_stdate,#order_ltdate').datepick({ 
		onSelect: customRange1,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#pay_stdate,#pay_ltdate').datepick({ 
		onSelect: customRange2,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$('#stdate,#ltdate').datepick({ 
		onSelect: customRange3,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
});

function customRange1(dates) {
	if (this.id == 'order_stdate') { 
        $('#order_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#order_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function customRange2(dates) {
	if (this.id == 'pay_stdate') { 
        $('#pay_ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#pay_stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

function customRange3(dates) {
	if (this.id == 'stdate') { 
        $('#ltdate').datepick('option', 'minDate', dates[0] || null); 
    } else { 
        $('#stdate').datepick('option', 'maxDate', dates[0] || null); 
    }
}

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
		alert("삭제할 메뉴를 선택하세요!");
	} else {
		if (confirm("정말로 삭제하시겠습니까?")) {
			var del_arr = new Array();
			var i = 0;
			$(".selectable:checked").each(function() {
				del_arr[i] = $(this).val();
				i++;
			});
			var del_ids_val = del_arr.join();
			
			$("#del_ids").val(del_ids_val);
			document.frm_list.submit();
/*
			$.post("order_list_ajax.jsp", {
				mode: 'del', 
				del_ids: del_ids_val
			},
			function(data) {
				$(data).find('result').each(function() {
					if ($(this).text() == 'success') {
						alert('삭제되었습니다.');
						location.href = 'order_list.jsp';
					} else {
						$(data).find('error').each(function() {
							alert($(this).text());
						});
					}
				});
			}, "xml");
			*/
		}
	}
}
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>