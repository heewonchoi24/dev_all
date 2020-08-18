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
String cateCode		= "";	//메뉴관리를 넘기기 위해
stmt1				= conn.createStatement();
String devlType		= "";
int queryCount = 0;

query		= "SELECT (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID  ";
query		+= "WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ";
query		+= "ORDER BY ES.ID DESC ";
query		+= " LIMIT 0, 1) AS ATYPE, ";		
query		+= "(SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID  ";
query		+= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ";
query		+= " ORDER BY ES.ID DESC ";
query		+= " LIMIT 0, 1) AS BTYPE, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1,KAL_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DAY_EAT";				
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= " WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";

// 퀴진 헬시 슬림 쿼리 
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
		query		+= " AND ID IN ('43','50','72','46','44','48','107')  ";
		
		cateCode    = "0300965";
	}else{
		queryCount++;
		query		+= " AND ID IN ('43','50','72','46','44','48','107')  ";
		
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
	// 05:추천,06:베스트
	if("05".equals(tg) ||  "06".equals(tg)){
		queryCount++;
		query		+= " AND TAG LIKE '%," + tg + ",%'  ";
		query		+= " ORDER BY TAG_SORT DESC  ";
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
int cartId	  	  = 0;
String tag		  = "";
String dayEat	  = "";
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
	cartId		= rs1.getInt("ID");
	tag			= rs1.getString("TAG");
	dayEat		= ut.isnull(rs1.getString("DAY_EAT") );
	
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
			totalPrice = groupPrice1 - (int)(groupPrice1 * dBtype); // %세일 계산
			System.out.println(totalPrice);
		}else if(aType.equals("W")){
			totalPrice = groupPrice1 - Integer.parseInt(bType);
		}else if(aType == null){
			totalPrice = groupPrice1;
		}
	}
	%>
	<li>
		<div class="img">
			<div class="centered">
				<img src="/data/goods/<%=groupImg%>" alt="" onerror="this.src='/dist/images/order/sample_order_list1.jpg'" />
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
			<div class="summary">
				<%
				if(groupInfo1 == ""){
					%>
					<p class="txt2"></p>
					<%
				}else{
					%>
					<p class="txt2"><%=groupInfo1 %></p>
					<%
				}
				if(kalInfo == 0){
					%>
					<%
				}else{
					%>
					<p class="txt1"><strong>평균 <%=kalInfo %></strong>kcal</p>
					<%
				}
			%>
<%-- 				<div class="buttons"><button type="button" class="btn_gocart" onclick="cartFn.onAdd('img');"><img src="/dist/images/order/btn_gocart.png" alt="" /></button><a href="order_view.jsp?groupName=<%=groupName %>&groupPrice1=<%=groupPrice1%>&groupInfo1=<%=groupInfo1%>&kalInfo=<%=kalInfo%>&totalPrice=<%=totalPrice%>&groupInfo1=<%=groupInfo1%>&cateCode=<%=cateCode%>" class="btn_goview"><img src="/dist/images/order/btn_goview.png" alt="" /></a></div> --%>
					<div class="buttons">
						<a href="/shop/popup/__ajax_goods_set_options.jsp?lightbox[width]=500&lightbox[height]=530&groupName=<%=groupName %>&groupCode=<%=groupCode %>&groupPrice=<%=groupPrice%>&groupPrice1=<%=groupPrice1%>&groupInfo1=<%=groupInfo1%>&kalInfo=<%=kalInfo%>&totalPrice=<%=totalPrice%>&groupInfo1=<%=groupInfo1%>&cateCode=<%=cateCode%>&devlType=<%=devlType%>&cartId=<%=cartId%>&paramType=list" class="btn_gocart lightbox"><img src="/dist/images/order/btn_gocart.png" alt="" /></a>
						<a href="order_view.jsp?cateCode=<%=cateCode%>&cartId=<%=cartId%>&groupCode=<%=groupCode %>&pramType=list" class="btn_goview"><img src="/dist/images/order/btn_goview.png" alt="" /></a>
					</div>
			</div>
		</div>
		<div class="info">
			<p class="title"><%=groupName %></p>
			<p class="desc">
			<%
			if(dayEat.length() > 1){
				out.println("<span class=\"description\">"+dayEat+"</span>");
			}
			%>
				
				<%
				if(groupPrice1 == totalPrice){
					%>
					<span class="price">
						<span><strong><%=ut.getComma(totalPrice)%> 원</strong></span>
					</span>
					<%
				}else{
					%>
					<span class="price">
						<span><del><%=ut.getComma(groupPrice1)%>원</del></span>
						<span><strong><%=ut.getComma(totalPrice)%>원</strong></span>
					</span>
					<%
				}
				%>
				
			</p>
		</div>
	</li>
	
	<%
}
rs1.close();
%>

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
			<span class="delivery_kind dk_daily">일일배송</span>
			<div class="text_info">
				<p class="sub_title">다이어트를 위한 과학적 영양설계</p>
				<p class="title">퀴진</p>
			</div>
			<div class="pay_info">
				<span><del>35,000원</del></span>
				<span><strong>24,000원</strong></span>
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
			<span class="delivery_kind dk_daily">일일배송</span>
			<div class="text_info">
				<p class="sub_title">3kg감량 다이어트 프로그램</p>
				<p class="title">집중감량 2주 프로그램</p>
			</div>
			<div class="pay_info">
				<span><del>35,000원</del></span>
				<span><strong>24,000원</strong></span>
			</div>
		</div>
	</a>
</li> -->