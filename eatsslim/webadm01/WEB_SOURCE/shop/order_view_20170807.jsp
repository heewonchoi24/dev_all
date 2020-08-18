<%@page import="javax.swing.text.StyledEditorKit.ForegroundAction"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import="java.util.List,java.util.ArrayList,java.util.Map,java.util.HashMap"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css">
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
<%
String temp_no = (String)session.getAttribute("esl_customer_num");
if(temp_no!=null){
	if(temp_no.equals("1")){//통합회원 sso에서 약관동의 안한 사람은 회원세션소멸
		session.setAttribute("esl_member_idx","");
		session.setAttribute("esl_member_id",null);
		session.setAttribute("esl_member_name","");
		session.setAttribute("esl_customer_num","");
		session.setAttribute("esl_member_code",""); //통합회원 구분
		response.sendRedirect("https://www.eatsslim.co.kr/sso/logout.jsp");if(true)return;
	}
}

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
query		+= " GUBUN1, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, GUBUN2, ID, LIST_VIEW_YN, TAG, DEVL_GOODS_TYPE, DEVL_FIRST_DAY, DEVL_MODI_DAY, DEVL_WEEK3, DEVL_WEEK5, CATE_CODE";
query		+= " FROM ESL_GOODS_GROUP EGG ";
query		+= "  WHERE USE_YN = 'Y' ";
query		+= " AND LIST_VIEW_YN = 'Y' ";
query		+= " AND ID=" + groupId;
rs1 = stmt1.executeQuery(query);
if(rs1.next()){
	saleTitle			= ut.isnull(rs1.getString("SALE_TITLE") );
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

	salePrice = groupPrice;
 	if(bType != null){
 		if(aType.equals("P")){
 			dBtype = Integer.parseInt(bType)/100.0;
 			salePrice = groupPrice - (int)(groupPrice * dBtype); // %세일 계산
 			//System.out.println(salePrice);
 		}else if(aType.equals("W")){
 			salePrice = groupPrice - Integer.parseInt(bType);
 		}
 	}

	String setProductHistory = ut.getCook(request ,"PRODUCT_HISTORY");
	if("".equals(setProductHistory)){
		setProductHistory = "," + groupId + ",";
		ut.setCook(response ,"PRODUCT_HISTORY",setProductHistory);
	}
	else{
		if(setProductHistory.indexOf(","+groupId+",") == -1){
			setProductHistory += groupId + ",";
			ut.setCook(response ,"PRODUCT_HISTORY",setProductHistory);
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

//-- 휴무일정보
query       = "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME";
query       += " FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY_TYPE = '02' ";
query       += " ORDER BY HOLIDAY DESC, ID DESC";
pstmt       = conn.prepareStatement(query);
rs        = pstmt.executeQuery();

ArrayList<String> holiDay = new ArrayList();
while (rs.next()) {
    holiDay.add(rs.getString("HOLIDAY"));
}
rs.close();

%>

</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/dist/images/ico/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;">
</div>
<div id="wrap" class="added">
	<div id="header">
	<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div id="container">
	<form action="" name="productViewForm" id="productViewForm">
		<div class="order_view_contain ff_noto">
			<div class="path">
				<span>HOME</span><span>SHOP</span><strong><%=ut.getGubun1Name(gubun1)%></strong>
			</div>
			<div class="goods_frame">
				<div class="goods_thumbnail">
					<%
						if(tag != ""){
					%>
					<div class="goods_badge">
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
					<%
						}
					%>
					<img src="/data/goods/<%=groupImg%>" onerror='this.src="/dist/images/sample_order_view.jpg"'>
				</div>
				<div class="goods_info">

					<div class="goods_title">
						<p><%=groupInfo1 %></p>
						<h2><%=groupName %></h2>
					</div>
					<div class="section">
				        <input type="hidden" name="devlWeek" id="devlWeek" value="">
				        <input type="hidden" name="devlDay" id="devlDay" value="">
				        <input type="hidden" name="groupId" id="groupId" value="<%=groupId%>">
				        <input type="hidden" name="groupCode" id="groupCode" value="<%=groupCode%>">
				        <input type="hidden" name="devlType" id="devlType" value="<%=devlGoodsType%>">
			        	<input type="hidden" name="buyBagYn" id="buyBagYn" value="">
			        	<input type="hidden" name="pcAndMobileType" id="pcAndMobileType" value="pc">
						<input type="hidden" name="totalPrice" id="totalPrice" value="">
<%
if(infoNoticeList != null && !infoNoticeList.isEmpty() ){
%>
							<div class="prd_info">
				        		<div class="title">상품정보</div>
				        		<div class="tableBox">
				        			<table>
					        			<colgroup>
											<col width="29.5%"/>
											<col width="*"/>
										</colgroup>
										<tbody>
<%
	for(Map nMap : infoNoticeList){
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
				        	</div>
<%
}
%>

							<table>
								<colgroup>
									<col width="29.5%">
									<col width="*">
								</colgroup>
								<tbody>
<%
if(devlGoodsType.equals("0001")){
	if(isDevlWeek){//-- 일일배송 선택할것이 있다면
		if("02".equals(gubun1)){ //-- 프로그램 다이어트는 요일과 기간이 정해져 있다.
			if(!"".equals(devlWeek3)){
%>
								<input type="hidden" name="selectDevlDay" id="selectDevlDay" value="3">
								<input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="<%=devlWeek3%>">
<%
			}
			else{
%>
								<input type="hidden" name="selectDevlDay" id="selectDevlDay" value="5">
								<input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="<%=devlWeek5%>">
<%
			}
		}
		else{
%>
								<tr>
									<th>배송 요일</th>
									<td>
									<div class="select_group selectWrap" id="selectDevlDay" name="selectDevlDay">
										<select name="selectDevlDay" id="selectDevlDay" class="notCustom">
											<% if(arrDevlWeek5 != null){ %><option value="5">주 5회 (월~금)</option><% } %>
											<% if(arrDevlWeek3 != null){ %><option value="3">주 3회 (월/수/금)</option><% } %>
										</select>
									</div>
									</td>
								</tr>
								<tr>
									<th>배송 기간</th>
									<td>
									<div class="selectWrap">
									<select name="selectDevlWeek" id="selectDevlWeek" class="notCustom">

<%
			String[] arrFor = null;
			if(arrDevlWeek5 != null){
				arrFor = arrDevlWeek5;
			}
			else{
				arrFor = arrDevlWeek3;
			}
			for(int forCt = 0; forCt < arrFor.length;forCt++){
%>
										<option value="<%=arrFor[forCt]%>"><%=arrFor[forCt]%>주</option>
<%
			}
%>
									</select>
									</div>
									</td>
								</tr>
<%
		} //if("02".equals(gubun1)){} else
	} //if(isDevlWeek){ %>
								<tr>
									<th>수량</th>
									<td>
										<div class="inp_quantity">
						        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="buyQty" value="1">
						        			<button type="button" class="inp_qtt_minus" onclick="QuantityFn.minus();">-</button>
						        			<button type="button" class="inp_qtt_plus" onclick="QuantityFn.plus();">+</button>
						        		</div>
									</td>
								</tr>
								<tr>
									<th>첫 배송일</th>
									<td>
										<div class="inp_datepicker">
											<input type="text" id="day" name="day" class="dp-applied date-pick" readonly/>
										</div>
									</td>
								</tr>
								<tr>
									<th>보냉가방</th>
									<td>
										<div class="inp_thermos">
											<%
												if(bagCnt < 1){
													%>
													<input type="checkbox" id="buy_bag" name="buy_bag" checked="checked" disabled="disabled"/> <label for="buy_bag">보냉가방 구매 (4,000원)</label>
													<%
												}else if(bagCnt > 0){
													%>
													<input type="checkbox" id="buy_bag" name="buy_bag"/> <label for="buy_bag">보냉가방 구매 (4,000원)</label>
													<%
												}
											%>
											<p>보냉가방을 필수로 구매하셔야 상품을 신선하게 배송받으실 수 있습니다.</p>
										</div>
									</td>
								</tr>
<%
} //if(devlGoodsType.equals("0001")){
else{
%>
								<input type="hidden" name="selectDevlDay" id="selectDevlDay" value="0">
								<input type="hidden" name="selectDevlWeek" id="selectDevlWeek" value="0">
								<tr>
									<th>수량</th>
									<td>
						        		<ul>
<% if(!"0300993".equals(groupCode)){ %>
											<li>
												<div class="inp_quantity">
								        			<input type="text" class="inp_qtt_text only_number" name="buyQty" id="buyQty" value="1">
								        			<button type="button" class="inp_qtt_minus" onclick="QuantityFn.minus();">-</button>
								        			<button type="button" class="inp_qtt_plus" onclick="QuantityFn.plus();">+</button>
								        		</div>
											</li>
<% } else { %>
											<li>
												<div class="title">한식세트</div>
												<div class="inp_quantity">
								        			<input type="text" class="inp_qtt_text only_number" name="buyQty2" id="buyQty2" value="1">
								        			<button type="button" class="inp_qtt_minus" onclick="QuantityFn2.minus();">-</button>
								        			<button type="button" class="inp_qtt_plus" onclick="QuantityFn2.plus();">+</button>
								        		</div>
											</li>
											<li>
												<div class="title">양식세트</div>
												<div class="inp_quantity">
								        			<input type="text" class="inp_qtt_text only_number" name="buyQty3" id="buyQty3" value="1">
								        			<button type="button" class="inp_qtt_minus" onclick="QuantityFn3.minus();">-</button>
								        			<button type="button" class="inp_qtt_plus" onclick="QuantityFn3.plus();">+</button>
								        		</div>
											</li>
<% } %>
										</ul>
									</td>
								</tr>
<%
}
%>
							</tbody>
							</table>
							<table class="tfoot">
								<tfoot>
									<tr>
										<th>총 주문금액</th>
										<td>
										<% if(groupPrice != salePrice){ %><span class="event_area"><%=saleTitle%></span><% } %>
										</td>
									</tr>
									<tr>
										<td colspan="2">
										<%
										if(groupPrice == salePrice){
											%>
											<span><strong id="sumPrice">&nbsp;</strong></span>
											<%
										}else{
											%>
											<del id="orgPrice">&nbsp;</del><span><strong id="sumPrice">&nbsp;</strong></span>
											<p><span></span></p>
											<!-- (3월 특별 고객할인 이벤트가) -->
											<%
										}
										%>
										</td>
									</tr>
								</tfoot>
							</table>
						</form>
					</div>
					<div class="footer">
						<div class="btn_group ta-l">
							<button type="button" id="btnProductViewForm" class="btn" onclick="">장바구니 담기</button>
							<button type="button" class="btn_go_order">주문하기</button>
						</div>
						<!-- <div class="btn_share">
							<p>SHARE THIS</p>
							<ul>
								<li class="facebook"><a href="http://www.facebook.com/share.php?u=http://www.eatsslim.co.kr/shop/order_view.jsp"><img src="/dist/images/ico/ico_share_facebook.png" alt=""></a></li>
								<li class="twitter"><a href="http://twitter.com/share?url=http://www.eatsslim.co.kr/shop/dietMeal.jsp&text=eatsslim diet"><img src="/dist/images/ico/ico_share_twitter.png" alt=""></a></li>
							</ul>
						</div> -->
					</div>
				</div>
			</div>
			<div class="goods_detail">
				<!-- <div class="detail_inner cbg">
					<dl>
						<dt>기본정보</dt>
						<dd class="goods_detail1">
							<div class="desc_title">
								<div class="calorie">
									<span>평균 250kcal</span>
								</div>
								<div class="tt">
									One-dish Style로 디자인된<br><strong>알라까르떼 슬림</strong>
								</div>
								<p>데우지 않고 간편한 식사</p>
							</div>
							<div class="desc_list">
								<ul>
									<li><span><img src="/dist/images/ico/ico_goods_detail1_1.png" alt="" /></span>총 10가지 다양한 메뉴로 <strong>질리지 않는 즐거운 식사!</strong></li>
									<li><span><img src="/dist/images/ico/ico_goods_detail1_2.png" alt="" /></span>풀무원 식문화 연구소 영양 자문단의 <strong>과학적이고 체계적인 영양설계!</strong></li>
									<li><span><img src="/dist/images/ico/ico_goods_detail1_3.png" alt="" /></span>데우지 않고 간편하게 <strong>언제 어디서나 섭취 가능</strong></li>
									<li><span><img src="/dist/images/ico/ico_goods_detail1_4.png" alt="" /></span>풀무원 극신선배송시스템으로 <strong>안전하고 신선한 냉장 배송!</strong></li>
								</ul>
							</div>
						</dd>
					</dl>
				</div> -->
				<div class="detail_inner">
					<dl>
						<dt>상품 상세정보</dt>
						<dd class="goods_detail3">
							<!-- <img src="/dist/images/ms03_1_03.gif" alt="" /> -->
							<%=groupInfo%>
						</dd>
					</dl>
				</div>
<%
if(isCateCode){
%>
				<%-- <div class="set_list_wrap">
								<div class="title_area">
									<h3><%=groupNm %></h3>
								</div>
								<div class="set_list">
									<ul>
										<%
										String setName = "";
										String kal     = "";
										String thumbImg= "";
										int setID	   = 0;
										while(rs1.next()){
										setName = rs1.getString("SET_NAME");
										kal		= rs1.getString("CALORIE");
										thumbImg= rs1.getString("THUMB_IMG");
										setID	= rs1.getInt("ID");
										System.out.println(" setID::"+setID);
										%>
										<li>
											<a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>">
												<div class="img">
													<img src="/data/goods/<%=thumbImg %>" alt="캐슈넛 팬네파스타샐러드" />
												</div>
												<div class="info">
												<%
													if(!kal.equals("")){
														%>
														<p class="calorie"><%=kal %>kcal</p>
														<%
													}
												%>
													<p class="name"><%=setName%></p>
												</div>
											</a>
										</li>
										<%
										}
										%>
									</ul>
								</div>
							</div> --%>

				<div class="detail_inner">
					<dl>
						<dt>식단구성 <p>※ 아래 제품 이미지를 클릭하시면, 상세 영양정보를 확인하실 수 있습니다.</p></dt>
						<dd class="goods_detail2">
<%
	for(int forCt = 0; forCt < arrCateCode.length;forCt++){
		int categoryId = 0;
		String categoryName = "";
		query		= "SELECT ID, CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE='" + arrCateCode[forCt] + "'";
		//System.out.println(query);
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
			//System.out.println(query);
			try {
				rs1 = stmt1.executeQuery(query);
			} catch(Exception e) {
				System.out.println(e+"=>"+query);
				if(true)return;
			}
%>
							<div class="set_list_wrap">
								<div class="title_area">
									<h3><%=categoryName%></h3>
								</div>
								<div class="set_list">
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
				//System.out.println(query);
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
										<li>
											<a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>&caregoryCode=<%=caregoryCode%>">
												<div class="img">
													<img src="/data/goods/<%=thumbImg %>" alt="<%=setName%>" />
												</div>
												<div class="info">
													<p class="calorie">
												<%
													if(!kal.equals("")){
														%>
														<%=kal %>kcal
														<%
													}
												%>
													</p>
													<p class="name"><%=setName%></p>
												</div>
											</a>
										</li>
<%
			} //-- while(rs1.next()){
%>
									</ul>
								</div>
							</div>
<%
		} //-- if(categoryId > 0){
	} //-- for(int forCt = 0; forCt < arrCateCode.length;forCt++){
%>
						<%--
							<div class="set_list_wrap">
								<div class="title_area">
									<h3><%=groupNm %></h3>
								</div>
								<div class="set_list">
									<ul>
										<%
										String setName = "";
										String kal     = "";
										String thumbImg= "";
										int setID	   = 0;
										while(rs1.next()){
										setName = rs1.getString("SET_NAME");
										kal		= rs1.getString("CALORIE");
										thumbImg= rs1.getString("THUMB_IMG");
										setID	= rs1.getInt("ID");
										System.out.println(" setID::"+setID);
										%>
										<li>
											<a class="custombox" rel="setItem1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=800&lightbox[height]=650&set_id=<%=setID%>">
												<div class="img">
													<img src="/data/goods/<%=thumbImg %>" alt="캐슈넛 팬네파스타샐러드" />
												</div>
												<div class="info">
												<%
													if(!kal.equals("")){
														%>
														<p class="calorie"><%=kal %>kcal</p>
														<%
													}
												%>
													<p class="name"><%=setName%></p>
												</div>
											</a>
										</li>
										<%
										}
										%>
									</ul>
								</div>
							</div> --%>


						</dd>
					</dl>
				</div>
<%
}//-- if(isCateCode){
%>
				</form>
<%
if(deliveryNoticeList != null && !deliveryNoticeList.isEmpty() ){
%>
				<div class="detail_inner cbg">
					<dl>
						<dt>배송안내</dt>
						<dd class="goods_detail4">
							<table>
								<colgroup>
									<col width="23%"/>
									<col width="*"/>
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
						</dd>
					</dl>
				</div>
<%
}
if(productNoticeList != null && !productNoticeList.isEmpty() ){
%>
				<div class="detail_inner cbg">
					<dl>
						<dt>상품정보 제공고시</dt>
						<dd class="goods_detail5">
							<table>
								<colgroup>
									<col width="23%"/>
									<col width="*"/>
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
						</dd>
					</dl>
				</div>
<%
}
%>
			</div>
		</div>
	</div>
	<!-- End container -->
	<%@ include file="/common/include/inc-cart.jsp"%>
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu" class="ov">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>

</body>
<script>
var GroupCode = '<%=groupCode%>';
var SaleTotalPrice = "";
var GoodsTotalPrice = "";
var IsDevlWeek = <%=isDevlWeek%>;
var SalePrice = <%=salePrice%>;
var GoodsPrice = <%=groupPrice%>;
var Hour =  new Date().getHours();
var MinDate = <%=devlFirstDay%>;
var Gubun1 = "<%=gubun1%>";
if(GroupCode == "0301369"){ //헬씨퀴진만 3시 이후되면 1일을 더한다.
	if(Hour >= 15){
		MinDate += 1;
	}
}


if(IsDevlWeek){
	/* 170624 : 요청에 의해 전체상품 설정 */
	if(true || GroupCode != "0331"){
		$('#selectDevlWeek > option[value="2"]').attr('selected', 'true');
	}

	if(Gubun1 != "02"){
		$("#devlDay").val($('#selectDevlDay option:selected').val());
		$("#devlWeek").val($('#selectDevlWeek option:selected').val());
	}
	else{
		$("#devlDay").val($('#selectDevlDay').val());
		$("#devlWeek").val($('#selectDevlWeek').val());
	}

	if($("input:checkbox[id='buy_bag']").is(":checked") == true){
		$("#buyBagYn").val("Y");
	}else if($("input:checkbox[id='buy_bag']").is(":checked") == false){
		$("#buyBagYn").val("N");
	}
}


$("#buy_bag").change(function(){

	if($(this).is(":checked") == true){
		$("#buyBagYn").val("Y");
	   	CalAmount();

	}else{
		$("#buyBagYn").val("N");
		CalAmount();
	}
});

Date.prototype.addDays = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};


var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
    holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
$(".date-pick").datepick({
    dateFormat: "yyyy.mm.dd",
    minDate: MinDate,
    showTrigger: '#calImg',
    showAnim: 'slideDown',
    changeMonth: false,
    onDate: function(date) {
    	var currentYear = date.getFullYear(),
	    	currentMonth = date.getMonth()+1,
	    	currentDate = date.getDate(),
	   		currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);

	   	for (i = 0; i < holiDays.length; i++) {
	   		if (currentToday == holiDays[i]) {
	   			return {dateClass: '-holiday-', selectable: false};
	   		}
	   	}
		return {};
    }
});

		//     $('#pop_scheduler').data('datepicker');

$(":input").filter(".only_number").css("imeMode", "disabled").keypress(function(event){
	if (event.which && (event.which < 48 || event.which > 57)){
		event.preventDefault();
	}
});


 	// 옵션변경 수량선택
    var QuantityFn = {
    	onSet : function(i){
    		$("#buyQty").val(i);
    	},
    	plus : function(){
    		var $val = $("#buyQty").val();
    		var i = Number($val)+1;
    		QuantityFn.onSet(i);
		   	CalAmount();
    	},
    	minus : function(){
    		var $val = $("#buyQty").val();
    		var i = Number($val)-1;
    		if(i < 1) {
    			alert("수량은 1개 이상 선택해주세요.");
    			return false;
   			}else{
   				QuantityFn.onSet(i);
   			   	CalAmount();
   			}
    	}
    }
    var QuantityFn2 = {
        	onSet : function(i2){
        		$("#buyQty2").val(i2);
        	},
        	plus : function(){
        		var $val2 = $("#buyQty2").val();
        		var i2 = Number($val2)+1;
        		QuantityFn2.onSet(i2);
    		   	CalAmount();
        	},
        	minus : function(){
        		var $val2 = $("#buyQty2").val();
        		var $val3 = $("#buyQty3").val();
        		var i2 = Number($val2)-1;
        		var i3 = Number($val3);
        		if(i2 < 1) {
        			i2 = 0;
       			}
        		if((i2+i3) < 2) {
        			alert("최소 주문은 2Set부터 가능합니다.");
        			return false;
       			}else{
       				QuantityFn2.onSet(i2);
       			   	CalAmount();
       			}
        	}
        }
    var QuantityFn3 = {
        	onSet : function(i3){
        		$("#buyQty3").val(i3);
        	},
        	plus : function(){
        		var $val3 = $("#buyQty3").val();
        		var i3 = Number($val3)+1;
        		QuantityFn3.onSet(i3);
    		   	CalAmount();
        	},
        	minus : function(){
        		var $val2 = $("#buyQty2").val();
        		var $val3 = $("#buyQty3").val();
        		var i2 = Number($val2);
        		var i3 = Number($val3)-1;
        		if(i3 < 0) {
        			i3 = 0;
       			}
        		if((i2+i3) < 2) {
        			alert("최소 주문은 2Set부터 가능합니다.");
        			return false;
       			}else{
       				QuantityFn3.onSet(i3);
       			   	CalAmount();
       			}
        	}
        }

    // 3일 5일 구분
    var OptionWeek = {"week3":"<%=devlWeek3%>","week5":"<%=devlWeek5%>"};
   	$('#selectDevlDay').change(function(){
   		var arrOptionWeek = OptionWeek["week"+$(this).find("option:selected").val()].split(",");
   		$("#selectDevlWeek option").remove();
   		for(var forCt = 0; forCt < arrOptionWeek.length; forCt++){
   			$('#selectDevlWeek').append("<option value='" + arrOptionWeek[forCt] + "'>" + arrOptionWeek[forCt] + "주</option>");
   		}
   		$('#selectDevlWeek > option[value="2"]').attr('selected', 'true');
   		$("#devlWeek").val($("#selectDevlWeek option:selected").val());
   		$("#devlDay").val($('#selectDevlDay option:selected').val());
   		CalAmount();
    });

    // 배송기간 선택시 가격 실시간으로 변동
    $('#selectDevlWeek').change(function(){
       $("#devlWeek").val($('#selectDevlWeek option:selected').val());
       CalAmount();
    });

    // 수량 직접 입력시
    $('#buyQty').on("keyup",function(e) {
        var ct = $(this).val();
        if(isNaN(ct) || 1 > parseInt(ct)){
        	$('#buyQty').val(1);
        }
        CalAmount();
    });

    //콤마 가격 붙여주기
    function totalComma(total){
    	total = total + "";
    	point = total.length % 3 ;
    	len = total.length;
    	str = total.substring(0, point);
    	while (point < len) {
    	    if (str != "") str += ",";
    	    str += total.substring(point, point + 3);
    	    point += 3;
    	}
		return str;
    }

    //-- 금액을 계산한다.
    function CalAmount(){
    	if(GroupCode == "0300993"){ //-- 미니밀일경우 한식,양식세트로 적용
	   		SaleTotalPrice	= SalePrice * (parseInt($("#buyQty2").val()) + parseInt($("#buyQty3").val()));
	   		if(SalePrice != GoodsPrice){
		   		GoodsTotalPrice	= GoodsPrice * (parseInt($("#buyQty2").val()) + parseInt($("#buyQty3").val()));
	   		}
    	}
    	else{
	    	if(IsDevlWeek && Gubun1 != "02"){ //-- 요일체크이면서 프로그램다이어트가 아닌상품
		   		SaleTotalPrice	= SalePrice * parseInt($("#devlWeek").val()) * parseInt($("#devlDay").val()) * parseInt($("#buyQty").val());

		   		if(SalePrice != GoodsPrice){
			   		GoodsTotalPrice	= GoodsPrice * parseInt($("#devlWeek").val()) * parseInt($("#devlDay").val()) * parseInt($("#buyQty").val());
		   		}

		   	}else{
		   		SaleTotalPrice	= SalePrice * parseInt($("#buyQty").val());
		   		if(SalePrice != GoodsPrice){
			   		GoodsTotalPrice	= GoodsPrice * parseInt($("#buyQty").val());
		   		}
		   	}
    	}
    	if($("#buyBagYn").val() == "Y") SaleTotalPrice += 4000;
    	$("#totalPrice").val(SaleTotalPrice);
		$("#sumPrice").html(totalComma(SaleTotalPrice)+"원");
		if(SalePrice != GoodsPrice){
			$("#orgPrice").html(totalComma(GoodsTotalPrice)+"원");
   		}
    }

    $(function(){
    	CalAmount();
    });

 	var eslMemberId = '<%=eslMemberId%>';
    $("#btnProductViewForm").click(function(){
	   	if(eslMemberId != ""){
		 	if(IsDevlWeek && $("#day").val() == ""){
		 		alert("배송일을 선택해 주세요.");
		 	}
		 	else{

		 		if(IsDevlWeek && Gubun1 != "02"){
		 			$("#devlDay").val($('#selectDevlDay option:selected').val());
		 			$("#devlWeek").val($('#selectDevlWeek option:selected').val());
		 		}
		 		else{
		 			$("#devlDay").val($('#selectDevlDay').val());
		 			$("#devlWeek").val($('#selectDevlWeek').val());
		 		}

		    	var queryString = $("form[name=productViewForm]").serialize() ;

		    	$.ajax({
		            url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp",
		            type : 'post',
		            data : queryString,
		    		dataType : "json",
		            async : true,
		            success : function(data){
		            	if(data.code == "success"){
		            		top.location.reload();
		            		//$(".jquery-lightbox-button-close").click();
		            	}
		            	else{
		            		alert(data.data);
		            	}
		            },
		            error : function(a,b,c){
		                alert('error : ' + c);
		                moving = false;
		            }
		        })
		 	}
	   	}else{
	   		alert("로그인을 먼저 하시기 바랍니다.");
	   		var url = "/shop/popup/loginCheck.jsp";
	   		$.lightbox(url, {
	            width  : 640,
	            height : 740
	        });
	   	}

    });

    $(".btn_go_order").click(function(){
	   	if(eslMemberId != ""){
		 	if(IsDevlWeek && $("#day").val() == ""){
		 		alert("배송일을 선택해 주세요.");
		 	}
		 	else{

		 		if(IsDevlWeek && Gubun1 != "02"){
		 			$("#devlDay").val($('#selectDevlDay option:selected').val());
		 			$("#devlWeek").val($('#selectDevlWeek option:selected').val());
		 		}
		 		else{
		 			$("#devlDay").val($('#selectDevlDay').val());
		 			$("#devlWeek").val($('#selectDevlWeek').val());
		 		}

		    	var queryString = $("form[name=productViewForm]").serialize() ;

		    	$.ajax({
		            url : "/mobile/shop/order/__ajax_goods_set_options_path.jsp?cart_type=L",
		            type : 'post',
		            data : queryString,
		    		dataType : "json",
		            async : true,
		            success : function(data){
		            	if(data.code == "success"){
		            		location.href='/shop/order.jsp?mode=L';
		            		//$(".jquery-lightbox-button-close").click();
		            	}
		            	else{
		            		alert(data.data);
		            	}
		            },
		            error : function(a,b,c){
		                alert('error : ' + c);
		                moving = false;
		            }
		        })
		 	}
	   	}else{
	   		alert("로그인을 먼저 하시기 바랍니다.");
	   		var url = "/shop/popup/loginCheck.jsp";
	   		$.lightbox(url, {
	            width  : 640,
	            height : 740
	        });
	   	}

    });

</script>
</html>
