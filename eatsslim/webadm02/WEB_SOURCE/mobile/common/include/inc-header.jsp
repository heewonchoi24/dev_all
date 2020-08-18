<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
		<a class="ui-btn-left ui-btn allmenu iframe" href="/mobile/shop/popup/allmenu.jsp"></a>
		<h1 class="ui-title"><a href="http://www.eatsslim.co.kr/mobile/index.jsp"></a></h1>
		<a class="ui-btn-right ui-btn mypage" href="/mobile/shop/mypage/index.jsp"></a>
		<a class="ui-btn-right ui-btn cart" href="/mobile/shop/cart.jsp">
			<%
			if (!eslMemberId.equals("")) {
				int cartItemCnt		= 0;
				String cQeury		= "";
				Statement cstmt		= null;
				ResultSet crs		= null;
				cstmt				= conn.createStatement();
				cQeury		= "SELECT COUNT(ID) FROM ESL_CART WHERE MEMBER_ID = '"+ eslMemberId +"' AND CART_TYPE = 'C'";
				try {
					crs	= cstmt.executeQuery(cQeury);
				} catch(Exception e) {
					out.println(e+"=>"+cQeury);
					if(true)return;
				}

				if (crs.next()) {
					cartItemCnt			= crs.getInt(1);
				} else {
					cartItemCnt			= crs.getInt(0);
				}

				crs.close();
			%>
			<div class="push"><%=cartItemCnt%></div>
			<%}%>
		</a>
		<div class="ui-navbar ui-bar-a">
			<ul class="ui-grid-d">
				<li class="ui-block-a">
					<a id="home" class="ui-btn ui-btn-inline ui-btn-icon-top ui-btn-up-a<%if (request.getRequestURI().indexOf("mobile/index.jsp") >= 0) out.print(" ui-btn-active");%>" href="http://www.eatsslim.co.kr/mobile/index.jsp">
						<span class="ui-btn-inner">
							<span class="ui-btn-text">메인</span>
							<span class="ui-icon ui-icon-custom"></span>
						</span>
					</a>
				</li>
				<li class="ui-block-b">
					<a id="order" class="ui-btn ui-btn-inline ui-btn-icon-top ui-btn-up-a<%if (request.getRequestURI().indexOf("mobile/customer") >= 0) out.print(" ui-btn-active");%>" href="/mobile/customer/service.jsp">
						<span class="ui-btn-inner">
							<span class="ui-btn-text">상품안내</span>
							<span class="ui-icon ui-icon-custom"></span>
						</span>
					</a>
				</li>
				<li class="ui-block-c">
					<a id="shop" class="ui-btn ui-btn-inline ui-btn-icon-top ui-btn-up-a<%if (request.getRequestURI().indexOf("mobile/shop") >= 0) out.print(" ui-btn-active");%>" href="/mobile/shop/dietMeal.jsp">
						<span class="ui-btn-inner">
							<span class="ui-btn-text">SHOP</span>
							<span class="ui-icon ui-icon-custom"></span>
						</span>
					</a>
				</li>
				<li class="ui-block-d">
					<a id="event" class="ui-btn ui-btn-inline ui-btn-icon-top ui-btn-up-a<%if (request.getRequestURI().indexOf("mobile/event") >= 0) out.print(" ui-btn-active");%>" href="/mobile/event/index.jsp">
						<span class="ui-btn-inner">
							<span class="ui-btn-text">이벤트</span>
							<span class="ui-icon ui-icon-custom"></span>
						</span>
					</a>
				</li>
				<li class="ui-block-e">
					<a id="delivery" class="ui-btn ui-btn-inline ui-btn-icon-top ui-btn-up-a<%if (request.getRequestURI().indexOf("mobile/delivery") >= 0) out.print(" ui-btn-active");%>" href="/mobile/delivery/delivery.jsp">
						<span class="ui-btn-inner">
							<span class="ui-btn-text">배달안내</span>
							<span class="ui-icon ui-icon-custom"></span>
						</span>
					</a>
				</li>
				<div class="clear"></div>
			</ul>
		</div>
		<!-- End ui-navbar -->