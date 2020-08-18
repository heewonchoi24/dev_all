<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<div class="headerWrapper">
	<div class="top-menu">
		<ul>
			<%if (eslMemberId.equals("")) {%>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">로그인</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">회원가입</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">장바구니</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">주문내역조회</a></li>
			<%} else {%>
			<li><a href="/sso/logout.jsp">로그아웃</a></li>
			<li><a href="/shop/cart.jsp">장바구니</a></li>
			<li><a href="/shop/mypage/orderList.jsp">주문내역조회</a></li>
			<%}%>
			<li><a href="/customer/notice.jsp">고객센터</a></li>
			<li class="last">
				<%if (eslMemberId.equals("")) {%>
				<a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">마이잇슬림</a>
				<%} else {%>
				<a href="/shop/mypage/index.jsp">마이잇슬림</a>
				<%}%>
			</li>
		</ul>
		<div class="clear"></div>
	</div>
	<!-- End top-menu-->
	<div class="logo">
		<a href="/index.jsp"></a>
	</div>
	<div id="menu">
		<ul id="dropline">
			<li class="top<%if (request.getRequestURI().indexOf("/shop") >= 0 && request.getRequestURI().indexOf("/shop/mypage") < 0) out.print(" current");%>"><a class="down" href="/shop/orderGuide.jsp"><span class="m01"></span>SHOP</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/shop/orderGuide") >= 0) out.print(" class=\"current\"");%>><a href="/shop/orderGuide.jsp">상품안내</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/dietMeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/dietMeal.jsp">식사 다이어트</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/reductionProgram") >= 0 || request.getRequestURI().indexOf("/shop/keepProgram") >= 0 || request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/reductionProgram.jsp">프로그램 다이어트</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/reductionProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/reductionProgram.jsp">감량 프로그램</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/keepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/keepProgram.jsp">유지 프로그램</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/fullstepProgram.jsp">FULL-STEP 프로그램</a></li>
						</ul>
					</li>
					<li<%if (request.getRequestURI().indexOf("/shop/secretSoup") >= 0 || request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSoup.jsp">타입별 다이어트</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/secretSoup") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSoup.jsp">시크릿수프</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/balanceShake.jsp">밸런스 쉐이크</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/intro") >= 0) out.print(" current");%>"><a class="down" href="/intro/eatsslimStory.jsp"><span class="m02"></span>잇슬림 소개</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimStory") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimStory.jsp">잇슬림 스토리</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimFeature") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimFeature.jsp">잇슬림 특징</a></li>
                    <li<%if (request.getRequestURI().indexOf("/intro/lowgldiet") >= 0) out.print(" class=\"current\"");%>><a href="/intro/lowgldiet.jsp">Low GL Diet</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCounsel2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCounsel2.jsp">자문단 소개</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCkitchen2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCkitchen2.jsp">스마트 키친</a></li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/goods") >= 0) out.print(" current");%>"><a class="down" href="/goods/cuisine.jsp"><span class="m03"></span>제품소개</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/goods/cuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/cuisine.jsp">퀴진</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/alacarte") >= 0) out.print(" class=\"current\"");%>><a href="/goods/alacarte.jsp">알라까르떼</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/secretSoup") >= 0) out.print(" class=\"current\"");%>><a href="/goods/secretSoup.jsp">시크릿수프</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/goods/balanceShake.jsp">밸런스쉐이크</a></li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/colums") >= 0) out.print(" current");%>"><a class="down" href="/colums/dietColum.jsp"><span class="m06"></span>GO! 다이어트</a>
				<ul class="sub" style="margin-left:300px;width:300px;">
					<li<%if (request.getRequestURI().indexOf("/colums/dietColum") >= 0) out.print(" class=\"current\"");%>><a href="/colums/dietColum.jsp">다이어트 칼럼</a></li>
					<!--li<%if (request.getRequestURI().indexOf("/colums/postScript") >= 0) out.print(" class=\"current\"");%>><a href="/colums/postScript.jsp">다이어트 체험후기</a></li-->
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/event") >= 0) out.print(" current");%>"><a class="down" href="/event/currentEvent.jsp"><span class="m05"></span>이벤트</a>
				<ul class="sub floatRight">
					<!--li<%if (request.getRequestURI().indexOf("/event/choi") >= 0) out.print(" class=\"current\"");%>><a href="/event/choiPost.jsp">최과장이 쏘는 잇슬림 후기</a></li-->
					<li<%if (request.getRequestURI().indexOf("/event/lastEvent") >= 0) out.print(" class=\"current\"");%>><a href="/event/lastEvent.jsp">지난 이벤트</a></li>
					<li<%if (request.getRequestURI().indexOf("/event/currentEvent") >= 0) out.print(" class=\"current\"");%>><a href="/event/currentEvent.jsp">진행중인 이벤트</a></li>
				</ul>
			</li>
			<li class="top last<%if (request.getRequestURI().indexOf("/delivery") >= 0) out.print(" current");%>"><a class="down" href="/delivery/freshparcel.jsp"><span class="m04"></span>배달안내</a>
				<ul class="sub floatRight">
					<li<%if (request.getRequestURI().indexOf("/delivery/delivery") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/delivery.jsp">배달지역 안내</a></li>
					<li<%if (request.getRequestURI().indexOf("/delivery/parcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/parcel.jsp">택배배달</a></li>
					<li<%if (request.getRequestURI().indexOf("/delivery/freshparcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/freshparcel.jsp">극신선 일일배달</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="shipping-search">
		<a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">배달 가능 지역을 먼저 검색하세요!</a>
	</div>
</div>
<!-- End headerWrapper --> 