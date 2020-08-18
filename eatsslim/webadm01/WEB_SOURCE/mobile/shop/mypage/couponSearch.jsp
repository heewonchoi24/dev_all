<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-login-check.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
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

where			= " WHERE C.ID = CM.COUPON_ID AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N' AND C.LTDATE >= DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i')";

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
query		+= "	DATE_FORMAT(C.INST_DATE, '%Y.%m.%d') INST_DATE, C.STDATE AS STDATE, C.LTDATE AS LTDATE, ";
query		+= "	C.ORDERWEEK ";
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

	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->

	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">������ȸ/���</span></span></h1>

		<div id="couponSearch">
			<div class="topBox">
				<p>�������� ������ �߱޹����� ���� <br/>�̰����� ������ ����� ���� ����ϼ���.</p>
				<div class="ipt_group">
			    	<input type="text" name="off_coupon_num" id="off_coupon_num" class="ipt" maxlength="20" />
			    </div>
			    <button type="button" class="btn btn_gray square" onclick="setCoupon();">���� ����ϱ�</button>
			</div>
			<div class="listArea">
				<div class="title">��밡���� ���� <span><%=intTotalCnt%></span></div>
				<ul class="couponList">
					<!-- <li>
						<div class="titleHead">
							<span class="couponImg">20%</span>�ϰ� 20% Ư������
						</div>
						<div class="info">
							<p><span>��ȿ�Ⱓ:</span> 2017.06.13 ~ 2017.06.30</p>
							<p><span>�����ڵ�:</span> ET170613143924001</p>
							<p><span>�߱޳�¥:</span> 2017. 06. 13</p>
							<p class="use">20,000�� �̻� ���Ž� ��� ����</p>
							<p class="use">��ü��ǰ�� ��� ����</p>
						</div>
					</li>
					<li>
						<div class="titleHead">
							<span class="couponImg">5000��</span>�ϰ� 20% Ư������
						</div>
						<div class="info">
							<p><span>��ȿ�Ⱓ:</span> 2017.06.13 ~ 2017.06.30</p>
							<p><span>�����ڵ�:</span> ET170613143924001</p>
							<p><span>�߱޳�¥:</span> 2017. 06. 13</p>
							<p class="use">20,000�� �̻� ���Ž� ��� ����</p>
							<p class="use">��ü��ǰ�� ��� ����</p>
						</div>
					</li> -->

<%
if (intTotalCnt > 0) {
	while (rs.next()) {
		useLimitTxt			= "";
		useGoodsTxt			= "";
		orderWeeksTxt       = "";
		orderWeeks          = "";

		int goodsId = 0;
		int goodsGubun1 = 0;
		int chk = 0;

		couponId			= rs.getInt("ID");
		couponName			= rs.getString("COUPON_NAME");
		couponNum			= rs.getString("COUPON_NUM");
		saleType			= (rs.getString("SALE_TYPE").equals("P"))? "%" : "��";
		salePrice			= rs.getInt("SALE_PRICE");
		useLimitCnt			= rs.getInt("USE_LIMIT_CNT");
		useLimitPrice		= rs.getInt("USE_LIMIT_PRICE");
		instDate			= rs.getString("INST_DATE");
		stdate				= rs.getString("STDATE");
		ltdate				= rs.getString("LTDATE");
		orderWeeks			= rs.getString("ORDERWEEK");

			if (useLimitCnt > 0) {
				useLimitTxt			+= "<p class='use'>"+ nf.format(useLimitCnt) + "�� �̻� ���Ž� ��� ����</p>\n";
			} else {
				useLimitTxt			= "";
			}
			if (useLimitPrice > 0) {
				useLimitTxt			+= "<p class='use'>"+ nf.format(useLimitPrice) + "�� �̻� ���Ž� ��� ����</p>\n";
			} else {
				useLimitTxt			= "";
			}
			useGoods			= rs.getString("USE_GOODS");
			if (useGoods.equals("01")) {
				useGoodsTxt			= "<p class='use'>��ü ��ǰ�� ��� ����</p>\n";
				orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
				orderWeeksTxt = orderWeeks + "(��) ��밡��\n";				
			} else if (useGoods.equals("03")) {
				useGoodsTxt			= "<p class='use'>�Ϲ��ǰ �ֹ��� ��� ����</p>\n";
				orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
				orderWeeksTxt = orderWeeks + "(��) ��밡��\n";		
			} else if (useGoods.equals("04")) {
				useGoodsTxt			= "<p class='use'>�ù��ǰ �ֹ��� ��� ����</p>\n";
			} else {
				query1		= "SELECT B.ID, B.GUBUN1, A.GROUP_NAME FROM ESL_COUPON_GOODS A, ESL_GOODS_GROUP B WHERE A.GROUP_CODE = B.GROUP_CODE  AND A.COUPON_ID = "+ couponId;
				try {
					rs1 = stmt1.executeQuery(query1);
				} catch(Exception e) {
					out.println(e+"=>"+query1);
					if(true)return;
				}

				while (rs1.next()) {
					useGoodsTxt		+= "<p class='use'> "+ rs1.getString("GROUP_NAME") + " �ֹ��� ��밡��</p>\n";
					goodsId = rs1.getInt("ID");
					goodsGubun1 = rs1.getInt("GUBUN1");

					if(goodsId == 15 || goodsId == 31 || goodsId == 118 || goodsId == 119 || goodsGubun1 == 50 || goodsGubun1 == 60 ){
					}else{
						chk = 1;
					}

				}

				if(chk == 1){
				orderWeeks = orderWeeks.substring(0,orderWeeks.length() -1);
				orderWeeksTxt = "�Ϲ��ǰ >> " + orderWeeks + "(��) ��밡��\n";		
				}
										
			}

%>
					<li>
						<div class="titleHead">
							<span class="couponImg"><%=nf.format(salePrice) + saleType%></span><%=couponName%>
						</div>
						<div class="info">
							<p><span>��ȿ�Ⱓ:</span> <%=stdate%> ~ <%=ltdate%></p>
							<p><span>�����ڵ�:</span> <%=couponNum%></p>
							<p><span>�߱޳�¥:</span> <%=instDate%></p>
							<p><span>�ֹ��Ⱓ:</span> <%=orderWeeksTxt%></p>
							<%=useLimitTxt + useGoodsTxt%>
						</div>
					</li>
<%
	}
} else {
%>
					<li class="none">
						��� ������ ������ �����ϴ�.
					</li>
<%
}
%>
				</ul>
			</div>
			<div class="guide">
				�ٿ���� ������ <span>�ֹ�/���� > ��������</span> ȭ�鿡�� �����Ͻ� �����׸��� �����Ͻø� ����� �����մϴ�.
			</div>
		</div>
	</div>
	<!-- End Content -->

	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
<script type="text/javascript">
function setCoupon() {
	$.post("/shop/order_ajax.jsp", {
		mode: "setCoupon",
		couponNum: $("#off_coupon_num").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("��ϵǾ����ϴ�.");
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
</body>
</html>