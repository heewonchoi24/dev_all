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

String devlGoodsType = "";
String gubun1         = "";
String devlWeek3     = "";
String devlWeek5     = "";

query		= "SELECT ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";		
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE,";
query		+= " GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1,KAL_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DAY_EAT, GUBUN1, DEVL_GOODS_TYPE, DEVL_WEEK3, DEVL_WEEK5";				
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= " WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";

// 퀴진 헬시 슬림 쿼리 
if(menuF.equals("1") && menuS.equals("1")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('32','40','69','36','44','48','106','124')";
		
		cateCode    = "0300700";
	}else{
		queryCount++;
		query		+= " AND ID IN ('32','40','69','36','44','48','106','124')";
		
		cateCode    = "0300700";
	}
}else if(menuF.equals("1") && menuS.equals("2")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('34','42','71','46','36','48','108','120','125')  ";
		
		cateCode    = "0300702";
	}else{
		queryCount++;
		query		+= " AND ID IN ('34','42','71','46','36','48','108','120','125')  ";
		
		cateCode    = "0300702";
	}
	
}else if(menuF.equals("1") && menuS.equals("3")){
	if(!eatCoun.equals("")){
		queryCount++;
		query		+= " AND SUBSTR(gubun2,2,3) = "+eatCoun;
		query		+= " AND ID IN ('43','50','72','46','43','48','107','126')  ";
		
		cateCode    = "0300965";
	}else{
		queryCount++;
		query		+= " AND ID IN ('43','50','72','46','43','48','107','126')  ";
		
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
		query		+= " AND ID IN ('105','106','107','108','109','121','127')  ";
		
		cateCode    = "0";
	}else{
		queryCount++;
		query		+= " AND ID IN ('105','106','107','108','109','121','127')  ";
		
		cateCode    = "0";
	}
}else if(menuF.equals("1") && menuS.equals("6")){
    if(!eatCoun.equals("")){
        queryCount++;
        query        += " AND SUBSTR(gubun2,2,3) = "+eatCoun;
        query        += " AND ID IN ('122')  ";
        
        cateCode    = "0";
    }else{
        queryCount++;
        query        += " AND ID IN ('122')  ";
        
        cateCode    = "0";
    }
}else if(menuF.equals("2") && menuS.equals("1")){
	queryCount++;
	//query		+= " AND ID IN ('73','54')";
	query		+= " AND ID IN ('134','135','136')";
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
		query		+= " AND ID IN ('89','92','90','91','128')  ";
		
		cateCode    = "0301369";
	}else{
		queryCount++;
		query		+= " AND GUBUN1= '01'  ";
		query		+= " AND ID IN ('89','92','90','91','128')  ";
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
}else if(menuF.equals("4") && menuS.equals("4")){
    queryCount++;
    query        += " AND ID IN ('123', '124', '125', '126', '127', '127', '128')  ";
    cateCode    = "0";
}
else if(!"".equals(tg)){
	// 05:추천,06:베스트
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
    gubun1        = ut.isnull(rs1.getString("GUBUN1") ) ;
    devlGoodsType = ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );// 택배, 일배 구분
    devlWeek3   = ut.isnull(rs1.getString("DEVL_WEEK3") );
    devlWeek5   = ut.isnull(rs1.getString("DEVL_WEEK5") );
	

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

	if(groupCode.equals("0301844")){	// 150 프로틴밀 경우
		totalPrice = groupPrice;
		groupPrice1 = groupPrice;
	}
	
	int payPrice		= 0;
	String cpColumns	= " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE, C.ORDERWEEK, C.USE_GOODS, C.USE_LIMIT_CNT, C.USE_LIMIT_PRICE";
	String cpTable		= " ESL_COUPON C, ESL_COUPON_MEMBER CM";
	String cpWhere		= "";

	// 쿠폰 조건
	cpWhere				= "  WHERE C.ID = CM.COUPON_ID";
	cpWhere				+= " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
	cpWhere				+= " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

	 // 쿠폰 개수
	query        = "SELECT * FROM (";
	query        += "    SELECT "+ cpColumns;
	query        += "        FROM "+ cpTable;
	query        +=            cpWhere;
	query        += "        AND USE_GOODS = '01'";
	query        += "    UNION";
	query        += "    SELECT "+ cpColumns;
	query        += "        FROM "+ cpTable;
	query        +=            cpWhere;
	query        += "        AND USE_GOODS IN ('03','04')";
	query        += "    UNION";
	query        += "    SELECT "+ cpColumns;
	query        += "        FROM "+ cpTable;
	query        +=            cpWhere;
	query        += "        AND CM.COUPON_ID IN (SELECT COUPON_ID FROM ESL_COUPON_GOODS WHERE GROUP_CODE = '"+ groupCode +"')";
	query        += "        ) X ";
	//query1        += " WHERE DATE_FORMAT(NOW(), '%Y-%m-%d') BETWEEN STDATE AND LTDATE";
	//query1        += " AND MEMBER_ID = '"+ eslMemberId +"' AND USE_YN = 'N'";
	
	try {
		rs = stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	String couponSaleType		= "";
	String couponMaxSaleType	= "";
	//String couponName		= "";
	int couponeSalePrice		= 0;
	int couponPrice		= 0;
	int couponMaxPrice	= 0;

    String orderWeek = "";
    int useGoods = 0;
    int paramVala        = 0;
    int paramValb         = 0;
    boolean IsDevlWeek   = false;

	int useLimitCnt = 0;
	int useLimitPrice = 0;

	while (rs.next()) {
		couponSaleType	= rs.getString("SALE_TYPE");
		couponeSalePrice 	= rs.getInt("SALE_PRICE");

        orderWeek      = rs.getString("ORDERWEEK");
        useGoods       = rs.getInt("USE_GOODS");

		useLimitCnt		  = rs.getInt("USE_LIMIT_CNT");
		useLimitPrice	  = rs.getInt("USE_LIMIT_PRICE");

		if (couponSaleType.equals("W")) {
			couponPrice		= couponeSalePrice;
		} else {
			couponPrice		= Integer.parseInt(String.valueOf(Math.round((double)groupPrice1 * (double)couponeSalePrice / 100)));
		}
		
		if (couponMaxPrice < couponPrice) {
			couponMaxPrice = couponPrice;
			//couponName	= rs.getString("COUPON_NAME");
			//couponMaxSaleType	= rs.getString("SALE_TYPE");
		}

	//rs.close();

	if(couponMaxPrice > 0){		


           if(!"".equals(devlWeek3)){
                IsDevlWeek = true;
            }
            if(!"".equals(devlWeek5)){
                IsDevlWeek = true;
            }

			if( useLimitCnt <= 1 && useLimitPrice <= groupPrice1 ){

				if(devlWeek3.indexOf("2") > -1 || devlWeek5.indexOf("2") > -1 || devlGoodsType.equals("0002")){
					
					// 1 전체상품에 쿠폰 사용가능
					if(useGoods == 1){
						if(devlGoodsType.equals("0002")){    // 택배
							//쿠폰계산식
							if(couponSaleType.equals("W")){        //선택할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}else{    //퍼센트할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}            
						}else if(orderWeek.indexOf("2") > -1){    // 일배
							//쿠폰계산식
							if(couponSaleType.equals("W")){        //선택할인
								
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;                                    
								}else{
									paramValb = couponPrice;
								}
							}else{    //퍼센트할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;                
								}else{
									paramValb = couponPrice;
								}
							}
						}
					}
					// 2 특정 상품에만 쿠폰 사용가능
					if(useGoods == 2){
						if(devlGoodsType.equals("0002")){    // 택배
							//쿠폰계산식
							if(couponSaleType.equals("W")){        //선택할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}else{    //퍼센트할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}            
						}else if(orderWeek.indexOf("2") > -1){    // 일배
							//쿠폰계산식
							if(couponSaleType.equals("W")){        //선택할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}else{    //퍼센트할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}
						}
					}
					// 3 일배 상품 전체 사용가능
					if(useGoods == 3){
						if(devlGoodsType.equals("0001")){// 선택상품이 일배
							if(orderWeek.indexOf("2") > -1){
								//쿠폰계산식
								if(couponSaleType.equals("W")){        //선택할인
									if(IsDevlWeek && gubun1 != "02"){
										paramValb = couponPrice;
									}else{
										paramValb = couponPrice;
									}
								}else{    //퍼센트할인
									if(IsDevlWeek && gubun1 != "02"){
										paramValb = couponPrice;
									}else{
										paramValb = couponPrice;
									}
								}
							}
						}
					}
					//  4 택배 상품 전체 사용가능
					if(useGoods == 4){
						if(devlGoodsType.equals("0002")){
							//쿠폰계산식
							if(couponSaleType.equals("W")){        //선택할인
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}else{    
								if(IsDevlWeek && gubun1 != "02"){
									paramValb = couponPrice;
								}else{
									paramValb = couponPrice;
								}
							}
						}
					}
				}
			}// the end of if

			// 값 비교
			if(paramVala < paramValb){
				paramVala = paramValb;
			}

            //금액계산
            totalPrice = groupPrice1 - paramVala;    

	}else {
		totalPrice = groupPrice1;
	}	

}
rs.close(); 
	
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
						<span><strong><%=ut.getComma(totalPrice)%>원</strong></span>
						<%
					}else{
						%>
						<span><strong><%=ut.getComma(totalPrice)%>원</strong></span>
						<span><del><%=ut.getComma(groupPrice1)%>원</del></span>
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