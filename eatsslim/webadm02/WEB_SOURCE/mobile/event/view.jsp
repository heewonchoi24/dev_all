<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>

<%
request.setCharacterEncoding("euc-kr");

int eventId				= 0;
String query			= "";
String query1			= "";
Statement stmt1			= null;
ResultSet rs1			= null;
stmt1					= conn.createStatement();
String eventType		= "";
String title			= "";
String openYn			= "";
String stdate			= "";
String ltdate			= "";
String eventTarget		= "";
String ancDate			= "";
String content			= "";
String param			= "";
String keyword			= "";
String iPage			= ut.inject(request.getParameter("page"));
String pgsize			= ut.inject(request.getParameter("pgsize"));
String schCate			= ut.inject(request.getParameter("sch_cate"));
String field			= ut.inject(request.getParameter("field"));
int chkCnt				= 0;
String goodsName		= "";
String reply_goodsName	= "";

String login_stat_str	= "";

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

String imgUrl			= "";
String viewImg			= "";

int noticeId			= 0;

String	dw_yn			= ""; 
String	imgMapLocal_m1  = ""; 
String	coupon_num_m1   = ""; 
String	imgMapLocal_m2  = ""; 
String	coupon_num_m2   = ""; 
String	imgMapLocal_m3  = "";
String	coupon_num_m3   = "";
String	coupon_num_p1   = "";

String imgMapLocal_m4	= "";
String link_num_m4		= "";
String imgMapLocal_m5	= "";
String link_num_m5		= "";
String imgMapLocal_m6	= "";
String link_num_m6		= "";

String imgMapLocal_m7   = "";
String link_num_m7		= "";
String imgMapLocal_m8   = "";
String link_num_m8		= "";

if (request.getParameter("reply_idx") != null && request.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
}

if (!ut.isNaN(iPage)) {
	iPage = "1";
}
if (!ut.isNaN(pgsize)) {
	pgsize = "10";
}

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	//댓글수
	noticeId = eventId;
	query		= "SELECT COUNT(ID) FROM ESL_EVENT_REPLY where ID="+noticeId+"";
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		reply_count = rs.getInt(1); //총 레코드 수
	}
	if (rs != null) try { rs.close(); } catch (Exception e) {}
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

	query		= "SELECT TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,";
	query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, CONTENT_MOBILE, VIEW_IMG, DW_YN, IMG_M1, COUPON_NUM_M1, IMG_M2, COUPON_NUM_M2, IMG_M3, COUPON_NUM_M3, IMG_M4, HL_M4, IMG_M5, HL_M5, IMG_M6, HL_M6, IMG_M7, HL_M7,  IMG_M8, HL_M8 ";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		ancDate			= (rs.getString("ANC_DATE") == null || rs.getString("ANC_DATE").equals(""))? "없음" : rs.getString("ANC_DATE");
		content			= (rs.getString("CONTENT_MOBILE") == null)? "" : rs.getString("CONTENT_MOBILE");     
		viewImg			= (rs.getString("VIEW_IMG").equals("") || rs.getString("VIEW_IMG") == null)? "" : rs.getString("VIEW_IMG");
		imgUrl			= webUploadDir +"promotion/"+ viewImg;
		dw_yn			= (rs.getString("DW_YN") == null)? "" : rs.getString("DW_YN");
		imgMapLocal_m1  = (rs.getString("IMG_M1") == null)? "" : rs.getString("IMG_M1");
		coupon_num_m1   = (rs.getString("COUPON_NUM_M1") == null)? "" : rs.getString("COUPON_NUM_M1");
		imgMapLocal_m2  = (rs.getString("IMG_M2") == null)? "" : rs.getString("IMG_M2");
		coupon_num_m2   = (rs.getString("COUPON_NUM_M2") == null)? "" : rs.getString("COUPON_NUM_M2");
		imgMapLocal_m3  = (rs.getString("IMG_M3") == null)? "" : rs.getString("IMG_M3");
		coupon_num_m3   = (rs.getString("COUPON_NUM_M3") == null)? "" : rs.getString("COUPON_NUM_M3");
		imgMapLocal_m4  = (rs.getString("IMG_M4") == null)? "" : rs.getString("IMG_M4");
		link_num_m4		= (rs.getString("HL_M4") == null)? "" : rs.getString("HL_M4");
		imgMapLocal_m5  = (rs.getString("IMG_M5") == null)? "" : rs.getString("IMG_M5");
		link_num_m5		= (rs.getString("HL_M5") == null)? "" : rs.getString("HL_M5");
		imgMapLocal_m6  = (rs.getString("IMG_M6") == null)? "" : rs.getString("IMG_M6");
		link_num_m6		= (rs.getString("HL_M6") == null)? "" : rs.getString("HL_M6");
		imgMapLocal_m7	= (rs.getString("IMG_M7") == null)? "" : rs.getString("IMG_M7");
		link_num_m7		= (rs.getString("HL_M7") == null)? "" : rs.getString("HL_M7");
		imgMapLocal_m8	= (rs.getString("IMG_M8") == null)? "" : rs.getString("IMG_M8");	
		link_num_m8		= (rs.getString("HL_M8") == null)? "" : rs.getString("HL_M8");
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>
<script src="eventView.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

</head>
<body>
<div id="wrap">
    <div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
       <%@ include file="/mobile/common/include/inc-header.jsp"%>
    </div>
    <!-- End ui-header -->
    <!-- Start Content -->
    <div id="content">
        <h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">이벤트</span></span></h1>
            <div class="row">
                <div class="event">
                    <div class="head">
                       <h3 class="title"><%=title%></h3>
                       <p class="meta">이벤트 기간 : <%=stdate%> ~ <%=ltdate%></p>
                    </div>

					<%
					if(dw_yn.equals("DW") || dw_yn.equals("RDW")){// 신규 이벤트 처리
					%>
					<div class="imgArea" id="imgArea_p">
						<img id="image_section_m" name="image_section_m" style="max-width: 320px; min-height: 600px;" src="<%=webUploadDir +"promotion/"+ content%>" alt="잇슬림이벤트" border="0" usemap="#tabMap" />
					</div>
					<map name="tabMap" id="tabMap">
					<%  if(!imgMapLocal_m1.equals("") && !coupon_num_m1.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m1%>" target="_self" onclick="setCouponNew(<%=coupon_num_m1%>);" />
					<%} if(!imgMapLocal_m2.equals("") && !coupon_num_m2.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m2%>" target="_self" onclick="setCouponNew(<%=coupon_num_m2%>);" />
					<%} if(!imgMapLocal_m3.equals("") && !coupon_num_m3.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m3%>" target="_self" onclick="setCouponNew(<%=coupon_num_m3%>);" />
					<%} if(!imgMapLocal_m4.equals("") && !link_num_m4.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m4%>" target="_self" onclick="location.href='<%=link_num_m4%>'" />
					<%} if(!imgMapLocal_m5.equals("") && !link_num_m5.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m5%>" target="_self" onclick="location.href='<%=link_num_m5%>'" />								
					<%} if(!imgMapLocal_m6.equals("") && !link_num_m7.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m7%>" target="_self" onclick="location.href='<%=link_num_m7%>'" />	
					<%} if(!imgMapLocal_m7.equals("") && !link_num_m6.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m6%>" target="_self" onclick="location.href='<%=link_num_m6%>'" />						
					<%} if(!imgMapLocal_m8.equals("") && !link_num_m8.equals("")){%>
						<area shape="rect" coords="<%=imgMapLocal_m8%>" target="_self" onclick="location.href='<%=link_num_m8%>'" />							
					<%}%>
					</map>

					<% } else{%>
						
                    <div class="article">
                         <%=content%>
                    </div>

					<%}%>

                </div>
            </div>
            <div class="row" style="text-align:center;">
                <a href="index.jsp?<%=param%>" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">이벤트 목록</span></span></a>
            </div>


			<div class="comment-wrap">
				<div class="sectionHeader">
					<h4>댓글(<%=reply_count%>)</h4>
					<div style="text-align:right;">
						<a href="javascript:reply_write();" class="ui-btn ui-mini ui-btn-inline ui-btn-up-c"><span class="ui-btn-inner"><span class="ui-btn-text">댓글등록</span></span></a>
					</div>
				</div>
				<%
				if(eslMemberId.equals("")){
					login_stat_str = "로그인 후 댓글을 입력해 주세요. ";
				}

				//댓글 수정 처리
				if(reply_idx > 0){
					query		= "SELECT * ";
					query		+= " FROM ESL_EVENT_REPLY where ID="+noticeId+" and IDX="+reply_idx+" and M_ID='"+eslMemberId+"'";
					query		+= " ORDER BY IDX ASC";

					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();

					reply_idx= 0;

					if (rs.next()) {
						reply_idx		= rs.getInt("IDX");
						reply_goodsName	= rs.getString("GOODS_NAME");
						reply_content	= rs.getString("CONTENT");
					}

					if(reply_idx > 0){
						reply_mode = "edit";
					}
				}
				%>
				<form name="reply_write" method="post" action="" enctype="multipart/form-data">
					<input type="hidden" name="m_id" value="<%=eslMemberId%>">
					<input type="hidden" name="m_name" value="<%=eslMemberName%>">
					<input type="hidden" name="id" value="<%=noticeId%>">
					<input type="hidden" name="idx" value="">
					<input type="hidden" name="mode" value="<%=reply_mode%>">
					<input type="hidden" name="reply_idx" value="<%=reply_idx%>">
					<input type="hidden" name="iPage" value="<%=iPage%>">
					<input type="hidden" name="pgsize" value="<%=pgsize%>">
					<input type="hidden" name="keyword" value="<%=keyword%>">
					<input type="hidden" name="field" value="<%=field%>">
					<input type="hidden" name="dw_yn" value="<%=dw_yn%>">
					<input type="hidden" name="coupon_num_m1" value="<%=coupon_num_m1%>">
					<input type="hidden" name="coupon_num_m2" value="<%=coupon_num_m2%>">
					<input type="hidden" name="coupon_num_m3" value="<%=coupon_num_m3%>">
				<%
					query1		= "SELECT COUNT(ID) FROM ESL_EVENT_GOODS WHERE EVENT_ID = "+ noticeId;
					try {
						rs1	= stmt1.executeQuery(query1);
					} catch(Exception e) {
						out.println(e+"=>"+query1);
						if(true)return;
					}

					if (rs1.next()) {
						chkCnt		= rs1.getInt(1);
					}
					rs1.close();

					if (chkCnt > 0) {
				%>
					제품선택
					<select name="goods_name" id="goods_name">
				<%
						query1		= "SELECT GOODS_NAME FROM ESL_EVENT_GOODS WHERE EVENT_ID = "+ noticeId;
						query1		+= " ORDER BY ID";
						try {
							rs1	= stmt1.executeQuery(query1);
						} catch(Exception e) {
							out.println(e+"=>"+query1);
							if(true)return;
						}

						while (rs1.next()) {
							goodsName	= rs1.getString("GOODS_NAME");
				%>
						<option value="<%=goodsName%>"<%if (reply_goodsName.equals(goodsName)) out.println(" selected=\"selected\"");%>><%=goodsName%></option>
				<%
						}
					}
				%>
					</select>
					<br />
					<textarea id="recontent" name="recontent" class="auto-hint" title="<%=login_stat_str%>게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다." wrap="virtual" <%if(eslMemberId.equals("")){%>disabled="true"<%}%>><%=reply_content%></textarea>
				</form>
				<ul>
					<li class="comment depth-1" >
						<%
						query		= "SELECT * ";
						query		+= " FROM ESL_EVENT_REPLY where ID="+noticeId+"";
						query		+= " ORDER BY IDX DESC";

						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();
						%>
						<%
						if (reply_count > 0) {
							int i		= 0;
							while (rs.next()) {
								reply_id			= rs.getInt("ID");
								reply_idx			= rs.getInt("IDX");
								m_id				= rs.getString("M_ID");
								m_name				= rs.getString("M_NAME");
								reply_content		= rs.getString("CONTENT");
								reply_content2		= (rs.getString("CONTENT2") == null)? "" : rs.getString("CONTENT2");
								reply_date			= rs.getString("INST_DATE");
								reply_date2			= rs.getString("RE_UPDT_DATE");
								reply_goodsName		= ut.isnull(rs.getString("GOODS_NAME"));
						%>
						<%		if(i > 0){ %>
						<div class="lineSeparator" style="margin-bottom:10px"></div>
						<%		} %>
						<%
								String m_id_open = "";
								String m_id_hide = "";
								int m_id_len = 0;

								m_id_open = m_id.substring(0,3);
								m_id_len  = m_id.length();

								for (i=0; i<m_id_len; i++) {
									m_id_hide += "*";
								}
						%>
						<div class="commentheader">
							<h5><%=m_id_open + m_id_hide%></h5>
							<div class="metastamp"><%=reply_date.substring(0,16)%></div>
							<div class="myadmin">
								<% if(m_id.equals(eslMemberId)){ %>
								<a href="view.jsp?<%=param%>&id=<%=noticeId%>&reply_idx=<%=reply_idx%>">수정</a> ㅣ <a href="javascript:reply_del('<%=reply_idx%>');">삭제</a>
								<% } %>
							</div>
						</div>
						<p>
							<%if (!reply_goodsName.equals("")) {%>
							[<%=reply_goodsName%>]
							<%}%>
							<%=ut.nl2br(reply_content)%>
						</p>
						<%		if(reply_content2 !=""){ %>
						<div class="lineSeparator"></div>
							<ul>
								<li class="comment depth-2" >
									<div class="commentheader">
										<h5>관리자</h5>
										<div class="metastamp"><%=reply_date2.substring(0,16)%></div>
									</div>
									<p><%=ut.nl2br(reply_content2)%></p>
									<div class="lineSeparator"></div>
								</li>
							</ul>
						<%		} %>
						<%
							i++;
							}
						}
						%>
					</li>
				</ul>
			</div>


    </div>
    <!-- End Content -->
    <div class="ui-footer">
       <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    </div>
</div>

<script>
function setCouponNew(coupon_num){
	$.post("event_ajax.jsp", {
		mode: "setCouponNew",
		eventId: "<%=eventId%>",
		dw_yn: "<%=dw_yn%>",
		coupon_num_p1: coupon_num
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				<% if (eventId == 278) { %>
				alert("축하합니다. 전제품 10% 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else if (eventId == 282) { %>
				alert("축하합니다. 다이어트 지원금 3종 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else if (eventId == 338 || eventId == 348) { %>
				alert("축하합니다. 전제품 15% 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else { %>
				alert("축하합니다. 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } %>
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function setCoupon() {
	$.post("event_ajax.jsp", {
		mode: "setCoupon",
		eventId: "<%=eventId%>"
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				<% if (eventId == 278) { %>
				alert("축하합니다. 전제품 10% 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else if (eventId == 282) { %>
				alert("축하합니다. 다이어트 지원금 3종 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else if (eventId == 338 || eventId == 348) { %>
				alert("축하합니다. 전제품 15% 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } else { %>
				alert("축하합니다. 할인 쿠폰이 발급되었습니다. 쿠폰은 마이페이지에서 확인하실 수 있습니다.");
				<% } %>
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}
</script>


<!-- 미디어큐브 스크립트 2016-06-24 -->
<script language='JavaScript1.1' src='//pixel.mathtag.com/event/js?mt_id=1035515&mt_adid=158356&v1=&v2=&v3=&s1=&s2=&s3='></script>

</body>
</html>