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

String query		= "";

String title		= "";
String bannerImg 	= "";
String clickLink 	= "";
String content		= "";
String listImg		= "";
int maxLength		= 0;
String imgUrl		= "";
String instDate 	= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
//String cateCode     = ut.inject(request.getParameter("cateCode") );
String pramType		= ut.inject(request.getParameter("pramType"));
String groupId		= ut.inject(request.getParameter("cartId") );
String devlType		= ""; // ut.inject(request.getParameter("devlType"));
//String groupName    = ""; // ut.inject(request.getParameter("groupName"));
//String groupInfo1   = ""; // ut.inject(request.getParameter("groupInfo1"));
int groupPrice	    = 0;  //ut.inject(request.getParameter("groupPrice"));
//int totalPrice      = 0; //Integer.parseInt(ut.inject(request.getParameter("totalPrice")));
int salePrice      = 0;

//System.out.println("groupId : "+groupId);

String devlGoodsType	= "";
String devlFirstDay		= "";
String devlModiDay		= "";
String devlWeek3		= "";
String devlWeek5		= "";
String cateCode			= "";

String[] arrDevlWeek3 = null;
String[] arrDevlWeek5 = null;
String[] arrCateCode = null;
boolean isDevlWeek = false;
boolean isCateCode = false;

Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();

Statement stmt2		= null;
ResultSet rs2		= null;
stmt2				= conn.createStatement();


int count			= 0;


int bagCnt			= 0;
String gubun1	    = "";
String groupName    = "";
String groupInfo    = "";
String groupInfo1   = "";
String saleTitle    = "";
String aType 	    = "";
String bType 	    = "";
int kalInfo		    = 0;
int groupPrice1     = 0;
int totalPrice	    = 0;
int bTypeNum	    = 0;
String cartImg	    = "";
String groupImg	    = "";
String groupCode    = "";
String gubun2	    = "";
String tag		    = "";
String dayEat	  = "";
double dBtype;
query		= "SELECT COUNT(*) PURCHASE_CNT FROM ESL_ORDER O, ESL_ORDER_GOODS OG WHERE O.ORDER_NUM = OG.ORDER_NUM AND O.MEMBER_ID = '"+ eslMemberId +"' AND ((O.ORDER_STATE > 0 AND O.ORDER_STATE < 90) OR O.ORDER_STATE = '911') AND OG.DEVL_TYPE = '0001'";
try {
	rs1	= stmt1.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs1.next()) {
	bagCnt		= rs1.getInt("PURCHASE_CNT");
}
rs1.close();

//-- 상품 정보
query		= "SELECT ";
query		+= " (SELECT TITLE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS SALE_TITLE, ";
query		+= " (SELECT SALE_TYPE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS ATYPE, ";
query		+= " (SELECT SALE_PRICE FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID WHERE  '"+today+"' BETWEEN STDATE AND LTDATE AND (GROUP_CODE = EGG.GROUP_CODE  OR GROUP_CODE IS NULL) ORDER BY ES.ID DESC LIMIT 0, 1) AS BTYPE, ";
query		+= " GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE, DAY_EAT";
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= "  WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND ID=" + groupId;
rs1 = stmt1.executeQuery(query);
if(rs1.next()){
	saleTitle	= ut.isnull(rs1.getString("SALE_TITLE") );
	aType				= ut.isnull(rs1.getString("ATYPE") );
	bType				= ut.isnull(rs1.getString("BTYPE") );
	gubun1				= ut.isnull(rs1.getString("GUBUN1") );
	groupCode			= ut.isnull(rs1.getString("GROUP_CODE") );
	groupName   		= ut.isnull(rs1.getString("GROUP_NAME") );
	groupPrice  		= rs1.getInt("GROUP_PRICE");
	groupPrice1			= rs1.getInt("GROUP_PRICE1");
	groupInfo			= ut.isnull(rs1.getString("GROUP_INFO") );
	groupInfo1 			= ut.isnull(rs1.getString("GROUP_INFO1") );
	kalInfo 			= rs1.getInt("KAL_INFO");
	cartImg				= ut.isnull(rs1.getString("CART_IMG") );
	groupImg			= ut.isnull(rs1.getString("GROUP_IMGM") );
	gubun2				= ut.isnull(rs1.getString("GUBUN2") );
	tag					= ut.isnull(rs1.getString("TAG") );
	devlGoodsType		= ut.isnull(rs1.getString("DEVL_GOODS_TYPE") );
	devlFirstDay		= ut.isnull(rs1.getString("DEVL_FIRST_DAY") );
	devlModiDay			= ut.isnull(rs1.getString("DEVL_MODI_DAY") );
	devlWeek3			= ut.isnull(rs1.getString("DEVL_WEEK3") );
	devlWeek5			= ut.isnull(rs1.getString("DEVL_WEEK5") );
	cateCode			= ut.isnull(rs1.getString("CATE_CODE") );
	dayEat				= ut.isnull(rs1.getString("DAY_EAT") );


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

//-- 상품정보
query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
query		+= " WHERE NOTICE_TYPE='INFO' AND GOODS_GROUP_ID = "+ groupId;
rs1	= stmt.executeQuery(query);
while(rs1.next()){
	Map noticeMap = new HashMap();
	noticeMap.put("id",rs1.getString("ID"));
	noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
	noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
	infoNoticeList.add(noticeMap);
}
rs1.close();

//-- 상품고시
query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
query		+= " WHERE NOTICE_TYPE='PRODUCT' AND GOODS_GROUP_ID = "+ groupId;
rs1	= stmt.executeQuery(query);
while(rs1.next()){
	Map noticeMap = new HashMap();
	noticeMap.put("id",rs1.getString("ID"));
	noticeMap.put("title",rs1.getString("NOTICE_TITLE"));
	noticeMap.put("content",rs1.getString("NOTICE_CONTENT"));
	productNoticeList.add(noticeMap);
}
rs1.close();

//-- 배송고시
query		= "SELECT ID, NOTICE_TITLE,	NOTICE_CONTENT ";
query		+= " FROM ESL_GOODS_GROUP_NOTICE ";
query		+= " WHERE NOTICE_TYPE='DELIVERY' AND GOODS_GROUP_ID = "+ groupId;
rs1	= stmt.executeQuery(query);
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
if(groupPrice1 == salePrice){
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
		query		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE='" + arrCateCode[forCt] + "'";
		rs1 = stmt1.executeQuery(query);
		if(rs1.next() ){
			categoryId = rs1.getInt("ID");
			categoryName = ut.isnull(rs1.getString("CATE_NAME") );
		}
		rs1.close();

		if(categoryId > 0){
			query		= "SELECT a.CATEGORY_ID, a.ID, a.SET_CODE, a.SET_NAME, a.SET_PRICE, a.SET_INFO, a.MAKE_DATE, a.THUMB_IMG, a.BIG_IMG,";
			query		+= "	a.BIGO, a.USE_YN, b.PORTION_SIZE, b.CALORIE, b.CARBOHYDRATE_G, b.CARBOHYDRATE_P, b.SUGAR_G, b.SUGAR_P,";
			query		+= "	b.PROTEIN_G, b.PROTEIN_P, b.FAT_G, b.FAT_P, b.SATURATED_FAT_G, b.SATURATED_FAT_P, b.TRANS_FAT_G,";
			query		+= "	b.TRANS_FAT_P, b.CHOLESTEROL_G, b.CHOLESTEROL_P, b.NATRIUM_G, b.NATRIUM_P";
			query		+= " FROM ESL_GOODS_SET a, ESL_GOODS_SET_CONTENT b";
			query		+= " WHERE a.ID = b.SET_ID ";
			query		+= " AND a.USE_YN = 'Y'";
			query		+= " AND a.CATEGORY_ID = " + categoryId;
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
			int setID	   = 0;
			String setCode = "";

			while(rs1.next()){
				setName = rs1.getString("SET_NAME");
				kal		= rs1.getString("CALORIE");
				//thumbImg= rs1.getString("THUMB_IMG");
				thumbImg= rs1.getString("BIG_IMG");
				setID	= rs1.getInt("ID");
				setCode = rs1.getString("SET_CODE");

				query		= "SELECT CATEGORY_CODE FROM ESL_GOODS_CATEGORY_SCHEDULE";
				query		+= " WHERE SET_CODE = '"+setCode+"'";
				query		+= " LIMIT 1";
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

 --%>			<button type="button" class="addtocart">
					<img src="/mobile/common/images/order/ico_cart_b.png" alt="" />
					<span></span>
				</button>
		</section>
	</div>
	<!-- End container -->

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