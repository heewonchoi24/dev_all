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
			<h1>�����ս���</h1>
			<div class="pageDepth">
				HOME &gt; �����ս��� &gt; <strong>Ȩ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li class="active"><a href="index.jsp">Ȩ</a></li>
						<li><a href="orderList.jsp">�ֹ�/���</a></li>
						<li><a href="couponList.jsp">��������</a></li>
						<li><a href="myqna.jsp">1:1 ���ǳ���</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<%
			String table		= "ESL_COUPON C, ESL_COUPON_MEMBER CM";
			String where		= " WHERE C.ID = CM.COUPON_ID AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N' AND C.LTDATE >= DATE_FORMAT(NOW(), '%Y-%m-%d')";
			query		= "SELECT COUNT(C.ID) FROM "+ table + where;
			try {
				rs = stmt.executeQuery(query);
			} catch(Exception e) {
				out.println(e+"=>"+query);
				if(true)return;
			}
			if (rs.next()) {
				tcnt = rs.getInt(1); //�� ���ڵ� ��		
			}

			rs.close();

			query		= "SELECT C.ID, COUPON_NAME, COUPON_NUM, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS,";
			query		+= "	DATE_FORMAT(C.STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(C.LTDATE, '%Y.%m.%d') LTDATE";
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
							<h4><b class="font-blue"><%=eslMemberName%>��</b>, �ݰ����ϴ�. ���Բ��� ��밡���� ������ <b class="font-maple"><%=tcnt%></b>�� �ֽ��ϴ�.</h4>
							<div class="floatright button dark small">
								<a href="couponList.jsp">������</a>
							</div>
						</div>
						<%
						if (tcnt > 0) {
							int i = 1;
							
							while (rs.next()) {
								useLimitTxt			= "";
								useGoodsTxt			= "";
								couponId			= rs.getInt("ID");
								couponName			= rs.getString("COUPON_NAME");
								couponNum			= rs.getString("COUPON_NUM");
								saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "��";
								salePrice			= rs.getInt("SALE_PRICE");
								useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
								useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
								if (useLimitCnt > 0 && useLimitPrice > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "�� �̻� ���� �� ���</p>\n";
									useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "�� �̻� ���� �� ���</p>\n";
								} else if (useLimitCnt > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "�� �̻� ���� �� ���</p>\n";
								} else  if (useLimitPrice > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "�� �̻� ���� �� ���</p>\n";
								} else {
									useLimitTxt			= "";
								}
								useGoods			= rs.getString("USE_GOODS");
								if (useGoods.equals("01")) {
									useGoodsTxt			= "<p>- ��� �ֹ��� ��� ����</p>\n";
								} else {
									query1		= "SELECT GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									while (rs1.next()) {
										useGoodsTxt		+= "<p>- "+ rs1.getString("GROUP_NAME") + " �ֹ��� ��밡��</p>\n";
									}
								}
								stdate				= rs.getString("STDATE");
								ltdate				= rs.getString("LTDATE");
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
									</div>
									<div class="review-date">
										<%=stdate%>~<%=ltdate%>
									</div>
								</div>
							</a>

						</div>
						<%
								i++;
							}
						}
						%>
						<!--div class="element onefourth">
							<div class="couponImage present">
								<div class="couponInfo">
									30% ����
								</div>
							</div>
							<div class="post-text">
								<h5> <a href="#">[7�� �̺�Ʈ]Quick���α׷�</a> </h5>
								<div class="review-text">
									75,600�� �̻� ���Ž� ��밡��
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
			<div class="divider"></div>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4>1:1 ����</h4>
						<div class="floatright button dark small">
							<a href="/customer/indiqna.jsp">1:1 �����ϱ�</a>
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
									answerYnTxt		= "�亯�Ϸ�";
									answer			= ut.nl2br(rs.getString("ANSWER"));
									answerDate		= rs.getString("ANSWER_DATE");
									btnMod = "";
									btnDel = "";
								} else {
									answerYnTxt		= "�̴亯";
									answer			= "";
									answerDate		= "";
									btnMod = "<div class='button dark small' style='padding:3px; line-height:20px;'><a href='/customer/indiqna.jsp?counselID="+ counselID +"'>����</a></div>";
									btnDel = "<div class='button dark small' style='padding:3px; line-height:20px;'><a href=\"javascript:confDel('"+ counselID +"');\">����</a></div>";
								}
							%>
							<li>
								<a href="javascript:;">
									<span class="cate">[<%=ut.getFaqType(counselType)%>]</span>
									<span class="post-subject">
										<span class="qa">Q.</span>
										<%=title%>
									</span>
									<span class="comments font-maple"><%=answerYnTxt%></span>
									<span class="post-date"><%=instDate%></span>
								</a>
								<div class="post-view">
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
							<li>��ϵ� 1:1 ���ǰ� �����ϴ�.</li>
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
							<h2>�����ϴ� ���� <strong class="font-blue">TOP5</strong></h2>
							<div class="floatright button italic">
								<a href="/customer/faq.jsp">������..</a>
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
							<h2>��������</h2>
							<div class="floatright button italic">
								<a href="/customer/notice.jsp">������..</a>
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
$(document).ready(function(){
	$(".boardStyle div.post-view").attr("style", "display: none;");
	$(".boardStyle a").click(function() {
		if ($(this).next("div.post-view").attr("style") == "display: none;") {
			$(".boardStyle div.post-view").slideUp(200);
			$(this).next("div.post-view").slideToggle(200);	
		} else {
			$(this).next("div.post-view").attr("style", "display: none;");
		}
	})	
})

function confDel(counselID) {
	var msg = "������ �����Ͻðڽ��ϱ�? ���� �� ������ �� �����ϴ�."
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