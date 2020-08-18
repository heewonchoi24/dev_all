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
String where			= " WHERE GUBUN1 = '03' AND GUBUN2 = '33' AND USE_YN = 'Y'";
String sort				= " ORDER BY ID ASC";

query		= "SELECT ID, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM "+ table + where + sort + " LIMIT 0, 1";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");

	totalPrice		= price * 2;
	
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
                HOME &gt; SHOP &gt; 타입별 다이어트 &gt; <strong>잇슬림 미니밀</strong>
            </div>
            <div class="clear"></div>
        </div>
        <div class="eleven columns offset-by-one ">
            <div class="row">
                <h3 class="marb20">잇슬림 타입별 다이어트</h3>
                <ul class="quizintab_">
                    <li class="quizinA current">
						<a href="minimeal.jsp"></a>
                    </li>
                    <li class="alaCool">
						<a href="secretSoup.jsp"></a>
                    </li>
                </ul>
                <div class="twothird last col" style="width:606px !important; float:right;">
                    <div class="dietcontent">
                        <div class="head">
                            <p class="f18 bold8">칼로리 걱정없이 기분좋은 든든함</p>
                            <p class="f24 bold8">잇슬림 미니밀</p>
                            <div class="balloon"><img src="/images/balloon-200cal.png" width="67" height="83"></div>
                        </div>
                        <p class="mart20 marb20">한손에 쏙, 간편하게 즐기는 미니컵밥!</p>
                        <div class="marb10"><img src="/images/minimeal.jpg" width="637" height="314"></div>
                        <ul class="ssoup-list">
                            <li style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=120">
									<img src="/images/meal_01_01.jpg" width="185" height="139" alt="매운한돈우엉밥">
									<p>매운한돈우엉밥</p>
								</a>
                            </li>
                            <li style="width:186px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=121">
									<img src="/images/meal_02_01.jpg" width="185" height="139" alt="고구마찜닭흑미덮밥">
									<p>고구마찜닭흑미덮밥</p>
								</a>
                            </li>
                            <li class="last" style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=124">
									<img src="/images/meal_03_01.jpg" width="185" height="139" alt="소고기마파두부보리밥">
									<p>소고기마파두부보리밥</p>
								</a>
                            </li>
                            <div class="clear"></div>
                        </ul>
                        <ul class="ssoup-list">
							<li style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=122">
									<img src="/images/meal_04_01.jpg" width="185" height="139" alt="녹차현미삼계리조또">
									<p>녹차현미삼계리조또</p>
								</a>
							</li>
							<li style="width:186px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=123">
									<img src="/images/meal_05_01.jpg" width="185" height="139" alt="레드퀴노아연두부게살리조또">
									<p>레드퀴노아연두부게살리조또</p>
								</a>
							</li>
							<li class="last" style="width:187px !important;">
								<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=550&set_id=119">
									<img src="/images/meal_06_01.jpg" width="185" height="139" alt="양송이버섯귀리리조또">
									<p>양송이버섯귀리리조또</p>
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
			<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
			<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
			<input type="hidden" name="buy_qty" id="buy_qty" value="2" />
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
								<p>배달 메뉴 및 수량 선택</p>
								<div class="quantity" style="margin:3px 0 5px 0;">
									<span>한식 세트(A)</span>
									<input class="minus" type="button" value="-" onclick="setMinus(1);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty1" id="buy_qty1" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(1);" />
								</div>
								<div class="quantity">
									<span>양식 세트(B) </span>
									<input class="minus" type="button" value="-" style="margin-left:2px;" onclick="setMinus(2);" />
									<input class="input-text qty text" maxlength="1" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty2" id="buy_qty2" readonly />
									<input class="plus" type="button" value="+" onclick="setPlus(2);" />
								</div>
								<div class="order_menu">
									<div class="hanset">
										<span class="tit" style="font-weight:bold;">한식세트 구성</span>
										<span>· 매운한돈우엉덮밥</span>
										<span>· 녹차현미삼계리조또</span>
										<span>· 고구마찜닭흑미덮밥</span>
									</div>
									<div class="yangset">
										<span class="tit" style="font-weight:bold;">양식세트 구성</span>
										<span>· 레드퀴노아연두부게살<br>&nbsp;&nbsp;리조또</span>
										<span>· 소고기마파두부보리밥</span>
										<span>· 양송이버섯귀리리조또</span>
									</div>
								</div>
								<p style="color:#623a1e; font-weight:bold;">
									<br />
									최소 주문은 2Set부터 가능합니다.
								</p>
								<div class="clear"></div>
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
                <!--        <p class="marb40"><img src="/images/detail_tit.gif" alt="상세정보" width="296" height="65"></p>  -->
                        <p><img src="/images/detail_sample_meal.jpg"></p>
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
                        <p><img src="/images/dietmeal_detail_02_3.jpg"></p>
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
	getSalePrice();
	$("a").attr("onfocus", "this.blur()");	
});

function setPlus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty < 9) buyQty		+= 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function setMinus(obj) {
	var totalPrice	= 0;	
	var buyQty		= parseInt($("#buy_qty"+ obj).val());
	if (buyQty > 0) buyQty		= buyQty - 1;
	$("#buy_qty"+ obj).val(buyQty);
	var tcnt	= setTcnt();
	if (tcnt < 2) {
		alert("최소 주문은 2Set부터 가능합니다.");
		$("#buy_qty"+ obj).val(buyQty + 1);
	}

	tcnt	= setTcnt();
	var totalPrice	= parseInt($("#price").val()) * tcnt;
	$(".tprice").text(commaSplit(totalPrice)+ "원");
	getSalePrice();
}

function setTcnt() {
	var tcnt	= parseInt($("#buy_qty1").val()) + parseInt($("#buy_qty2").val());
	$("#buy_qty").val(tcnt);

	return tcnt;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("minimeal_ajax.jsp", $("#frm_order").serialize(),
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
	var salePrice	= $("#sale_price").val();
	var saleType	= $("#sale_type").val();
	var totalPrice	= parseInt($("#price").val()) * buyQty;
	if (parseInt(salePrice) > 0 && saleType) {
		$("#saleDiv").removeClass("hidden");
		$("#nosaleDiv").addClass("hidden");
		if (saleType == "W") {
			salePrice	= totalPrice - salePrice * buyQty;
		} else {
			salePrice	= Math.round(parseFloat(totalPrice) * (100 - parseFloat(salePrice)) / 100);
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
