<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%-- <%@ include file="/mobile/common/include/inc-login-check.jsp"%> --%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
List<Map> infoNoticeList = new ArrayList(); //-- 상품정보
List<Map> productNoticeList = new ArrayList(); //-- 상품고시
List<Map> deliveryNoticeList = new ArrayList(); //-- 배송고시

String query        = "";

String title        = "";
String bannerImg     = "";
String clickLink     = "";
String content        = "";
String listImg        = "";
int maxLength        = 0;
String imgUrl        = "";
String instDate     = "";
SimpleDateFormat dt    = new SimpleDateFormat("yyyy-MM-dd");
String today        = dt.format(new Date());
//String cateCode     = ut.inject(request.getParameter("cateCode") );
String pramType        = ut.inject(request.getParameter("pramType"));
String groupId        = ut.inject(request.getParameter("cartId") );
String devlType        = ""; // ut.inject(request.getParameter("devlType"));
//String groupName    = ""; // ut.inject(request.getParameter("groupName"));
//String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice        = 0;  //ut.inject(request.getParameter("groupPrice"));
//int totalPrice      = 0; //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
int salePrice      = 0;

String devlGoodsType    = "";
String devlFirstDay        = "";
String devlModiDay        = "";
String devlWeek3        = "";
String devlWeek5        = "";
String cateCode            = "";
String[] arrDevlWeek3 = null;
String[] arrDevlWeek5 = null;
String[] arrCateCode = null;
boolean isDevlWeek = false;
boolean isCateCode = false;

Statement stmt1        = null;
ResultSet rs1        = null;
stmt1                = conn.createStatement();

Statement stmt2        = null;
ResultSet rs2        = null;
stmt2                = conn.createStatement();

int count            = 0;
int bagCnt            = 0;
String gubun1        = "";
String groupName    = "";
String groupInfo    = "";
String groupInfo1   = "";
String saleTitle    = "";
String aType         = "";
String bType         = "";
int kalInfo            = 0;
int groupPrice1     = 0;
int totalPrice        = 0;
int bTypeNum        = 0;
String cartImg        = "";
String groupImg        = "";
String groupCode    = "";
String gubun2        = "";
String tag            = "";
String dayEat      = "";
double dBtype;

ArrayList<String> aryOrderWeek = new ArrayList<String>();
ArrayList<Integer> aryUseGoods = new ArrayList<Integer>();
ArrayList<String> aryCouponName = new ArrayList<String>();
ArrayList<String> aryPer = new ArrayList<String>();
ArrayList<String> aryW = new ArrayList<String>();

String orderWeek = "";
int useGoods = 0;
int paramVala        = 0;
int paramValb         = 0;
boolean IsDevlWeek   = false;
String couponNameMax = "";

/* 상품별 추천상품 시작 */
int rec_cnt = 0;
List<String> recNameList  = new ArrayList<String>(); //-- 추천 상품명
List<String> recgImgList  = new ArrayList<String>(); //-- 추천 상품의 이미지
List<String> recImgNo     = new ArrayList<String>(); //-- 추천 상품의 이미지 번호
List<String> recgSubCode  = new ArrayList<String>(); //-- 추천 상품의 그룹코드
List<String> reccCodeList = new ArrayList<String>(); //-- 추천 상품의 CATE_CODE
List<Integer> recgId	  = new ArrayList<Integer>(); //-- 현재 상품의 그룹코드
/* 상품별 추천상품 끝 */

query        = "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
try {
    rs1    = stmt1.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

if (rs1.next()) {
    bagCnt        = rs1.getInt("PURCHASE_CNT");
}
rs1.close();

//-- 상품 정보
query        = "SELECT ";
query        += " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query        += " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query        += " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query        += " GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DAY_EAT";
query        += " FROM ESL_GOODS_GROUP EGG ";
query        += "  WHERE USE_YN = 'Y' ";
query        += " AND LIST_VIEW_YN = 'Y' ";
query        += " AND ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
if(rs1.next()){
    saleTitle    = ut.isnull(rs1.getString("SALE_TITLE") );
    aType                = ut.isnull(rs1.getString("ATYPE") );
    bType                = ut.isnull(rs1.getString("BTYPE") );
    gubun1                = ut.isnull(rs1.getString("GUBUN1") );
    groupCode            = ut.isnull(rs1.getString("GROUP_CODE") );
    groupName           = ut.isnull(rs1.getString("GROUP_NAME") );
    groupPrice          = rs1.getInt("GROUP_PRICE");
    groupPrice1            = rs1.getInt("GROUP_PRICE1");
    groupInfo            = ut.isnull(rs1.getString("GROUP_INFO") );
    groupInfo1             = ut.isnull(rs1.getString("GROUP_INFO1") );
    kalInfo             = rs1.getInt("KAL_INFO");
    cartImg                = ut.isnull(rs1.getString("CART_IMG") );
    groupImg            = ut.isnull(rs1.getString("GROUP_IMGM") );
    gubun2                = ut.isnull(rs1.getString("GUBUN2") );
    tag                    = ut.isnull(rs1.getString("TAG") );
    devlGoodsType        = ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );
    devlFirstDay        = ut.isnull(rs1.getString("DEVL_FIRST_DAY") );
    devlModiDay            = ut.isnull(rs1.getString("DEVL_MODI_DAY") );
    devlWeek3            = ut.isnull(rs1.getString("DEVL_WEEK3") );
    devlWeek5            = ut.isnull(rs1.getString("DEVL_WEEK5") );
    cateCode            = ut.isnull(rs1.getString("CATE_CODE") );
    dayEat                = ut.isnull(rs1.getString("DAY_EAT") );

    if(!ut.isNaN(devlFirstDay) || "".equals(devlFirstDay) ) devlFirstDay = "0";
    if(!ut.isNaN(devlModiDay) || "".equals(devlFirstDay) ) devlModiDay = "0";

    if(!"".equals(devlWeek3)){
        arrDevlWeek3 = devlWeek3.split(",");
        isDevlWeek = true;
    }
    if(!"".equals(devlWeek5)){
        arrDevlWeek5 = devlWeek5.split(",");
        isDevlWeek = true;
    }
    if(!"".equals(cateCode)){
        arrCateCode = cateCode.split(",");
        isCateCode = true;
    }

    //-- 모바일은 계산된 금액으로 처리
    salePrice = groupPrice1;
    if(bType != null){
        if(aType.equals("P")){
            dBtype = Integer.parseInt(bType)/100.0;
            salePrice = groupPrice1 - (int)(groupPrice1 * dBtype); // %세일 계산
            //System.out.println(salePrice);
        }else if(aType.equals("W")){
            salePrice = groupPrice1 - Integer.parseInt(bType);
        }
    }
	if(groupCode.equals("0301844")){	// 150 프로틴밀 경우
		totalPrice = groupPrice;
		groupPrice1 = groupPrice;
		salePrice = groupPrice;
	}
}
else{
%>
<script>
alert("상품을 조회할 수 없습니다.");
history.back();
</script>
<%
}
rs1.close();

/* 상품별 추천상품 시작 */
int groupId2      = Integer.parseInt(groupId);
try {
	query         = " SELECT E.ID, E.CATE_CODE, E.GROUP_NAME, E.GROUP_IMGM, ER.IMG_NO, ER.GROUP_SUB_CODE ";
	query        += " FROM ESL_GOODS_GROUP_RECIMG ER, ESL_GOODS_GROUP E ";
	query        += " WHERE E.GROUP_CODE = ER.GROUP_SUB_CODE ";
	query        += " AND ER.GROUP_SUB_ID = ? ";
	query        += " ORDER BY IMG_NO ";
	pstmt        = conn.prepareStatement(query);
	pstmt.setInt(1, groupId2);
	rs    = pstmt.executeQuery();
	//System.out.println(pstmt);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
while (rs.next()) {
	recgId.add(rs.getInt("ID"))	;
	reccCodeList.add(ut.isnull(rs.getString("CATE_CODE")));
	recNameList.add(ut.isnull(rs.getString("GROUP_NAME")));
	recgImgList.add(ut.isnull(rs.getString("GROUP_IMGM")));
	recImgNo.add(ut.isnull(rs.getString("IMG_NO")));
	recgSubCode.add(ut.isnull(rs.getString("GROUP_SUB_CODE")));
}
rs.close();	
//System.out.println(recNameList.size());
/* 상품별 추천상품 끝 */


String cpColumns    = " C.ID, C.STDATE, C.LTDATE, CM.MEMBER_ID, CM.USE_YN, CM.COUPON_NUM, C.COUPON_NAME, C.SALE_TYPE, C.SALE_PRICE, C.ORDERWEEK, C.USE_GOODS, C.USE_LIMIT_CNT, C.USE_LIMIT_PRICE ";
String cpTable        = " ESL_COUPON C, ESL_COUPON_MEMBER CM";
String cpWhere        = "";

// 쿠폰 조건
cpWhere                = "  WHERE C.ID = CM.COUPON_ID";
cpWhere                += " AND DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i') BETWEEN C.STDATE AND C.LTDATE";
cpWhere                += " AND CM.MEMBER_ID = '"+ eslMemberId +"' AND CM.USE_YN = 'N'";

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
    rs1 = stmt1.executeQuery(query);
} catch(Exception e) {
    out.println(e+"=>"+query);
    if(true)return;
}

String couponSaleType        = "";
String couponMaxSaleType    = "";
String couponName        = "";
int couponeSalePrice        = 0;
int couponPrice        = 0;
int couponMaxPrice    = 0;
int cnt_coupon = 0;

int useLimitCnt = 0;
int useLimitPrice = 0;

while (rs1.next()) {
    couponSaleType   = rs1.getString("SALE_TYPE");
    couponeSalePrice = rs1.getInt("SALE_PRICE");
	orderWeek        = rs1.getString("ORDERWEEK");
    useGoods         = rs1.getInt("USE_GOODS");
	couponName       = rs1.getString("COUPON_NAME");
	useLimitCnt		 = rs1.getInt("USE_LIMIT_CNT");
	useLimitPrice	 = rs1.getInt("USE_LIMIT_PRICE");

    if (couponSaleType.equals("W")) {
        couponPrice        = couponeSalePrice;
    } else {
        couponPrice        = Integer.parseInt(String.valueOf(Math.round((double)groupPrice1 * (double)couponeSalePrice / 100)));
    }

	if (couponMaxPrice < couponPrice) {
		couponMaxPrice = couponPrice;
	}

/*
    if("02".equals(gubun1)) {
            couponMaxPrice = couponPrice;
            couponName    = rs1.getString("COUPON_NAME");
            couponMaxSaleType    = rs1.getString("SALE_TYPE");
            orderWeek      = rs1.getString("ORDERWEEK");
            useGoods       = rs1.getInt("USE_GOODS");
    } else {
        if (couponMaxPrice < couponPrice) {
            couponMaxPrice = couponPrice;
            couponName    = rs1.getString("COUPON_NAME");
            couponMaxSaleType    = rs1.getString("SALE_TYPE");
            orderWeek      = rs1.getString("ORDERWEEK");
            useGoods       = rs1.getInt("USE_GOODS");
        }
    }
	*/

	if(couponMaxPrice > 0){    // 쿠폰이 있다면

		if(!"".equals(devlWeek3)){
			IsDevlWeek = true;
		}
		if(!"".equals(devlWeek5)){
			IsDevlWeek = true;
		}

		if( useLimitCnt <= 1 && useLimitPrice <= groupPrice1 ){

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

		// 값 비교
		if(paramVala < paramValb){
			paramVala = paramValb;
			couponNameMax = couponName;
			cnt_coupon++;
		}

	}
    //금액계산
    //couponMaxPrice = paramVala;
    //couponMaxPrice = paramVala;
    //totalPrice = groupPrice1 - paramVala;
}
rs1.close();

//-- 상품정보
query        = "SELECT ID, NOTICE_TITLE,    NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    infoNoticeList.add(noticeMap);
}
rs1.close();

//-- 상품고시
query        = "SELECT ID, NOTICE_TITLE,    NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='PRODUCT' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    productNoticeList.add(noticeMap);
}
rs1.close();

//-- 배송고시
query        = "SELECT ID, NOTICE_TITLE, NOTICE_CONTENT ";
query        += " FROM ESL_GOODS_GROUP_NOTICE ";
query        += " WHERE NOTICE_TYPE='DELIVERY' AND GOODS_GROUP_ID = ? ";
pstmt       = conn.prepareStatement(query);
pstmt.setString(1, groupId);
rs1    = pstmt.executeQuery();
while(rs1.next()){
    Map noticeMap = new HashMap();
    noticeMap.put("id",rs1.getString("ID"));
    noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
    noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
    deliveryNoticeList.add(noticeMap);
}
rs1.close();
%>
</head>
<body>
<div id="wrap" class="expansioncss">
    <%@ include file="/mobile/common/include/inc-header.jsp"%>
    <!-- End header -->
    <div id="container">
        <section id="shop_content">
            <div class="shop_inner">
                <div class="shop_title">
                    <p>상품 상세정보</p>
                    <button type="button" class="loc_back" onclick="javascript:history.back();"><img src="/mobile/common/images/ico/ico_loc_back.png" alt="" /></button>
                </div>
                <div class="goods_view">
                    <div class="img">
                        <img src="/data/goods/<%=groupImg%>" onerror="this.src='/mobile/common/images/orderview_sample.jpg'" alt="">
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
                    </div>
                    <div class="info">
                        <div class="text_info">
                            <p class="sub_title"><%=groupInfo1 %></p>
                                <p class="title"><%=groupName %> </p>
                                <!-- (총 10종 메뉴) -->
                                </div>
                                <div class="pay_info">
                                    <div class="pay_info_inner">
<%
if (cnt_coupon > 0) {
%>
                                    <div class="event_desc">
                                    <p>(<%=couponNameMax%>)</p>
                                    </div>

                                    <div class="pay_desc">
            <%
            if(dayEat.length() > 1){
                out.println("<p class=\"eat_cycle\">"+dayEat+"</p>");
            }
            %>
                                    <p class="price_desc"><del><%=ut.getComma(groupPrice1)%>원</del><strong><%=ut.getComma(groupPrice1-paramVala)%>원</strong></p>
                                    </div>
<%
} else if(groupPrice1 == salePrice){
%>
                                    <div class="pay_desc">
            <%
            if(dayEat.length() > 1){
                out.println("<p class=\"eat_cycle\">"+dayEat+"</p>");
            }
            %>
                                    <p class="price_desc"><strong><%=ut.getComma(groupPrice1)%>원</strong></p>
                                    </div>
<%
}else{
%>
                                    <div class="event_desc">
                                    <% if(groupPrice != salePrice){ %><p>(<%=saleTitle%>)</p><% } %>
                                    </div>

                                    <div class="pay_desc">
            <%
            if(dayEat.length() > 1){
                out.println("<p class=\"eat_cycle\">"+dayEat+"</p>");
            }
            %>
                                    <p class="price_desc"><del><%=ut.getComma(groupPrice1)%>원부터</del><strong><%=ut.getComma(salePrice)%>원</strong></p>
                                    </div>
<%
}
%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="goods_description related_prd">
					<% 
					if(recImgNo.size() > 0){
					%>
                <div class="title">Related Product</div>
                <div class="goods_list related">
                    <ul>
						<%
						for(int g=0; g<recImgNo.size(); g++){ 
						%>

							<li>
								<a href="order_view.jsp?cateCode=<%=reccCodeList.get(g)%>&amp;cartId=<%=recgId.get(g)%>&amp;pramType=list">
									 <div class="img">
										<div class="centered">
											<img src="/data/goods/<%=recgImgList.get(g)%>" onerror="this.src='/mobile/common/images/orderview_sample.jpg'" alt="">
										</div>
										<div class="badge">
											<span class="b_rcmd"></span>
										</div>
									</div>
								</a>
								<div class="info">
									<p class="title"><%=recNameList.get(g)%></p>
								</div>
							</li>
<!--
                        <li>
                            <a href="order_view.jsp?cateCode=0300702&amp;cartId=42&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="http://www.eatsslim.co.kr/data/goods/groupImgM_18342180801104038.jpg" onerror="this.src='/mobile/common/images/orderview_sample.jpg'" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_rcmd"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <p class="title">300 샐러드+밸런스쉐이크</p>
                                </div>
                            </a>
                        </li>
						-->
  						<% 
						}
						%>                      
                    </ul>
                </div>
					<%
					} 
					%>
                <script type="text/javascript">
                    $('.goods_list.related ul').slick({
                      infinite: false,
                      slidesToShow: 1.5,
                      slidesToScroll: 1,
                      arrows: false
                    });
                </script>
            </div>


            <div class="goods_description">
                <dl>
                    <dt class="show"><button onclick="calcitemToggle(this);">상세정보<span></span></button></dt>
                    <dd class="w100"><%=groupInfo%></dd>
                </dl>
<%
if(isCateCode){
%>
<%
    for(int forCt = 0; forCt < arrCateCode.length;forCt++){
        int categoryId = 0;
        String categoryName = "";
        query        = "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE='" + arrCateCode[forCt] + "'";
        rs1 = stmt1.executeQuery(query);
        if(rs1.next() ){
            categoryId = rs1.getInt("ID");
            categoryName = ut.isnull(rs1.getString("CATE_NAME") );
        }
        rs1.close();

        if(categoryId > 0){
            query        = "SELECT a.CATEGORY_ID, a.ID, a.SET_CODE, a.SET_NAME, a.SET_PRICE, a.SET_INFO, a.MAKE_DATE, a.THUMB_IMG, a.BIG_IMG,";
            query        += "    a.BIGO, a.USE_YN, b.PORTION_SIZE, b.CALORIE, b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P,";
            query        += "    b.PROTEIN_G, b.PROTEIN_P, b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G,";
            query        += "    b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P";
            query        += " FROM ESL_GOODS_SET a, ESL_GOODS_SET_CONTENT b";
            query        += " WHERE a.ID = b.SET_ID ";
            query        += " AND a.USE_YN = 'Y'";
            query        += " AND a.CATEGORY_ID = " + categoryId;
            try {
                rs1 = stmt1.executeQuery(query);
            } catch(Exception e) {
                System.out.println(e+"=>"+query);
                if(true)return;
            }
%>
                <dl>
                    <dt>
                        <button onclick="calcitemToggle(this);">
                            <%=categoryName%> 식단정보<span></span>
                        </button>
                    </dt>
                    <dd class="nbg">
                        <div class="goods_diet_list">
                            <ul>
<%
            String setName = "";
            String kal     = "";
            String thumbImg= "";
            int setID       = 0;
            String setCode = "";

            while(rs1.next()){
                setName = rs1.getString("SET_NAME");
                kal        = rs1.getString("CALORIE");
                //thumbImg= rs1.getString("THUMB_IMG");
                thumbImg= rs1.getString("BIG_IMG");
                setID    = rs1.getInt("ID");
                setCode = rs1.getString("SET_CODE");

                query        = "SELECT CATEGORY_CODE FROM ESL_GOODS_CATEGORY_SCHEDULE";
                query        += " WHERE SET_CODE = '"+setCode+"'";
                query        += " LIMIT 1";
                try {
                    rs2 = stmt2.executeQuery(query);
                } catch(Exception e) {
                    System.out.println(e+"=>"+query);
                    if(true)return;
                }
                String caregoryCode = "";
                if(rs2.next()){

                    caregoryCode = rs2.getString("CATEGORY_CODE");
                }
                rs2.close();
%>
                                <li><a class="cboxElement "
                                    href="/mobile/shop/cuisineinfo/cuisineA.jsp?set_id=<%=setID%>&caregoryCode=<%=caregoryCode%>">
                                        <div class="img">
                                            <img src="/data/goods/<%=thumbImg %>" alt="<%=setName%>">
                                        </div>
                                        <div class="info">
                                            <div class="text_info">
                                                <p class="title"><%=setName%></p>
                                            </div>
                                            <div class="calorie_info">
                                            <%
                                                if(!kal.equals("")){
                                                    %>
                                                    <span><%=kal %>kcal</span>
                                                    <%
                                                }
                                            %>
                                            </div>
                                        </div>
                                </a></li>
<%
            } //-- while(rs1.next()){
%>
                            </ul>
                        </div>
                    </dd>
                </dl>
<%
        } //-- if(categoryId > 0){
    } //-- for(int forCt = 0; forCt < arrCateCode.length;forCt++){
} //-- if(isCateCode){
%>
<%
if(deliveryNoticeList != null && !deliveryNoticeList.isEmpty() ){
%>
                <dl>
                    <dt><button onclick="calcitemToggle(this);">배송정보<span></span></button></dt>
                    <dd>
                        <div class="goods_desc_table">
                            <table>
                                <colgroup>
                                    <col width="30%">
                                    <col width="70%">
                                </colgroup>
                                <tbody>
<%
    for(Map nMap : deliveryNoticeList){
%>
                                    <tr>
                                        <th><%=nMap.get("title") %></th>
                                        <td><%=nMap.get("content") %></td>
                                    </tr>
<%
    }
%>
                                </tbody>
                            </table>
                        </div>
                    </dd>
                </dl>
<%
}
if(productNoticeList != null && !productNoticeList.isEmpty() ){
%>
                <dl>
                    <dt><button onclick="calcitemToggle(this);">상품고시정보<span></span></button></dt>
                    <dd>
                        <div class="goods_desc_table">
                            <table>
                                <colgroup>
                                    <col width="40%">
                                    <col width="60%">
                                </colgroup>
                                <tbody>
<%
    for(Map nMap : productNoticeList){
%>
                                    <tr>
                                        <th><%=nMap.get("title") %></th>
                                        <td><%=nMap.get("content") %></td>
                                    </tr>
<%
    }
%>
                                </tbody>
                            </table>
                        </div>
                    </dd>
                </dl>
            </div>
<%
}
%>
<%--
            <div class="other_items">
                <div class="shop_inner">
                    <h3>다른 추천 상품</h3>
                    <div class="other_items_slider">
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="other_items_slide">
                            <a href="order_view.jsp?groupName=퀴진&amp;groupPrice1=95000&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;kalInfo=360&amp;totalPrice=90250&amp;groupInfo1=정찬형 스타일의 체계적인 다이어트식&amp;cateCode=0300700&amp;cartId=32&amp;devlType=0001&amp;paramType=list">
                                <div class="img">
                                    <div class="centered">
                                        <img src="/mobile/common/images/orderview_sample.jpg" alt="">
                                    </div>
                                    <div class="badge">
                                        <span class="b_event"></span>
                                        <span class="b_special"></span>
                                        <span class="b_sale"></span>
                                        <span class="b_new"></span>
                                    </div>
                                </div>
                                <div class="info">
                                    <div class="text_info">
                                        <p class="sub_title">정찬형 스타일의 체계적인 다이어트식</p>
                                        <p class="title">퀴진 360Kal</p>
                                    </div>
                                    <div class="pay_info">
                                        <span><del>95000원</del></span>
                                        <span><strong>90250원</strong></span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

--%>            <button type="button" id="cartBtn" class="addtocart">
                    <img src="/mobile/common/images/order/ico_cart_b.png" alt="" />
                    <span></span>
                </button>
        </section>
    </div>
    <!-- End container -->

<!-- WIDERPLANET  SCRIPT START 2018.9.5 -->
<div id="wp_tg_cts" style="display:none;"></div>
<script type="text/javascript">
var wptg_tagscript_vars = wptg_tagscript_vars || [];
var groupCode = '<%=groupCode%>';
wptg_tagscript_vars.push(
(function() {
    return {
        wp_hcuid:"",      /*고객넘버 등 Unique ID (ex. 로그인  ID, 고객넘버 등 )를 암호화하여 대입.
                 *주의 : 로그인 하지 않은 사용자는 어떠한 값도 대입하지 않습니다.*/
        ti:"25218",
        ty:"Item",
        device:"mobile"
        ,items:[{i:groupCode, t:"상품명"}] /* i:<?상품 식별번호  (Feed로 제공되는 식별번호와 일치하여야 합니다 .) t:상품명  */
        };
}));
</script>
<script type="text/javascript" async src="//cdn-aitg.widerplanet.com/js/wp_astg_4.0.js"></script>
<!-- // WIDERPLANET  SCRIPT END 2018.9.5 -->

<!-- Enliple Shop Log Tracker v3.5 start -->
<script type="text/javascript">
<!--
function mobRfShop(){
  var sh = new EN();      
  // [상품상세정보]

  var mobGroupCode = '<%=groupCode%>';
  var mobGroupName = '<%=groupName %>';
  var mobGroupPrice = '<%=groupPrice%>';
  var cartImg = '<%=cartImg %>';

  //var imgUrl = 'http://dev.eatsslim.co.kr<%=webUploadDir%>' +'goods/'+ encodeURIComponent(cartImg);
  var imgUrl = 'http://www.eatsslim.co.kr<%=webUploadDir%>' + 'goods/' + encodeURIComponent(cartImg);

  sh.setData("sc", "995f3de777d1894591fafb3feb1a673b");	
  sh.setData("userid", "eatsslim");
  sh.setData("pcode", mobGroupCode);
  sh.setData("price", mobGroupPrice);
  sh.setData("pnm", encodeURIComponent(encodeURIComponent(mobGroupName)));
  sh.setData("img", imgUrl);
  //sh.setData("dcPrice", $("#totalPrice").val()); // 옵션 
  //sh.setData("soldOut", mobSoldOut); //옵션 1:품절,2:품절아님
  //sh.setData("mdPcode", "추천상품코드1,추천상품코드2,…"); //옵션 
  //sh.setData("cate1", encodeURIComponent(encodeURIComponent("카테고리 코드 또는 이름"))); //옵션
  sh.setSSL(true);
  sh.sendRfShop();
} 
//-->
</script>
<script src="https://cdn.megadata.co.kr/js/en_script/3.5/enliple_sns_min3.5.js" defer="defer" onload="mobRfShop()"></script>
<!-- Enliple Shop Log Tracker v3.5 end  -->

        <%@ include file="/mobile/common/include/inc-footer.jsp"%>
    <!-- End footer -->
</div>
<script>
//-- 장바구니 버튼
atcButton('<%=groupId%>');

$(".goods_diet_list ul").slick({
    infinite: false,
    centerMode : false,
    variableWidth: false,
    slidesToShow: 2,
    slidesToScroll: 2,
    rows:2,
    arrows: true,
    dots:false,
    prevArrow: '<button type="button" class="slick-prev"><img src="/dist/images/ico/ico_slider_left.png" alt="" /></button>',
    nextArrow: '<button type="button" class="slick-next"><img src="/dist/images/ico/ico_slider_right.png" alt="" /></button>'
    });
</script>

</body>
</html>