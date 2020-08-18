<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "ESL_ORDER";
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
int payPrice		= 0;
String payType		= "";
String orderState	= "";
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

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND ORDER_STATE > 90";

if (request.getParameter("page") != null && request.getParameter("page").length()>0){
	iPage		= Integer.parseInt(request.getParameter("page"));
	startpage	= ((int)(iPage-1) / pagelist) * pagelist + 1;
}else{
	iPage		= 1;
	startpage	= 1;
}
if (request.getParameter("pgsize") != null && request.getParameter("pgsize").length()>0)
	pgsize		= Integer.parseInt(request.getParameter("pgsize"));

if (stdate != null && stdate.length() > 0 && ltdate != null && ltdate.length() > 0) {
	param		+= "&amp;stdate="+ stdate +"&amp;ltdate="+ ltdate;
	where		+= " AND DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') BETWEEN '"+ stdate +"' AND '"+ ltdate +"'";
}

if (stateType != null && stateType.length() > 0) {
	param		+= "&amp;state_type="+ stateType +"&amp;ltdate="+ ltdate;
	where		+= " AND ORDER_STATE = '"+ stateType +"'";
}

query		= "SELECT COUNT(ID) FROM "+ table + where; //out.print(query); if(true)return;
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

query		= "SELECT ORDER_NUM, DATE_FORMAT(ORDER_DATE, '%Y.%m.%d') ORDER_DATE, ORDER_NAME, PAY_TYPE, PAY_PRICE,";
query		+= "	ORDER_STATE, ORDER_ENV";
query		+= " FROM "+ table + where;
query		+= " ORDER BY ORDER_NUM DESC";
query		+= " LIMIT "+String.valueOf((iPage-1) * pgsize)+", "+String.valueOf(pgsize); //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
///////////////////////////
%>

	<script type="text/javascript" src="/common/js/date.js"></script>
	<script type="text/javascript" src="/common/js/jquery.datePicker.js"></script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1> �ֹ���� ��ȸ </h1>
			<div class="pageDepth">
				HOME > My Eatsslim > <strong>�ֹ�/���</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li> <a href="index.jsp">Ȩ</a> </li>
						<li class="active"> <a href="orderList.jsp">�ֹ�/���</a> </li>
						<li> <a href="couponList.jsp">��������</a> </li>
						<li> <a href="myqna.jsp">1:1 ���ǳ���</a> </li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a>
						</div>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<ul class="listSort">
						<li> <a href="/shop/mypage/orderList.jsp">�ֹ�/�����ȸ</a> </li>
						<li> <span class="current"> ���/��ȯ/��ǰ��ȸ </span> </li>
						<li> <a href="/shop/mypage/delichange.jsp">������ں���</a> </li>
					</ul>
					<div class="clear">
					</div>
				</div>
			</div>
			<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
				<div class="row">
					<div class="one last col">
						<div class="graytitbox orderSearch">
							<div class="floatleft">
								<h5> �Ⱓ����ȸ </h5>
								<input type="radio" id="radio1" name="radios" value="all" checked="checked" onclick="setDate(1)">
								<label for="radio1">1����</label>
								<input type="radio" id="radio2" name="radios" value="false" onclick="setDate(3)">
								<label for="radio2">3����</label>
								<input type="radio" id="radio3" name="radios" value="true" onclick="setDate(6)">
								<label for="radio3">6����</label>
								<input name="stdate" id="stdate" class="date-pick" value="<%=stdate%>" />
								-
								<input name="ltdate" id="ltdate" class="date-pick" value="<%=ltdate%>" />
								<span class="button dark small"><a href="javascript:;" onclick="document.frm_search.submit();">�˻�</a></span>
							</div>
							<div class="floatright">
								<h5>����</h5>
								<select name="state_type" id="state_type" style="width:90px;" onchange="document.frm_search.submit();">
									<option value="">��ü</option>
									<option value="91"<%if (stateType.equals("91")) out.println(" selected=\"selected\"");%>>��ҿϷ�</option>
									<option value="92"<%if (stateType.equals("1")) out.println(" selected=\"selected\"");%>>��ȯ��û</option>
									<option value="921"<%if (stateType.equals("2")) out.println(" selected=\"selected\"");%>>��ȯó����</option>
									<option value="922"<%if (stateType.equals("3")) out.println(" selected=\"selected\"");%>>��ȯ�Ϸ�</option>
									<option value="923"<%if (stateType.equals("4")) out.println(" selected=\"selected\"");%>>��ȯ�Ұ�</option>
									<option value="93"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>��ǰ��û</option>
									<option value="931"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>��ǰó����</option>
									<option value="932"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>��ǰ�Ϸ�</option>
									<option value="933"<%if (stateType.equals("5")) out.println(" selected=\"selected\"");%>>��ǰ�Ұ�</option>
								</select>
							</div>
							<div class="clear"></div>
						</div>
					</div>
				</div>
			</form>
			<div class="row">
				<div class="one last col">
					<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>�ֹ�����/�ֹ���ȣ</th>
							<th class="none">��۱���</th>
							<th>��ǰ��</th>
							<th class="none">����</th>
							<th>��������</th>
							<th>�����ݾ�</th>
							<th>ó������</th>
							<th class="last">���/��ȯ/��ǰ</th>
						</tr>
						<%
						if (intTotalCnt > 0) {
							while (rs.next()) {
								orderNum	= rs.getString("ORDER_NUM");
								orderDate	= (rs.getString("ORDER_DATE") == null)? "" : rs.getString("ORDER_DATE");
								payPrice	= rs.getInt("PAY_PRICE");
								orderState	= rs.getString("ORDER_STATE");
								payType		= rs.getString("PAY_TYPE");

								query1		= "SELECT ";
								query1		+= "		GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,";
								query1		+= "		DEVL_DAY, DEVL_WEEK, DEVL_PRICE";
								query1		+= " FROM ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O";
								query1		+= " WHERE G.ID = OG.GROUP_ID";
								query1		+= " AND OG.ORDER_NUM = O.ORDER_NUM";
								query1		+= " AND O.MEMBER_ID = '"+ eslMemberId +"' AND OG.ORDER_NUM = '"+ orderNum +"'";
								query1		+= " ORDER BY O.ID DESC";
								try {
									rs1 = stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								String devlDiv		= "";
								String goodsDiv		= "";
								String cntDiv		= "";
								String priceDiv		= "";
								String devlDay		= "";
								String devlWeek		= "";
								int price			= 0;
								while (rs1.next()) {
									devlDiv			+= "<div class=\"shipping font-blue\">"+ ut.getDevlType(rs1.getString("DEVL_TYPE")) +"</div>";
									goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
									cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
									devlDay			= rs1.getString("DEVL_DAY");
									devlWeek		= rs1.getString("DEVL_WEEK");
									price			= (rs1.getString("DEVL_TYPE").equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
									priceDiv		+= "<div>"+ nf.format(price) +"��</div>";
									if (rs1.getString("BUY_BAG_YN").equals("Y")) {
										devlDiv			+= "<div class=\"shipping font-blue\">�Ϲ�</div>";
										goodsDiv		+= "���ð���<p class=\"option\"></p>";
										cntDiv			+= "<div>1</div>";
										priceDiv		+= "<div>"+ nf.format(defaultBagPrice) +"��</div>";
									}
								}
						%>
						<tr>
							<td>
								<%=orderDate%><br />
								<span class="orderNum"><%=orderNum%></span>
							</td>
							<td><%=devlDiv%></td>
							<td>
								<div class="orderName">
									<a href="javascript:;"><%=goodsDiv%></a>
								</div>
							</td>
							<td><%=cntDiv%></td>
							<td><%=priceDiv%></td>
							<td><div><%=nf.format(payPrice)%>��</div></td>
							<td>
								<div class="font-maple">
									<%=ut.getOrderState(orderState)%>
								</div>
							</td>
							<td>
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/cancelResult.jsp?lightbox[width]=700&lightbox[height]=550&ono=<%=orderNum%>">�ڼ�������</a>
								</div>
							</td>
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="8">���/��ȯ/��ǰ������ �����ϴ�.</td>
						</tr>
						<%
						}
						%>
						<!--
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-blue">
									�Ϲ�
								</div></td>
							<td><div class="orderName">
									<a href="#">���̾�Ʈ�Ļ� 3��
									<p class="option"> (����A+����B) </p>
									</a>
								</div></td>
							<td><div>
									1
								</div></td>
							<td>�ǽð� ������ü</td>
							<td><div>
									104,400��
								</div></td>
							<td><div class="font-maple">
									��ȯ��û
								</div></td>
							<td><div class="button light small">
									<a href="#">��ȯöȸ</a>
								</div></td>
						</tr>
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-blue">
									�Ϲ�
								</div></td>
							<td><div class="orderName">
									<a href="#">Full-Step���α׷�
									<p class="option"> 4�� </p>
									</a><a href="#">���ð���</a>
								</div></td>
							<td><div>
									1
								</div>
								<div>
									-
								</div></td>
							<td>�������</td>
							<td><div>
									94,400��
								</div>
								<div>
									<%=nf.format(defaultBagPrice)%>��
								</div></td>
							<td><div class="font-maple">
									��ǰ��û(1��)
								</div></td>
							<td><div class="button light small">
									<a href="#">��ǰöȸ</a>
								</div></td>
						</tr>
						<tr>
							<td>2013.08.01<a class="orderNum" href="#">A2013080138441</a></td>
							<td><div class="shipping font-green">
									�ù�
								</div></td>
							<td><div class="orderName">
									<a href="#"> ��Ƽ����Ƽ(BOX) </a>
								</div></td>
							<td><div>
									1
								</div></td>
							<td>�ſ�ī��</td>
							<td><div>
									84,400��
								</div></td>
							<td><div class="font-maple">
									��ǰ�Ϸ�
								</div></td>
							<td><div class="button light small">
									<a href="#">�ڼ�������</a>
								</div></td>
						</tr>
						<tr>
							<td colspan="8">�ֹ������� �����ϴ�.</td>
						</tr>
						-->
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
<script type="text/javascript">  
$(document).ready(function() {
	Date.format	= 'yyyy.mm.dd';
	$('.date-pick').datePicker({
		startDate: '2013.09.01',
		clickInput:true
	});
});

function setDate(val) {
	var settingDate = new Date();

	$("#ltdate").val(settingDate.asString()); //���ó�¥

	settingDate.setMonth(settingDate.getMonth()-val); // ?���� ��
	$("#stdate").val(settingDate.asString());

}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>