<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
String groupName		= "";
int price				= 0;
int tSalePrice			= 0;
String groupInfo		= "";
String offerNotice		= "";
int categoryId			= 0;
String categoryName		= "";
NumberFormat nf = NumberFormat.getNumberInstance();

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '03' AND GUBUN2 = '32'";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");

	//tSalePrice		= (int)Math.round((double)(price) * (double)(100 - 10) / 100);
}

rs.close();
pstmt.close();
%>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>밸런스 쉐이크</h1>
			<div class="pageDepth">
				HOME > SHOP > 타입별 다이어트 > <strong>밸런스 쉐이크</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="eleven columns offset-by-one ">
			<div class="row">
				<h3 class="marb20">잇슬림 밸런스쉐이크</h3>
				<div class="twothird last col">
					<div class="dietcontent">
						<div class="head">
							<p class="f18 bold8">칼로리는 낮추고 영양은 채운 체중조절용 식품</p>
							<p class="f24 bold8">밸런스 쉐이크</p>
                        <div class="balloon"><img src="/images/balloon-125cal.png" width="67" height="83"></div>    
						</div>
						<div class="center">
                          <p class="mart20"><img src="/images/balanceshake.jpg" width="638" height="207" /></p>
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
			<input type="hidden" name="price" id="price" value="<%=price%>" />
			<input type="hidden" name="sale_type" id="sale_type" value="P" />
			<input type="hidden" name="sale_price" id="sale_price" value="20" />
			<div class="sidebar five columns">
				<h3 class="marb20">주문하기</h3>
				<div class="sideorder">
					<div class="title">메인제품 선택</div>
					<div class="itembox">
						<ul class="badgecount">
							<li>
								<span class="badge">1</span>
								<p>제품선택</p>
                                <div id="groupSelect">
									<select name="select" id="select" style="width:230px;">
										<option value="<%=groupId%>"><%=groupName%></option>
									</select>
                                </div>    
							</li>
							<li>
								<span class="badge">2</span>
								<p class="floatleft">수량</p>
								<div class="quantity floatright" style="width:140px;">
									<input class="minus" type="button" value="-" />
									<input class="input-text qty text" maxlength="2" title="Qty" size="4" value="1" data-max="0" data-min="1" name="buy_qty" id="buy_qty" readonly />
									<input class="plus" type="button" value="+" />
								</div>
								<div class="clear"></div>
							</li>
						</ul>
					</div>
				</div>
				<div class="divider"></div> 
				<div class="price-wrapper">
					<font style="font-weight:bold; color:blue;">추석은 풍요롭게, 지금 주문하고 추석뒤부터는 다이어트 시작! 특별할인(~9/5)</font>
					<p class="price">
						총가격:
						<span id="saleDiv" class="hidden">
							<del>
								<span class="amount tprice"><%=nf.format(price)%>원</span>
							</del>
							<ins>
								<span class="amount" id="sprice"><%=nf.format(tSalePrice)%>원</span>
							</ins>
						</span>
						<span id="nosaleDiv">
							<ins>
								<span class="amount tprice"><%=nf.format(price)%>원</span>
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
						<p class="marb40"><img src="/images/detail_sample_shake.jpg" alt="상세정보"></p>
          <!--p><img src="/images/detail_sample.jpg" width="999" height="472"></p-->
						<%=groupInfo%>
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
						<p><img src="/images/dietmeal_detail_02_2.jpg"></p>
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
							<td style="text-align:left;">체중조절용조제식품</td>
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
						  <td style="text-align:left;"><span class="font-maple">※ 주문이후 각 생산공장에서 가장 최근에 생산된 제품을 준비하여신속히 배송하므로,<br />정확한 제조년월일 안내가 어렵습니다.</span></td>
						  <!--<td style="text-align:left;">수령일 기준, 2일전 생산된 제품이 배달됩니다.<br /><span class="font-maple">※ 주문이후 각 생산공장에서 가장 최근에 생산된 제품을 준비하여<br />신속히 배송하므로, 정확한 제조년월일 안내가 어렵습니다.</span></td>-->
						  </tr>
						<tr>
						  <td>유통기한</td>
						  <td style="text-align:left;">365일</td>
						  </tr>
                         <tr>
						  <td>중량 및 구성</td>
						  <td style="text-align:left;">35g*14개입</td>
						  </tr> 
						<tr>
						  <td>원재료 및 함량</td>
						  <td style="text-align:left;">유청단백분말(우유, 미국), 팔라티노스, 팽화미분 9.69%(백미, 국산), 볶은현미분말 7.23%(현미, 국산),<br />
                          볶은보리분말 6.17%(보리, 국산), 볶은통밀분말 5.66%(통밀, 국산), 볶은대두분말 5.43%(대두, 국산),<br />
                          볶은쌀가루 5.31%(백미, 국산), 아가베이눌린, 볶은검은콩분말 4.00%(검은콩, 국산), 현미퍼핑 2.57%(현미, 국산),<br />
                          식이섬유(밀), 가르시니아캄보지아추출분말, 볶은검은깨분말 1.90%(검은깨, 중국산), 멀티비타민미네랄믹스<br />
                          (비타민A혼합제제, B1, B2, B6, C, E혼합제제, 나이아신, 염산, 해조칼슘, 푸마르산제일철, 산화아연), 카테킨,<br />치커리뿌리분말, 분말유산균</td>
						  </tr>
						<tr>
						  <td>섭취량, 섭취방법,<br />섭취시 주의사항</td>
						  <td style="text-align:left;">* 본 제품은 섭취자의 신체 상태에 따라 반응에 차이가 있을 수 있습니다.<br />* 알레르기 체질이신 경우 성분을 확인하신 후 섭취하여 주시기 바랍니다.</td>
						  </tr>
						<tr>
						  <td>유전자재조합식품 여부</td>
						  <td style="text-align:left;">해당사항 없음</td>
						  </tr>
						<tr>
                        <tr>
						  <td>표시광고 사전심의여부</td>
						  <td style="text-align:left;">표시광고 사전심의 필함</td>
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

	$(".plus").click(function() {
		var totalPrice	= 0;
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty < 9) buyQty		+= 1;
		totalPrice	= parseInt($("#price").val()) * buyQty;
		$("#buy_qty").val(buyQty);
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		getSalePrice();
	});
	$(".minus").click(function() {
		var totalPrice	= 0;
		var buyQty		= parseInt($("#buy_qty").val());
		if (buyQty > 1) buyQty		= buyQty - 1;
		totalPrice	= parseInt($("#price").val()) * buyQty;		
		$(".tprice").text(commaSplit(totalPrice)+ "원");
		$("#buy_qty").val(buyQty);
		getSalePrice();
	});
});

function addCart(t) {
	$("#cart_type").val(t);
	$.post("balanceShake_ajax_test.jsp", $("#frm_order").serialize(),
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
			salePrice	= totalPrice - salePrice;
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