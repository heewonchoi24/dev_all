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
	
	query		= "SELECT ID FROM "+ cpTable +" WHERE COUPON_NAME = '�ս��� �귣����ũ_5% ���α�' AND STDATE = '20160401' AND LTDATE = '20160407'";
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
	query		+= " WHERE C.ID = CM.COUPON_ID AND CM.MEMBER_ID = '"+ eslMemberId +"' AND C.COUPON_NAME like '%�ս��� ��������_���� 2��%'";
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
		// �̹� �߱޵�
%>
	<script language="javascript">
		alert("������ �̹� �߱޹����̽��ϴ�.");
	</script>	
<%
	} else {
		// ����ȸ�� �߱�
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
		alert("������ ���� �߱޵Ǿ����ϴ�.");
	</script>	
<%
} else {
	// ���� ���� ����
%>
	<script language="javascript">
		alert("���ų����� �����ϴ�.");
	</script>	
<%
}
%>