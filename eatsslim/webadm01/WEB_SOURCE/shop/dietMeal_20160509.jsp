<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
int price				= 0;
int totalPrice			= 0;
int realPrice			= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String groupCode		= "";
String offerNotice		= "";
String groupName		= "";
SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
String today		= dt.format(new Date());
String saleTitle = 	"";
String saleType = 	"";
int salePrice = 	0;
String useGoods = 	"";

NumberFormat nf			= NumberFormat.getNumberInstance();
String table			= " ESL_GOODS_GROUP";
String where			= " WHERE GUBUN1 = '01' AND GUBUN2 = '11' AND USE_YN = 'Y'";
String sort				= " ORDER BY ID ASC";
int	tab					= 0;
if (request.getParameter("tab") != null && request.getParameter("tab").length()>0) {
	tab		= Integer.parseInt(request.getParameter("tab"));
} else {
	tab		= 7;
}

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= (price * 10) + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - 5) / 100) + defaultBagPrice;
	
	
	String where1			= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '"+groupCode+"'  or GROUP_CODE is null) ";
	String sort1			=  " ORDER BY ES.ID DESC";
	query		= "SELECT TITLE, SALE_TYPE, SALE_PRICE, USE_GOODS FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID " + where1 + sort1 + " LIMIT 0, 1";
	//out.println(query);if(true)return;
	pstmt		= conn.prepareStatement(query);
	rs			= pstmt.executeQuery();

	if (rs.next()) {		
		saleTitle			= rs.getString("TITLE");
		saleType			= rs.getString("SALE_TYPE");
		salePrice		= rs.getInt("SALE_PRICE");
		useGoods		= rs.getString("USE_GOODS");
		
		if (saleType.equals("P")) {
			tSalePrice		= (int)Math.round((double)(price * 10) * (double)(100 - salePrice) / 100) + defaultBagPrice;
		} else {
			tSalePrice		= (int)Math.round((double)( (price - salePrice) * 10)) + defaultBagPrice;
		}
		
	}	
	
}


rs.close();
pstmt.close();
%>

	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<input type="hidden" id="tab" value="<%=tab%>" />
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>식사 다이어트</h1>
			<div class="pageDepth">
				HOME &gt; SHOP &gt; <strong>식사 다이어트</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">잇슬림 식사 다이어트 한눈에 보기</h3>
				<div class="twothird last col">
					<div class="quizindiet">
						<ul class="quizintab">
							<li class="quizinA current">
								<a href="javascript:;" onclick="cngMenu(7);"></a>
							</li>
							<li class="quizinB">
								<a href="javascript:;" onclick="cngMenu(8);"></a>
							</li>
							<li class="alaCool">
								<a href="javascript:;" onclick="cngMenu(9);"></a>
							</li>
							<li class="alaCoolB">
								<a href="javascript:;" onclick="cngMenu(10);"></a>
							</li>
						</ul>
						<div class="quizinlist">
							<div class="share floatright">
								<ul>
									<li>
										<a class="facebook" href="http://www.facebook.com/share.php?u=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
									<li>
										<a class="twitter" href="http://twitter.com/share?url=http://www.eatsslim.com/shop/dietMeal.jsp&text=eatsslim diet" target="_blank"></a>
									</li>
									<li>
										<a class="me2day" href="http://me2day.net/posts/new?new_post[body]=http://www.eatsslim.com/shop/dietMeal.jsp" target="_blank"></a>
									</li>
								</ul>
							</div>
							<div class="clear"></div>
							<h1 class="row center">
								<img src="/images/headcopy_01.png" alt="저열량, 저나트륨으로 디자인된 맛있는 다이어트!" id="titleImg" />
							</h1>
							<div class="center">
								<p class="marb20">
									<img src="/images/quizinA_subject.png" alt="퀴진A" id="topImg1" />
								</p>
								<p>
									<img src="/images/quizinA_feature.png" alt="퀴진A 특징" id="topImg2" />
								</p>
							</div>
							<!-- 퀴진 리스트 -->
							<div class="foodlist">
								<%
								int setId			= 0;
								String thumbImg		= "";
								String imgUrl		= "";
								String setName		= "";
								String calorie		= "";

								query		= "SELECT GS.ID, GS.SET_NAME, GSC.CALORIE, GS.THUMB_IMG FROM ESL_GOODS_SET GS, ESL_GOODS_SET_CONTENT GSC WHERE GS.ID = GSC.SET_ID AND GS.CATEGORY_ID = 7 AND GS.USE_YN = 'Y' ORDER BY GS.ID";
								pstmt		= conn.prepareStatement(query);
								rs			= pstmt.executeQuery();

								int i			= 0;
								int divNum		= 0;
								String divClass	= "";
								while (rs.next()) {
									setId		= rs.getInt("ID");
									thumbImg	= rs.getString("THUMB_IMG");
									if (thumbImg.equals("") || thumbImg == null) {
										imgUrl		= "/images/quizin_sample.jpg";
									} else {										
										imgUrl		= webUploadDir +"goods/"+ thumbImg;
									}
									setName		= rs.getString("SET_NAME");
									calorie		= (rs.getString("CALORIE").equals(""))? "" : rs.getString("CALORIE") + "kcal";

									divNum		= i % 4;
									if (divNum == 0) {
										divClass	= " first";
									} else if (divNum == 3) {
										divClass	= " last";
									} else {
										divClass	= "";
									}
								%>
								<div class="food<%=divClass%>">
									<div>
										<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>" title="<%=setName%>"><img src="<%=imgUrl%>" alt="<%=setName%>" /></a> 
										<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=<%=setId%>">
											<div class="food-calorie"><%=calorie%></div>
											<div class="food-title"><%=setName%></div>
										</a>
									</div>
								</div>
								<%
									i++;
								}
								%>
								<div class="clear"></div>
							</div>
							<!-- End 퀴진 리스트 -->
						</div>
						<div class="clear"></div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
		</div>
		<!-- End eleven columns offset-by-one -->
		<form name="frm_order" id="frm_order" method="post">
			<input type="hidden" name="mode" value="addCart" />
			<input type="hidden" name="cart_type" id="cart_type" />
			<input type="hidden" name="group_id" id="group_id" value="<%=groupId%>" />
			<input type="hidden" name="gubun2" id="gubun2" />
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<input type="hidden" name="set_holiday" id="set_holiday" />
			<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
			<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
			<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
			<div class="sidebar five columns">
				<h3 class="marb20">주문하기</h3>
				<div class="sideorder">
					<div class="title">메인제품 선택</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>배송가능지역 검색<br /><font style="font-weight:normal; color:#777;">배송이 가능한 지역인지 확인</font></p>
								<div class="button small dark">
									<a href="javascript:;" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0003','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no')">검색</a>
								</div>
							</li>
							<li>
								<span class="badge">2</span>
								<p>1일 배달식수를 선택</p>
								<div class="ordernum">
									<span class="active num0"><a class="ordernum-one" href="javascript:;" onclick="getGroup(0);"></a>1일1식</span>
									<span class="num5"><a class="ordernum-six" href="javascript:;" onclick="getGroup(5);"></a>1일1식+간편식</span>
									<span class="last num1"><a class="ordernum-two" href="javascript:;" onclick="getGroup(1);"></a>1일2식</span>
									<div class="clear"></div>
									<span class="last num2"><a class="ordernum-three" href="javascript:;" onclick="getGroup(2);"></a>1일3식</span>
									<div class="clear"></div>
								</div>
							</li>
							<li>
								<span class="badge">3</span>
								<p>일일끼니수별 식사스타일을 선택</p>
								<div id="groupSelect">
									<select name="group_code" id="group_code" onChange="selGroup();" style="width:235px;">
										<%
										query		= "SELECT ID, GROUP_NAME FROM  "+ table + where + sort;
										pstmt		= conn.prepareStatement(query);
										rs			= pstmt.executeQuery();

										while (rs.next()) {
											groupId			= rs.getInt("ID");
											groupName		= rs.getString("GROUP_NAME");
										%>
										<option value="<%=groupId%>"><%=groupName%></option>
										<%
										}
										%>
									</select>
								</div>
							</li>
							<li>
								<span class="badge">4</span>
								<p>식사 기간을 선택</p>
								<table width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td width="120">
											<select name="devl_day" id="devl_day" style="width:100px;">
												<option value="5" selected="selected">주5회(월~금)</option>
												<option value="3">주3회(월수금)</option>
											</select>
										</td>
										<td></td>
										<td width="110">
											<span id="type_sel">
											<select name="devl_week" id="devl_week" style="width:100px;">
												<option value="1">1주</option>
												<option value="2" selected="selected">2주</option>
												<option value="4">4주</option>
											</select>
											</span>
										</td>
									</tr>
								</table>
							</li>
							<li>
								<span class="badge">5</span>
								<p class="floatleft">첫 배송일 지정</p>
								<div class="floatright" style="width:140px;">
									<input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
								</div>	
								<div class="clear"></div>
							</li>
							<li>
								<span class="badge">6</span>
								<p class="floatleft">수량</p>
								<div class="quantity floatright" style="width:140px;">
									<input class="minus" type="button" value="-" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
									<input class="plus" type="button" value="+" />
								</div>
								<div class="clear"></div>
							</li>
							<li id="addOption" class="hidden">
								<span class="badge">7</span>
								<p class="floatleft">옵션상품</p>
								<div class="floatright" style="width:140px;" id="optionSelect">
									<select name="add_goods" id="add_goods" style="width:140px;">
										<option value="0" selected="selected">없음</option>
										<option value="2500">매일 밸런스쉐이크1포</option>
									</select>
								</div>
								<div class="clear"></div>
							</li>
							<!--li>
								<a href="javascript:;" onclick="$.lightbox('/images/popup/pop_shake.jpg');"><font style="font-weight:bold; color:red;">식사와 함께하면 참좋은 밸런스쉐이크<br />옵션, 자세히보기</font></a>
							</li-->
						</ul>
					</div>
				</div>
				<div class="divider"></div>
				<div class="addoption">
					<div class="title">보냉가방 구매</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge add">1</span>
								<p>
									<input name="buy_bag" id="buy_bag" type="checkbox" value="Y" checked="checked" /> 보냉가방 구매 (<%=nf.format(defaultBagPrice)%>원)<br />
									<font style="font-weight:normal; color:#777;">보냉가방을 필수로 구매하셔야 상품을 신선하게 배송할 수 있습니다.</font>
								</p>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div> 
				<div class="price-wrapper">
				
					<font name="saleTitle" id="saleTitle" style="font-weight:bold; color:blue;" ><%=saleTitle%></font>
					<p class="price">
						총가격:
						<span id="saleDiv" >
							<del>
								<span class="amount tprice"><%=nf.format(totalPrice)%>원</span>
							</del>
							<ins>
								<span class="amount" id="sprice"><%=nf.format(tSalePrice)%>원</span>
							</ins>
						</span>
						<span id="nosaleDiv">
							<ins>
								<span class="amount tprice"><%=nf.format(totalPrice)%>원</span>
							</ins>
						</span>
					</p>
					<%if (eslMemberId.equals("")) {%>
					<div class="button large light"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">장바구니</a></div>
					<div class="button large dark iconBtn"><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350"><span class="star"></span>바로구매</a></div>
					<%} else {%>
					<div class="button large light"><a href="javascript:;" onclick="addCart('C');">장바구니</a></div>
					<div class="button large dark iconBtn"><a href="javascript:;" onclick="addCart('L');"><span class="star"></span>바로구매</a></div>
					<%}%>
					<div class="clear"></div>
				</div>  
			</div>
		</form>
		<!-- End sidebar four columns -->
		<div class="clear"></div>
		<div class="sixteen columns offset-by-one">	
			<div class="divider"></div> 
			<div class="row col">
				<div class="one last col">
					<ul class="tabNavi marb30">
						<li class="active">
							<a href="#detail-item">상세 제품정보</a>
						</li>
                        <li>
							<a href="#detail-delivery">배송안내</a>
						</li>
						<li>
							<a href="#detail-notify">상품정보 제공고시</a>
						</li>                
						<div class="clear"></div>                  
					</ul>
						
					<div id="detail-item">
						<img src="/images/dietmeal_detail_1.jpg" usemap="#Map" border="0">
                        <map name="Map">
                          <area shape="circle" coords="473,2039,130" href="#" onclick="window.open('/intro/foodmonthplan.jsp','pop','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=1013,height=600')">
                        </map>
					</div>
					<div class="divider"></div> 
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">상세 제품정보</a>
						</li>
						<li class="active">
							<a href="#detail-delivery">배송안내</a>
						</li>
						<li>
							<a href="#detail-notify">상품정보 제공고시</a>
						</li>
						<div class="clear"></div>
					</ul>                   
					<div id="detail-delivery">
						<p><img src="/images/dietmeal_detail_02_1.jpg"></p>
				  </div>
					<div class="divider"></div>
					<ul class="tabNavi marb30">
						<li>
							<a href="#detail-item">상세 제품정보</a>
						</li>
						<li>
							<a href="#detail-delivery">배송안내</a>
						</li>
						<li class="active">
							<a href="#detail-notify">상품정보 제공고시</a>
						</li>
						<div class="clear"></div>
					</ul>
				  <div id="detail-notify">
                        <table class="orderList clear" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>구분</th>
							<th class="last">내용</th>
						</tr>
						<tr>
							<td>식품의 유형</td>
							<td style="text-align:left;">즉석섭취식품</td>
						</tr>
						<tr>
						  <td>제조원 및 생산자</td>
						  <td style="text-align:left;">풀무원건강생활(주)</td>
						  </tr>
						<tr>
						  <td>소재지</td>
						  <td style="text-align:left;">충북 증평군 도안면 원명로 35</td>
						  </tr>
						<tr>
						  <td>수입품의 경우 수입자</td>
						  <td style="text-align:left;">해당사항 없음</td>
						  </tr>
						<tr>
						  <td>제조일자</td>
						  <td style="text-align:left;">수령일 기준, 2일전 생산된 제품이 배달됩니다.<br /><span class="font-maple">※ 주문이후 각 생산공장에서 가장 최근에 생산된 제품을 준비하여<br />신속히 배송하므로, 정확한 제조년월일 안내가 어렵습니다.</span></td>
						  </tr>
						<tr>
						  <td>유통기한</td>
						  <td style="text-align:left;">제조 시간으로 부터 52시간 이내</td>
						  </tr>
						<tr>
						  <td>중량 및 구성</td>
						  <td style="text-align:left;">각 끼니별 150g ~ 600g</td>
						  </tr>
						<tr>
						  <td>원재료 및 함량</td>
						  <td style="text-align:left;">각 메뉴별 상세페이지 참조</td>
						  </tr>
						<tr>
						  <td>유전자 재조합식품 여부</td>
						  <td style="text-align:left;">해당사항 없음</td>
						  </tr>
						<tr>
						  <td>영유아식, 체중조절 식품<br />표시광고 사전심의필</td>
						  <td style="text-align:left;">해당사항 없음</td>
						  </tr>
						<tr>
						  <td>수입식품:<br /><span class="font-maple">식품위생법에 따른 수입신고 여부</span></td>
						  <td style="text-align:left;">해당사항 없음</td>
						  </tr>
						<tr>
						  <td>고객상담실 연락처</td>
						  <td style="text-align:left;">풀무원 고객기쁨센터 080-800-0434(수신자부담)</td>
						  </tr>

						 <tr>
						  <td>유의사항</td>
						  <td style="text-align:left;"><span class="font-maple">잇슬림은 칼로리 조정 식단으로 임산부, 수유부는 섭취하지 마시기 바랍니다.</span></td>
						  </tr>
				    </table>
				  </div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
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
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();

	cngMenu($("#tab").val());

	$(".date-pick").datepick({ 
		dateFormat: "yyyy.mm.dd",
		minDate: +4,
		onDate: $.datepick.noWeekend,
		showTrigger: '#calImg'
	});

	$("a").attr("onfocus", "this.blur()");

	$("#devl_day").change(cngDay);

	$("#devl_week").change(function() {
		var addPrice	= parseInt($("#add_goods").val());
		$("#set_holiday").val("");
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	$(".plus").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	$(".minus").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
	$("#buy_bag").click(function() {
		var addPrice	= parseInt($("#add_goods").val());
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});

	$("#add_goods").change(optionCng);
});

(function($) {
	$.extend($.datepick, {
		noSundays: function(date) {
			return {selectable: date.getDay() != 0};
		},
		noWeekend: function(date) {
			return {selectable: date.getDay() != 0  && date.getDay() != 6};
		},
		noOdd: function(date) {
		return {selectable: date.getDay() != 0 && date.getDay() != 1 && date.getDay() != 3 && date.getDay() != 5};
		},
		noEven: function(date) {
		return {selectable: date.getDay() != 0 && date.getDay() != 2 && date.getDay() != 4 && date.getDay() != 6};
		}
	});
})(jQuery);

function optionCng() {
	var addPrice	= parseInt($("#add_goods").val());
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	getSalePrice();
}

function cngDay() {
	var addPrice	= parseInt($("#add_goods").val());
	$("#set_holiday").val("");
	var devlDay		= $("#devl_day").val();
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	var gid =  $("#group_id").val();
	var typeOptions	= '<select name="devl_week" id="devl_week" style="width:100px;">';

	if (devlDay == 5) {
		if (gid == "32" || gid == "40" || gid == "69" ) {		
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +4,
				onDate: $.datepick.noWeekend,
				showTrigger: '#calImg'
			});
		} else {
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +6,
				onDate: $.datepick.noWeekend,
				showTrigger: '#calImg'
			});
		}
		
		typeOptions	+= '<option value="1">1주</option>';
		typeOptions	+= '<option value="2" selected="selected">2주</option>';
		typeOptions	+= '<option value="4">4주</option>';
	} else {
		if (gid == "32" || gid == "40" || gid == "69" ) {		
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +4,
				onDate: $.datepick.noEven,
				showTrigger: '#calImg'
			});
		} else {
			$(".date-pick").datepick({ 
				dateFormat: "yyyy.mm.dd",
				minDate: +6,
				onDate: $.datepick.noEven,
				showTrigger: '#calImg'
			});
		}
		
		typeOptions	+= '<option value="2">2주</option>';
		typeOptions	+= '<option value="4">4주</option>';
	}
	typeOptions	+= "</select>"
	$("#type_sel").html(typeOptions);
	$("#devl_week").selectBox();	
	
	$("#devl_week").change(function() {
		var addPrice	= parseInt($("#add_goods").val());
		$("#set_holiday").val("");
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function cngMenu(num) {
	$(".quizintab li").removeClass("current");
	if (num == 4) {
		$(".quizinA").css("z-index", "10");
		$(".quizinB").css("z-index", "7");
		$(".alaCool").css("z-index", "4");
		$(".alaCoolB").css("z-index", "1");
		$("#titleImg").attr("src", "/images/headcopy_04.png");
		$("#topImg1").attr("src", "/images/snack_subject.png");
		$("#topImg2").attr("src", "/images/quizinA_feature.png");
		$(".foodlist").addClass("hidden");
		$(".snack").addClass("current");
		$(".snacklist").removeClass("hidden");
	} else {
		$.post("dietMeal_ajax.jsp", {
			mode: 'cngMenu',
			cate_id: num
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					var menuArr		= "";
					var menuHtml	= "";
					var i			= 0;
					var divNum		= 0;
					var divClass	= "";

					$(data).find("menu").each(function() {
						divNum		= i % 4;
						if (divNum == 0) {
							divClass	= " first";
						} else if (divNum == 3) {
							divClass	= " last";
						} else {
							divClass	= "";
						}

						menuArr			= $(this).text().split("|");
						menuHtml		+= '<div class="food'+ divClass +'">';
						menuHtml		+= '<div>';
						menuHtml		+= '<a class="food-thumb lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'" title="'+ menuArr[2] +'"><img src="'+ menuArr[1] +'" alt="'+ menuArr[2] +'" /></a> ';
						menuHtml		+= '<a class="food-link lightbox" rel="group1" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id='+ menuArr[0] +'">';
						menuHtml		+= '<div class="food-calorie">'+ menuArr[3] +'</div>';
						menuHtml		+= '<div class="food-title">'+ menuArr[2] +'</div>';
						menuHtml		+= '</a>';
						menuHtml		+= '</div>';
						menuHtml		+= '</div>';

						$(".foodlist").removeClass("hidden");
						$(".snacklist").addClass("hidden");
						
						$("."+ menuArr[4]).addClass("current");						
						$("#titleImg").attr("src", "/images/"+ menuArr[5] +".png");
						$("#topImg1").attr("src", "/images/"+ menuArr[6] +".png");
						$("#topImg2").attr("src", "/images/"+ menuArr[7] +".png");
						
						if (num == 7) {
							$(".quizinA").css("z-index", "10");
							$(".quizinB").css("z-index", "7");
							$(".alaCool").css("z-index", "4");
							$(".alaCoolB").css("z-index", "1");
						} else if (num == 8) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "10");
							$(".alaCool").css("z-index", "7");
							$(".alaCoolB").css("z-index", "4");
						} else if (num == 9) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "4");
							$(".alaCool").css("z-index", "10");
							$(".alaCoolB").css("z-index", "7");
						} else if (num == 10) {
							$(".quizinA").css("z-index", "1");
							$(".quizinB").css("z-index", "4");
							$(".alaCool").css("z-index", "7");
							$(".alaCoolB").css("z-index", "10");
						}
						i++;
					});

					$(".foodlist").html(menuHtml);
				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
						});
					});
				}
			});
		}, "xml");
		return false;
	}
}

function getTprice() {
	var addPrice	= parseInt($("#add_goods").val());
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice;
	if (addPrice > 0 ) {
		totalPrice		= (addPrice + parseInt($("#price").val())) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty;
		totalPrice		= totalPrice + parseInt(bag_price);
	} else {
		totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + parseInt(bag_price);
	}

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("dietMeal_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if (!$("#set_holiday").val() && $(this).text() == 'setHoliday') {
				window.open("popup/deliveryDate.jsp?devl_date="+ $("#devl_date").val() +"&devl_day="+ $("#devl_day").val() +"&devl_week="+ $("#devl_week").val() +"&gid="+ $("#group_code").val(),'popDelivery','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=960,height=500');
			} else if ($(this).text() == "success") {
				if (t == 'C') {
					$.lightbox("/shop/cartConfirm.jsp?lightbox[width]=960&lightbox[height]=500");
				} else {
					location.href = "order.jsp?mode=L";
				}
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				});
			}
		});
	}, "xml");
	return false;
}

function getGroup(num) {
	$(".ordernum span").removeClass("active");
	$(".ordernum .num"+ num).addClass("active");
	$("#set_holiday").val("");
	var addPrice;
	if (num > 0) {
		addPrice	= 0;
	} else {
		addPrice	= parseInt($("#add_goods").val());
	}
    if (num == 5) {
		$.lightbox("popup/optionPop.jsp?lightbox[width]=784&lightbox[height]=475");
	}	
	
 
	
	$.post("dietMeal_ajax.jsp", {
		mode: 'getGroup',
		gubun2: num + 1
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				var groupOptions	= '<select name="group_code" id="group_code" class="formsel" onchange="selGroup();" style="width:235px;">';
				var i				= 0;
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					groupOptions	+= '<option value="'+ groupArr[0] +'">'+ groupArr[1] +"</option>\n";
					if (i == 0) {
						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#saleTitle").text(groupArr[5]);
						$("#sale_type").val(groupArr[6]);
						$("#sale_price").val(groupArr[7]);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "원");
					}
					i++;
				});
				groupOptions	+= "</select>"
				$("#groupSelect").html(groupOptions);
				$("#group_code").selectBox();
				getSalePrice();
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$(".ordernum span").removeClass("active");
						$("#group_id").val("");
						$("#price").val(0);
						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "원");
					});
				});
			}
			 
			 cngDay();
		});
	}, "xml");
	return false;
}

function selGroup() {
	var addPrice		= parseInt($("#add_goods").val());
	var groupCode	= $("#group_code").val();
	$("#set_holiday").val("");
	$.post("dietMeal_ajax.jsp", {
		mode: 'selGroup',
		group_id: groupCode
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				var groupArr		= "";
				$(data).find("group").each(function() {
					groupArr		= $(this).text().split("|");
					$("#group_id").val(groupArr[0]);
					$("#price").val(groupArr[1]);
					$("#saleTitle").text(groupArr[4]);
					$("#sale_type").val(groupArr[5]);
					$("#sale_price").val(groupArr[6]);
					totalPrice	= getTprice();
					$(".tprice").text(commaSplit(totalPrice)+ "원");
					getSalePrice();
				});
				
				cngDay();
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
						$("#group_id").val("");
					});
				});
			}
		});
	}, "xml");
	return false;
}

function getSalePrice() {
	var groupCode	= $("#group_code").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
	// 특정 상품만 할일 시 적용
	//if (parseInt(salePrice) > 0 && saleType && groupCode == 43) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= (totalPrice - bagPrice) - salePrice * parseInt($("#devl_week").val()) * parseInt($("#devl_day").val()) * buyQty + bagPrice;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "원");
	} else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>