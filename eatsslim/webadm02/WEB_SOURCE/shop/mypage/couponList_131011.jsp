<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_COUPON C, ESL_COUPON_MEMBER CM";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String where		= "";
String param		= "";
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
String instDate		= "";
String stdate		= "";
String ltdate		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());

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

where			= " WHERE C.ID = CM.COUPON_ID AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N' AND C.LTDATE >= DATE_FORMAT(NOW(), '%Y-%m-%d')";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

query		= "SELECT COUNT(C.ID) FROM "+ table + where; //out.print(query); if(true)return;
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

query		= "SELECT C.ID, COUPON_NAME, COUPON_NUM, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS,";
query		+= "	DATE_FORMAT(C.INST_DATE, '%Y.%m.%d') INST_DATE, DATE_FORMAT(C.STDATE, '%Y.%m.%d') STDATE,";
query		+= "	DATE_FORMAT(C.LTDATE, '%Y.%m.%d') LTDATE";
query		+= " FROM "+ table + where;
query		+= " ORDER BY CM.ID DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
///////////////////////////
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
			<h1> 마이잇슬림 </h1>
			<div class="pageDepth">
				HOME &gt; My Eatsslim &gt; <strong>쿠폰내역</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="index.jsp">홈</a></li>
						<li><a href="orderList.jsp">주문/배송</a></li>
						<li class="active"><a href="couponList.jsp">쿠폰내역</a></li>
						<li><a href="myqna.jsp">1:1 문의내역</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> 회원정보수정</a>
						</div>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<ul class="listSort">
						<li><span class="current">사용 가능한 쿠폰</span></li>
						<li><a href="/shop/mypage/expireCoupon.jsp">사용/만료된 쿠폰</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<div class="sectionHeader">
						<h4>보유하신 오프라인 쿠폰의 인증번호 입력 후 등록버튼을 눌러주세요.</h4>
						<div class="floatright">
							쿠폰등록
							<input type="text" class="inputfield" name="textfield" id="textfield" />
							<input type="submit" class="button darkbrown small" name="button" value="등록" />
						</div>
						<div class="clear"></div>
					</div>
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>쿠폰명</th>
							<th>쿠폰코드</th>
							<th>할인혜택</th>
							<th>사용조건</th>
							<th>발급날짜</th>
							<th class="last">사용유효기간</th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							while (rs.next()) {
								useLimitTxt			= "";
								useGoodsTxt			= "";
								couponId			= rs.getInt("ID");
								couponName			= rs.getString("COUPON_NAME");
								couponNum			= rs.getString("COUPON_NUM");
								saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "원";
								salePrice			= rs.getInt("SALE_PRICE");
								useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
								useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
								if (useLimitCnt > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "개 이상 구매시 사용 가능</p>\n";
								} else {
									useLimitTxt			= "";
								}
								if (useLimitPrice > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "원 이상 구매시 사용 가능</p>\n";
								} else {
									useLimitTxt			= "";
								}
								useGoods			= rs.getString("USE_GOODS");
								if (useGoods.equals("01")) {
									useGoodsTxt			= "<p>- 전체 상품에 사용 가능</p>\n";
								} else {
									query1		= "SELECT GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									while (rs1.next()) {
										useGoodsTxt		+= "<p>- "+ rs1.getString("GROUP_NAME") + " 주문시 사용 가능</p>\n";
									}
								}
								instDate			= rs.getString("INST_DATE");
								stdate				= rs.getString("STDATE");
								ltdate				= rs.getString("LTDATE");
						%>
						<tr>
							<td><%=couponName%></td>
							<td><%=couponNum%></td>
							<td><%=nf.format(salePrice) + saleType%> 할인</td>
							<td><%=useLimitTxt + useGoodsTxt%></td>
							<td><%=instDate%></td>
							<td><%=stdate%>~<%=ltdate%></td>
						</tr>
						<%
							}
						} else {
						%>	
						<tr>
							<td colspan="6">사용 가능한 쿠폰이 없습니다.</td>
						</tr>
						<%
						}
						%>
					</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<%@ include file="/common/include/inc-paging.jsp"%>
				</div>
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
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>