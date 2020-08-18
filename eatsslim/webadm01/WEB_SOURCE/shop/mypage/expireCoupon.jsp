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
String useDate		= "";
String stdate		= "";
String ltdate		= "";
String useYn		= "";
String useTxt		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();

///////////////////////////
int pgsize		= 10; //�������� �Խù� ��
int pagelist	= 10; //ȭ��� ������ ��
int iPage;			  // ���������� ��ȣ
int startpage;		  // ���� ������ ��ȣ
int endpage		= 0;
int totalPage	= 0;
int intTotalCnt	= 0;
int number;
int step		= 0;
int curNum		= 0;

String[] arr_orderWeek	= new String[4];	// �ֹ��Ⱓ
String orderWeeks   = "";	
String orderWeeksTxt = "";

where			= " WHERE C.ID = CM.COUPON_ID AND MEMBER_ID = '"+ eslMemberId +"' AND (USE_YN = 'Y' OR C.LTDATE < DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i'))";

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
	intTotalCnt = rs.getInt(1); //�� ���ڵ� ��
}
if (rs != null) try { rs.close(); } catch (Exception e) {}
if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}

totalPage	= (int)(Math.ceil((float)intTotalCnt/pgsize)); // �� ������ ��
endpage		= startpage + pagelist - 1;
if (endpage > totalPage) {
	endpage = totalPage;
}
curNum		= intTotalCnt-pgsize*(iPage-1);
param		+= "&amp;pgsize=" + pgsize;

query		= "SELECT C.ID, COUPON_NAME, COUPON_NUM, SALE_TYPE, SALE_PRICE, USE_LIMIT_CNT, USE_LIMIT_PRICE, USE_GOODS,";
query		+= "	DATE_FORMAT(CM.USE_DATE, '%Y.%m.%d') USE_DATE, C.STDATE AS STDATE,";
query		+= "	C.LTDATE AS LTDATE, USE_YN, C.ORDERWEEK";
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
			<div class="pageDepth">
				<span>Ȩ</span><span>����������</span><strong>��������Ʈ</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="index.jsp">����������</a></li>
						<li><a href="orderList.jsp">�ֹ�������ȸ</a></li>
						<li><a href="calendar.jsp">���Ķ����</a></li>
						<li class="active"><a href="couponList.jsp">��������Ʈ</a></li>
						<li><a href="myqna.jsp">1:1 ���ǳ���</a></li>
						<div class="button small iconBtn light">
							<% if("U".equals(eslMemberCode) ){ %><a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a><% } %>
						</div>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<ul class="listSort">
						<li><a href="/shop/mypage/couponList.jsp"> ��� ������ ����</a></li>
						<li><span class="current">���/����� ����</span></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>������</th>
							<th>�����ڵ�</th>
							<th>��������</th>
							<th>�������</th>
							<th>��ȿ�Ⱓ</th>
							<th class="last">��뿩��</th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							while (rs.next()) {
								orderWeeksTxt       = "";
								orderWeeks          = "";
								couponId			= rs.getInt("ID");
								couponName			= rs.getString("COUPON_NAME");
								couponNum			= rs.getString("COUPON_NUM");
								saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "��";
								salePrice			= rs.getInt("SALE_PRICE");
								useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
								useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
								useDate			= rs.getString("USE_DATE");
								stdate			= rs.getString("STDATE");
								ltdate			= rs.getString("LTDATE");
								useYn			= rs.getString("USE_YN");
								orderWeeks			= rs.getString("ORDERWEEK");

								int goodsId = 0;
								int goodsGubun1 = 0;
								int chk = 0;
							    int devlType = 0;

								if (useLimitCnt > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitCnt) + "�� �̻� ���Ž� ��� ����</p>\n";
								} else {
									useLimitTxt			= "";
								}
								if (useLimitPrice > 0) {
									useLimitTxt			+= "<p>- "+ nf.format(useLimitPrice) + "�� �̻� ���Ž� ��� ����</p>\n";
								} else {
									useLimitTxt			= "";
								}
								useGoods			= rs.getString("USE_GOODS");
								if (useGoods.equals("01")) {
									useGoodsTxt			= "<p>- ��ü ��ǰ�� ��� ����</p>\n";
									orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
									orderWeeksTxt = "<p>- �ֹ��Ⱓ: "+ orderWeeks + "(��) ��밡��</p>\n";
								} else if (useGoods.equals("03")) {
									useGoodsTxt			= "<p>- �Ϲ��ǰ �ֹ��� ��� ����</p>\n";
									orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
									orderWeeksTxt = "<p>- �ֹ��Ⱓ: "+ orderWeeks + "(��) ��밡��</p>\n";
								} else if (useGoods.equals("04")) {
									useGoodsTxt			= "<p>- �ù��ǰ �ֹ��� ��� ����</p>\n";
								} else {
									query1		= "SELECT B.DEVL_GOODS_TYPE, B.ID, B.GUBUN1, A.GROUP_NAME FROM ESL_COUPON_GOODS A, ESL_GOODS_GROUP B WHERE A.GROUP_CODE = B.GROUP_CODE  AND A.COUPON_ID = "+ couponId;
									try {
										rs1 = stmt1.executeQuery(query1);
									} catch(Exception e) {
										out.println(e+"=>"+query1);
										if(true)return;
									}

									while (rs1.next()) {
										useGoodsTxt		+= "<p>- "+ rs1.getString("GROUP_NAME") + " �ֹ��� ��밡��</p>\n";
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
										orderWeeksTxt = "<p>- (�Ϲ�)�ֹ��Ⱓ: "+ orderWeeks + "(��) ��밡��</p>\n";
									}
								}

								if (useYn.equals("Y")) {
									useTxt			= "<p class=\"font-maple\">���</p><p class=\"font-maple\">("+ useDate +")</p>";
								} else {
									useTxt			= "<p class=\"font-maple\">�̻��</p><p class=\"font-maple\">(�Ⱓ ����)</p>";
								}
						%>
						<tr>
							<td><%=couponName%></td>
							<td><%=couponNum%></td>
							<td><%=nf.format(salePrice) + saleType%> ����</td>
							<td style="text-align:left;"><%=useLimitTxt + useGoodsTxt + orderWeeksTxt%></td>
							<td><%=stdate%> ~ <br><%=ltdate%></td>
							<td><%=useTxt%></td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="6">���/����� ������ �����ϴ�.</td>
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
				<div class="one last  col">
					<%@ include file="/common/include/inc-paging.jsp"%>
				</div>
			</div>
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
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>