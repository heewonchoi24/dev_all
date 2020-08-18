<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query	= "";
int myCnt		= 0;
int versus1		= 0;
int versus2		= 0;

if (!eslMemberId.equals("") && eslMemberId != null) {
	query		= "SELECT CNT FROM ESL_EVENT_VERSUS WHERE MEMBER_ID = '"+ eslMemberId +"'";
	try {
		rs	= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if (true) return;
	}

	if (rs.next()) {
		myCnt	= rs.getInt("CNT");
	}

	rs.close();
}

query		= "SELECT ";
query		+= " (SELECT COUNT(ID) FROM ESL_EVENT_VERSUS WHERE VERSUS = '1') AS VERSUS1";
query		+= " ,(SELECT COUNT(ID) FROM ESL_EVENT_VERSUS WHERE VERSUS = '2') AS VERSUS2";
query		+= " FROM DUAL";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if (true) return;
}

if (rs.next()) {
	versus1		= rs.getInt("VERSUS1");
	versus2		= rs.getInt("VERSUS2");
}

rs.close();
%>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/event.css" />
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container" style="width:1024px;">
		<div class="maintitle">
			<h1> 최과장 VS 이대리 </h1>
			<div class="pageDepth">
				HOME &lt 이벤트 &lt <strong>최과장VS이대리</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="row">
			<div id="event01" class="marb50">
				<ul class="promotiontabNavi marb20">
					<li class="active"><a href="#event01"><img src="/images/promotion/pr1120/btn_01_on.png" width="248" height="56" alt="event-1" /></a></li>
					<li><a href="#event03"><img src="/images/promotion/pr1120/btn_03_off.png" width="248" height="56" alt="event-3" /></a></li>
					<li><a href="/event/observe.jsp" target="_blank"><img src="/images/promotion/pr1120/btn_04_off.png" width="248" height="56" alt="event-3" /></a></li>
					<div class="clear"></div>
				</ul>
				<div class="eventchapter" style="background:url(/images/promotion/pr1120/pr_top.jpg) no-repeat 0 0; width:1024px; height:756px;">
					<%if (eslMemberId.equals("")) {%>
					<a class="lightbox support a-part" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"></a>
					<a class="lightbox support b-part" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"></a>
					<%} else {%>
					<a href="javascript:;" onclick="versus(1, <%=myCnt%>);" class="support a-part"></a>
					<a href="javascript:;" onclick="versus(2, <%=myCnt%>);" class="support b-part"></a>
					<%}%>
					<div class="a-account">
						<input type="text" name="versus1" value="<%=versus1%>" readonly="readonly" />
					</div>
					<div class="b-account">
						<input type="text" name="versus2" value="<%=versus2%>" readonly="readonly" />
					</div>
				</div>
				<div>
					<img src="/images/promotion/pr1120/pr_top_info.jpg" width="1024" height="458" />
				</div>
			</div>
			<%--
			<div id="event02" class="marb40">
				<ul class="promotiontabNavi marb20">
					<li> <a href="#event01"><img src="/images/promotion/pr1120/btn_01_off.png" width="248" height="56" alt="event-1"></a> </li>
					<li> <a href="#event02"><img src="/images/promotion/pr1120/btn_02_on.png" width="248" height="56" alt="event-2"></a> </li>
					<li> <a href="#event03"><img src="/images/promotion/pr1120/btn_03_off.png" width="248" height="56" alt="event-3"></a> </li>
					<li><a href="/event/observe.jsp" target="_blank"><img src="/images/promotion/pr1120/btn_04_off.png" width="248" height="56" alt="event-3" /></a></li>
					<div class="clear">
					</div>
				</ul>
				<div class="eventchapter" style="background:url(/images/promotion/pr1120/pr_middle.jpg) no-repeat 0 0; width:1024px; height:644px;">
					<a href="/event/eventView.jsp?id=18" class="diary-btn-a"><img src="/images/promotion/pr1120/btn_diary_a.png" width="102" height="92"></a>
					<a href="/event/eventView.jsp?id=18" class="diary-btn-b"><img src="/images/promotion/pr1120/btn_diary_b.png" width="102" height="92"></a>
					<a href="/event/eventView.jsp?id=18" class="support-btn"><img src="/images/promotion/pr1120/btn_contact.png" width="344" height="54"></a>
				</div>
			</div>
			--%>
			<div id="event03" class="marb50">
				<ul class="promotiontabNavi marb20">
					<li> <a href="#event01"><img src="/images/promotion/pr1120/btn_01_off.png" width="248" height="56" alt="event-1"></a> </li>
					<li> <a href="#event03"><img src="/images/promotion/pr1120/btn_03_on.png" width="248" height="56" alt="event-3"></a> </li>
					<li><a href="/event/observe.jsp" target="_blank"><img src="/images/promotion/pr1120/btn_04_off.png" width="248" height="56" alt="event-3" /></a></li>
					<li><img src="/images/promotion/pr1120/pr_bottom_1.jpg" width="1012" height="157" usemap="#map"></li>
					<map name="Map">
                      <area shape="rect" coords="20,90,226,140" href="/event/schedule_1.jsp" target="_blank" alt="최과장님 식단 보기">
                      <area shape="rect" coords="800,90,980,140" href="/event/schedule_1.jsp" target="_blank" alt="이대리님 식단 보기">
                      <area shape="rect" coords="320,30,700,140" href="/event/observe.jsp" target="_blank" alt="밀착 감시 보러가기">
                    </map> 
					<div class="clear">
					</div>
				</ul>

				<div class="eventchapter marb50" style="background:url(/images/promotion/pr1120/pr_bottom.jpg) no-repeat 0 0; width:1024px; height:696px;">
					<%
					String table		= "ESL_EVENT_DIARY";
					String where		= "";
					String param		= "";
					int diaryId			= 0;
					String title		= "";
					int day				= 0;
					String weekday		= "";
					int intI			= 0;
					String pageType		= "";

					///////////////////////////
					int pgsize		= 7; //페이지당 게시물 수
					int pagelist	= 10; //화면당 페이지 수
					int iPage;			  // 현재페이지 번호
					int startpage;		  // 시작 페이지 번호
					int endpage		= 0;
					int totalPage	= 0;
					int intTotalCnt	= 0;
					int number;
					int step		= 0;
					int curNum		= 0;

					where			= " WHERE VERSUS = '1' ";

					if (request.getParameter("page") != null && request.getParameter("page").length()>0){
						iPage		= Integer.parseInt(request.getParameter("page"));
						startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
					}else{
						iPage		= 1;
						startpage	= 1;
					}
					if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
						pgsize		= Integer.parseInt(request.getParameter("pgsize"));

					query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
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

					query		= "SELECT ID, TITLE, DAY, WEEKDAY";
					query		+= " FROM "+ table + where;
					query		+= " ORDER BY ID DESC";
					query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
					pstmt		= conn.prepareStatement(query);
					rs			= pstmt.executeQuery();
					///////////////////////////
					%>
					<div class="choi-diary">						
						<ul>
							<%
							intI	= 0;
							if (intTotalCnt > 0) {
								while (rs.next()) {
									diaryId		= rs.getInt("ID");
									title		= rs.getString("TITLE");
									day			= rs.getInt("DAY");
									weekday		= rs.getString("WEEKDAY");
							%>
							<li><a href="javascript:;" onClick="window.open('choi_diary.jsp?id=<%=diaryId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=day%>일차(<%=weekday%>)</span><%=title%></a></li>
							<%
									intI++;
								}
							}

							for (int ii=(intI + 1); ii<=7; ii++) {
								out.println("<li>&nbsp;</li>");
							}

							pageType	= "1";
							%>
						</ul>
						<%@ include file="../common/include/inc-paging-event.jsp"%>
					</div>
					<div class="lee-diary">
						<%
						where			= " WHERE VERSUS = '2' ";

						if (request.getParameter("page") != null && request.getParameter("page").length()>0){
							iPage		= Integer.parseInt(request.getParameter("page"));
							startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
						}else{
							iPage		= 1;
							startpage	= 1;
						}
						if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
							pgsize		= Integer.parseInt(request.getParameter("pgsize"));

						query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
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

						query		= "SELECT ID, TITLE, DAY, WEEKDAY";
						query		+= " FROM "+ table + where;
						query		+= " ORDER BY ID DESC";
						query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();
						///////////////////////////
						%>
						<ul>
							<%
							intI	= 0;
							if (intTotalCnt > 0) {
								while (rs.next()) {
									diaryId		= rs.getInt("ID");
									title		= rs.getString("TITLE");
									day			= rs.getInt("DAY");
									weekday		= rs.getString("WEEKDAY");
							%>
							<li><a href="javascript:;" onClick="window.open('lee_diary.jsp?id=<%=diaryId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=day%>일차(<%=weekday%>)</span><%=title%></a></li>
							<%
									intI++;
								}
							}
							for (int ii=(intI + 1); ii<=7; ii++) {
								out.println("<li>&nbsp;</li>");
							}

							pageType	= "2";
							%>
						</ul>
						<%@ include file="../common/include/inc-paging-event.jsp"%>
					</div>
					<div class="advisor-comment">
						<%
						table		= "ESL_EVENT_WEEK_COMMENT";
						int weekId			= 0;
						String stdate		= "";
						String ltdate		= "";
						pgsize		= 4;
						where			= " WHERE 1=1 ";

						if (request.getParameter("page") != null && request.getParameter("page").length()>0){
							iPage		= Integer.parseInt(request.getParameter("page"));
							startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
						}else{
							iPage		= 1;
							startpage	= 1;
						}
						if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
							pgsize		= Integer.parseInt(request.getParameter("pgsize"));

						query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query1); if(true)return;
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

						query		= "SELECT ID, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE, TITLE";
						query		+= " FROM "+ table + where;
						query		+= " ORDER BY ID DESC";
						query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
						pstmt		= conn.prepareStatement(query);
						rs			= pstmt.executeQuery();
						///////////////////////////
						%>
						<ul>
							<%
							intI	= 0;
							if (intTotalCnt > 0) {
								while (rs.next()) {
									weekId		= rs.getInt("ID");
									stdate		= rs.getString("STDATE");
									ltdate		= rs.getString("LTDATE");
									title		= rs.getString("TITLE");
							%>
							<li><a href="javascript:;" onClick="window.open('week_comment.jsp?id=<%=weekId%>','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=900,height=500')"><span><%=stdate%>~<%=ltdate%></span><%=title%></a></li>
							<%
									intI++;
								}
							}
							for (int ii=(intI + 1); ii<=4; ii++) {
								out.println("<li>&nbsp;</li>");
							}

							pageType	= "3";
							%>
						</ul>
						<%@ include file="../common/include/inc-paging-event.jsp"%>
					</div>
				</div>
				<div>
					<img src="/images/promotion/pr1120/pr_preview.jpg" width="1024" height="228">
				</div>
			</div>
		</div>
		<!-- End Row -->
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
</div>
<script type="text/javascript">
function versus(num, cnt) {
	var vName	= (num == 1)? '최과장' : '이대리';
	var msg		= (cnt == 0)? vName + "님을 응원하십니까?" : "응원할 도전자를 "+ vName +"님으로 변경 하시겠습니까?";
	if (confirm(msg)) {
		$.post("versus_ajax.jsp", {
			mode: "versus",
			versus: num,
			cnt: cnt
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					alert(vName +"님을 응원합니다.");
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
}

function getDiary(page, ptype) {
	$.get("versus_list_ajax.jsp", {
		page: page,
		ptype: ptype
	}, function(data) {
		if (ptype == '1') {
			$(".choi-diary").html(data);
		} else if (ptype == '2') {
			$(".lee-diary").html(data);
		} else if (ptype == '3') {
			$(".advisor-comment").html(data);
		}
	});
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp" %>