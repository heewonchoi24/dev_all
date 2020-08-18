<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
StringBuilder quickQuery = new StringBuilder();
int quickProductCount = 0;
String getProductHistory = ut.getCook(request ,"PRODUCT_HISTORY");
if(!"".equals(getProductHistory) ){
	String[] arrProductHistory = getProductHistory.split(",");
	for(int quickHistoryCount = arrProductHistory.length - 1;quickHistoryCount >= 0; quickHistoryCount--){
		String quickHistory = arrProductHistory[quickHistoryCount];
		if(!"".equals(quickHistory)){
			quickProductCount++;
			if(!"".equals(quickQuery.toString() ) )  quickQuery.append("UNION ALL \n");
			quickQuery.append("SELECT ID,GROUP_NAME,GROUP_IMGM FROM ESL_GOODS_GROUP WHERE ID=" + quickHistory + "\n");
		}
	}
}
%>
	<div class="img_ban"><img src="/images/right_banner.png" alt="" /></div>

<div class="qm_header">
	<h2>최근본상품</h2>
	<div class="qm_count">(<%=quickProductCount%>)</div>
</div>
<div class="qm_container">
	<div class="qm_container_inner">
		<div class="qm_recent">
<%

if(!"".equals(quickQuery.toString())){
	Statement quickStmt		= null;
	ResultSet quickRs		= null;
	quickStmt				= conn.createStatement();
	quickRs = quickStmt.executeQuery(quickQuery.toString());
	while(quickRs.next()){
%>
			<div class="qm_item"><a href="/shop/order_view.jsp?cateCode=0&cartId=<%=quickRs.getString("ID")%>"><img src="/data/goods/<%=quickRs.getString("GROUP_IMGM")%>" alt="<%=quickRs.getString("GROUP_NAME")%>" onerror="this.src='/dist/images/quickmenu_sample1.png'"></a></div>
<%
	}
	quickRs.close();
}
%>
			<!-- <div class="qm_item"><a href="javascript:void(0);"><img src="/dist/images/quickmenu_sample1.png" alt="" width="68"></a></div> -->
		</div>
		<div class="qm_menu">
			<ul>
			<%if (eslMemberId.equals("")) {%>
				<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=630">주문조회<br>변경</a></li>
				<li><a href="/shop/mypage/outmallOrder.jsp">타쇼핑몰<br>주문확인</a></li>
				<li><a href="/intro/foodmonthplan.jsp">이달의 식단</a></li>
	<!--			<li><a href="/shop/orderGuide.jsp">나에게  맞는<br>잇슬림</a></li>-->
				<li><a class="lightbox" href="/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=630">1:1문의</a></li>
			<%} else {%>
				<li><a href="/shop/mypage/calendar.jsp">주문조회<br>변경</a></li>
				<li><a href="/shop/mypage/outmallOrder.jsp">타쇼핑몰<br>주문확인</a></li>
				<li><a href="/intro/foodmonthplan.jsp">이달의 식단</a></li>
	<!--			<li><a href="/shop/orderGuide.jsp">나에게  맞는<br>잇슬림</a></li> -->
				<li><a href="/customer/indiqna.jsp">1:1문의</a></li>
			<%}%>

			</ul>
		</div>
	</div>
</div>
<div class="qm_footer">
	<button type="button" class="go_top">TOP</button>
</div>
