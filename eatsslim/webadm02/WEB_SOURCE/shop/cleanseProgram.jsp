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
String where			= " WHERE GUBUN1 = '02' AND GUBUN2 = '28'";
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

	totalPrice		= price + defaultBagPrice;
	//tSalePrice		= (int)Math.round((double)(price) * (double)(100 - 10) / 100) + defaultBagPrice;
	
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
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
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
			<h1>프로그램 다이어트</h1>
			<div class="pageDepth">
				HOME &gt; SHOP &gt; 프로그램 다이어트  &gt; <strong>클렌즈 프로그램</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">클렌즈 프로그램</h3>
				<div class="twothird last col">
					<div class="dietcontent">
						<div class="head" style="padding:25px 0;">
							<p class="f18 bold8">체내 비움과 감량, 병행이 가능한</p>
							<p class="f24 bold8">클렌즈 프로그램</p>
						</div>
						<div style="margin:20px auto 0;">
							<h4>(클렌즈 프로그램 4주 옵션 기준)</h4>
							<p class="marb10"><strong class="selected">① 1일차 : </strong>24시간 쉬지 못하는 우리 몸의 휴식과 비움을 위한 클렌즈 시작(클렌즈 1day) <br />하루 8병의 클렌즈주스로 가볍고 상쾌한 하루를 만들어주며 채소와 과일 퓨레가 포만감을 주어 배고픔을 덜어줍니다.</p>
							<p class="marb10"><strong class="selected">② 감량 단계 : </strong>건강한 신체 유지, 활력있게 감량할 수 있도록 적정량의 탄수화물과 단백질 공급으로 신체의 지방을 태우는 모드로 전환시키는 기간입니다.</p>
							<p class="marb10"><strong class="selected">③ 주말 : </strong>대사작용을 정상으로 돌리기 위한 출발점을 의미하며, 이 기간동안 탄수화물 수치를 낮게 유지하게 됩니다. 특히 이 기간 동안 탄수화물 섭취량을 엄격히 지켜야 하며, 탄수화물에 대한 갈망을 줄이는데 효과를 끼치는 인슐린을 낮게 안정화 시키는 것이 중요합니다. 이 기간 동안 지방과 함께 함유되어 있는 수분의 체중이 빠지면서 높았던 인슐린 수치를 정상화합니다.</p>
							<p class="marb10"><strong class="selected">④ 안정화 단계 : </strong>감량이 한계를 보이는 시기에 단백질 공급량을 유지하면서 탄수화물을 높여, 적은 열량에 인체가 적응하게 되어 대사율이 떨어지는 문제를 방지하는 기간입니다.</p>


					<!--		<p class="marb10">체중감량이나 감량된 체중유지 등 고객이 원하는 목적에 따라, <strong class="f16">다이어트쉐이크/ 다이어트 간편식/ 다이어트식사</strong> 등 다양한 제품 라인업의 섭취 스케쥴을 디자인하여 제공하는 잇슬림의 과학적인 다이어트 프로그램입니다.</p> -->
							<img src="/images/cleanse_program1.jpg" width="640" height="360" alt="클렌즈 프로그램">
						</div>
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
			<input type="hidden" name="gubun2" id="gubun2" value="28" />
			<input type="hidden" name="gubun3" id="gubun3" value="2" />
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<input type="hidden" name="set_holiday" id="set_holiday" />
			<input type="hidden" name="sale_type" id="sale_type" value="<%=saleType%>" />
			<input type="hidden" name="sale_price" id="sale_price" value="<%=salePrice%>" />
			<input type="hidden" name="bag_price" id="bag_price" value="<%=defaultBagPrice%>" />
			<div class="sidebar five columns">
				<h3 class="marb20">주문하기</h3>
				<div class="sideorder">
					<div class="title">주문 STEP (매일 배달)</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>배송가능지역 검색<br /><font style="font-weight:normal; color:#777;">배송이 가능한 지역인지 확인</font></p>
								<div class="button small dark"><a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">검색</a></div>
							</li>
							<li>
								<span class="badge">2</span>
								<p>프로그램 진행 기간
								<!--  </p>
								<div class="ordernum">
									<span class="last active"><a class="ordernum-4week" href="javascript:;"></a>4주</span>    -->
									<select name="devl_week" id="devl_week" style="width:100px;">
										<option value="27">1주</option>
										<option value="28" selected="selected">2주</option>
										<option value="29">4주</option>
									</select>	
								
								</p>
								<div class="clear"></div>
							</li>
							<li>
								<span class="badge">3</span>
								<p class="floatleft">첫 배송일 지정</p>
								<div class="floatright">
									<input id="devl_date" class="dp-applied date-pick" name="devl_date" readonly />
								</div>	
								<div class="clear"></div>
							<li>
								<span class="badge">4</span>
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
					<font name="saleTitle" id="saleTitle" style="font-weight:bold; color:blue;"><%=saleTitle%></font>
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
						<p><img src="/images/cleanse_program2.jpg"></p>
						<!-- <%=groupInfo%> -->
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
						<!-- <%=offerNotice%>  -->
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
					</ul>
					<div id="detail-notify">
                    <table class="orderList clear" width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th>구분</th>
							<th class="last">내용</th>
						</tr>
						<tr>
							<td>식품의 유형</td>
							<td style="text-align:left;"><span class="font-blue">알라까르떼, 퀴진 : </span>즉석섭취식품 / <span class="font-blue">잇슬림미니밀 : </span>즉석조리식품 / <span class="font-blue">밸런스쉐이크 : </span>체중조절용조제식품</td>
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
						  <td style="text-align:left;">각 끼니별 35g ~ 600g</td>
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
		onDate: $.datepick.noWeekends,
		showTrigger: '#calImg'
	});

	$(".plus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	$(".minus").click(function() {
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
		var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
	$("#buy_bag").click(function() {
		totalPrice	= getTprice();
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	
	$("#devl_week").change(function() {

		/*
		if ( parseInt($("#devl_week").val()) == 1 ) {
			$("#price").val(12000);
		} else if ( parseInt($("#devl_week").val()) == 2 ) {
			$("#price").val(20000);
		} else {
			$("#price").val(40000);
		}
		*/
		
		$.post("cleanseProgram_ajax.jsp", {
			mode: 'getGroup',
			gubun2: $("#devl_week").val()
		},
		function(data) {
			$(data).find("result").each(function() {
				if ($(this).text() == "success") {
					var groupArr		= "";
					$(data).find("group").each(function() {
						groupArr			= $(this).text().split("|");

						$("#group_id").val(groupArr[0]);
						$("#price").val(groupArr[2]);
						$("#gubun3").val(groupArr[4]);
						$("#saleTitle").text(groupArr[5]);
						$("#sale_type").val(groupArr[6]);
						$("#sale_price").val(groupArr[7]);

						totalPrice	= getTprice();
						$(".tprice").text(commaSplit(totalPrice)+ "원");
						getSalePrice();
					});
				} else {
					$(data).find("error").each(function() {
						$(data).find("error").each(function() {
							alert($(this).text());
							$("#price").val(0);
							totalPrice	= getTprice();
							$(".tprice").text(commaSplit(totalPrice)+ "원");
						});
					});
				}
				 
			});
		}, "xml");
		
		//totalPrice	= getTprice();
		//$(".tprice").text(commaSplit(totalPrice)+ "원");
		//getSalePrice();	
	
	});
});

function getTprice() {
	var buyQty		= parseInt($("#buy_qty").val());
	var bag_price	= ($("#buy_bag").is(":checked"))? parseInt($("#bag_price").val()) * buyQty : 0;
	var totalPrice	= parseInt($("#price").val()) * buyQty + parseInt(bag_price);

	return totalPrice;
}

function addCart(t) {
	$("#cart_type").val(t);
	$.post("keepProgram_ajax.jsp", $("#frm_order").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if (!$("#set_holiday").val() && $(this).text() == 'setHoliday') {
				window.open("popup/deliveryDate.jsp?devl_date="+ $("#devl_date").val() +"&devl_day=5&devl_week="+ $("#gubun3").val() +"&gid="+ $("#group_id").val(),'popDelivery','resizable=no,scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,width=960,height=500');
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
			salePrice	= (totalPrice - bagPrice) - salePrice * buyQty + bagPrice;
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