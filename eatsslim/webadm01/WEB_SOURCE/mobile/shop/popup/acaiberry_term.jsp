<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp" %>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
String query			= "";
int groupId				= 0;
String groupName		= "";
int tSalePrice			= 0;
int price				= 0;
String groupInfo		= "";
String groupCode		= "";
String offerNotice		= "";
int categoryId			= 0;
String categoryName		= "";

query		= "SELECT ID, GROUP_NAME, GROUP_PRICE, GROUP_INFO, OFFER_NOTICE, GROUP_CODE FROM ESL_GOODS_GROUP WHERE GUBUN1 = '60' AND GUBUN2 = '03' AND  GROUP_CODE = '0070679' ";
pstmt		= conn.prepareStatement(query);
rs			= pstmt.executeQuery();

if (rs.next()) {
	groupId			= rs.getInt("ID");
	groupName		= rs.getString("GROUP_NAME");
	price			= rs.getInt("GROUP_PRICE");
	groupInfo		= rs.getString("GROUP_INFO");
	offerNotice		= rs.getString("OFFER_NOTICE");
	groupCode		= rs.getString("GROUP_CODE");
	
}

rs.close();
pstmt.close();
%>


</head>
<body>
	<div class="pop-wrap">
		<div class="headpop">
		    <h2>상품정보제공고시</h2>
            <button id="cboxClose" type="button">close</button>
            <div class="clear"></div>
		</div>
	    <div class="contentpop">
			<%=offerNotice%>
	    </div>
		<!-- End contentpop -->
</div>  
</body>
</html>