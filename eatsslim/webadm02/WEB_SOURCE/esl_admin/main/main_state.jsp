<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.text.*"%>
<%@ include file="../lib/config.jsp"%>
<%@ include file="../include/inc-login-check.jsp"%>
<%@ include file="../include/inc-top.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>Pulmuone EATSSLIM 관리자시스템</title>
<link rel="stylesheet" type="text/css" href="/css/styles.css" />
<!--[if lte IE 6]>
	<link rel="stylesheet" href="css/ie6.css" type="text/css" media="all">
	<script src="js/DD_belatedPNG-min.js" type="text/javascript"></script>
    <script type="text/javascript">
        DD_belatedPNG.fix('div, ul, li, img, input, h1, h2, a');
    </script>
<![endif]-->
<!--[if lte IE 7]><link rel="stylesheet" href="css/ie7.css" type="text/css" media="all"><![endif]-->
<!--[if lte IE 8]><link rel="stylesheet" href="css/ie8.css" type="text/css" media="all"><![endif]-->
<script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/js/menu_model.js"></script>
<script type="text/javascript" src="/js/menu_model2.js"></script>
<script type="text/javascript" src="/js/main.js"></script>
<%@ include file="../include/inc-cal-script.jsp" %>
<style type="text/css">
html, body { height:auto; background:#fff;}
.scrollBox {position:relative;overflow-y:scroll;overflow-x:hidden; width:367px; height:443px;}
</style>
</head>
<body>
<h2>&#8226; 매출 추세</h2>
<table class="table01" border="1" cellspacing="0">
	<colgroup>
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
		<col width="15%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col" style="text-align:center">일실적</th>
			<th scope="col" style="text-align:center">당월누적</th>
			<th scope="col" style="text-align:center">전월동기</th>
			<th scope="col" style="text-align:center">전월대비(%)</th>
			<th scope="col" style="text-align:center">전년동기</th>
			<th scope="col" style="text-align:center">전년대비(%)</th>
		</tr>
	</thead>
	<tbody>
<%
String query	= "";
NumberFormat nf	= NumberFormat.getNumberInstance();
double idata1=0,idata2=0,idata3=0,idata4=0,idata5=0,idata6=0;
double ddata1=0,ddata2=0,ddata3=0,ddata4=0,ddata5=0,ddata6=0;

query		= "SELECT ";
query		+= "(SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND DATE_FORMAT(ORDER_DATE, '%Y%m%d') = DATE_FORMAT(NOW(), '%Y%m%d')) DATE1";
query		+= ", (SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND DATE_FORMAT(ORDER_DATE, '%Y%m') = DATE_FORMAT(NOW(), '%Y%m')) DATE2";
cal.setTime(new Date()); //이번달
String thisMonth=(new SimpleDateFormat("yyyyMM")).format(cal.getTime());
if (thisMonth.equals("201311")) {
	query		+= ", (SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND ORDER_DATE < 20131101) DATE3";
} else {
	query		+= ", (SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND DATE_FORMAT(ORDER_DATE, '%Y%m') = DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 MONTH), '%Y%m')) DATE3";
}
query		+= ", (SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND DATE_FORMAT(ORDER_DATE, '%Y') = DATE_FORMAT(NOW(), '%Y')) DATE4";
query		+= ", (SELECT SUM(PRICE * ORDER_CNT) FROM ESL_ORDER_DEVL_DATE WHERE STATE < 90 AND DATE_FORMAT(ORDER_DATE, '%Y') = DATE_FORMAT(DATE_ADD(NOW(), INTERVAL -1 YEAR), '%Y')) DATE5";
query		+= " FROM DUAL";
try {
	rs = stmt.executeQuery(query);
} catch(Exception e){
	out.println(e+"=>"+query);
	if(true)return;
}

if(rs.next()){ 
	idata1=rs.getDouble("DATE1");
	idata2=rs.getDouble("DATE2");
	idata3=rs.getDouble("DATE3");
	idata4=rs.getDouble("DATE4");
	idata5=rs.getDouble("DATE5");

	if(idata3>0)ddata1=(idata2/idata3)*100;
	if(idata5>0)ddata2=(idata4/idata5)*100;
}
rs.close();
%>
		<tr bgcolor="white">					
			<td align="right"><%=nf.format(idata1)%>&nbsp;&nbsp;</td>
			<td align="right"><%=nf.format(idata2)%>&nbsp;&nbsp;</td>
			<td align="right"><%=nf.format(idata3)%>&nbsp;&nbsp;</td>
			<td align="right"><%=nf.format(Math.round(ddata1))%>&nbsp;&nbsp;</td>
			<td align="right"><%=nf.format(idata5)%>&nbsp;&nbsp;</td>
			<td align="right"><%=nf.format(Math.round(ddata2))%>&nbsp;&nbsp;</td>
		</tr>
	</tbody>
</table>

</body>
</html>
<%@ include file="../lib/dbclose.jsp" %>