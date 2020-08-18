<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%viewPage	= true;%>
<%@ taglib uri="/WEB-INF/FCKeditor.tld" prefix="FCK" %>
<%@ include file="../include/inc-top.jsp"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<%
request.setCharacterEncoding("euc-kr");

int eventId				= 0;
String query			= "";
String gubun			= "";
String eventType		= "";
String title			= "";
String openYn			= "";
String stdate			= "";
String ltdate			= "";
String eventTarget		= "";
String ancDate			= "";
String content			= "";
String mcontent			= "";
String listImg			= "";
String viewImg			= "";
String eventUrl			= "";
String goodsName		= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));

int pressId				= 0;
int reply_count			= 0;
int reply_id			= 0;
int reply_idx			= 0;

String m_id				= "";
String m_name			= "";
String reply_content	= "";
String reply_content2	= "";
String reply_date		= "";
String reply_date2		= "";
String reply_mode		= "write";
String reply_goodsName	= "";

String dw_yn			= "";

String imgMapLocal_p1	= "";
String coupon_num_p1	= "";
String imgMapLocal_p2	= "";
String coupon_num_p2	= "";
String imgMapLocal_p3	= "";
String coupon_num_p3	= "";

String imgMapLocal_m1	= "";
String coupon_num_m1	= "";
String imgMapLocal_m2	= "";
String coupon_num_m2	= "";
String imgMapLocal_m3	= "";
String coupon_num_m3	= "";

String imgMapLocal_p4	= "";
String link_num_p4		= "";
String imgMapLocal_p5	= "";
String link_num_p5		= "";
String imgMapLocal_p6	= "";
String link_num_p6		= "";

String imgMapLocal_m4	= "";
String link_num_m4		= "";
String imgMapLocal_m5	= "";
String link_num_m5		= "";
String imgMapLocal_m6	= "";
String link_num_m6		= "";

String imgMapLocal_p7   = "";
String link_num_p7		= "";
String imgMapLocal_p8   = "";
String link_num_p8		= "";

String imgMapLocal_m7   = "";
String link_num_m7		= "";
String imgMapLocal_m8   = "";
String link_num_m8		= "";

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	query		= "SELECT GUBUN, EVENT_TYPE, TITLE, OPEN_YN, STDATE, LTDATE, EVENT_TARGET, ANC_DATE, CONTENT, CONTENT_MOBILE, LIST_IMG, VIEW_IMG, EVENT_URL, DW_YN, IMG_P1, COUPON_NUM_P1, IMG_P2, COUPON_NUM_P2, IMG_P3, COUPON_NUM_P3, IMG_M1, COUPON_NUM_M1, IMG_M2, COUPON_NUM_M2, IMG_M3, COUPON_NUM_M3, IMG_P4, HL_P4, IMG_P5, HL_P5, IMG_P6, HL_P6, IMG_M4, HL_M4, IMG_M5, HL_M5, IMG_M6, HL_M6, IMG_P7, HL_P7, IMG_P8, HL_P8, IMG_M7, HL_M7,  IMG_M8, HL_M8 ";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		gubun			= rs.getString("GUBUN");
		eventType		= rs.getString("EVENT_TYPE");
		title			= rs.getString("TITLE");
		openYn			= rs.getString("OPEN_YN");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		eventTarget		= rs.getString("EVENT_TARGET");
		ancDate			= rs.getString("ANC_DATE");
		content			= (rs.getString("CONTENT") == null)? "" : rs.getString("CONTENT");
		mcontent		= (rs.getString("CONTENT_MOBILE") == null)? "" : rs.getString("CONTENT_MOBILE");
		listImg			= (rs.getString("LIST_IMG") == null)? "" : rs.getString("LIST_IMG");
		viewImg			= (rs.getString("VIEW_IMG") == null)? "" : rs.getString("VIEW_IMG");
		eventUrl		= (rs.getString("EVENT_URL") == null)? "" : rs.getString("EVENT_URL");
		dw_yn			= (rs.getString("DW_YN") == null)? "" : rs.getString("DW_YN");
		imgMapLocal_p1  = (rs.getString("IMG_P1") == null)? "" : rs.getString("IMG_P1");
		coupon_num_p1   = (rs.getString("COUPON_NUM_P1") == null)? "" : rs.getString("COUPON_NUM_P1");
		imgMapLocal_p2  = (rs.getString("IMG_P2") == null)? "" : rs.getString("IMG_P2");
		coupon_num_p2   = (rs.getString("COUPON_NUM_P2") == null)? "" : rs.getString("COUPON_NUM_P2");
		imgMapLocal_p3  = (rs.getString("IMG_P3") == null)? "" : rs.getString("IMG_P3");
		coupon_num_p3   = (rs.getString("COUPON_NUM_P3") == null)? "" : rs.getString("COUPON_NUM_P3");
		imgMapLocal_m1  = (rs.getString("IMG_M1") == null)? "" : rs.getString("IMG_M1");
		coupon_num_m1   = (rs.getString("COUPON_NUM_M1") == null)? "" : rs.getString("COUPON_NUM_M1");
		imgMapLocal_m2  = (rs.getString("IMG_M2") == null)? "" : rs.getString("IMG_M2");
		coupon_num_m2   = (rs.getString("COUPON_NUM_M2") == null)? "" : rs.getString("COUPON_NUM_M2");
		imgMapLocal_m3  = (rs.getString("IMG_M3") == null)? "" : rs.getString("IMG_M3");
		coupon_num_m3   = (rs.getString("COUPON_NUM_M3") == null)? "" : rs.getString("COUPON_NUM_M3");
		imgMapLocal_p4  = (rs.getString("IMG_P4") == null)? "" : rs.getString("IMG_P4");
		link_num_p4		= (rs.getString("HL_P4") == null)? "" : rs.getString("HL_P4");
		imgMapLocal_p5  = (rs.getString("IMG_P5") == null)? "" : rs.getString("IMG_P5");
		link_num_p5		= (rs.getString("HL_P5") == null)? "" : rs.getString("HL_P5");
		imgMapLocal_p6  = (rs.getString("IMG_P6") == null)? "" : rs.getString("IMG_P6");
		link_num_p6		= (rs.getString("HL_P6") == null)? "" : rs.getString("HL_P6");
		imgMapLocal_m4  = (rs.getString("IMG_M4") == null)? "" : rs.getString("IMG_M4");
		link_num_m4		= (rs.getString("HL_M4") == null)? "" : rs.getString("HL_M4");
		imgMapLocal_m5  = (rs.getString("IMG_M5") == null)? "" : rs.getString("IMG_M5");
		link_num_m5		= (rs.getString("HL_M5") == null)? "" : rs.getString("HL_M5");
		imgMapLocal_m6  = (rs.getString("IMG_M6") == null)? "" : rs.getString("IMG_M6");
		link_num_m6		= (rs.getString("HL_M6") == null)? "" : rs.getString("HL_M6");
		imgMapLocal_p7  = (rs.getString("IMG_P7") == null)? "" : rs.getString("IMG_P7");
		link_num_p7     = (rs.getString("HL_P7") == null)? "" : rs.getString("HL_P7");
		imgMapLocal_p8  = (rs.getString("IMG_P8") == null)? "" : rs.getString("IMG_P8");
		link_num_p8		= (rs.getString("HL_P8") == null)? "" : rs.getString("HL_P8");
		imgMapLocal_m7  = (rs.getString("IMG_M7") == null)? "" : rs.getString("IMG_M7");
		link_num_m7		= (rs.getString("HL_M7") == null)? "" : rs.getString("HL_M7");
		imgMapLocal_m8  = (rs.getString("IMG_M8") == null)? "" : rs.getString("IMG_M8");
		link_num_m8		= (rs.getString("HL_M8") == null)? "" : rs.getString("HL_M8");
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>
	<%@ include file="../include/inc-cal-script.jsp" %>
	<script type="text/javascript">
	//<![CDATA[
	$(function(){
		$('#gnb').menuModel1({hightLight:{level_1:<%=topLevelNo%>,level_2:0,level_3:0},target_obj:'#header',showOps:{visibility:'visible'},hideOps:{visibility:'hidden'}});
		$('#lnb').menuModel2({hightLight:{level_1:2,level_2:0,level_3:0},target_obj:'',showOps:{display:'block'}, hideOps:{display:'block'}});
	})
	//]]>
	</script>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
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
		<%@ include file="../include/inc-sidebar-promotion.jsp" %>
		<!-- incon -->
		<div id="incon">
			<!-- location -->
			<div id="location">
				<div class="bgright_location"></div>
				<%@ include file="../include/inc-header-location.jsp" %>
				<p id="path"><img src="../images/common/layout/ico_home.gif" alt="홈" /> &gt; 프로모션관리 &gt; <strong>이벤트</strong></p>
			</div>
			<!-- //location -->
			<!-- contents -->
			<div id="contents">
				<form name="frm_edit" id="frm_edit" method="post" action="event_db.jsp" enctype="multipart/form-data">
					<input type="hidden" name="mode" value="upd" />
					<input type="hidden" name="id" value="<%=eventId%>" />
					<input type="hidden" name="param" value="<%=param%>" />
					<input type="hidden" name="org_list_img" value="<%=listImg%>" />
					<input type="hidden" name="org_view_img" value="<%=viewImg%>" />
					<input type="hidden" name="dw_yn" value="<%=dw_yn%>" />
					<table class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><span>웹/모바일 구분</span></th>
								<td>
									<input type="radio" name="gubun" value="0"<%if (gubun.equals("0")) out.println(" checked=\"checked\"");%> />
									모두
									<input type="radio" name="gubun" value="1"<%if (gubun.equals("1")) out.println(" checked=\"checked\"");%> />
									웹
									<input type="radio" name="gubun" value="2"<%if (gubun.equals("2")) out.println(" checked=\"checked\"");%> />
									모바일
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 구분</span></th>
								<td>
									<input type="radio" name="event_type" value="01"<%if (eventType.equals("01")) out.println(" checked=\"checked\"");%> />
									EVENT
									<input type="radio" name="event_type" value="02"<%if (eventType.equals("02")) out.println(" checked=\"checked\"");%> />
									SALE
									<input type="radio" name="event_type" value="03"<%if (eventType.equals("03")) out.println(" checked=\"checked\"");%> />
									브랜드위크
								</td>
							</tr>
							<tr>
								<th scope="row"><span>제목</span></th>
								<td>
									<input type="text" name="title" id="title" required label="제목" class="input1" style="width:400px;" maxlength="100" value="<%=title%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>공개여부</span></th>
								<td>
									<input type="radio" name="open_yn" value="Y"<%if (openYn.equals("Y")) out.println(" checked=\"checked\"");%> />
									공개
									<input type="radio" name="open_yn" value="N"<%if (openYn.equals("N")) out.println(" checked=\"checked\"");%> />
									미공개
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 기간</span></th>
								<td>
									<input type="text" name="stdate" id="stdate" class="input1" maxlength="8" readonly="readonly" required label="시작일자" value="<%=stdate%>" />
									~
									<input type="text" name="ltdate" id="ltdate" class="input1" maxlength="8" readonly="readonly" required label="마감일자" value="<%=ltdate%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>이벤트 대상</span></th>
								<td>
									<input type="text" name="event_target" id="event_target" class="input1" style="width:200px;" maxlength="50" value="<%=eventTarget%>" />
								</td>
							</tr>
							<tr>
								<th scope="row"><span>당첨자발표일</span></th>
								<td>
									<input type="text" name="anc_date" id="anc_date" class="input1" maxlength="8" readonly="readonly" value="<%=ancDate%>" />
								</td>
							</tr>

							<%
							if(dw_yn.equals("DW") || dw_yn.equals("RDW")){// 신규 이벤트 처리
							%>

							<tr>
								<th scope="row"><span>쿠폰 발급 방식</span></th>
								<td>
									<input type="radio" id="dw_yn" name="dw_yn" value="DW" <%if(dw_yn.equals("DW")){ %> checked <%}%> />
									맵 버튼 클릭 시 발급
									<input type="radio" id="dw_yn" name="dw_yn" value="RDW" <%if(dw_yn.equals("RDW")){ %> checked <%}%> />
									댓글 등록 시 발급
								</td>
							</tr>
							<tr>
								<th scope="row"><span>PC<br/> 이벤트 이미지</span></th>
								<td>
									<div class="imgUpload">
										<input type="file" id="content" name="content" /> (최적화 사이즈: 1000 x auto | BOS에서 50%로 축소되어 보입니다.)
									</div>
									<div class="imgArea" id="imgArea_p" style=" max-width: 500px; min-height: 300px;">
										<img id="image_section_p" name="image_section_p" <% if(!content.equals("")){%> src="<%=webUploadDir +"promotion/"+ content%>" alt="잇슬림이벤트" <%}%> border="0" usemap="#tabMap" />
									</div>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>쿠폰넘버</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 1
													<button type="button" onclick="addImageMap('p',1);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p1" id="imgMapLocal_p1" class="input1" style="width:400px;" value="<%=imgMapLocal_p1%>" />
													</map>
												</td>
												<td>
													<input type="text" name="coupon_num_p1" id="coupon_num_p1" class="input1" style="width:100px;" value="<%=coupon_num_p1%>" />
												</td>
											</tr>
											<tr>
												<td>
													Image Map 2
													<button type="button" onclick="addImageMap('p',2);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p2" id="imgMapLocal_p2" class="input1" style="width:400px;" value="<%=imgMapLocal_p2%>" />
													</map>
												</td>
												<td>
													<input type="text" name="coupon_num_p2" id="coupon_num_p2" class="input1" style="width:100px;" value="<%=coupon_num_p2%>" />
												</td>
											</tr>
											<tr>
												<td>
													Image Map 3
													<button type="button" onclick="addImageMap('p',3);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p3" id="imgMapLocal_p3" class="input1" style="width:400px;" value="<%=imgMapLocal_p3%>" />
													</map>

												<td>
													<input type="text" name="coupon_num_p3" id="coupon_num_p3" class="input1" style="width:100px;" value="<%=coupon_num_p3%>" />
												</td>
											</tr>
										</tbody>
									</table>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>하이퍼링크</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 4
													<button type="button" onclick="addImageMap('p',4);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p4" id="imgMapLocal_p4" class="input1" style="width:400px;" value="<%=imgMapLocal_p4%>"/>
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p4" id="link_num_p4" class="input1" style="width:300px" value="<%=link_num_p4%>" />
												</td>
											</tr>
											<tr>
												<td>
													Image Map 5
													<button type="button" onclick="addImageMap('p',5);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p5" id="imgMapLocal_p5" class="input1" style="width:400px;" value="<%=imgMapLocal_p5%>"/>
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p5" id="link_num_p5" class="input1" style="width:300px;"  value="<%=link_num_p5%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 6
													<button type="button" onclick="addImageMap('p',6);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p6" id="imgMapLocal_p6" class="input1" style="width:400px;" value="<%=imgMapLocal_p6%>"/>
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p6" id="link_num_p6" class="input1" style="width:300px;"  value="<%=link_num_p6%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 7
													<button type="button" onclick="addImageMap('p',7);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p7" id="imgMapLocal_p7" class="input1" style="width:400px;" value="<%=imgMapLocal_p7%>"/>
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p7" id="link_num_p7" class="input1" style="width:300px;" value="<%=link_num_p7%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 8
													<button type="button" onclick="addImageMap('p',8);">+</button>
												</td>
												<td>
													<map name="tabMap" id="tabMap">
														<input type="text" name="imgMapLocal_p8" id="imgMapLocal_p8" class="input1" style="width:400px;" value="<%=imgMapLocal_p8%>" />
													</map>
												</td>
												<td>
													<input type="text" name="link_num_p8" id="link_num_p8" class="input1" style="width:300px;" value="<%=link_num_p8%>"/>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>MOBILE<br/> 이벤트 이미지</span></th>
								<td>
									<div class="imgUpload">
										<input type="file" id="mcontent" name="mcontent" /> (최적화 사이즈: 1000 x auto | BOS에서 50%로 축소되어 보입니다.)
									</div>
									<div class="imgArea" id="imgArea_m" style="max-width: 500px; min-height: 300px;">
										<img id="image_section_m" name="image_section_m" <% if(!mcontent.equals("")){%> src="<%=webUploadDir +"promotion/"+ mcontent%>" alt="잇슬림이벤트" <%}%>  border="0" />
									</div>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>쿠폰넘버</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 1
													<button type="button" onclick="addImageMap('m',1);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m1" id="imgMapLocal_m1" class="input1" style="width:400px;" value="<%=imgMapLocal_m1%>" />
												</td>
												<td>
													<input type="text" name="coupon_num_m1" id="coupon_num_m1" class="input1" style="width:100px;" value="<%=coupon_num_m1%>" />
												</td>
											</tr>
											<tr>
												<td>
													Image Map 2
													<button type="button" onclick="addImageMap('m',2);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m2" id="imgMapLocal_m2" class="input1" style="width:400px;" value="<%=imgMapLocal_m2%>" />
												</td>
												<td>
													<input type="text" name="coupon_num_m2" id="coupon_num_m2" class="input1" style="width:100px;" value="<%=coupon_num_m2%>" />
												</td>
											</tr>
											<tr>
												<td>
													Image Map 3
													<button type="button" onclick="addImageMap('m',3);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m3" id="imgMapLocal_m3" class="input1" style="width:400px;" value="<%=imgMapLocal_m3%>" />
												</td>
												<td>
													<input type="text" name="coupon_num_m3" id="coupon_num_m3" class="input1" style="width:100px;" value="<%=coupon_num_m3%>" />
												</td>
											</tr>
										</tbody>
									</table>
									<table class="tableView" border="1" cellspacing="0" style="margin-bottom: 1em;">
										<colgroup>
											<col width="200px">
											<col>
											<col width="400px">
										</colgroup>
										<thead>
											<th><span>맵 버튼</span></th>
											<th><span>좌표</span></th>
											<th><span>하이퍼링크</span></th>
										</thead>
										<tbody>
											<tr>
												<td>
													Image Map 4
													<button type="button" onclick="addImageMap('m',4);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m4" id="imgMapLocal_m4" class="input1" style="width:400px;" value="<%=imgMapLocal_m4%>"/>
												</td>
												<td>
													<input type="text" name="link_num_m4" id="link_num_m4" class="input1" style="width:300px;" value="<%=link_num_m4%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 5
													<button type="button" onclick="addImageMap('m',5);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m5" id="imgMapLocal_m5" class="input1" style="width:400px;" value="<%=imgMapLocal_m5%>"/>
												</td>
												<td>
													<input type="text" name="link_num_m5" id="link_num_m5" class="input1" style="width:300px;" value="<%=link_num_m5%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 6
													<button type="button" onclick="addImageMap('m',6);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m6" id="imgMapLocal_m6" class="input1" style="width:400px;" value="<%=imgMapLocal_m6%>"/>
												</td>
												<td>
													<input type="text" name="link_num_m6" id="link_num_m6" class="input1" style="width:300px;" value="<%=link_num_m6%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 7
													<button type="button" onclick="addImageMap('m',7);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m7" id="imgMapLocal_m7" class="input1" style="width:400px;" value="<%=imgMapLocal_m7%>" />
												</td>
												<td>
													<input type="text" name="link_num_m7" id="link_num_m7" class="input1" style="width:300px;" value="<%=link_num_m7%>"/>
												</td>
											</tr>
											<tr>
												<td>
													Image Map 8
													<button type="button" onclick="addImageMap('m',8);">+</button>
												</td>
												<td>
													<input type="text" name="imgMapLocal_m8" id="imgMapLocal_m8" class="input1" style="width:400px;" value="<%=imgMapLocal_m8%>" />
												</td>
												<td>
													<input type="text" name="link_num_m8" id="link_num_m8
													" class="input1" style="width:300px;" value="<%=link_num_m8%>"/>
												</td>
											</tr>
										</tbody>
									</table>
								</td>
							</tr>


							<%}else{%>

							<tr>
								<th scope="row"><span>내용</span></th>
								<td>
									<textarea id="content" name="content" style="height:500px;width:100%;" type=editor><%=content%></textarea>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>모바일내용</span></th>
								<td>
									<textarea id="mcontent" name="mcontent" style="height:500px;width:100%;" type=editor><%=mcontent%></textarea>
								</td>
							</tr>

							<%}%>

							<tr>
								<th scope="row"><span>리스트용 이미지</span></th>
								<td colspan="3">
									<input type="file" name="list_img" value="<%=listImg%>" />
									(최적화 사이즈: 608 x 203)
									<%if (!listImg.equals("")) {%>
										<br /><input type="checkbox" name="del_list_img" value="y" />삭제<br />
										<img src="<%=webUploadDir +"promotion/"+ listImg%>" width="160" height="108" />
									<%}%>
								</td>
							</tr>
							<tr>
								<th scope="row"><span>URL</span></th>
								<td>
									<input type="text" name="event_url" id="event_url" class="input1" style="width:400px;" maxlength="100" value="<%=eventUrl%>" />
								</td>
							</tr>
						</tbody>
					</table>
					<br />
					<table id="goodsTable" class="tableView" border="1" cellspacing="0">
						<colgroup>
							<col width="140px" />
							<col width="*" />
							<col width="80px" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col" colspan="5" style="text-align:center">
									<span>체험단 제품등록(옵션)</span>
									<a href="javascript:;" id="addGoodsBtn" class="function_btn"><span style="padding: 7px 8px 0 5px;">추가</span></a>
								</th>
							</tr>
							<tr class="goods_item0 hidden">
								<th scope="row"><span>제품명</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="100" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
							query		= "SELECT GOODS_NAME FROM ESL_EVENT_GOODS WHERE EVENT_ID = ? ORDER BY ID";
							pstmt		= conn.prepareStatement(query);
							pstmt.setInt(1, eventId);
							rs			= pstmt.executeQuery();

							i = 1;
							while (rs.next()) {
								goodsName		= rs.getString("GOODS_NAME");
							%>
							<tr class="goods_item<%=i%>">
								<th scope="row"><span>제품명</span></th>
								<td>
									<input type="text" name="goods_name" class="input1" style="width:400px;" maxlength="50" value="<%=goodsName%>" />
								</td>
								<td style="text-align:center">
									<a href="javascript:;" onclick="delTr(this);" class="function_btn"><span>삭제</span></a>
								</td>
							</tr>
							<%
								i++;
							}

							if (rs != null) try { rs.close(); } catch (Exception e) {}
							if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
							%>
						</tbody>
					</table>
					<div class="btn_center">
						<a href="javascript:;" onclick="fn_edit();" class="function_btn"><span>수정</span></a>
						<a href="event_list.jsp?<%=param%>" class="function_btn"><span>목록</span></a>
					</div>
				</form>
				<!-- 댓글 시작 -->
				<%
				//댓글수
				pressId = eventId;
				query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY where ID="+pressId+"";

				pstmt		= conn.prepareStatement(query);
				rs			= pstmt.executeQuery();
				if (rs.next()) {
					reply_count = rs.getInt(1); //총 레코드 수
				}
				if (rs != null) try { rs.close(); } catch (Exception e) {}
				if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
				%>
				<div>
					<p>댓글수(<%=reply_count%>)</p>
					<ul style="padding-top:10px">
						<li class="comment depth-1" >
						<%
						query		= "SELECT * ";
						query		+= " FROM ESL_EVENT_REPLY where ID="+pressId+"";
						query		+= " ORDER BY IDX DESC";

						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();
						%>
						<%
						if (reply_count > 0) {
							i		= 0;
							while (rs.next()) {
								reply_id		= rs.getInt("ID");
								reply_idx		= rs.getInt("IDX");
								m_id		= rs.getString("M_ID");
								m_name		= rs.getString("M_NAME");
								reply_content		= rs.getString("CONTENT");
								reply_content2		= (rs.getString("CONTENT2") == null)? "" : rs.getString("CONTENT2");
								reply_date		= rs.getString("INST_DATE");
								reply_date2		= rs.getString("RE_UPDT_DATE");
								reply_goodsName	= ut.isnull(rs.getString("GOODS_NAME"));
						%>
						<%		if(i > 0){ %>
						<div class="lineSeparator" style="margin-bottom:10px"></div>
						<%		} %>
						<div class="commentheader">
							<h5  style="float:left"><%=m_id%></h5>
							<div class="metastamp" style="float:left;padding-left:30px"><%=reply_date.substring(0,16)%></div>
							<div class="myadmin"  style="float:left;padding-left:30px">
								<a href="javascript:reply_del('<%=reply_idx%>');">삭제</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">댓글</a>
							</div>
							<p style="clear:both">
								<%if (!reply_goodsName.equals("")) {%>
								[<%=reply_goodsName%>]
								<%}%>
								<%=ut.nl2br(reply_content)%>
							</p>
							<% if(reply_content2 != null && reply_content2 !="" ){ %>
							<div style="padding-left:10px;padding-top:10px">
								<p>관리자
								<% if(reply_date2 == null){ %>
								<% }else{ %>
								<%=reply_date2.substring(0,16)%>
								<% } %>
								&nbsp;<a href="javascript:reply_del2('<%=reply_idx%>');">삭제</a> | <a href="javascript:reply_write_view('<%=reply_idx%>');">수정</a>
								</p>
								<p><%=ut.nl2br(reply_content2)%></p>
							</div>
							<% } %>
						</div>
						<p id="reply_form_re<%=reply_idx%>" style="display:none">
							<form name="reply_write<%=reply_idx%>" method="post" action="" enctype="multipart/form-data">
								<input type="hidden" name="m_id" value="<%=m_id%>">
								<input type="hidden" name="m_name" value="<%=m_name%>">
								<input type="hidden" name="id" value="<%=pressId%>">
								<input type="hidden" name="mode" value="<%=reply_mode%>">
								<input type="hidden" name="reply_idx" value="<%=reply_idx%>">
								<input type="hidden" name="iPage" value="<%=iPage%>">
								<input type="hidden" name="pgsize" value="<%=pgsize%>">
								<input type="hidden" name="keyword" value="<%=keyword%>">
								<input type="hidden" name="field" value="<%=field%>">
								<textarea id="content" name="content" class="auto-hint" title="" wrap="virtual" style="width:550px;height:100px"><%=reply_content2%></textarea>
							</form>
							<br />
							<a href="javascript:reply_write('<%=reply_idx%>');"  class="function_btn"><span>댓글등록</span></a>
						</p>
					<%
						i++;
						}
					}
					%>
					</li>
					</ul>
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
	$("#title").focus();
	$('#stdate,#ltdate').datepick({
		onSelect: setPeriod,
		dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#anc_date").datepick({
	    dateFormat: "yyyy-mm-dd",
		showTrigger: '#calImg'
	});
	$("#addGoodsBtn").click(function(){
		var lastItemNo = $("#goodsTable tr:last").attr("class").replace("goods_item", "");

		var newitem = $("#goodsTable tr:eq(1)").clone();
		newitem.removeClass();
		newitem.find("td:eq(0)").attr("rowspan", "1");
		newitem.addClass("goods_item"+(parseInt(lastItemNo)+1));
		newitem.removeClass("hidden");

		$("#goodsTable").append(newitem);
	});
});

function setPeriod(dates) {
	var stdate		= $("#stdate").val();
	var ltdate		= $("#ltdate").val();

	if (this.id == 'stdate') {
		$('#ltdate').datepick('option', 'minDate', dates[0] || null);
	} else {
		$('#stdate').datepick('option', 'maxDate', dates[0] || null);
	}
}

function delTr(obj) {
	$(obj).parent().parent().remove();
}

function fn_edit() {
	var msg = "수정 하시겠습니까?"
	if(confirm(msg)){
		chkForm(document.frm_edit);
	}else{
		return;
	}
}

function reply_del(idx){
	var f = eval("document.reply_write"+ idx);
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="event_edit_reply_db.jsp";
		f.submit();
	}
}

function reply_del2(idx){
	var f = eval("document.reply_write"+ idx);
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del2";
		f.reply_idx.value = idx;
		f.action="event_edit_reply_db.jsp";
		f.submit();
	}
}

function reply_write_view(idx){
	$("#reply_form_re"+idx+"").show();
}

function reply_write(idx){
	var f = eval("document.reply_write"+ idx);

	if(f.content.value==""){
		alert('내용을 입력하세요');
		f.content.focus();
		return;
	}

	f.action="event_edit_reply_db.jsp";
	f.submit();
}

function addImageMap(f,n) {
	var mapID = "imgMap_"+f+n
	if($("#"+mapID).length == 0){
		$("#imgArea_"+f).append('<div id="'+mapID+'" class="ui-widget-content imgMap"><div class="inner">'+n+'<a herf="javascript:void(0);" class="close">X</a></div></div>');
		$("#"+mapID).draggable({
			appendTo: "#imgArea_"+f,
			containment: "#imgArea_"+f,
			scroll: false,
			drag: function( event, ui ) {
				var w = $("#"+mapID).outerWidth(),
					h = $("#"+mapID).outerHeight();
				/*if(f=="p"){
					$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
				}else{
					$("#imgMapLocal_"+f+n).val(ui.position.left+","+ui.position.top+","+(ui.position.left+w)+","+(ui.position.top+h));
				}*/
				$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
			}
		})
		.resizable({
			resize: function( event, ui ) {
				var w = $("#"+mapID).outerWidth(),
					h = $("#"+mapID).outerHeight();
				/*if(f=="p"){
					$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
				}else{
					$("#imgMapLocal_"+f+n).val(ui.position.left+","+ui.position.top+","+(ui.position.left+w)+","+(ui.position.top+h));
				}*/
				$("#imgMapLocal_"+f+n).val((ui.position.left*2)+","+(ui.position.top*2)+","+((ui.position.left+w)*2)+","+((ui.position.top+h)*2));
			}
		});

		$("#"+mapID).find('.close').off().click(function(event) {
			$("#"+mapID).draggable( "destroy" ).resizable( "destroy" ).remove();
			$("#imgMapLocal_"+f+n).val("");
		});
	}
}

//	PC - 이미지를 올리기전에 선택했을때 미리 보여준다
$(function() {
	$("#content").on('change', function(){
		readURL_pc(this);
	});
});

function readURL_pc(input) {
	if (input.files && input.files[0]) {
	var reader = new FileReader();

	reader.onload = function (e) {
			$('#image_section_p').attr('src', e.target.result);
		}

	  reader.readAsDataURL(input.files[0]);
	}
}

//	모바일 - 이미지를 올리기전에 선택했을때 미리 보여준다
$(function() {
	$("#mcontent").on('change', function(){
		readURL_M(this);
	});
});

function readURL_M(input) {
	if (input.files && input.files[0]) {
	var reader = new FileReader();

	reader.onload = function (e) {
			$('#image_section_m').attr('src', e.target.result);
		}

	  reader.readAsDataURL(input.files[0]);
	}
}
</script>
<style type="text/css">
	.imgArea { position: relative; margin: 20px 0; border: 1px solid #d9d9d9; width: 100%;  overflow: hidden; }
	.imgArea img { max-width: 100%; }
	.imgMap { width: 100px; height: 100px; background-color: rgba(0,255,255,0.5); padding: 5px; box-sizing: border-box; border: 0; color: #fff; position: absolute; left: 1em; bottom: 1em; font-weight: bold; }
	.imgMap > .inner { position: relative; }
	.imgMap .close { position: absolute; top: 0; right: 2px; color: #fff; font-weight: bold; display: block; cursor: pointer; text-decoration: none !important; }
</style>
<!-- 웹에디터 활성화 스크립트 -->
<script src="/editor/editor_board.js"></script>
<script>
mini_editor('/editor/');
</script>
</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>