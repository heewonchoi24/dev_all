<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
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

	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<!-- End ui-header -->
	
	<!-- Start Content -->
	<div id="content">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">������ȸ/���</span></span></h1>
		
		<table class="form-line" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="70"><label>�������</label></td>
				<td style="padding-right:20px;"><input type="text" name="off_coupon_num" id="off_coupon_num" style="width:100%;" maxlength="20" /></td>
				<td width="40"><button class="ui-btn ui-mini ui-btn-up-b" onclick="setCoupon();" value="���"><span class="ui-btn-inner"><span class="ui-btn-text">���</span></span></button></td>
			</tr>
		</table>
		
		<p class="guide">*�������� ������ �߱޹����� ���� �̰����� ������ ����� ���� ����ϼ���.</p>
		<div class="divider"></div>
		<h2 class="ui-title">��밡�� ���� <%=intTotalCnt%>��<span class="ui-icon-right"></span></h2>
		<ul class="itemlist">


<%
if (intTotalCnt > 0) {
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
		} else if (useGoods.equals("03")) {
			useGoodsTxt			= "<p>- �Ϲ��ǰ �ֹ��� ��� ����</p>\n";
		} else if (useGoods.equals("03")) {
			useGoodsTxt			= "<p>- �ù��ǰ �ֹ��� ��� ����</p>\n";
		} else {
			query1		= "SELECT GROUP_NAME FROM ESL_COUPON_GOODS WHERE COUPON_ID = "+ couponId;
			try {
				rs1 = stmt1.executeQuery(query1);
			} catch(Exception e) {
				out.println(e+"=>"+query1);
				if(true)return;
			}

			while (rs1.next()) {
				useGoodsTxt		+= "<p>- "+ rs1.getString("GROUP_NAME") + " �ֹ��� ��� ����</p>\n";
			}
		}
		instDate			= rs.getString("INST_DATE");
		stdate				= rs.getString("STDATE");
		ltdate				= rs.getString("LTDATE");
%>

			<li class="couponli">
				<div class="couponImage sale">
                    <div class="couponInfo">
                        <p><%=nf.format(salePrice) + saleType%></p>����
                    </div>
                </div>
				<p class="title"><%=couponName%></p>
				<p><%=useLimitTxt + useGoodsTxt%></p>
				<p>��ȿ�Ⱓ:<%=stdate%>~<%=ltdate%></p>
                <p>�����ڵ�:<%=couponNum%></p>
                <p>�߱޳�¥:<%=instDate%></p>
			</li>

<%
	}
} else {
%>	

			<li class="noitem">��밡���� ������ �����ϴ�.</li>
<%
}
%>

		</ul>
		<p class="guide">* �ٿ���� ������ �ֹ�/���� > �������� ȭ�鿡�� �����Ͻ� �����׸��� �����Ͻø� ����� �����մϴ�.</p>
		<div class="divider"></div>
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