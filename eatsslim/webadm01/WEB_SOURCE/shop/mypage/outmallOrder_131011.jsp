<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div> <!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				타쇼핑몰 주문확인
			</h1>
			<div class="pageDepth">
				HOME > <strong>타쇼핑몰 주문확인</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<div class="graytitbox orderSearch center">
							<p class="marb10">다른 쇼핑몰에서 구매하신 배송정보가 궁금하시면 이곳에서 조회하실 수 있습니다.</p>
                            <label>
								<select name="select" id="select" style="width:130px;">
									<option>주문번호</option>
									<option>핸드폰번호</option>
								</select>
							</label>
							<label>
							<input type="text" name="textfield" id="textfield">
							</label>
							<label>
							<input type="submit" class="button dark small" name="button" value="조회">
							</label>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
						<table class="orderList" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>주문일자/주문번호</th>
								<th class="none">배송구분</th>
								<th>상품명</th>
								<th class="none">수량</th>
								<th>정상금액</th>
								<th>결제금액</th>
								<th>주문상태</th>
								<th class="last">주문조회</th>
							</tr>
							<tr>
								<td>2013.08.01<a class="orderNum" href="/shop/mypage/orderInfo.jsp">A2013080138441</a></td>
								<td><div class="shipping font-blue">
										일배
									</div></td>
								<td><div class="orderName">
										<a href="#">다이어트식사 3식
										<p class="option">
											(퀴진A+퀴진B)
										</p>
										</a>
									</div></td>
								<td><div>
										1
									</div></td>
								<td><div>
										104,400원
									</div></td>
								<td><div>
										104,400원
									</div></td>
								<td><div class="font-maple">
										결제완료
									</div></td>
								<td><div class="button light small">
										<a class="lightbox" href="/shop/popup/deliveryinfo.jsp?lightbox[width]=800&lightbox[height]=550">배송조회</a>
									</div>
									<div class="button light small">
										<a class="lightbox" href="/shop/popup/foodschedule.jsp?lightbox[width]=850&lightbox[height]=550">식단확인</a>
									</div></td>
							</tr>
							<tr>
								<td>2013.08.01<a class="orderNum" href="/shop/mypage/orderInfo.jsp">A2013080138441</a></td>
								<td><div class="shipping font-blue">
										일배
									</div>								</td>
								<td><div class="orderName">
										<a href="#">밸런스쉐이크(BOX)</a>
									</div></td>
								<td><div>
										1
									</div></td>
								<td><div>
										84,400원
									</div></td>
								<td><div>
										84,400원
									</div></td>
								<td><div class="font-maple">
										상품준비중
									</div></td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="8">주문번호 또는 핸드폰번호를 입력하시면 주문하신 내역을 확인하실 수 있습니다.</td>
							</tr>
						</table>
					<!-- End orderList -->
				</div>
			</div>
			<!-- End row -->
			<div class="row">
				<div class="one last  col">
					<div class="pageNavi">
						<a class="latelypostslink" href="#"><<</a> <a class="previouspostslink" href="#"><</a>
						<span class="current">
						1
						</span>
						<a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a class="firstpostslink" href="#">></a> <a class="nextpostslink" href="#">>></a>
					</div>
				</div>
			</div>
		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear">
		</div>
	</div>
	<!-- End container -->
	<div id="footer">		
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div> <!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
	<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
</body>
</html>