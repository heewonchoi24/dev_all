<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int tcnt			= 0;
int couponId		= 0;
String couponName	= "";
String couponNum	= "";
String saleType		= "";
int salePrice		= 0;
int useLimitCnt		= 0;
int useLimitPrice	= 0;
String useLimitTxt	= "";
String useGoods		= "";
String useGoodsTxt	= "";
String stdate		= "";
String ltdate		= "";
String counselID	= "";
String btnMod		= "";
String btnDel		= "";
String upFile		= "";
String imgUrl		= "";

String[] arr_orderWeek	= new String[4];	// 주문기간
String orderWeeks   = "";	
String orderWeeksTxt = "";

NumberFormat nf		= NumberFormat.getNumberInstance();
%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>HOME</span><strong>마이페이지</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li class="active"><a href="index.jsp">마이페이지</a></li>
						<li><a href="orderList.jsp">주문내역조회</a></li>
						<li><a href="calendar.jsp">배송캘린더</a></li>
						<li><a href="couponList.jsp">쿠폰리스트</a></li>
						<li><a href="myqna.jsp">1:1 문의내역</a></li>
						<div class="button small iconBtn light">
							<% if("U".equals(eslMemberCode))	//통합회원 구분 
							{ 
							%>
								<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> 회원정보수정</a>
							<% 
							}
							else 
							{ 
							%>
								<a href="/shop/mypage/member_edit.jsp"><span class="gear"></span>회원정보수정</a> 
								<a href="/shop/mypage/member_leave.jsp"></span>회원탈퇴</a>
							<% 
							} 
							%>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<%
			String table		= "ESL_COUPON C, ESL_COUPON_MEMBER CM";
			String where		= " WHERE C.ID = CM.COUPON_ID AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N' AND C.LTDATE >= DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i')";
			query		= "SELECT COUNT(C.ID) FROM "+ table + where;
			try {
				rs = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			if (rs.next()) {
				tcnt = rs.getInt(1); //총 레코드 수
			}

			rs.close();

			query		= "SELECT C.ID, COUPON_NAME, COUPON_NUM, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS,";
			query		+= "	C.STDATE AS STDATE, C.LTDATE AS LTDATE, C.ORDERWEEK";
			query		+= " FROM "+ table + where;
			query		+= " ORDER BY CM.ID DESC";
			query		+= " LIMIT 0, 4";
			try {
				rs = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			%>
			<div class="row">
				<div class="one last col">
					<div class="mycoupon">
						<div class="sectionHeader">
							<h4><b class="font-blue"><%=eslMemberName%>님</b>, 반갑습니다. 고객님께서 사용가능한 쿠폰이 <b class="font-maple"><%=tcnt%></b>장 있습니다.</h4>
							<div class="floatright button dark small">
								<a href="couponList.jsp">더보기</a>
							</div>
						</div>
						<%
						if (tcnt > 0) {
							int i = 1;

							while (rs.next()) {
								useLimitTxt			= "";
								useGoodsTxt			= "";
								orderWeeksTxt       = "";
								orderWeeks          = "";

								int goodsId = 0;
								int goodsGubun1 = 0;
								int chk = 0;
							    int devlType = 0;

								couponId			= rs.getInt("ID");
								couponName			= rs.getString("COUPON_NAME");
								couponNum			= rs.getString("COUPON_NUM");
								saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "원";
								salePrice			= rs.getInt("SALE_PRICE");
								useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
								useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
								useGoods			= rs.getString("USE_GOODS");
								stdate				= rs.getString("STDATE");
								ltdate				= rs.getString("LTDATE");
								orderWeeks			= rs.getString("ORDERWEEK");

							//	if(!useGoods.equals("04") && !orderWeeks.equals("") || useGoods.equals("04")){// 04가아니면서 주문기간이 선택된 쿠폰들 혹은 04인 경우
								
									if (useLimitCnt > 0 && useLimitPrice > 0) {
										useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
										useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
									} else if (useLimitCnt > 0) {
										useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "개 이상 구매 시 사용</p>\n";
									} else  if (useLimitPrice > 0) {
										useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "원 이상 구매 시 사용</p>\n";
									} else {
										useLimitTxt			= "";
									}
									
									if (useGoods.equals("01")) {
										useGoodsTxt			= "<p>- 모든 주문시 사용 가능</p>\n";
										orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
										orderWeeksTxt = "<p>- 주문기간: "+ orderWeeks + "(주) 사용가능</p>\n";
									} else if (useGoods.equals("03")) {
										useGoodsTxt			= "<p>- 일배상품 주문시 사용 가능</p>\n";
										orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
										orderWeeksTxt = "<p>- 주문기간: "+ orderWeeks + "(주) 사용가능</p>\n";
									} else if (useGoods.equals("04")) {
										useGoodsTxt			= "<p>- 택배상품 주문시 사용 가능</p>\n";
									} else {
										query1		= "SELECT B.DEVL_GOODS_TYPE, B.ID, B.GUBUN1, A.GROUP_NAME FROM ESL_COUPON_GOODS A, ESL_GOODS_GROUP B WHERE A.GROUP_CODE = B.GROUP_CODE  AND A.COUPON_ID = "+ couponId;
										try {
											rs1 = stmt1.executeQuery(query1);
										} catch(Exception e) {
											out.println(e+"=>"+query1);
											if(true)return;
										}

										while (rs1.next()) {
											useGoodsTxt		+= "<p>- "+ rs1.getString("GROUP_NAME") + " 주문시 사용가능</p>\n";
											goodsId = rs1.getInt("ID");
											goodsGubun1 = rs1.getInt("GUBUN1");
											devlType = rs1.getInt("DEVL_GOODS_TYPE");

											if(devlType == 0002){
											}else{
												chk = 1;
											}

										}

										if(chk == 1){
											orderWeeks = orderWeeks.substring(0,orderWeeks.length()-1);
											orderWeeksTxt = "<p>- (일배)주문기간: "+ orderWeeks + "(주) 사용가능</p>\n";
										}
									}
						%>
						<div class="element onefourth<%if (i == 4) out.print(" last");%>">

							<a href="couponList.jsp">
								<div class="couponImage sale">
									<div class="couponInfo">
										<%=nf.format(salePrice) + saleType%>
									</div>
								</div>
								<div class="post-text">
									<h5><%=couponName%></h5>
									<div class="review-text">
										<%=useLimitTxt%>
										<%=useGoodsTxt%>
										<%=orderWeeksTxt%>
									</div>
									<div class="review-date">
										<%=stdate%><br> ~ <%=ltdate%>
									</div>
								</div>
							</a>

						</div>
						<%
								i++;
							//	}
							}
						}
						%>

						<!--div class="element onefourth">
							<div class="couponImage present">
								<div class="couponInfo">
									30% 할인
								</div>
							</div>
							<div class="post-text">
								<h5> <a href="#">[7월 이벤트]Quick프로그램</a> </h5>
								<div class="review-text">
									75,600원 이상 구매시 사용가능
								</div>
								<div class="review-date">
									2013.07.28~2013.08.28
								</div>
							</div>
						</div-->
						<div class="clear"></div>
					</div>
					<!-- End mycoupon -->
				</div>
			</div>

			<div class="row">
			<%

				query		= "SELECT COUNT(O.ID)";
				query		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG";
				query		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM";
				query		+= " AND O.MEMBER_ID ='"+ eslMemberId +"'";
				query		+= " AND (OG.ORDER_STATE > 0 AND OG.ORDER_STATE < 90)";
				query		+= " AND DATE_FORMAT(DATE_SUB(SYSDATE(), INTERVAL 30 DAY), '%Y%m%d') < DATE_FORMAT(O.ORDER_DATE,'%Y%m%d')  ";
				try {
					rs	= stmt.executeQuery(query);
				} catch(Exception e) {
					out.println(e+"=>"+query);
					if(true)return;
				}

				if (rs.next()) {
					tcnt = rs.getInt(1); //총 레코드 수
				}

			%>
				<div class="one last col">
					<div class="mycoupon">
						<div class="sectionHeader">
							<h4>고객님의 최근 1개월간 주문/배송건은 <b class="font-maple"><%=tcnt%></b>건 입니다.</h4>
							<div class="floatright button dark small">
								<a href="orderList.jsp">더보기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="divider"></div>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4>1:1 문의</h4>
						<div class="floatright button dark small">
							<a href="/customer/indiqna.jsp">1:1 문의하기</a>
						</div>
					</div>
					<div class="postList">
						<%
						String counselType	= "";
						String title		= "";
						String content		= "";
						String instDate		= "";
						String answerYn		= "";
						String answerYnTxt	= "";
						String answer		= "";
						String answerDate	= "";
						int i				= 0;

						query		= "SELECT ID, COUNSEL_TYPE, TITLE, CONTENT, DATE_FORMAT(INST_DATE, '%Y-%m-%d') INST_DATE,";
						query		+= "	ANSWER_YN, ANSWER, DATE_FORMAT(ANSWER_DATE, '%Y-%m-%d') ANSWER_DATE, UP_FILE";
						query		+= " FROM ESL_COUNSEL";
						query		+= " WHERE MEMBER_ID = '"+ eslMemberId +"'";
						query		+= " ORDER BY ID DESC";
						query		+= " LIMIT 0, 5";
						try {
							rs		= stmt.executeQuery(query);
						} catch(Exception e) {
							out.println(e+"=>"+query);
							if(true)return;
						}
						%>
						<ul class="boardStyle">
							<%
							while (rs.next()) {
								counselID		= rs.getString("ID");
								counselType		= rs.getString("COUNSEL_TYPE");
								title			= rs.getString("TITLE");
								content			= ut.nl2br(rs.getString("CONTENT"));
								instDate		= rs.getString("INST_DATE");
								answerYn		= rs.getString("ANSWER_YN");
								upFile			= ut.isnull(rs.getString("UP_FILE"));
								if (upFile.equals("") || upFile == null) {
									imgUrl		= "";
								} else {
									imgUrl		= "<img src='"+ webUploadDir +"board/"+ upFile + "' />";
								}
								if (answerYn.equals("Y")) {
									answerYnTxt		= "답변완료";
									answer			= ut.nl2br(rs.getString("ANSWER"));
									answerDate		= rs.getString("ANSWER_DATE");
									btnMod = "";
									btnDel = "";
								} else {
									answerYnTxt		= "미답변";
									answer			= "";
									answerDate		= "";
									btnMod = "<div class='button dark small' style='padding:3px; line-height:20px;'><a href='/customer/indiqna.jsp?counselID="+ counselID +"'>수정</a></div>";
									btnDel = "<div class='button dark small' style='padding:3px; line-height:20px;'><a href=\"javascript:confDel('"+ counselID +"');\">삭제</a></div>";
								}
							%>
							<li>
								<a href="javascript:;" onclick="showContent(<%=counselID%>)">
									<span class="cate">[<%=ut.getCounselType(counselType)%>]</span>
									<span class="post-subject">
										<span class="qa">Q.</span>
										<%=title%>
									</span>
									<span class="comments font-maple"><%=answerYnTxt%></span>
									<span class="post-date"><%=instDate%></span>
								</a>
								<div id="content_<%=counselID%>" class="post-view hidden">
									<div class="post-article">
										<%=imgUrl%>
										<p><%=content%></p>
									</div>
									<div class="btnGroup floatright">
										<%=btnMod%>
										<%=btnDel%>
									</div>
                                    <div class="clear"></div>
                                    
									<%if (answerYn.equals("Y")) {%>
									<div class="post-view-comment">
										<div class="re-title">
											<%=title%> <span class="comment-date"><%=answerDate%></span>
										</div>
										<p><%=answer%></p>
									</div>
									<%}%>
								</div>
							</li>
							<%
								i++;
							}
							rs.close();

							if (i < 1) {
							%>
							<li>등록된 1:1 문의가 없습니다.</li>
							<%}%>
						</ul>
					</div>
					<!-- End postList -->
				</div>
			</div>
			<!-- End row -->
			<div class="divider"></div>
			<div class="row">
				<div class="onehalf col">
					<div class="mypage-faq-list">
						<div class="sectionHeader">
							<h2>자주하는 질문 <strong class="font-blue">TOP5</strong></h2>
							<div class="floatright button italic">
								<a href="/customer/faq.jsp">더보기..</a>
							</div>
						</div>
						<ul>
							<%
							query		= "SELECT ID, TITLE FROM ESL_FAQ ORDER BY HIT_CNT DESC LIMIT 0, 5";
							pstmt		= conn.prepareStatement(query);
							rs			= pstmt.executeQuery();

							while (rs.next()) {
							%>
							<li><a href="/customer/faq.jsp?id=<%=rs.getInt("ID")%>"><%=ut.cutString(50, rs.getString("TITLE"), "..")%></a></li>
							<%
							}

							rs.close();
							%>
						</ul>
					</div>
				</div>
				<!-- End onehalf -->
				<div class="onehalf last col">
					<div class="mypage-notice-list">
						<div class="sectionHeader">
							<h2>공지사항</h2>
							<div class="floatright button italic">
								<a href="/customer/notice.jsp">더보기..</a>
							</div>
						</div>
						<ul>
							<%
							query		= "SELECT ID, TITLE, CONTENT FROM ESL_NOTICE ORDER BY TOP_YN DESC, ID DESC LIMIT 0, 2";
							pstmt		= conn.prepareStatement(query);
							rs			= pstmt.executeQuery();

							while (rs.next()) {
							%>
							<li>
								<a href="/customer/noticeView.jsp?id=<%=rs.getInt("ID")%>">
									<p class="title"><%=ut.cutString(50, rs.getString("TITLE"), "..")%></p>
									<p class="summary"><%=ut.cutString(50, ut.convertHtmlTags(rs.getString("CONTENT")), "...")%></p>
								</a>
							</li>
							<%
							}

							rs.close();
							%>
						</ul>
					</div>
				</div>
				<div class="clear"></div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
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
function showContent(cid) {
	if ($("#content_"+ cid).hasClass("hidden")) {
		$(".post-view").addClass("hidden");
		$("#content_"+ cid).removeClass("hidden");
	} else {
		$("#content_"+ cid).addClass("hidden");
	}
}

function confDel(counselID) {
	var msg = "정말로 삭제하시겠습니까? 삭제 후 복구할 수 없습니다."
	if(confirm(msg)){
		location.href = "/customer/indiqna_del_db.jsp?counselID="+ counselID +"&mode=del";
	}else{
		return;
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>