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
String groupCode	= "";
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
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '31'";
String sort				= " ORDER BY ID DESC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price * 6 + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price * 6) * (double)(100 - 10) / 100) + defaultBagPrice;
	
	String where1			= " WHERE  ('"+today+"' BETWEEN STDATE AND LTDATE) AND (GROUP_CODE = '"+groupCode+"'  or GROUP_CODE is null) ";
	String sort1			=  " ORDER BY ES.ID DESC";
	query		= "SELECT TITLE, SALE_TYPE, SALE_PRICE, USE_GOODS FROM ESL_SALE ES LEFT JOIN ESL_SALE_GOODS ESG ON ES.ID = ESG.SALE_ID " + where1 + sort1 + " LIMIT 0, 1";
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
<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
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
            <h1>간편식</h1>
            <div class="pageDepth">
                HOME &gt; SHOP &gt; 타입별 다이어트 &gt; <strong>시크릿수프</strong>
            </div>
            <div class="clear"></div>
        </div>
        <div class="eleven columns offset-by-one ">
            <div class="row">
                <h3 class="marb20">잇슬림 타입별 다이어트</h3>
                <ul class="quizintab_">
                    <li class="quizinA" style="z-index:0">
						<a href="minimeal.jsp"></a>
                    </li>
                    <li class="alaCool current">
						<a href="secretSoup.jsp"></a>
                    </li>
                </ul>
                <div class="twothird last col" style="width:606px !important; float:right;">
                    <div class="dietcontent">
                        <div class="head">
                            <p class="f18 bold8">6가지 채소의</p>
                            <p class="f24 bold8">시크릿수프(Hot)</p>
                            <div class="balloon"><img src="/images/balloon-100cal.png" width="67" height="83"></div>
                        </div>
                        <p class="mart20 marb20"><strong class="f14">6가지 비법재료와</strong> 식이섬유 콜라겐을 더한<strong class="f14">홈메이드 타입의 수프!</p>
                        <div class="marb10"><img src="/images/secretsoup2.jpg" width="637" height="314"></div>
                        <ul class="ssoup-list">
                            <li style="width:187px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=62">
                            <img src="/images/ssoup_01_01.jpg" width="185" height="139" alt="이집트콩토마토풍기니">
                            <p>이집트콩토마토풍기니</p>
                            </a>
                            </li>
                            </a>
                            <li style="width:186px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=63">
                            <img src="/images/ssoup_02_01.jpg" width="185" height="139" alt="레드빈율무">
                            <p>레드빈율무</p>
                            </a>
                            </li>
                            <li class="last" style="width:187px !important;">
                            <a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=64">
                            <img src="/images/ssoup_03_01.jpg" width="185" height="139" alt="닭가슴살미역곤약">
                            <p>닭가슴살미역곤약</p>
                            </a>
                            </li>
                            <div class="clear"></div>
                        </ul>
                        <div class="clear"></div>
                    </div>
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
        <input type="hidden" name="devl_day" id="devl_day" value="6" />
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
                        <div class="button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">검색</a></div>
                        </li>
                        <li>
                        <span class="badge">2</span>
                        <p>배송 스타일을 선택</p>
                        <select name="ss_type" id="ss_type" style="width:160px;">
                        <option value="0">매일(월~토)-총12개/주</option>
                        <option value="1">주3회(월수금)-총6개/주</option>
                        <option value="2">주3회(화목토)-총6개/주</option>
                        </select>
                        </li>
                        <li>
                        <span class="badge">3</span>
                        <p>배송기간 선택</p>
                        <span id="type_sel">
                        <select name="devl_week" id="devl_week" style="width:130px;" onChange="setTprice();">
                        <option value="1">1주</option>
                        <option value="2">2주</option>
                        <option value="4">4주</option>
                        </select>
                        </span>
                        </li>
                        <li>
                        <span class="badge">4</span>
                        <p class="floatleft">첫 배송일 지정</p>
                        <div class="floatright">
                            <input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
                        </div>
                        <div class="clear"></div>
                        </li>
                        <li>
                        <span class="badge">5</span>
                        <p class="floatleft">수량</p>
                        <div class="quantity floatright">
                            <input class="minus" type="button" value="-" />
                            <input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
                            <input class="plus" type="button" value="+" />
                        </div>
                        <div class="clear"></div>
                        </li>
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
                <font style="font-weight:bold; color:blue;"><%=saleTitle%></font>
                <p class="price">
                총가격:
                <span id="saleDiv" class="hidden">
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
                <div class="button large light"><a href="javascript:;" onClick="addCart('C');">장바구니</a></div>
                <div class="button large dark iconBtn"><a href="javascript:;" onClick="addCart('L');"><span class="star"></span>바로구매</a></div>
                <%}%>
                <div class="clear"></div>
            </div>
        </div>
        </form>
        <!-- End sidebar four columns -->
        <div class="divider"></div>
        <div class="sixteen columns offset-by-one">
            <!--div class="row col grayhalf">
				<h4 class="font-blue marb10">제품리뷰</h4>
				<div class="oneinhalf">
					<a href="#" title="잇슬림으로 다이어트 도전">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[공지]잇슬림 퀴진 변경안내 (불고기 비빔밥)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>잇슬림으로 다이어트 도전</h3>
							<p>안녕하세요. 잇슬림입니다. 잇슬림의 점심메뉴인 "불고기비빔밥"이 5월 30일(목) 제공분부터 "비빔밥"으로 변경 제공될 예정입니다. 신선한 메뉴 제공을 위해 변경 제공되오니...</p>
						</span>
					</a>
				</div>
				<div class="oneinhalf last">
					<a href="#" title="잇슬림으로 다이어트 도전">
						<img class="thumbleft" src="/images/notice_sample.jpg" width="160" height="108" title="[공지]잇슬림 퀴진 변경안내 (불고기 비빔밥)" />
						<span class="meta"><strong>POST BY</strong> hong1004</span>
						<span class="post-title">
							<h3>잇슬림으로 다이어트 도전</h3>
							<p>안녕하세요. 잇슬림입니다. 잇슬림의 점심메뉴인 "불고기비빔밥"이 5월 30일(목) 제공분부터 "비빔밥"으로 변경 제공될 예정입니다. 신선한 메뉴 제공을 위해 변경 제공되오니...</p>
						</span>
					</a>
				</div>
				<div class="clear"></div>
			</div-->
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
                      <!--  <p class="marb40"><img src="/images/detail_tit.gif" alt="상세정보" width="296" height="65"></p> -->
                        <p><img src="/images/detail_sample_soup2.jpg"></p>
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
                            <td style="text-align:left;">즉석조리식품</td>
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
                            <td style="text-align:left;">9일</td>
                        </tr>
                        <tr>
                            <td>원재료 및 함량</td>
                            <td style="text-align:left;">식단의 요일별 메뉴를 클릭하시면 요리별 원재료 및 함량을 확인하실 수 있습니다.</td>
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
                            <td style="text-align:left;">풀무원 고객기쁨센터 080-022-0085(수신자부담)</td>
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
getSalePrice();

$(".date-pick").datepick({
dateFormat: "yyyy.mm.dd",
minDate: +6,
onDate: $.datepick.noSundays,
showTrigger: '#calImg'
});
$("a").attr("onfocus", "this.blur()");
$("#ss_type").change(cngWeek);
$(".plus").click(function() {
var devl_day	= $("#devl_day").val();
var buyQty		= parseInt($("#buy_qty").val());
if (buyQty < 9) buyQty		+= 1;
var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
$("#buy_qty").val(buyQty);
$(".tprice").text(commaSplit(totalPrice)+ "원");
getSalePrice();
});
$(".minus").click(function() {
var devl_day	= $("#devl_day").val();
var buyQty		= parseInt($("#buy_qty").val());
if (buyQty > 1) buyQty		= buyQty - 1;
var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);
$(".tprice").text(commaSplit(totalPrice)+ "원");
$("#buy_qty").val(buyQty);
getSalePrice();
});
$("#buy_bag").click(setTprice);
});

(function($) {
$.extend($.datepick, {
noSundays: function(date) {
return {selectable: date.getDay() != 0};
},
noOdd: function(date) {
return {selectable: date.getDay() != 0 && date.getDay() != 1 && date.getDay() != 3 && date.getDay() != 5};
},
noEven: function(date) {
return {selectable: date.getDay() != 0 && date.getDay() != 2 && date.getDay() != 4 && date.getDay() != 6};
}
});
})(jQuery);

function getTprice() {
	var devl_day	= $("#devl_day").val();
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * parseInt($("#devl_week").val()) * parseInt(devl_day) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function setTprice() {
	totalPrice	= getTprice();
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function cngWeek() {
	var devlType		= $("#ss_type").val();
	var typeOptions	= '<select name="devl_week" id="devl_week" style="width:130px;" onchange="setTprice();">';
	$(".date-pick").datepick('clear');
	$(".date-pick").datepick('destroy');
	if (devlType == "0") {
		typeOptions	+= '<option value="1">1주</option>';
		typeOptions	+= '<option value="2">2주</option>';
		typeOptions	+= '<option value="4">4주</option>';
		$(".date-pick").datepick({
		dateFormat: "yyyy.mm.dd",
		minDate: +6,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
		});
	}
	else {
		typeOptions	+= '<option value="1">2주</option>';
		typeOptions	+= '<option value="2">4주</option>';
		typeOptions	+= '<option value="4">8주</option>';
		if (devlType == "1") {
			$(".date-pick").datepick({
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noEven,
			showTrigger: '#calImg'
			});
		}
		else {
			$(".date-pick").datepick({
			dateFormat: "yyyy.mm.dd",
			minDate: +6,
			onDate: $.datepick.noOdd,
			showTrigger: '#calImg'
			});
		}
	}

	typeOptions	+= "</select>"
	$("#type_sel").html(typeOptions);
	$("#devl_week").selectBox();
	setTprice();
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("secretSoup_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
	$(data).find("result").each(function() {
	if ($(this).text() == "success") {
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

function getSalePrice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bagPrice	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= getTprice();
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			if ( $("#ss_type").val() == "0" ) {
				salePrice	= (totalPrice - bagPrice) - salePrice * parseInt($("#devl_week").val()) * 6 * buyQty + bagPrice;
			} else { 
				salePrice	= (totalPrice - bagPrice) - salePrice * parseInt($("#devl_week").val()) * 6 * buyQty + bagPrice;
			}
			
			
		}
		else {
			salePrice	= Math.round(parseFloat(totalPrice - bagPrice) * (100 - parseFloat(salePrice)) / 100) + bagPrice;
		}
		$("#sprice").text(commaSplit(salePrice)+ "원");
	}
	else {
		$("#saleDiv").addClass("hidden");
		$("#nosaleDiv").removeClass("hidden");
	}
}
</script>
</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>
