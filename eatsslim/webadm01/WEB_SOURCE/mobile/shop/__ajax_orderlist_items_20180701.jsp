<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ include file="/lib/config.jsp"%>
<%
String menuF		= ut.inject(request.getParameter("menuF"));
String menuS		= ut.inject(request.getParameter("menuS"));
String eatCoun      = ut.inject(request.getParameter("eatCoun"));
String tg			= ut.inject(request.getParameter("tg"));
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String path			= webUploadDir;
String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
String cateCode		= "";	//�޴������� �ѱ�� ����
stmt1				= conn.createStatement();
String devlType		= "";
int queryCount = 0;

query		= "SELECT ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";		
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE,";
query		+= " GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1,KAL_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DAY_EAT";				
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= " WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";

// ���� ��� ���� ���� 
if(menuF.equals("1") && menuS.equals("1")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('32','40','69','36','44','48','106')";
		
		cateCode    = "0300700";
	}else{
		queryCount++;
		query		+= " AND ID IN ('32','40','69','36','44','48','106')";
		
		cateCode    = "0300700";
	}
}else if(menuF.equals("1") && menuS.equals("2")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('34','42','71','46','36','48','108','120')  ";
		
		cateCode    = "0300702";
	}else{
		queryCount++;
		query		+= " AND ID IN ('34','42','71','46','36','48','108','120')  ";
		
		cateCode    = "0300702";
	}
	
}else if(menuF.equals("1") && menuS.equals("3")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('43','50','72','46','43','48','107')  ";
		
		cateCode    = "0300965";
	}else{
		queryCount++;
		query		+= " AND ID IN ('43','50','72','46','43','48','107')  ";
		
		cateCode    = "0300965";
	}
	
}else if(menuF.equals("1") && menuS.equals("4")){
	queryCount++;
	query		+= " AND GUBUN1= '01'  ";
	query		+= " AND ID IN ( '69', '71', '72', '110' ) ";
	
	cateCode    = "0";
}else if(menuF.equals("1") && menuS.equals("5")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('105','106','107','108','109','121')  ";
		
		cateCode    = "0";
	}else{
		queryCount++;
		query		+= " AND ID IN ('105','106','107','108','109','121')  ";
		
		cateCode    = "0";
	}
}else if(menuF.equals("2") && menuS.equals("1")){
	queryCount++;
	query		+= " AND ID IN ('73','54')";
	
	cateCode    = "0";
}else if(menuF.equals("2") && menuS.equals("2")){
	queryCount++;
	query		+= " AND GUBUN1= '02'  ";
	query		+= " AND ID IN ('65','51','88')  ";
	
	cateCode    = "0";
}else if(menuF.equals("2") && menuS.equals("3")){
	queryCount++;
	query		+= " AND GUBUN1= '02'  ";
	query		+= " AND ID IN ('82','83','84')  ";
	
	cateCode    = "0";
}else if(menuF.equals("2") && menuS.equals("4")){
	queryCount++;
	query		+= " AND GUBUN1= '02'  ";
	query		+= " AND ID IN ('85','86','87')  ";
	cateCode    = "0";
}else if(menuF.equals("3") && menuS.equals("1")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND GUBUN1= '01'  ";
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('89','92','90','91')  ";
		
		cateCode    = "0301369";
	}else{
		queryCount++;
		query		+= " AND GUBUN1= '01'  ";
		query		+= " AND ID IN ('89','92','90','91')  ";
		cateCode    = "0301369";
	}
	
}else if(menuF.equals("4") && menuS.equals("1")){
	queryCount++;
	query		+= " AND ID IN ('15','31', '118', '119')  ";
	cateCode    = "0";
}else if(menuF.equals("4") && menuS.equals("2")){
	queryCount++;
	query		+= " AND GUBUN1 = '50'  ";
	cateCode    = "0";
}else if(menuF.equals("4") && menuS.equals("3")){
	queryCount++;
	query		+= " AND GUBUN1 = '60'  ";
	cateCode    = "0";
}
else if(!"".equals(tg)){
	// 05:��õ,06:����Ʈ
	if("05".equals(tg) ||  "06".equals(tg)){
		queryCount++;
		query		+= " AND TAG LIKE '%," + tg + ",%'  ";
		query		+= " ORDER BY TAG_SORT ASC  ";
		cateCode    = "0";
	}	
}

if(queryCount == 0){	
	return;
}

try {
	rs1 = stmt1.executeQuery(query);
} catch(Exception e) {
	System.out.println(e+"=>"+query);
	if(true)return;
}
String groupName  = "";
String groupInfo1 = "";
String aType 	  = "";
String bType 	  = "";
int kalInfo		  = 0;
int groupPrice1   = 0;
int totalPrice	  = 0;
int bTypeNum	  = 0;
String cartImg	  = "";
String groupImg	  = "";
String groupCode  = "";
String gubun2	  = "";
String sikdan	  = "";
String dayEat	  = "";
int cartId	  	  = 0;
String tag		  = "";
double dBtype;
int groupPrice    = 0;
while(rs1.next()){
	aType		= rs1.getString("ATYPE");
	bType		= rs1.getString("BTYPE");
	groupCode	= rs1.getString("GROUP_CODE");
	groupName   = rs1.getString("GROUP_NAME");
	groupPrice  = rs1.getInt("GROUP_PRICE");
	groupPrice1  = rs1.getInt("GROUP_PRICE1");
	groupInfo1  = rs1.getString("GROUP_INFO1");
	kalInfo 	= rs1.getInt("KAL_INFO");
	cartImg		= rs1.getString("CART_IMG");
	groupImg	= rs1.getString("GROUP_IMGM");
	gubun2		= rs1.getString("GUBUN2");
	//sikdan		= gubun2.substring(1);
	dayEat		= ut.isnull(rs1.getString("DAY_EAT") );
	cartId		= rs1.getInt("ID");
	tag			= rs1.getString("TAG");
	
	if(cartId == 52 || cartId == 54 || cartId == 15 || cartId == 75 || cartId == 76 || cartId == 77 || cartId == 79 || cartId == 80 || cartId == 81 || cartId == 102 || cartId == 103 || cartId == 93 || cartId == 94 || cartId == 95 || cartId == 96 || cartId == 97 || cartId == 104 || cartId == 95){
		devlType = "0002";
	}else{
		devlType = "0001";
	}
	if(groupInfo1 == null){
		groupInfo1 = "";
	}
	
	if(groupInfo1 == null){
		groupInfo1 = "";
	}
	
	if(bType == null){
		/* bTypeNum = Integer.parseInt(bType);
		bTypeNum = 0; */
		totalPrice = groupPrice1;
	}else{
		if(aType.equals("P")){
			dBtype = Integer.parseInt(bType)/100.0;
			totalPrice = groupPrice1 - (int)(groupPrice1 * dBtype); // %���� ���
			System.out.println(totalPrice);
		}else if(aType.equals("W")){
			totalPrice = groupPrice1 - Integer.parseInt(bType);
		}else if(aType == null){
			totalPrice = groupPrice1;
		}
	}
	%>
	<li>
	<a href="order_view.jsp?cateCode=<%=cateCode%>&cartId=<%=cartId%>&paramType=list">
		<div class="img">
			<div class="centered">
				<img src="/data/goods/<%=groupImg%>" onerror="this.src='/mobile/common/images/orderview_sample.jpg'" alt="">
			</div>
			<div class="badge"> 
			<%
				if(tag.indexOf("01") != -1){
					%>
					<span class="b_event"></span>
					<%
				}
				if(tag.indexOf("02") != -1){
					%>
					<span class="b_special"></span>
					<%
				}
				if(tag.indexOf("03") != -1){
					%>
					<span class="b_sale"></span>
					<%
				}
				if(tag.indexOf("04") != -1){
					%>
					<span class="b_new"></span>
					<%
				}
				if(tag.indexOf("05") != -1){
					%>
					<span class="b_rcmd"></span>
					<%
				}
				if(tag.indexOf("06") != -1){
					%>
					<span class="b_best"></span>
					<%
				}		
			%>
			</div>
			<button type="button" class="minimal_cart" onclick="window.calendarPop = new CalendarPopFn({url:'/mobile/shop/order/__ajax_goods_set_options.jsp?groupId=<%=cartId%>'});return false;"><img src="/mobile/common/images/order/ico_cart_s.png" alt="" /></button>
			<%
				if (groupPrice1 != totalPrice) {
			%>
					<!-- <div class="badge bd_sale">
						<div class="badge_article">SALE</div>
					</div> -->
			<%
				} 
			%>
		</div>		
		<div class="info">
			<p class="title"><%=groupName %></p>
			<p class="desc">
				<span class="price">
				<%
					if(groupPrice1 == totalPrice){
						%>
						<span><strong><%=ut.getComma(totalPrice)%>��</strong></span>
						<%
					}else{
						%>
						<span><strong><%=ut.getComma(totalPrice)%>��</strong></span>
						<span><del><%=ut.getComma(groupPrice1)%>��</del></span>
						<%
					}
				
				%>
				</span>
			<%
			if(dayEat.length() > 1){
				out.println("<span class=\"description\">"+dayEat+"</span>");
			}
			%>
			</p>
		</div>
	</a>
</li>
	
	
	<%
}
rs1.close();
%>
<link rel="stylesheet" type="text/css" media="all" href="/mobile/common/css/expansion.css">
<!-- <li>
	<a href="order_view.jsp">
		<div class="img">
			<img src="/mobile/common/images/orderlist_sample2.jpg" alt="">
			<div class="badge bd_mdpick">
				<div class="badge_article">
					<span>MD'</span><small>s</small><br>PICK
				</div>
			</div>
		</div>
		<div class="info">
			<span class="delivery_kind dk_daily">���Ϲ��</span>
			<div class="text_info">
				<p class="sub_title">���̾�Ʈ�� ���� ������ ���缳��</p>
				<p class="title">����</p>
			</div>
			<div class="pay_info">
				<span><del>35,000��</del></span>
				<span><strong>24,000��</strong></span>
			</div>
		</div>
	</a>
</li>
<li>
	<a href="order_view.jsp">
		<div class="img">
			<img src="/mobile/common/images/orderlist_sample3.jpg" alt="">									
		</div>
		<div class="info">
			<span class="delivery_kind dk_daily">���Ϲ��</span>
			<div class="text_info">
				<p class="sub_title">3kg���� ���̾�Ʈ ���α׷�</p>
				<p class="title">���߰��� 2�� ���α׷�</p>
			</div>
			<div class="pay_info">
				<span><del>35,000��</del></span>
				<span><strong>24,000��</strong></span>
			</div>
		</div>
	</a>
</li> -->