<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<%
String table			= "ESL_ORDER O, ESL_ORDER_CANCEL C";
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String schOrderName		= ut.inject(request.getParameter("sch_order_name"));
String schReasonType	= ut.inject(request.getParameter("sch_reason_type"));
String cancelStdate		= ut.inject(request.getParameter("cancel_stdate"));
String cancelLtdate		= ut.inject(request.getParameter("cancel_ltdate"));
String field			= ut.inject(request.getParameter("field"));
String keyword			= ut.inject(request.getParameter("keyword"));
String where			= "";
String param			= "";
String orderNum			= "";
String payDate			= "";
String productName		= "";
String orderName		= "";
String orderState		= "";
String reasonType		= "";
String cancelDate		= "";
String confirmDate		= "";

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

where			= " WHERE O.ORDER_NUM = C.ORDER_NUM AND O.ORDER_STATE IN (94,941,95,951)";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage			= Integer.parseInt(request.getParameter("page"));
	startpage		= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage			= 1;
	startpage		= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize			= Integer.parseInt(request.getParameter("pgsize"));

if (schOrderName != null && schOrderName.length() > 0) {
	schOrderName	= new String(schOrderName.getBytes("8859_1"), "EUC-KR");
	param			+= "&amp;sch_order_name="+ schOrderName;
	where			+= " AND ORDER_NAME LIKE '%"+ schOrderName +"%'";
}

if (schReasonType != null && schReasonType.length() > 0) {
	param			+= "&amp;sch_reason_type="+ schReasonType;
	where			+= " AND C.REASON_TYPE = '"+ schReasonType +"'";
}

if (cancelStdate != null && cancelStdate.length() > 0) {
	param			+= "&amp;cancel_stdate="+ cancelStdate;
	where			+= " AND (DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') >= '"+ cancelStdate +"')";
}

if (cancelLtdate != null && cancelLtdate.length() > 0) {
	param			+= "&amp;cancel_ltdate="+ cancelLtdate;
	where			+= " AND (DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') <= '"+ cancelLtdate +"')";
}

query		= "SELECT COUNT(O.ID) FROM "+ table + where; //out.print(query); if(true)return;
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

query		= "SELECT O.ORDER_NUM, ORDER_NAME, O.ORDER_STATE, DATE_FORMAT(O.PAY_DATE, '%Y-%m-%d') PAY_DATE, C.REASON_TYPE,";
query		+= "	DATE_FORMAT(C.INST_DATE, '%Y-%m-%d') CANCEL_DATE, DATE_FORMAT(C.CONFIRM_DATE, '%Y-%m-%d') CONFIRM_DATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY O.ORDER_NUM DESC";
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
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:2,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-order.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 주문관리 &gt; 취소/반품관리 &gt; <strong>반품관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
					<table class="table01" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">
									<span>고객명</span>
								</th>
								<td><input type="text" class="input1" style="width:200px;" maxlength="30" name="sch_order_name" value="<%=schOrderName%>" onfocus="this.select()"/></td>
							</tr>
							<tr>
								<th scope="row">
									<span>사유검색</span>
								</th>
								<td>
									<span>
										<select style="width:80px;" name="sch_reason_type">
											<option value="">전체</option>
											<option value="1"<%if(schReasonType.equals("1")){out.print(" selected=\"selected\"");}%>>구매의사취소</option>
											<option value="2"<%if(schReasonType.equals("2")){out.print(" selected=\"selected\"");}%>>상품 잘못 주문</option>
											<option value="3"<%if(schReasonType.equals("3")){out.print(" selected=\"selected\"");}%>>상품정보 상이</option>
											<option value="4"<%if(schReasonType.equals("4")){out.print(" selected=\"selected\"");}%>>서비스 및 상품 불만족</option>
										</select>
									</span>
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
				<form name="frm_list" id="frm_list" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="4%" />
							<col width="10%" />
							<col width="10%" />
							<col width="*" />
							<col width="6%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
							<col width="10%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th scope="col"><span>주문자</span></th>
								<th scope="col"><span>주문번호</span></th>
								<th scope="col"><span>주문상품</span></th>
								<th scope="col"><span>주문상태</span></th>
								<th scope="col"><span>결제일</span></th>
								<th scope="col"><span>반품요청일</span></th>
								<th scope="col"><span>승인일</span></th>
								<th scope="col"><span>반품사유</span></th>
							</tr>
							<%
							if (intTotalCnt > 0) {
								while (rs.next()) {
									orderNum	= rs.getString("ORDER_NUM");
									payDate		= rs.getString("PAY_DATE");
									query1		= "SELECT ";
									query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
									query1		+= "		DEVL_DAY, DEVL_WEEK";
									query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
									query1		+= " WHERE G.ID = OG.GROUP_ID";
									query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM AND OG.ORDER_NUM = '"+ orderNum +"'";
									query1		+= " ORDER BY O.ID DESC";
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									i		= 0;
									while (rs1.next()) {
										if (i > 0) {
											productName	= rs1.getString("GROUP_NAME")+" 외 "+ i +"건";
										} else {
											productName	= rs1.getString("GROUP_NAME");
										}
										i++;
									}
									orderName	= rs.getString("ORDER_NAME");
									cancelDate	= rs.getString("CANCEL_DATE");
									confirmDate	= rs.getString("CONFIRM_DATE");
									orderState	= rs.getString("ORDER_STATE");
									reasonType	= rs.getString("REASON_TYPE");
							%>
							<tr>
								<td><%=curNum%></td>
								<td><%=orderName%></td>
								<td><a href="javascript:;" onclick="popup('order_view.jsp?ordno=<%=orderNum%>',900,720,'order_view');"><%=orderNum%></a></td>
								<td><%=productName%></td>
								<td><%=ut.getOrderState(orderState)%></td>
								<td><%=ut.setDateFormat(payDate)%></td>
								<td><%=ut.setDateFormat(cancelDate)%></td>
								<td><%=ut.setDateFormat(confirmDate)%></td>
								<td><%=ut.getCancelReason(reasonType)%></td>
							</tr>
							<%
									curNum--;
								}
							} else {
							%>
							<tr>
								<td colspan="9">등록된 반품내역이 없습니다.</td>
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
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>