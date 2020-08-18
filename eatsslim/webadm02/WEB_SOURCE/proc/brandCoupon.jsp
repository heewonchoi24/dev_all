<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%@ include file="/lib/dbconn_phi.jsp" %>
<%
String cpTable			= "ESL_COUPON";
String query			= "";
int couponId			= 0;
int orderId				= 0;
int couponCnt			= 0;
String couponNum		= "";

query		= "SELECT COUNT(ID) FROM ESL_ORDER WHERE SHOP_TYPE in ('51', '52') AND ORDER_STATE < 90 AND MEMBER_ID = '" + eslMemberId + "' ";
try {
	rs		= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}
if (rs.next()) {
	orderId	= rs.getInt(1);
}
rs.close();


if (orderId > 0) {
	
	query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = '잇슬림 브랜드위크_5% 할인권' AND STDATE = '20160401' AND LTDATE = '20160407'";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}
	if (rs.next()) {
		couponId	= rs.getInt(1);
	}
	rs.close();
	
	query		= "SELECT COUNT(CM.ID) FROM ESL_COUPON C, ESL_COUPON_MEMBER CM";
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ eslMemberId +"' AND C.COUPON_NAME like '%잇슬림 웰컴쿠폰_퀴진 2주%'";
	try {
		rs		= stmt.executeQuery(query);
	} catch(Exception e) {
		out.println(e+"=>"+query);
		if(true)return;
	}

	if (rs.next()) {
		couponCnt	= rs.getInt(1);
	}
	rs.close();


	if (couponCnt > 0) {
		// 이미 발급됨
%>
	<script language="javascript">
		alert("쿠폰을 이미 발급받으셨습니다.");
	</script>	
<%
	} else {
		// 구매회원 발급
		SimpleDateFormat dt	= new SimpleDateFormat("yyMMddHHmmss");
		couponNum		= "ET" + dt.format(new Date()) + "001";

		query		= "INSERT INTO ESL_COUPON_MEMBER (COUPON_ID, COUPON_NUM, MEMBER_ID, USE_YN, INST_DATE)";
		query		+= " VALUES ("+ couponId +",'"+ couponNum +"','"+ eslMemberId +"','N',NOW())";
		try {
			stmt.executeUpdate(query);
		} catch (Exception e) {
			out.println(e);
			if(true)return;
		}
	}
	rs.close();
%>
	<script language="javascript">
		alert("쿠폰이 정상 발급되었습니다.");
	</script>	
<%
} else {
	// 구매 내역 없음
%>
	<script language="javascript">
		alert("구매내역이 없습니다.");
	</script>	
<%
}
%>