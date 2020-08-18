<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<div class="headerWrapper">
	<div class="top-menu">
		<ul>
			<%if (eslMemberId.equals("")) {%>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">�α���</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">ȸ������</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">��ٱ���</a></li>
			<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">�ֹ�������ȸ</a></li>
			<%} else {%>
			<li><a href="/sso/logout.jsp">�α׾ƿ�</a></li>
			<li><a href="/shop/cart.jsp">��ٱ���</a></li>
			<li><a href="/shop/mypage/orderList.jsp">�ֹ�������ȸ</a></li>
			<%}%>
			<li><a href="/customer/notice.jsp">������</a></li>
			<li class="last">
				<%if (eslMemberId.equals("")) {%>
				<a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350">�����ս���</a>
				<%} else {%>
				<a href="/shop/mypage/index.jsp">�����ս���</a>
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
					<li<%if (request.getRequestURI().indexOf("/shop/orderGuide") >= 0) out.print(" class=\"current\"");%>><a href="/shop/orderGuide.jsp">��ǰ�ȳ�</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/dietMeal") >= 0) out.print(" class=\"current\"");%>><a href="/shop/dietMeal.jsp">�Ļ� ���̾�Ʈ</a></li>
					<li<%if (request.getRequestURI().indexOf("/shop/reductionProgram") >= 0 || request.getRequestURI().indexOf("/shop/keepProgram") >= 0 || request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/reductionProgram.jsp">���α׷� ���̾�Ʈ</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/reductionProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/reductionProgram.jsp">���� ���α׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/keepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/keepProgram.jsp">���� ���α׷�</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/fullstepProgram") >= 0) out.print(" class=\"current\"");%>><a href="/shop/fullstepProgram.jsp">FULL-STEP ���α׷�</a></li>
						</ul>
					</li>
					<li<%if (request.getRequestURI().indexOf("/shop/secretSoup") >= 0 || request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSoup.jsp">Ÿ�Ժ� ���̾�Ʈ</a>
						<ul class="sub">
							<li<%if (request.getRequestURI().indexOf("/shop/secretSoup") >= 0) out.print(" class=\"current\"");%>><a href="/shop/secretSoup.jsp">��ũ������</a></li>
							<li<%if (request.getRequestURI().indexOf("/shop/balanceShake") >= 0) out.print(" class=\"current\"");%>><a href="/shop/balanceShake.jsp">�뷱�� ����ũ</a></li>
						</ul>
					</li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/intro") >= 0) out.print(" current");%>"><a class="down" href="/intro/eatsslimStory.jsp"><span class="m02"></span>�ս��� �Ұ�</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimStory") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimStory.jsp">�ս��� ���丮</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimFeature") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimFeature.jsp">�ս��� Ư¡</a></li>
                    <li<%if (request.getRequestURI().indexOf("/intro/lowgldiet") >= 0) out.print(" class=\"current\"");%>><a href="/intro/lowgldiet.jsp">Low GL Diet</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCounsel2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCounsel2.jsp">�ڹ��� �Ұ�</a></li>
					<li<%if (request.getRequestURI().indexOf("/intro/eatsslimCkitchen2") >= 0) out.print(" class=\"current\"");%>><a href="/intro/eatsslimCkitchen2.jsp">����Ʈ Űģ</a></li>
				</ul>
			</li>
			<li class="top<%if (request.getRequestURI().indexOf("/goods") >= 0) out.print(" current");%>"><a class="down" href="/goods/cuisine.jsp"><span class="m03"></span>��ǰ�Ұ�</a>
				<ul class="sub">
					<li<%if (request.getRequestURI().indexOf("/goods/cuisine") >= 0) out.print(" class=\"current\"");%>><a href="/goods/cuisine.jsp">����</a></li>
					<li<%if (request.getRequestURI().indexOf("/goods/alacarte") >= 0) out.print(" class=\"current\"");%>><a href="/goods/alacarte.jsp">�˶���</a></li>
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
					<li<%if (request.getRequestURI().indexOf("/delivery/delivery") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/delivery.jsp">������� �ȳ�</a></li>
					<li<%if (request.getRequestURI().indexOf("/delivery/parcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/parcel.jsp">�ù���</a></li>
					<li<%if (request.getRequestURI().indexOf("/delivery/freshparcel") >= 0) out.print(" class=\"current\"");%>><a href="/delivery/freshparcel.jsp">�ؽż� ���Ϲ��</a></li>
				</ul>
			</li>
		</ul>
	</div>
	<div class="shipping-search">
		<a class="lightbox" href="/shop/popup/deliverypossi.jsp?lightbox[width]=600&lightbox[height]=600">��� ���� ������ ���� �˻��ϼ���!</a>
	</div>
</div>
<!-- End headerWrapper --> 