<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%-- <a class="ui-btn-left ui-btn allmenu iframe" href="/mobile/shop/popup/allmenu.jsp"></a>
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
			<%}%> --%>
	<input type="hidden" id="cartCount" value="2">
	<input type="hidden" id="dpValue" value="">
		<!-- <div id="header">
			<div class="header_inner">
				<span class="h100"></span>
				<div class="logo"><a href="/mobile/index.jsp"><img src="/mobile/common/images/common/m_logo.png" alt=""></a></div>
				<div class="gnb">
					<ul>
						<li><a href="/mobile/shop/mypage/index.jsp"><img src="/mobile/common/images/common/m_ico_mypage.png" alt=""></a></li>
					</ul>
				</div>
			</div>
		</div>
		<nav id="lnb">
			<div class="btn_lnb">
				<button type="button" onclick="leftNavFn('left_nav');"><span><img src="/mobile/common/images/common/btn_left_menu.png" alt=""></span>SHOP</button>
			</div>
			<div class="lnb_area">
				<ul>
					<li><a href="javascript:void(0);">�̺�Ʈ</a></li>
					<li><a href="javascript:void(0);">Į��</a></li>
					<li><a href="javascript:void(0);">�귣��Ұ�</a></li>
				</ul>
			</div>
		</nav> -->
		<div id="header">
			<div class="header_bnnner">
				<div class="bannerClose" onclick="topBannerClose();">Close</div>
				<div class="bannerSlider">
					<div class="item">
					<!--  <a href="javascript:void(0);" onclick="event_personal_pop();"><img src="/mobile/common/images/top_banner_01_m.jpg" alt=""></a>-->
					</div>
				</div>
			</div>
			<div class="header_top">
				<div class="header_inner">
					<span class="h100"></span>
					<div class="btn_lnb">
						<button type="button" onclick="leftNavFn('left_nav');"><img src="/mobile/common/images/common/btn_left_menu.png" alt=""></button>
					</div>
					<div class="logo"><a href="/mobile/index.jsp"><img src="/mobile/common/images/common/m_logo.png" alt=""></a></div>
					<div class="gnb">
						<ul>
							<%if (eslMemberId.equals("")) {%>
							<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">�α���</a></li> -->
							<li><a href="/mobile/customer/login.jsp"><img src="/mobile/common/images/common/m_ico_mypage_off.png" alt="�α���"></a></li>
							<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680" onMouseDown="_trk_flashEnvView('_TRK_PI=RGF1');">ȸ������</a></li> -->
							<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">��ٱ���</a></li> -->
							<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">�ֹ�������ȸ</a></li> -->
							<!-- <li><a href="#"><img src="/mobile/common/images/common/m_ico_mypage.png" alt=""></a></li>
							<li><a href="#"><img src="/mobile/common/images/common/m_ico_cart.png" alt=""></a></li> -->
							<%} else {%>
							<!-- <li><a href="/sso/logout.jsp">�α׾ƿ�</a></li> -->
							<li><a href="/mobile/shop/mypage/index.jsp"><img src="/mobile/common/images/common/m_ico_mypage_on.png" alt="����������"></a></li>
							<!-- <li><a href="/shop/mypage/orderList.jsp">�ֹ�������ȸ</a></li> -->
							<%}%>
						</ul>
					</div>
				</div>
			</div>
			<div class="header_bottom">
				<div class="header_bottom_slider">
					<a href="/mobile/intro/checkLocation.jsp">�ս������̵�</a>
					<a href="/mobile/shop/order_list.jsp?tg=06">����Ʈ��ǰ</a>
				<!--	<a href="/mobile/shop/order_list.jsp?tg=05">��õ��ǰ</a> -->
					<a href="/mobile/event/index.jsp">�̺�Ʈ</a>
					<a href="/mobile/shop/experience.jsp">ü���</a>
					<a href="/mobile/intro/eatsslimStory.jsp">�귣�彺�丮</a>
				</div>
			</div>
		</div>
		<nav id="left_nav">
			<div class="btn_close"><button type="button" onclick="leftNavFn('left_nav');"></button></div>
			<div class="left_nav_inner">
				<div class="left_nav_header">
					<h1><img src="/mobile/common/images/common/m_logo2.png" alt=""></h1>
<% if (!eslMemberId.equals("")) { %>
					<a href="/sso/logout.jsp" class="btn_logout">�α׾ƿ�</a>
<% } %>
				</div>
				<div class="left_nav_cont">
					<div class="nav_menu">
						<ul>
							<li>
								<div class="selector">Į�θ� ���� ���α׷�</div>
								<ul>
									<!--  
									<li><a href="/mobile/shop/order_list.jsp?menuF=2&menuS=1">�۽��� ��Ī ���α׷�</a></li>
									-->
									<li><a href="/mobile/shop/order_list.jsp?menuF=2&menuS=2">Į�θ� ���� ���α׷�</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=2&menuS=3">Ŭ�������α׷�</a></li>
									<!--li><a href="/mobile/shop/order_list.jsp?menuF=2&menuS=4">����Ʈ�׷�</a></li-->
								</ul>
							</li>
							<li>
								<div class="selector">Į�θ� ������</div>
								<ul>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=6&eatCoun=""">���̽�Ƽ ��Ʈ</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=1&eatCoun=""">400 ������</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=2&eatCoun=""">300 ������</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=3&eatCoun=""">300 ����</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=5&eatCoun=""">200 ����������</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=1&menuS=4&eatCoun=""">�̴Ϲ�</a></li>
								</ul>
							</li>

							<li>
								<div class="selector">�ǰ���</div>
								<ul>
									<li><a href="/mobile/shop/order_list.jsp?menuF=3&menuS=1&eatCoun=""">500 ����</a></li>
								</ul>
							</li>
							<li>
								<div class="selector">��ɽ�</div>
								<ul>
									<li><a href="/mobile/shop/order_list.jsp?menuF=4&menuS=4">150 ����ƾ��</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=4&menuS=1">�뷱������ũ</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=4&menuS=2">���̾�Ʈ ��ɽ�ǰ</a></li>
									<li><a href="/mobile/shop/order_list.jsp?menuF=4&menuS=3">�ǰ���</a></li>
								</ul>
							</li>
						</ul>
					</div>
					<div class="nav_gnb">
						<ul>
							<li><a href="/mobile/intro/schedule.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb3.png" alt=""></span>�̴��� �Ĵ�</a></li>
							<li><a href="/mobile/delivery/delivery.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb7.png" alt=""></span>�������Ȯ��</a></li>
						<!--	<li><a href="/mobile/shop/order_guide.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb4.png" alt=""></span>������ �´� �ս���</a></li> -->
							<li><a href="/mobile/shop/mypage/orderList.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb1.png" alt=""></span>�ֹ���ȸ ����</a></li>
							<li><a href="/mobile/shop/mypage/outmallOrder.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb2.png" alt=""></span>Ÿ���θ� �ֹ�Ȯ��</a></li>
							<li><a href="/mobile/customer/indiqna.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb5.png" alt=""></span>1:1����</a></li>
						    <li><a href="/mobile/customer/notice.jsp"><span><img src="/mobile/common/images/ico/ico_leftnav_gnb6.png" alt=""></span>��������</a></li>

						</ul>
					</div>
				</div>
			</div>
		</nav>

<%

	String eslMemberHp ="";

	if (!"".equals(eslCustomerNum)) {
		String esQeury = "";
		Statement cstmt = null;
		ResultSet crs = null;
		cstmt = conn.createStatement();
		esQeury = "SELECT HP FROM ESL_MEMBER WHERE 1=1 AND  customer_num ="+eslCustomerNum;
		try {
			crs = cstmt.executeQuery(esQeury);
		} catch(Exception e) {
			out.println(e+"=>"+esQeury);
			if(true)return;
		}

		if (crs.next()) {
			eslMemberHp = crs.getString("HP");
		} else {
			eslMemberHp = "";
		}

		crs.close();
	}

%>
<script type="text/javascript">

	$(window).load(function() {
		if( "<%=eslCustomerNum%>" != "" && ( "<%=eslMemberHp%>" == "null" || "<%=eslMemberHp%>" == "" ) ){
			window.location.href = "/mobile/customer/join_agree_mo.jsp";
		}

		$('.header_bnnner .bannerSlider').slick({
			arrows: false,
			dots: false,
			adaptiveHeight: true
		});
	});

	function event_personal_pop() {
		window.open('/promotion/personal.jsp', 'event_personal_pop', 'width=750, height=940, scrollbars= 0, toolbar=0, menubar=no');
	}

	function eventCallBack(){
	   window.location.href = "/mobile/customer/login.jsp";
	}

	function topBannerClose() {
		$('.header_bnnner').slideUp();
		//setCookie( "topProgramBanner", "done" , 1 );
	}

	function setCookie( name, value, expiredays ) {
		var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
	}
</script>

<script>
$(document).ready(function() {
	/*cookiedata = document.cookie;
	if ( cookiedata.indexOf("topProgramBanner=done") < 0 ){
		$(".header_bnnner").css("display","block");
	} else {
		$(".header_bnnner").css("display","none");
	}*/
});
</script>