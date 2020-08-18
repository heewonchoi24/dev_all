<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

String query				= "";
String query1				= "";
String query2				= "";
ResultSet rs1				= null; 
PreparedStatement pstmt1	= null;
String goodsCode			= "";
String goodsName			= "";
int curNum					= 1;
int cateId					= 0;
String ladtDate             = "";	// 최종식단 입력일
String cateName				= "";
String cateCode				= "";
String openYn				= "";
String scheduleYn			= "";
String updtDate				= "";
int goodsSetCnt				= 0;
String cate_id = "";

Calendar cal		= Calendar.getInstance();

int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);

String today		= nowYear +"-"+ nowMonth +"-"+ nowDay;
String strYear		= request.getParameter("year");
String strMonth		= request.getParameter("month");
String cDate		= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());

int year			= nowYear;
int month			= nowMonth;

if (strYear != null) {
	year				= Integer.parseInt(strYear);
}
if (strMonth != null) {
	month				= Integer.parseInt(strMonth);
}

query		= " SELECT T1.ID, T1.CATE_NAME, T1.CATE_CODE, T1.OPEN_YN, T1.SCHEDULE_YN, T1.GOODS_SET_CNT, DATE_FORMAT(T1.UPDT_DATE, '%Y-%m-%d') AS UPDT_DATE, (SELECT MAX(DEVL_DATE) AS MAX_DEVL_DATE FROM ESL_GOODS_CATEGORY_SCHEDULE WHERE CATEGORY_CODE = T1.CATE_CODE) AS LADT_DATE ";
query      += "  FROM ESL_GOODS_CATEGORY T1 WHERE CATE_CODE IN ('0301368', '0300700' ,'0300702', '0300965', '0301590') ";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();


%>

	<script type="text/javascript" src="../js/sub.js"></script>
	<script type="text/javascript" src="../js/left.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:5,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
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
		<%@ include file="../include/inc-sidebar-product.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 상품관리 &gt; <strong>식단관리</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_write" id="frm_write" method="post">
					<table class="table02" border="1" cellspacing="0">
						<colgroup>
							<col width="10%" />
							<col width="55%" />
							<col width="14%" />
							<col width="14%" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><span>번호</span></th>
								<th align="left" scope="col"><span>카테고리명</span></th>
								<th scope="col"><span>최종식단 입력일</span></th>
								<th scope="col"><span>카테고리 수정일</span></th>
								<th scope="col"><span>관리</span></th>
							</tr>
							<!-- 식단관리 리스트 시작 -->
							<%
							while (rs.next()) {
								cateCode      = rs.getString("CATE_CODE");
								cateName	  = rs.getString("CATE_NAME");
								ladtDate 	  = rs.getString("LADT_DATE");
								updtDate	  = ut.isnull(rs.getString("UPDT_DATE"));
								cateId 	      = rs.getInt("ID");
							%>
							<tr>
								<td><%=curNum%></td>
								<td style="text-align:left"><%=cateName%></td>
								<td>
									<%
									if(ladtDate == null) {	
										out.println("");
									}
									else{
										out.println(ladtDate);
									}
									%>
								</td>
								<td><%=updtDate%></td>
								<td>
									<%
									if(cateCode.equals("0300965")) {	//알라까르떼 헬씨
										cateId = 10;
									}
									if (cateCode.equals("0300702")) {	// 알라까르떼 슬림
										cateId = 9;
								    }
									if (cateCode.equals("0301590")) {	// 미니밀
								    	cateId = 13;
								    }
								    %>
									<a href="category_schedule_edit.jsp?cateCode=<%=cateCode%>&cateId=<%=cateId %>&year=<%=year %>&month=<%=month%>" class="function_btn"><span>관리</span></a>
								</td>
							</tr>
							<%
								curNum++;
							}
							%>
							<!-- 식단관리 리스트 끝 -->
						</tbody>
					</table>
				</form>
<!-- 				<div class="btn_style1">
					<p class="right_btn">
						<a href="category_schedule_write.jsp" class="function_btn"><span>등록</span></a>
					</p>
				</div> -->
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