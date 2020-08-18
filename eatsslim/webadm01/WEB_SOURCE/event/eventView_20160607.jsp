<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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
String ltdate2			= "";
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

int reply_count = 0;
int reply_id = 0;
int reply_idx = 0;

String m_id = "";
String m_name = "";
String reply_content = "";
String reply_content2 = "";
String reply_date = "";
String reply_date2 = "";
String reply_mode = "write";

String imgUrl = "";
String viewImg = "";

SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());

String listPageName = "";
String listPageNameStr = "";

int noticeId = 0;

if (request.getParameter("reply_idx") != null && request.getParameter("reply_idx").length() > 0) {
	reply_idx = Integer.parseInt(request.getParameter("reply_idx"));
}

if (request.getParameter("keyword") != null) {
	keyword					= ut.inject(request.getParameter("keyword"));
	keyword					= new String(keyword.getBytes("8859_1"), "EUC-KR");
}
param			= "page="+ iPage +"&pgsize="+ pgsize +"&field="+ field +"&keyword="+ keyword;

if (request.getParameter("id") != null && request.getParameter("id").length() > 0) {
	eventId	= Integer.parseInt(request.getParameter("id"));

	query		= "UPDATE ESL_EVENT SET HIT_CNT = HIT_CNT + 1 WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	pstmt.executeUpdate();
	if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
	
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

	query		= "SELECT TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE,DATE_FORMAT(LTDATE, '%Y-%m-%d') LTDATE2,";
	query		+= "	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, CONTENT, VIEW_IMG,EVENT_TARGET";
	query		+= " FROM ESL_EVENT";
	query		+= " WHERE ID = ?";
	pstmt		= conn.prepareStatement(query);
	pstmt.setInt(1, eventId);
	rs			= pstmt.executeQuery();

	if (rs.next()) {
		title			= rs.getString("TITLE");
		stdate			= rs.getString("STDATE");
		ltdate			= rs.getString("LTDATE");
		ltdate2			= rs.getString("LTDATE2");
		eventTarget	= rs.getString("EVENT_TARGET");
		ancDate			= (rs.getString("ANC_DATE") == null || rs.getString("ANC_DATE").equals(""))? "미정" : rs.getString("ANC_DATE");
		content			= rs.getString("CONTENT");
		//viewImg			= (rs.getString("view_img") == null || rs.getString("ANC_DATE").equals(""))? "" : rs.getString("view_img");
		viewImg			= (rs.getString("view_img") == null)? "" : rs.getString("view_img");
		imgUrl		= webUploadDir +"promotion/"+ viewImg;


		if(Integer.parseInt(ltdate.replace(".","")) >=  Integer.parseInt(today.replace("-",""))){	
			listPageName = "currentEvent.jsp";
			listPageNameStr = "진행중인";
		}else{
			listPageName = "lastEvent.jsp";
			listPageNameStr = "지난";
		}
	}
} else {
	ut.jsBack(out);
	if (true) return;
}
%>
<script src="eventView.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1><%=listPageNameStr%> 이벤트</h1>
			<div class="pageDepth">
				HOME &gt; EVENT &gt; <strong><%=listPageNameStr%> 이벤트</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="post-wrapper">
						<div class="post-read">
							<h2><%=title%></h2>
							<ul class="meta-wrap">
								<li><span class="time"></span><strong>이벤트기간</strong> <%=stdate%> ~ <%=ltdate%></li>
								<li><span class="who"></span><strong>이벤트대상</strong> <%=eventTarget%></li>
								<li><span class="win"></span><strong>당첨자발표</strong> <%=ancDate%></li>
								<div class="share floatright">
                                    <ul>
                                        <li>
                                            <a class="facebook" href="http://www.facebook.com/share.php?u=<%=request.getRequestURL()%>?id=<%=eventId%>" target="_blank"></a>
                                        </li>
                                        <li>
                                            <a class="twitter" href="http://twitter.com/share?url=<%=request.getRequestURL()%>?id=<%=eventId%>&text=eatsslim diet" target="_blank"></a>
                                        </li>
                                        <li>
                                            <a class="me2day" href="http://me2day.net/posts/new?new_post[body]=<%=request.getRequestURL()%>?id=<%=eventId%>" target="_blank"></a>
                                        </li>
                                    </ul>
                                 </div>
                            </ul>
							<div class="clear"></div>
							<div class="post-contents">
								<%=content%>
								<map name="tabMap" id="tabMap">
									<area shape="rect" coords="496,2,810,57" href="javascript:;" onclick="alert('준비중입니다.');" />
									<area shape="circle" coords="872,1360,32" href="/goods/balanceShake.jsp" target="goodsView" />
									<area shape="circle" coords="571,1360,32" href="/goods/alacarte.jsp" target="goodsView" />
									<area shape="circle" coords="266,1360,32" href="/goods/secretSoup.jsp" target="goodsView" />
								</map>
								<map name="note1" id="note1">
									<area shape="rect" coords="2,1,394,62" href="javascript:;" onclick="window.open('/promotion/note1.html','promotion','resizable=no,scrollbars=no,toolbar=no,location=no,status=no,menubar=no,width=883,height=650');" />
								</map>
								<map name="note2" id="note2">
									<area shape="rect" coords="2,1,394,62" href="javascript:;" onclick="window.open('/promotion/note2.html','promotion','resizable=no,scrollbars=no,toolbar=no,location=no,status=no,menubar=no,width=883,height=650');" />
								</map>
							</div>
							<div class="col center">
								<div class="button small dark">
									<a href="/event/<%=listPageName%>?<%=param%>">목록</a>
								</div>
							</div>
							<div class="comment-wrap">
								<div class="sectionHeader">
									<h4>댓글(<%=reply_count%>)</h4>
									<div class="floatright button dark small">
										<a href="javascript:reply_write();">댓글등록</a>
									</div>
									<div class="clear"></div>
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
									선택하기
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
									<textarea id="content" name="content" class="auto-hint" title="<%=login_stat_str%>게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다." wrap="virtual" <%if(eslMemberId.equals("")){%>disabled="true"<%}%>><%=reply_content%></textarea>
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
												<a href="eventView.jsp?<%=param%>&id=<%=noticeId%>&reply_idx=<%=reply_idx%>">수정</a> ㅣ <a href="javascript:reply_del('<%=reply_idx%>');">삭제</a>
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
					</div>
				</div>
			</div>
			<!-- End Row -->
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">
$(document).ready(function() {
	if ($(".selectBox")) {
		var width1 = parseInt($(".selectBox").css("width").replace("px", "")) + 13;
		var width2 = parseInt($(".selectBox-label").css("width").replace("px", "")) + 13;
		$(".selectBox").css("width", width1 + "px");
		$(".selectBox-label").css("width", width2 + "px");
	}
});

function UccLink() {
	var IE = (document.all) ? true : false;
	var URL = '<div style="margin:0 auto;text-align:center;position:relative;background:url(https://www.eatsslim.co.kr/images/promotion/201402/event_life3_scrap.jpg) no-repeat 0 0;width:960px;height:2436px;"><div style="position:absolute;left:380px;bottom:19px;width:238px;height:80px;display:block;"><a href="https://www.eatsslim.co.kr/event/eventView.jsp?id=39&pgsize=10" target="_blank"><img src="https://www.eatsslim.co.kr/images/event_ckpscrap_bt_201402.jpg" width="238" height="53" alt="이벤트 바로가기" /></a></div></div>';

	if (IE) {
		window.clipboardData.setData('Text', URL);
		alert('스크랩되었습니다. 블로그, 카페 게시판에 html 선택 후 Ctrl+V로 붙여 넣기 하세요.');
	} else {
		temp = prompt("이 글의 html입니다. Ctrl+C를 눌러 클립보드로 복사하세요", URL );
	}
}
</script>
</body>
</html>