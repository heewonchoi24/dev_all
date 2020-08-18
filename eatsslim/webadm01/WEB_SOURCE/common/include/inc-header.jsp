<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/dbcon_header.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

int headerRow = 0;
Statement headerStmt = null;
ResultSet headerRs = null;
headerStmt = null;
StringBuilder headerQuery = new StringBuilder();
String eslMemberHp ="";

if(!"".equals(eslCustomerNum)){
	headerQuery.setLength(0);
	headerQuery.append(" SELECT HP FROM ESL_MEMBER WHERE 1=1 AND customer_num = "+ eslCustomerNum );
	headerStmt = conn.createStatement();
	headerRs = headerStmt.executeQuery(headerQuery.toString());
	while(headerRs.next() ){
		eslMemberHp = headerRs.getString("HP") == null ? "": headerRs.getString("HP");
	}

	if(headerRs != null) headerRs.close();
	if(headerStmt != null) headerStmt.close();
}

// top banner
String query2_header          = "";
String topImgFile             = "";
String topFirstUrl            = "";
String topFirstBgcolor        = "";
String topSecondUrl           = "";
String topSecondBgcolor       = "";
String topBannerOpenYn        = "";
String topBannerType          = "";

query2_header        = "SELECT TOP_IMGFILE, TOP_FIRST_URL, TOP_FIRST_BGCOLOR, TOP_SECOND_URL, TOP_SECOND_BGCOLOR, TOP_BANNER_OPEN_YN, TOP_BANNER_TYPE ";
query2_header        += " FROM ESL_MAIN_BANNER ";
query2_header        += " WHERE ID = 1";
pstmt2_header        = conn2_header.prepareStatement(query2_header);
rs2_header           = pstmt2_header.executeQuery();

if (rs2_header.next()) {
    topImgFile          = (rs2_header.getString("TOP_IMGFILE") == null)? "" : rs2_header.getString("TOP_IMGFILE");
    topFirstUrl         = (rs2_header.getString("TOP_FIRST_URL") == null)? "" : rs2_header.getString("TOP_FIRST_URL");
    topFirstBgcolor     = (rs2_header.getString("TOP_FIRST_BGCOLOR") == null)? "" : rs2_header.getString("TOP_FIRST_BGCOLOR");
    topSecondUrl        = (rs2_header.getString("TOP_SECOND_URL") == null)? "" : rs2_header.getString("TOP_SECOND_URL");
    topSecondBgcolor    = (rs2_header.getString("TOP_SECOND_BGCOLOR") == null)? "" : rs2_header.getString("TOP_SECOND_BGCOLOR");
    topBannerOpenYn     = (rs2_header.getString("TOP_BANNER_OPEN_YN") == null)? "" : rs2_header.getString("TOP_BANNER_OPEN_YN");
	topBannerType       = (rs2_header.getString("TOP_BANNER_TYPE") == null)? "" : rs2_header.getString("TOP_BANNER_TYPE");
}

rs2_header.close();

%>
<script type="text/javascript">
	function clickMainBanner(url) {
		ga('send', 'event', 'main', 'click', '�ս����̺�Ʈ');
		if (url) {
			location = url;
		}
	}
	$(window).load(function() {
		if( "<%=eslCustomerNum%>" != "" && ( "<%=eslMemberHp%>" == "null" || "<%=eslMemberHp%>" == "" ) ){
			location = "/customer/join_agree.jsp";
		}
	    $(".gnb").css("display","block");
	});
</script>

<script>
function setCookie( name, value, expiredays ) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

/* type2 onclick event */
function topBannerCloseType2() {
	$(".type2").hide();
}
function closeAweekType2() {
	setCookie( "topBanner", "done" , 7 );     // ����� ��Ű�� , ��Ű value�� , �Ⱓ( ex. 1�� �Ϸ�, 7�� ������)
	$(".type2").hide();
}
/* type1 onclick event */
function topBannerCloseType1() {
	$(".type1").hide();
}
function closeAweekType1() {
	setCookie( "topBanner", "done" , 7 );     // ����� ��Ű�� , ��Ű value�� , �Ⱓ( ex. 1�� �Ϸ�, 7�� ������)
	$(".type1").hide();
}
</script>

<!-- 2�� ��� ���� -->
<div id="top_banner" class="type2" style="background: linear-gradient(to right, <%=topFirstBgcolor%> 50%, <%=topSecondBgcolor%> 50%); display:none"> <!-- 1�� ����϶� type2 class ���� -->
	<div class="inner">
			<div class="link">
				<a href="<%=topFirstUrl%>"></a>
				<a href="<%=topSecondUrl%>"></a> <!-- 1�� ����϶� ��ũ ���� -->
			</div>
			<div class="img"><img src="/data/promotion/<%=topImgFile%>" border="0" usemap="#skybn"></div>
			<div class="closeBtn">
				<input type="checkbox" id="topBannerChk" onclick="closeAweekType2();">
				<span>1���� ���� �����ʱ�</span>
				<button type="button" onclick="topBannerCloseType2();">�ݱ�</button>
			</div>
	</div>
</div>
<!-- 2�� ��� �� -->
<!-- 1�� ��� ���� -->
<div id="top_banner" class="type1" style="background: <%=topFirstBgcolor%>; display:none">
	<div class="inner">
			<div class="link">
				<a href="<%=topFirstUrl%>"></a>
			</div>
			<div class="img"><img src="/data/promotion/<%=topImgFile%>" border="0" usemap="#skybn"></div>
			<div class="closeBtn">
				<input type="checkbox" id="topBannerChk" onclick="closeAweekType1();">
				<span>1���� ���� �����ʱ�</span>
				<button type="button" onclick="topBannerCloseType1();">�ݱ�</button>
			</div>
	</div>
</div>
<!-- 1�� ��� �� -->
<div class="header_top ff_noto">
	<div class="header_inner">
		<div class="tal">
		<button type="button" class="btn_redirect" id="btnP"><img src="/dist/images/common/ico_redirect.png" class="ico" alt="��Ǯ�������� �귣��" />��Ǯ��������</button>
		</div>
		<div class="tar">
			<div class="gnb" style="display: none;">
				<ul>
					<%if (eslMemberId.equals("")) {%>
					<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=630">�α���</a></li>
					<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=630" onMouseDown="_trk_flashEnvView('_TRK_PI=RGF1');">ȸ������</a></li> -->
					<li><a class="lightbox" href="/shop/popup/gateMemberJoin.jsp?lightbox[width]=640&lightbox[height]=630">ȸ������</a></li>
					<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=630">��ٱ���</a></li>
					<!-- <li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">�ֹ�������ȸ</a></li> -->
					<%} else {%>
					<li><a href="/sso/logout.jsp">�α׾ƿ�</a></li>
					<li><a href="/shop/cart.jsp">��ٱ���</a></li>
					<li><a href="/shop/mypage/orderList.jsp">�ֹ�������ȸ</a></li>
					<%}%>
					<li><a href="/customer/notice.jsp">������</a></li>

						<%if (eslMemberId.equals("")) {%>
						<!-- <a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350" >����������</a> -->
						<%} else if(!eslMemberId.equals("")) {%>
						<li class="last">
							<a href="/shop/mypage/index.jsp">����������</a>
						</li>
						<%}%>

				</ul>
			</div>
		</div>
	</div>
</div>
<div id="siteSelect">
	<div class="inner">
		<div class="siteInfo">
			<img src="/dist/images/cat_sub/site_info_logo.jpg">
			<p>�ǰ��� ��Ȱ�� �����ϴ� <br/>���Ͻ���Ȱ���, <br/>Ǯ�������� �Դϴ�.</p>
			<a href="http://www.greenjuice.co.kr" target="_blank">����Ʈ �ٷΰ���</a>
		</div>
		<ul class="siteList">
			<li class="li1"><a href="https://www.pulmuone-lohas.com/pc/brand/index.do" target="_blank"><img src="/dist/images/cat_sub/site_logo_02.jpg"></a></li>
			<li class="li2"><a href="https://www.pulmuone-lohas.com/pc/shop/index.do" target="_blank"><img src="/dist/images/cat_sub/site_logo_03.jpg"></a></li>
			<li class="li3"><a href="http://www.greenjuice.co.kr" target="_blank"><img src="/dist/images/cat_sub/site_logo_01.jpg"></a></li>
			<li class="li4"><a href="http://www.eatsslim.co.kr" target="_blank"><img src="/dist/images/cat_sub/site_logo_07.jpg"></a></li>
			<li class="li5"><a href="http://www.babymeal.co.kr" target="_blank"><img src="/dist/images/cat_sub/site_logo_04.jpg"></a></li>
			<li class="li6"><a href="http://www.pulmuoneamio.com" target="_blank"><img src="/dist/images/cat_sub/site_logo_05.jpg"></a></li>
			<li class="li7"><a href="http://www.pulmuoneduskin.co.kr" target="_blank"><img src="/dist/images/cat_sub/site_logo_06.jpg"></a></li>
			<li class="li8"></li>
		</ul>
	</div>
</div>
<div id="siteSelectBg"></div>
<div class="header_mid ff_noto">
	<div class="header_inner">
		<div class="tal">
			<a href="/index_es.jsp"><img src="/dist/images/common/h_logo.png" alt="Ǯ���� �ս��� - �ǰ��ϰ� ���ִ� �Ļ�" /></a>
		</div>
		<div class="tar">
			<div class="harticle">
				<div class="adver">
					<ul>
						<li>
<%
		String headerImgUrl			= "";

		headerQuery.setLength(0);
		headerQuery.append("SELECT ID, TITLE, BANNER_IMG, LINK");
		headerQuery.append(" FROM ESL_BANNER ");
		headerQuery.append(" WHERE GUBUN in ('3') AND OPEN_YN = 'Y' AND ('"+ new SimpleDateFormat("yyyy-MM-dd").format(new Date()) +"' BETWEEN STDATE AND LTDATE)");
		headerQuery.append(" ORDER BY ID DESC LIMIT 1");
		headerStmt = conn.createStatement();
		headerRs = headerStmt.executeQuery(headerQuery.toString());

		if( headerRs.next() ){
			headerRow = headerRs.getInt(1);
		}

		if(headerRow > 0){
			if (headerRs.getString("BANNER_IMG").equals("") || headerRs.getString("BANNER_IMG") == null) {
				headerImgUrl		= "../images/event_thumb01.jpg";
			} else {
				headerImgUrl		= "/data/banner/"+ headerRs.getString("BANNER_IMG");
			}
%>
				<a href="<%=headerRs.getString("LINK")%>"><img src="<%=headerImgUrl%>" alt="<%=headerRs.getString("TITLE")%>" /></a>
<%
		}
		if(headerRs != null) headerRs.close();
		if(headerStmt != null) headerStmt.close();
%>
						</li>
					</ul>
				</div>
				<div class="delivery_search">
					<!-- <a href="/shop/popup/AddressSearchJiPop.jsp?ztype=0003&lightbox[width]=808&lightbox[height]=740" class="lightbox">
						<div class="icon"><img src="/dist/images/common/ico_search_delivery.png" alt="" /></div>
						<span>��ް�������</span> �˻�
					</a> -->
					<a href="javascript:void(0);" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0003','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no');">
						<div class="icon"><img src="/dist/images/common/ico_search_delivery.png" alt="" /></div>
						<span>��ް�������</span> �˻�
					</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="header_bot ff_noto">
	<div class="header_inner">
		<div class="tal">
			<div class="btn_category">
				<button type="button" onclick="catToggle('.btn_category');"><span><i></i></span>��ü ��ǰ����</button>
			</div>
		</div>
		<div class="tar">
			<div class="lnb">
				<ul>
					<!-- <li><button type="button" class="lnb_list1">�̺�Ʈ</button></li>
					<li><button type="button" class="lnb_list2">���̾�Ʈ Į��</button></li>
					<li><button type="button" class="lnb_list3">�ս��� �Ұ�</button></li> -->
					<li><button type="button" class="lnb_list1" onclick="location.href='/intro/checkLocation.jsp'">�ս��� ���̵�</button></li>
					<li><button type="button" class="lnb_list2" onclick="location.href='/shop/order_list.jsp?tg=06'">����Ʈ��ǰ</button></li>
					<!--<li><button type="button" class="lnb_list3" onclick="location.href='/shop/order_list.jsp?tg=05'">��õ��ǰ</button></li> -->
					<li><button type="button" class="lnb_list4" onclick="location.href='/event/currentEvent.jsp'">�̺�Ʈ</button></li>
					<li><button type="button" class="lnb_list4" onclick="location.href='/shop/experience.jsp'">ü���</button></li>
					<li><button type="button" class="lnb_list5" onclick="location.href='/intro/eatsslimStory.jsp'">�귣�彺�丮</button></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<%-- <div class="headerWrapper">
	<div class="top-menu">
		<ul>
			<%if (eslMemberId.equals("")) {%>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">�α���</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680" onMouseDown="_trk_flashEnvView('_TRK_PI=RGF1');">ȸ������</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">��ٱ���</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680">�ֹ�������ȸ</a></li>
			<%} else {%>
			<li><a href="/sso/logout.jsp">�α׾ƿ�</a></li>
			<li><a href="/shop/cart.jsp">��ٱ���</a></li>
			<li><a href="/shop/mypage/orderList.jsp">�ֹ�������ȸ</a></li>
			<%}%>
			<li><a href="/customer/notice.jsp">������</a></li>
			<li class="last">
				<%if (eslMemberId.equals("")) {%>
				<a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">����������</a>
				<%} else {%>
				<a href="/shop/mypage/index.jsp">����������</a>
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
			<li class="top<%if (request.getRequestURI().indexOf("/shop") >= 0 && request.getRequestURI().indexOf("/shop/mypage") < 0) out.print(" current");%>"><a class="down" href="/shop/dietMeal.jsp"><span class="m01"></span>SHOP</a>
				<ul class="sub">
					<!--li<%if (request.getRequestURI().indexOf("/shop/orderGuide") >= 0) out.print(" class=\"current\"");%>><a href="/shop/orderGuide.jsp">��ǰ�ȳ�</a></li-->
					<li<%if (request.getRequestURI().indexOf("/shop/healthyMeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/healthyMeal.jsp">500 ����</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/dietMeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/dietMeal.jsp">�Ļ� ���̾�Ʈ</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/secretSlimming") >= 0 || request.getRequestURI().indexOf("/shop/weight3days") >= 0 || request.getRequestURI().indexOf("/shop/weight2weeks") >= 0 || request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0 || request.getRequestURI().indexOf("/shop/cleanseProgram") >= 0 || request.getRequestURI().indexOf("/shop/smartgram") >= 0 || request.getRequestURI().indexOf("/shop/speed4weeks") >= 0) out.print(" class=\"current\"");%>><a href="/shop/weight2weeks.jsp">���α׷�</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/secretSlimming") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSlimming.jsp">6�� ���α׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/weight3days") >= 0) out.print(" class=\"current\"");%>><a href="/shop/weight3days.jsp">3�����α׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/weight2weeks") >= 0) out.print(" class=\"current\"");%>><a href="/shop/weight2weeks.jsp">���߰��� 2��</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/fullstepProgram.jsp">����&���� 4��</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/cleanseProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/cleanseProgram.jsp">Ŭ���� ���α׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/smartgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/smartgram.jsp">����Ʈ�׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/speed4weeks") >= 0) out.print(" class=\"current\"");%>><a href="/shop/speed4weeks.jsp">���ǵ� 4��</a></li>
						</ul>
					</li>
					<li<%if (request.getRequestURI().indexOf("/shop/minimeal") >= 0 || request.getRequestURI().indexOf("/shop/eatRice") >= 0 || request.getRequestURI().indexOf("/shop/secretSoup") >= 0 || request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/minimeal.jsp">�����</a>
						<ul class="sub" style="margin-left:250px;">
							<li<%if (request.getRequestURI().indexOf("/shop/minimeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/minimeal.jsp">�̴Ϲ�</a></li>
							<!--li<%if (request.getRequestURI().indexOf("/shop/eatRice") >= 0) out.print(" class=\"current\"");%>><a href="/shop/eatRice.jsp">���̽�</a></li-->
							<li<%if (request.getRequestURI().indexOf("/shop/secretSoup") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSoup.jsp">��ũ�� ����</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/balanceShake.jsp">�뷱�� ����ũ</a></li>
						</ul>
					<li<%if (request.getRequestURI().indexOf("/shop/dietCLA") >= 0 || request.getRequestURI().indexOf("/shop/digest") >= 0 || request.getRequestURI().indexOf("/shop/womanBalance") >= 0 || request.getRequestURI().indexOf("/shop/lock") >= 0 || request.getRequestURI().indexOf("/shop/vitaminD") >= 0 || request.getRequestURI().indexOf("/shop/chewable") >= 0 || request.getRequestURI().indexOf("/shop/megaVitamin") >= 0 || request.getRequestURI().indexOf("/shop/omega") >= 0) out.print(" class=\"current\"");%>><a href="/shop/dietCLA.jsp">��ɽ�ǰ</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/dietCLA") >= 0) out.print(" class=\"current\"");%>><a href="/shop/dietCLA.jsp">���̾�ƮCLA</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/digest") >= 0) out.print(" class=\"current\"");%>><a href="/shop/digest.jsp">��������Ʈ</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/womanBalance") >= 0) out.print(" class=\"current\"");%>><a href="/shop/womanBalance.jsp">��չ뷱��</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/lock") >= 0) out.print(" class=\"current\"");%>><a href="/shop/lock.jsp">���</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/vitaminD") >= 0) out.print(" class=\"current\"");%>><a href="/shop/vitaminD.jsp">Į����Ÿ��D</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/chewable") >= 0) out.print(" class=\"current\"");%>><a href="/shop/chewable.jsp">������Ƽ����</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/megaVitamin") >= 0) out.print(" class=\"current\"");%>><a href="/shop/megaVitamin.jsp">�ް���Ÿ��C</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/omega") >= 0) out.print(" class=\"current\"");%>><a href="/shop/omega.jsp">���ް�</a></li>
							</ul>
					</li>
					<li<%if (request.getRequestURI().indexOf("/shop/onion") >= 0 || request.getRequestURI().indexOf("/shop/pomegranate") >= 0 || request.getRequestURI().indexOf("/shop/acaiberry") >= 0 || request.getRequestURI().indexOf("/shop/blueberry") >= 0 || request.getRequestURI().indexOf("/shop/aronia") >= 0 || request.getRequestURI().indexOf("/shop/deodeok") >= 0 ) out.print(" class=\"current\"");%>><a href="/shop/onion.jsp">�ǰ���</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/onion") >= 0) out.print(" class=\"current\"");%>><a href="/shop/onion.jsp">����&��ä</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/pomegranate") >= 0) out.print(" class=\"current\"");%>><a href="/shop/pomegranate.jsp">����</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/acaiberry") >= 0) out.print(" class=\"current\"");%>><a href="/shop/acaiberry.jsp">�ƻ��̼��ۺ���</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/blueberry") >= 0) out.print(" class=\"current\"");%>><a href="/shop/blueberry.jsp">�߻���纣��</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/aronia") >= 0) out.print(" class=\"current\"");%>><a href="/shop/aronia.jsp">�ƷδϾƼ�Ʈ</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/deodeok") >= 0) out.print(" class=\"current\"");%>><a href="/shop/deodeok.jsp">����û</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/intro") >= 0) out.print(" current");%>"><a class="down" href="/intro/eatsslimStory.jsp"><span class="m02"></span>�ս��� �Ұ�</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimStory") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimStory.jsp">�ս��� ���丮</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimFeature") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimFeature.jsp">�ս��� Ư¡</a></li>
                    <li<%if (request.getRequestURI().indexOf("/intro/lowgldiet") >= 0) out.print(" class=\"current\"");%>><a href="/intro/lowgldiet.jsp">Why �ս���</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCounsel2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCounsel2.jsp">�ڹ��� �Ұ�</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCkitchen2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCkitchen2.jsp">����Ʈ Űģ</a></li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/goods") >= 0) out.print(" current");%>"><a class="down" href="/goods/cuisine.jsp"><span class="m03"></span>��ǰ�Ұ�</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/goods/healthyCuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/healthyCuisine.jsp">500 ����</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/cuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/cuisine.jsp">400 ������</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/alacarte") >= 0) out.print(" class=\"current\"");%>><a href="/goods/alacarte.jsp">�˶���</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/minimeal") >= 0) out.print(" class=\"current\"");%>><a href="/goods/minimeal.jsp">�̴Ϲ�</a></li>
					<!--li<%if (request.getRequestURI().indexOf("/goods/eatRice") >= 0) out.print(" class=\"current\"");%>><a href="/goods/eatRice.jsp">���̽�</a></li-->
					<li<%if (request.getRequestURI().indexOf("/goods/secretSoup") >= 0) out.print(" class=\"current\"");%>><a href="/goods/secretSoup.jsp">��ũ������</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/goods/balanceShake.jsp">�뷱������ũ</a></li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/colums") >= 0) out.print(" current");%>"><a class="down" href="/colums/dietColum.jsp"><span class="m06"></span>GO! ���̾�Ʈ</a>
				<ul class="sub" style="margin-left:300px;width:300px;">
					<li<%if (request.getRequestURI().indexOf("/colums/dietColum") >= 0) out.print(" class=\"current\"");%>><a href="/colums/dietColum.jsp">���̾�Ʈ Į��</a></li>
					<!--li<%if (request.getRequestURI().indexOf("/colums/postScript") >= 0) out.print(" class=\"current\"");%>><a href="/colums/postScript.jsp">���̾�Ʈ ü���ı�</a></li-->
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/event") >= 0) out.print(" current");%>"><a class="down" href="/event/currentEvent.jsp"><span class="m05"></span>�̺�Ʈ</a>
				<ul class="sub floatRight">
					<!--li<%if (request.getRequestURI().indexOf("/event/choi") >= 0) out.print(" class=\"current\"");%>><a href="/event/choiPost.jsp">�ְ����� ��� �ս��� �ı�</a></li-->
					<li<%if (request.getRequestURI().indexOf("/event/lastEvent") >= 0) out.print(" class=\"current\"");%>><a href="/event/lastEvent.jsp">���� �̺�Ʈ</a></li>
					<li<%if (request.getRequestURI().indexOf("/event/currentEvent") >= 0) out.print(" class=\"current\"");%>><a href="/event/currentEvent.jsp">�������� �̺�Ʈ</a></li>
				</ul>
			</li>
			<li class="top last<%if (request.getRequestURI().indexOf("/delivery") >= 0) out.print(" current");%>"><a class="down" href="/delivery/freshparcel.jsp"><span class="m04"></span>��޾ȳ�</a>
				<ul class="sub floatRight">
					<!--li<%if (request.getRequestURI().indexOf("/delivery/delivery") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/delivery.jsp">������� �ȳ�</a></li-->
					<li<%if (request.getRequestURI().indexOf("/delivery/parcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/parcel.jsp">�ù���</a></li>
					<li<%if (request.getRequestURI().indexOf("/delivery/freshparcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/freshparcel.jsp">�ؽż� ���Ϲ��</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="shipping-search">
		<a href="javascript:;" onclick="window.open('/shop/popup/AddressSearchJiPop.jsp?ztype=0003','chk_zipcode','width=800,height=650,top=50,left=100,scrollbars=yes,resizable=no,toolbar=no,status=no,menubar=no')">��� ���� ������ ���� �˻��ϼ���!</a>
	</div>
</div> --%>
<!-- End headerWrapper -->
<!-- Start Category Submenu -->
<nav class="cat_sub ff_noto">
	<div class="header_inner">
		<div class="bx_nav">
			<h1>ī�װ�</h1>
			<ul>
				<li>
					<div class="sub_anchor"><a href="/shop/order_list.jsp?menuF=2&menuS=2">Į�θ� ���� ���α׷�</a></div>
					<ul>
						<!--  
						<li>
							<a href="/shop/order_list.jsp?menuF=2&menuS=1" class="on">�۽��� ��Ī ���α׷�</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=2&menuS=1"><img src="/dist/images/cat_sub/m_gnb_cat6.jpg" alt=""></a></div>
						</li>
						-->
						<li>
							<a href="/shop/order_list.jsp?menuF=2&menuS=2">Į�θ� ���� ���α׷�</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=2&menuS=2"><img src="/dist/images/cat_sub/m_gnb_cat7.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=2&menuS=3">Ŭ�������α׷�</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=2&menuS=3"><img src="/dist/images/cat_sub/m_gnb_cat8.jpg" alt=""></a></div>
						</li>
						<!--li>
							<a href="/shop/order_list.jsp?menuF=2&menuS=4">����Ʈ�׷�</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=2&menuS=4"><img src="/dist/images/cat_sub/m_gnb_cat14.jpg" alt=""></a></div>
						</li-->
					</ul>
				</li>
				<li>
					<div class="sub_anchor on"><a href="/shop/order_list.jsp?menuF=1&menuS=6&eatCoun=">Į�θ� ������</a></div>
					<ul>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=6&eatCoun=" class="on">���̽�Ƽ ��Ʈ</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=6&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat17.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=1&eatCoun=" class="on">400 ������</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=1&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat2.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=2&eatCoun=">300 ������</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=2&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat4.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=3&eatCoun=">300 ����</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=3&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat3.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=5&eatCoun=">200 ����������</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=5&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat15.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=1&menuS=4&eatCoun=">�̴Ϲ�</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=1&menuS=4&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat5.jpg" alt=""></a></div>
						</li>
					</ul>
				</li>
				<li>
					<div class="sub_anchor"><a href="/shop/order_list.jsp?menuF=3&menuS=1">�ǰ���</a></div>
					<ul>
						<li>
							<a href="/shop/order_list.jsp?menuF=3&menuS=1" class="on">500 ����</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=3&menuS=1&eatCoun="><img src="/dist/images/cat_sub/m_gnb_cat1.jpg" alt=""></a></div>
						</li>
					</ul>
				</li>
				<li>
					<div class="sub_anchor"><a href="/shop/order_list.jsp?menuF=4&menuS=1">��ɽ�</a></div>
					<ul>
						<li>
							<a href="/shop/order_list.jsp?menuF=4&menuS=4" class="on">150 ����ƾ��</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=4&menuS=4"><img src="/dist/images/cat_sub/m_gnb_cat18.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=4&menuS=1" class="on">�뷱������ũ</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=4&menuS=1"><img src="/dist/images/cat_sub/m_gnb_cat9.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=4&menuS=2">���̾�Ʈ ��ɽ�ǰ</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=4&menuS=2"><img src="/dist/images/cat_sub/m_gnb_cat12.jpg" alt=""></a></div>
						</li>
						<li>
							<a href="/shop/order_list.jsp?menuF=4&menuS=3">�ǰ���</a>
							<div class="goods_preview"><a href="/shop/order_list.jsp?menuF=4&menuS=3"><img src="/dist/images/cat_sub/m_gnb_cat13.jpg" alt=""></a></div>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>
<!-- End Category Submenu -->

<!-- Start eatsslim Submenu -->
<nav class="lnb_sub ff_noto" id="eatsslim_sub">
	<div class="header_inner">
		<h1>������ �´� �ս���</h1>
		<div class="slider_container grid1">
			<div class="slider_item"><a href="/shop/orderGuide.jsp"><img src="/dist/images/cat_sub/eatsslim_sample_new.jpg" alt=""></a></div>
			</div>
		<a href="/shop/orderGuide.jsp" class="go_list">����Ʈ �������� <img src="/dist/images/cat_sub/ico_go_list.png" alt=""></a>
	</div>
</nav>
<!-- End diet_column Submenu -->
<!-- Start best Submenu -->
<nav class="lnb_sub ff_noto" id="best_sub">
	<div class="header_inner">
		<h1>����Ʈ��ǰ</h1>
<%
headerQuery.setLength(0);
headerQuery.append(" SELECT \n");
headerQuery.append(" 		count(*)\n");
headerQuery.append("   FROM ESL_GOODS_GROUP \n");
headerQuery.append("  WHERE USE_YN = 'Y' AND LIST_VIEW_YN='Y' AND TAG LIKE '%,06,%'");
headerStmt = conn.createStatement();
headerRs = headerStmt.executeQuery(headerQuery.toString());
if(headerRs.next() ){
	headerRow = headerRs.getInt(1);
}
%>
		<div class="slider_container grid4">
<%
if(headerRow > 0){
	if(headerRs != null) headerRs.close();
	if(headerStmt != null) headerStmt.close();

	headerQuery.setLength(0);
	headerQuery.append(" SELECT \n");
	headerQuery.append(" 		ID, GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM,DAY_EAT \n");
	headerQuery.append("   FROM ESL_GOODS_GROUP \n");
	headerQuery.append("  WHERE USE_YN = 'Y' AND LIST_VIEW_YN='Y' AND TAG LIKE '%,06,%' ORDER BY TAG_SORT DESC LIMIT 4");
	headerStmt = conn.createStatement();
	headerRs = headerStmt.executeQuery(headerQuery.toString());
	while(headerRs.next() ){
		String topSubTitle = "&nbsp;";
		String topGubun2 = headerRs.getString("GUBUN2") == null ? "": headerRs.getString("GUBUN2");
		String topGroupImg = headerRs.getString("GROUP_IMGM") == null ? "": headerRs.getString("GROUP_IMGM");
		topSubTitle = ut.isnull(headerRs.getString("DAY_EAT") );
		if("".equals(topSubTitle)) topSubTitle = "&nbsp;";
%>
			<div class="slider_item">
				<a href="/shop/order_view.jsp?cateCode=0&cartId=<%=headerRs.getString("ID")%>">
					<img src="/data/goods/<%=topGroupImg%>" onerror="this.src='/dist/images/cat_sub/best_sample1.jpg'" alt="" width="260">
					<div class="info">
						<div class="title"><%=headerRs.getString("GROUP_NAME")%></div>
						<div class="sub_title"><%=topSubTitle%></div>
						<div class="pay"><%=ut.getComma(headerRs.getInt("GROUP_PRICE1"))%>��</div>
					</div>
				</a>
			</div>
<%
	}
}
else{
%>
			<div class="header_inner">
				<div class="slider_container grid1">
					��ϵ� ����Ʈ��ǰ�� �����ϴ�.
				</div>
			</div>
<%
}
if(headerRs != null) headerRs.close();
if(headerStmt != null) headerStmt.close();
%>
		</div>
		<a href="/shop/order_list.jsp?tg=06" class="go_list">����Ʈ �������� <img src="/dist/images/cat_sub/ico_go_list.png" alt=""></a>
	</div>
</nav>
<!-- End best Submenu -->
<!-- Start recommend Submenu -->
<nav class="lnb_sub ff_noto" id="recommend_sub">
	<div class="header_inner">
		<h1>��õ��ǰ</h1>
<%
headerQuery.setLength(0);
headerQuery.append(" SELECT \n");
headerQuery.append(" 		count(*)\n");
headerQuery.append("   FROM ESL_GOODS_GROUP \n");
headerQuery.append("  WHERE USE_YN = 'Y' AND LIST_VIEW_YN='Y' AND TAG LIKE '%,05,%'");
headerStmt = conn.createStatement();
headerRs = headerStmt.executeQuery(headerQuery.toString());
if(headerRs.next() ){
	headerRow = headerRs.getInt(1);
}
%>
	<div class="slider_container grid4">
<%
if(headerRow > 0){
	if(headerRs != null) headerRs.close();
	if(headerStmt != null) headerStmt.close();
	headerQuery.setLength(0);
	headerQuery.append(" SELECT \n");
	headerQuery.append(" 		ID, GUBUN1, GUBUN2, GROUP_CODE, GROUP_NAME, OFFER_NOTICE, GROUP_PRICE1, KAL_INFO, GROUP_INFO, GROUP_INFO1, CART_IMG, GROUP_IMGM, DAY_EAT\n");
	headerQuery.append("   FROM ESL_GOODS_GROUP \n");
	headerQuery.append("  WHERE USE_YN = 'Y' AND LIST_VIEW_YN='Y' AND TAG LIKE '%,05,%' ORDER BY TAG_SORT DESC LIMIT 4");
	headerStmt = conn.createStatement();
	headerRs = headerStmt.executeQuery(headerQuery.toString());
	while(headerRs.next() ){
		String topSubTitle = "&nbsp;";
		String topGubun2 = headerRs.getString("GUBUN2") == null ? "": headerRs.getString("GUBUN2");
		String topGroupImg = headerRs.getString("GROUP_IMGM") == null ? "": headerRs.getString("GROUP_IMGM");
		topSubTitle = ut.isnull(headerRs.getString("DAY_EAT") );
		if("".equals(topSubTitle)) topSubTitle = "&nbsp;";
%>
			<div class="slider_item">
				<a href="/shop/order_view.jsp?cateCode=0&cartId=<%=headerRs.getString("ID")%>">
					<img src="/data/goods/<%=topGroupImg%>" onerror="this.src='/dist/images/cat_sub/best_sample1.jpg'" alt="" width="260">
					<div class="info">
						<div class="title"><%=headerRs.getString("GROUP_NAME")%></div>
						<div class="sub_title"><%=topSubTitle%></div>
						<div class="pay"><%=ut.getComma(headerRs.getInt("GROUP_PRICE1"))%>��</div>
					</div>
				</a>
			</div>
<%
	}
}
else{
%>
			<div class="header_inner">
				<div class="slider_container grid1">
					��ϵ� ����Ʈ��ǰ�� �����ϴ�.
				</div>
			</div>
<%
}
if(headerRs != null) headerRs.close();
if(headerStmt != null) headerStmt.close();
%>
		</div>
		<a href="/shop/order_list.jsp?tg=05" class="go_list">����Ʈ �������� <img src="/dist/images/cat_sub/ico_go_list.png" alt=""></a>
	</div>
</nav>
<!-- End recommend Submenu -->
<!-- Start Event Submenu -->
<nav class="lnb_sub ff_noto" id="event_sub">
	<div class="header_inner">
		<h1>�̺�Ʈ</h1>
		<div class="slider_container grid2">
<%
headerQuery.setLength(0);
headerQuery.append(" SELECT ID, EVENT_TYPE, TITLE, DATE_FORMAT(STDATE, '%Y.%m.%d') STDATE, DATE_FORMAT(LTDATE, '%Y.%m.%d') LTDATE, \n");
headerQuery.append("	EVENT_TARGET, DATE_FORMAT(ANC_DATE, '%Y.%m.%d') ANC_DATE, LIST_IMG, EVENT_URL, WINNER \n");
headerQuery.append(" FROM ESL_EVENT  \n");
headerQuery.append(" WHERE GUBUN in ('0', '1') AND OPEN_YN = 'Y' AND ('"+ new SimpleDateFormat("yyyy-MM-dd").format(new Date()) +"' BETWEEN STDATE AND LTDATE)  \n");
headerQuery.append(" ORDER BY ID DESC \n");
headerQuery.append(" LIMIT 2 \n");
headerStmt = conn.createStatement();
headerRs = headerStmt.executeQuery(headerQuery.toString());
while(headerRs.next() ){
	String headereventId		= headerRs.getString("ID");
	String headereventType		= headerRs.getString("EVENT_TYPE");
	String headertitle			= headerRs.getString("TITLE");
	String headerstdate			= headerRs.getString("STDATE");
	String headerltdate			= headerRs.getString("LTDATE");
	String headereventTarget	= headerRs.getString("EVENT_TARGET");
	String headerancDate		= (headerRs.getString("ANC_DATE") == null || headerRs.getString("ANC_DATE").equals(""))? "����" : headerRs.getString("ANC_DATE");
	String headerlistImg		= headerRs.getString("LIST_IMG");
	String headerimgUrl = "";
	if (headerlistImg == null || headerlistImg.equals("")) {
		headerimgUrl		= "/images/event_thumb01.jpg";
	} else {
		headerimgUrl		= webUploadDir +"promotion/"+ headerlistImg;
	}
	String headereventUrl	= headerRs.getString("EVENT_URL");
	String headerviewLink	= (headereventUrl == null || headereventUrl.equals(""))? "href=\"/event/eventView.jsp?id="+ headereventId + "\"" : "href=\""+ headereventUrl +"\" target=\"press\"";
	String headerwinner		= ut.isnull(headerRs.getString("WINNER"));

%>
			<div class="slider_item"><a <%=headerviewLink%>><img src="<%=headerimgUrl%>" alt=""></a></div>
<%
}
if(headerRs != null) headerRs.close();
if(headerStmt != null) headerStmt.close();
%>
			<!-- <div class="slider_item"><a href="#"><img src="/dist/images/eventBan_01.jpg" alt=""></a></div>\ -->
		</div>
		<a href="/event/eventView.jsp?id=284" class="go_list">����Ʈ �������� <img src="/dist/images/cat_sub/ico_go_list.png" alt=""></a>
	</div>
	<!-- <div class="header_inner">
		<div class="slider_container grid1">
			��ϵ� �̺�Ʈ�� �����ϴ�.
		</div>
	</div> -->
</nav>
<!-- End Event Submenu -->
<!-- Start brand_story Submenu -->
<nav class="lnb_sub ff_noto" id="bs_sub">
	<div class="header_inner">
		<h1>�귣�彺�丮</h1>
		<div class="slider_container grid1">
			<div class="slider_item"><a href="/intro/eatsslimStory.jsp"><img src="/dist/images/cat_sub/bs_sample_new.jpg" alt=""></a></div>
			</div>
		<a href="/intro/eatsslimStory.jsp" class="go_list">����Ʈ �������� <img src="/dist/images/cat_sub/ico_go_list.png" alt=""></a>
	</div>
</nav>
<!-- End brand_story Submenu -->
<script type="text/javascript">
	$("#btnP, #siteSelectBg").click(function(){
		var siteSelect = $("#siteSelect"),
			siteSelectBg = $("#siteSelectBg");
		if(siteSelect.hasClass('on')){
			siteSelect.slideUp('normal');
			siteSelect.removeClass('on');
			siteSelectBg.hide();
			$('#btnP').find('.ico').attr('src','/dist/images/common/ico_redirect.png');
		}else{
			siteSelect.slideDown('normal');
			siteSelect.addClass('on');
			siteSelectBg.show();
			$('#btnP').find('.ico').attr('src','/dist/images/common/ico_redirect_up.png');
		}
	});
</script>

<script>
$(document).ready(function() {
  	var topImgFile = "<%=topImgFile%>";
	var topBannerOpenYn = "<%=topBannerOpenYn%>";
	var topBannerType = "<%=topBannerType%>";
	if(topImgFile.length > 0 && topBannerOpenYn == "Y" && topBannerType == "top_type1"){
		cookiedata = document.cookie;
		if ( cookiedata.indexOf("topBanner=done") < 0 ){
			$(".type1").show();
		} else {
			$(".type1").hide();
		}
	}
	if(topImgFile.length > 0 && topBannerOpenYn == "Y" && topBannerType == "top_type2"){
		cookiedata = document.cookie;
		if ( cookiedata.indexOf("topBanner=done") < 0 ){
			$(".type2").show();
		} else {
			$(".type2").hide();
		}
	}
});
</script>
<%@ include file="/lib/dbclose_header.jsp" %>