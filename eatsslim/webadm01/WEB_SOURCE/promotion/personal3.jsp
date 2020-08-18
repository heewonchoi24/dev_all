<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
if (eslMemberId == null || eslMemberId.equals("")) {
	ut.jsAlert(out, "�α����� ���ּ���.");
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
				���� ���뿭�� ���� ��<br/>
				<span>������ �´� <strong>�ս��� �۽��� ��Ī���α׷�</strong></span>��<br/>
				��õ�ص帳�ϴ�.
			</div>
			<div class="result_box result2">
				<div class="top_text">
					<strong><%=eslMemberId %></strong> ������ data �м����,<br/>
					<span><%=groupName %></span>��<br class="mHide"/>
					��õ�ص帳�ϴ�.
				</div>
				<div class="img">
					<img src="/data/goods/<%=groupImg %>"/>
				</div>
				<div class="btns">
	<a href="javascript:self.close();" onclick="goAndClose();" >�ڼ��� ��������</a>
				</div>
			</div>
			<p class="em">*������ 1�� ó�濭���� �ٰ��Ͽ� ������ ��ǰ�� ��õ�ص帳�ϴ�. <br/>�ش� ������ ������ ������ ������ ������ �ȳ��帳�ϴ�.</p>
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
