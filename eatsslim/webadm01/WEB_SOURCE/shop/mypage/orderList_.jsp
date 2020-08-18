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
String devlType		= "";
NumberFormat nf		= NumberFormat.getNumberInstance();
SimpleDateFormat dt	= new SimpleDateFormat("yyyyMMdd");
Calendar cal		= Calendar.getInstance();
cal.setTime(new Date()); //����
String cDate		= dt.format(cal.getTime());
Date date1			= dt.parse(cDate);
Date date2			= null;
String devlDate		= "";
int compare			= 0;
long diff			= 0;
long diffDays		= 0;

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

where			= " WHERE MEMBER_ID = '"+ eslMemberId +"' AND (ORDER_STATE < 90 or ORDER_STATE = 911) ";
where			+= "  AND ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')";

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
	param		+= "&amp;state_type="+ stateType;
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
<script type="text/javascript" src="/common/js/common.js"></script>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>����������</h1>
			<div class="pageDepth">
				HOME &gt; ���������� &gt; <strong>�ֹ�/���</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<ul class="tabNavi">
						<li><a href="index.jsp">Ȩ</a></li>
						<li class="active"><a href="orderList.jsp">�ֹ�/���</a></li>
						<li><a href="couponList.jsp">��������</a></li>
						<li><a href="myqna.jsp">1:1 ���ǳ���</a></li>
						<li><a href="calendar.jsp">���Ķ����</a></li>
						<div class="button small iconBtn light">
							<a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> ȸ����������</a>
						</div>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<ul class="listSort">
						<li><span class="current">�ֹ�/�����ȸ</span></li>
						<li><a href="/shop/mypage/reorderList.jsp">���/��ȯ/��ǰ��ȸ</a></li>
						<li><a href="/shop/mypage/delichange.jsp">������ں���</a></li>
					</ul>
					<div class="clear"></div>
				</div>
			</div>
			<form method="get" name="frm_search" action="<%=request.getRequestURI()%>">
				<div class="row">
					<div class="one last col">
						<div class="graytitbox orderSearch">
							<div class="floatleft">
								<h5> �Ⱓ����ȸ </h5>
								<input type="radio" id="radio1" name="radios" value="1" checked="checked" onClick="setDate(1)" />
								<label for="radio1">1����</label>
								<input type="radio" id="radio2" name="radios" value="3" onClick="setDate(3)" />
								<label for="radio2">3����</label>
								<input type="radio" id="radio3" name="radios" value="6" onClick="setDate(6)" />
								<label for="radio3">6����</label>
								<input name="stdate" id="stdate" class="date-pick" value="<%=stdate%>" />
								-
								<input name="ltdate" id="ltdate" class="date-pick" value="<%=ltdate%>" />
								<span class="button dark small"><a href="javascript:;" onClick="document.frm_search.submit();">�˻�</a></span>
							</div>
							<div class="floatright">
								<h5>����</h5>
								<select name="state_type" id="state_type" style="width:90px;" onChange="document.frm_search.submit();">
									<option value="">��ü</option>
									<option value="00"<%if (stateType.equals("00")) out.println(" selected=\"selected\"");%>>�ֹ�����</option>
									<option value="01"<%if (stateType.equals("01")) out.println(" selected=\"selected\"");%>>�����Ϸ�</option>
									<option value="02"<%if (stateType.equals("02")) out.println(" selected=\"selected\"");%>>��ǰ�غ���</option>
									<option value="03"<%if (stateType.equals("03")) out.println(" selected=\"selected\"");%>>�����</option>
									<option value="04"<%if (stateType.equals("04")) out.println(" selected=\"selected\"");%>>��ۿϷ�</option>
									<option value="05"<%if (stateType.equals("05")) out.println(" selected=\"selected\"");%>>�ֹ��Ϸ�</option>
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
							<th>����ݾ�</th>
							<th>�����ݾ�</th>
							<th>�ֹ�����</th>
							<th class="last">�ֹ�����</th>
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
								query1		+= "		DEVL_DAY, DEVL_WEEK, DEVL_PRICE, DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, OG.ID";
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
								String gid			= "";
								
								int price			= 0;
								int i				= 0;
								while (rs1.next()) {
																	gid = rs1.getString("ID");

									devlType		= rs1.getString("DEVL_TYPE");
									devlDiv			+= "<div class=\"shipping font-blue\">"+ ut.getDevlType(devlType) +"</div>";
									goodsDiv		+= ut.getGubun1Name(rs1.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs1.getString("GUBUN2")) +": "+ rs1.getString("GROUP_NAME") + ")</p>";
									cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
									devlDay			= rs1.getString("DEVL_DAY");
									devlWeek		= rs1.getString("DEVL_WEEK");
									price			= (devlType.equals("0001"))? rs1.getInt("PRICE") : rs1.getInt("PRICE") + rs1.getInt("DEVL_PRICE");
									priceDiv		+= "<div>"+ nf.format(price) +"��</div>";
									if (rs1.getString("BUY_BAG_YN").equals("Y")) {
										devlDiv			+= "<div class=\"shipping font-blue\">�Ϲ�</div>";
										goodsDiv		+= "���ð���<p class=\"option\"></p>";
										cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
										priceDiv		+= "<div>"+ nf.format(defaultBagPrice) +"��</div>";
									}
									if (rs1.getString("GUBUN1").equals("01") && Integer.parseInt(orderDate.replace(".", "")) < 20131031) {
										devlDiv			+= "<div class=\"shipping font-blue\">����</div>";
										goodsDiv		+= "����ũ�ͽ�(2��)<p class=\"option\"></p>";
										cntDiv			+= "<div>"+ rs1.getInt("ORDER_CNT") +"</div>";
										priceDiv		+= "<div>0��</div>";
									}

									if (devlType.equals("0002")) {
										i++;
									}
								}
								rs1.close();

								if (Integer.parseInt(orderState) > 0) {
									query1	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
								} else {
									query1	= "SELECT MIN(DATE_FORMAT(DEVL_DATE, '%Y%m%d')) DEVL_DATE FROM ESL_ORDER_GOODS WHERE ORDER_NUM = '"+ orderNum +"'";
								}
								if (i > 0) {
									query1		+= " AND DEVL_TYPE = '0002'";
								}
								try {
									rs1	= stmt1.executeQuery(query1);
								} catch(Exception e) {
									out.println(e+"=>"+query1);
									if(true)return;
								}

								if (rs1.next()) {
									try{
										devlDate	= rs1.getString("DEVL_DATE");
										date2		= dt.parse(devlDate);
									 
										diff		= date2.getTime() - date1.getTime();
										diffDays	= diff / (24 * 60 * 60 * 1000);
									}
									catch(Exception e){
										
									}

									//out.println(date1 +":"+ date2 +":"+ diffDays);
								}

								rs1.close();
						%>
						<tr>
							<td>
								<%=orderDate%>
								<a class="orderNum" href="/shop/mypage/orderInfo.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>"><%=orderNum%></a>
							</td>
							<td><%=devlDiv%></td>
							<td>
								<div class="orderName">
									<a href="/shop/mypage/orderInfo.jsp?ono=<%=orderNum + param%>&odate=<%=orderDate%>"><%=goodsDiv%></a>
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
							<%
							if (Integer.parseInt(orderState) < 2 || Integer.parseInt(orderState) == 911) {
							%>
							<td>
							<%
								if (i > 0) {
									if (diffDays > 1) {
							%>
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/deliveryEdit.jsp?lightbox[width]=700&lightbox[height]=550&ono=<%=orderNum%>&odate=<%=orderDate%>">���������</a>
								</div>
							<%
										if (Integer.parseInt(orderState) == 1) {
							%>
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/orderCancel.jsp?lightbox[width]=800&lightbox[height]=550&ono=<%=orderNum%>&odate=<%=orderDate%>">�ֹ����</a>
								</div>
							<%
										}
									}
								} else {
									if (diffDays > 2) {
							%>
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/deliveryEdit.jsp?lightbox[width]=700&lightbox[height]=550&ono=<%=orderNum%>&odate=<%=orderDate%>">���������</a>
								</div>
							<%
										if (Integer.parseInt(orderState) == 1) {
							%>								
								<div class="button light small">
									<a class="lightbox" href="/shop/popup/orderCancel.jsp?lightbox[width]=800&lightbox[height]=550&ono=<%=orderNum%>&odate=<%=orderDate%>">�ֹ����</a>
								</div>
							<%
										}
									}
									
									if (Integer.parseInt(orderState) == 1 || Integer.parseInt(orderState) == 911) {
							%>
								<div class="button light small">
									<a href="/shop/mypage/delichange.jsp?ono=<%=orderNum%>&pdate=<%=orderDate.replace(".", "-")%>&gid=<%=gid%>">������ں���</a>
								</div>							
							<% } 
								}
							%>
							</td>
							<%
							}
							%>
						
						</tr>
						<%
							}
						} else {
						%>
						<tr>
							<td colspan="8">�ֹ������� �����ϴ�.</td>
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


<script type="text/javascript">  
$(document).ready(function() {
	Date.format	= 'yyyy.mm.dd';
	$('.date-pick').datePicker({
		startDate: '2013.09.01',
		clickInput:true
	});

	setDate(1); //�Ⱓ����ȸ�� 1������ ����
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