<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<script type="text/javascript">
	function clickMainBanner(url) {
		_trk_flashEnvView('_TRK_PI=RGF1');
		ga('send', 'event', 'main', 'click', '�ս����̺�Ʈ');
		
		if (url) {
			location = url;
		}	
		
	}
</script>
	
<div class="headerWrapper">
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
					<li<%if (request.getRequestURI().indexOf("/shop/healthyMeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/healthyMeal.jsp">�ﾾ����</a></li>
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
					<li<%if (request.getRequestURI().indexOf("/goods/healthyCuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/healthyCuisine.jsp">�ﾾ����</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/cuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/cuisine.jsp">����</a></li>
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
</div>
<!-- End headerWrapper --> 