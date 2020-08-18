<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "로그인을 해주세요.");
	out.println("<script>self.close();</script>");
}
%>
<%
eslMemberId				= (String)session.getAttribute("esl_member_id");
//String reckcal		    = ut.inject(request.getParameter("rec_kcal"));
String groupCode		= ut.inject(request.getParameter("group_code"));

String query		= "";
String groupName	= "";
String groupImg		= "";
String cateCode     = "";
int Id			= 0;

try{
	query = " SELECT ID, GROUP_NAME, PERSONAL_IMG, CATE_CODE from ESL_GOODS_GROUP WHERE GROUP_CODE = ? ";
	pstmt		= conn.prepareStatement(query);
	pstmt.setString(1, groupCode);
	rs			= pstmt.executeQuery();
	if (rs.next()) {
		Id  		= rs.getInt("ID");
		groupName	= rs.getString("GROUP_NAME");
		groupImg	= rs.getString("PERSONAL_IMG");
		cateCode	= rs.getString("CATE_CODE");
	}
}catch(Exception e) {
	out.println(e+"=>"+query);
}
%>
</head>
<body>
	<div class="pop-wrap" id="event_personal">
		<div class="inner">
			<div class="top_visual">
				적정 섭취열량 제시 및<br/>
				<span>나에게 맞는 <strong>잇슬림 퍼스널 코칭프로그램</strong></span>을<br/>
				추천해드립니다.
			</div>
			<div class="result_box result2">
				<div class="top_text">
					<strong><%=eslMemberId %></strong> 고객님의 data 분석결과,<br/>
					<span><%=groupName %></span>를<br class="mHide"/>
					추천해드립니다.
				</div>
				<div class="img">
					<img src="/data/goods/<%=groupImg %>"/>
				</div>
				<div class="btns">
	<a href="javascript:self.close();" onclick="goAndClose();" >자세히 보러가기</a>
				</div>
			</div>
			<p class="em">*개인의 1일 처방열량에 근거하여 적합한 제품을 추천해드립니다. <br/>해당 내용은 의학적 정보와 관련이 없음을 안내드립니다.</p>
		</div>
	</div>
	<script type="text/javascript">
	var filter_;
	var url;
	$(document).ready(function() {
		var filter = "win16|win32|win64|mac|macintel";
		if ( navigator.platform ) {
			if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
				filter_ = 'm';
			} else {
				filter_ = 'p';
			}
		}
	});
	function goAndClose() {
		if(filter_=='m'){
			url = '/mobile/shop/order_view.jsp?cateCode=<%=cateCode %>&cartId=<%=Id %>&pramType=list';
		}else{
			url = '/shop/order_view.jsp?cateCode=<%=cateCode %>&cartId=<%=Id %>&groupCode=<%=groupCode %>&pramType=list';
		}
		opener.location.href = url;
		this.close;
	}
	</script>
</body>
</html>
