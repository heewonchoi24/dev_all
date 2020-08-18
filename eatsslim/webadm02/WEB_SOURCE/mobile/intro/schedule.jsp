<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int i				= 0;
String chkMonth		= "";
String chkDay		= "";
String nowDate		= "";
String cateCode		= ut.inject(request.getParameter("ccode"));
if (cateCode.equals("") || cateCode == null) {
	cateCode		= "0300584";
} else {
	cateCode		= cateCode;
}
int setId			= 0;
String setName		= "";
String prdtName		= "";

Calendar cal		= Calendar.getInstance();

int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);

String today		= nowYear +"-"+ nowMonth +"-"+ nowDay;
String strYear		= request.getParameter("year");
String strMonth		= request.getParameter("month");

int year			= nowYear;
int month			= nowMonth;

if (strYear != null) {
	year				= Integer.parseInt(strYear);
}
if (strMonth != null) {
	month				= Integer.parseInt(strMonth);
}

int preYear=year, preMonth=month-1;
if (preMonth < 1) {
	preYear				= year-1;
	preMonth			= 12; 
}

int nextYear=year,nextMonth=month+1;
if (nextMonth>12) {
	nextYear			= year+1;
	nextMonth			= 1;
}

cal.set(year,month-1,1);
int startDay		= 1;
int endDay			= cal.getActualMaximum(Calendar.DAY_OF_MONTH);

int week			= cal.get(Calendar.DAY_OF_WEEK);
%>

</head>
<body>
<div id="wrap">
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
		<ul class="subnavi">
			<li><a href="/mobile/customer/service.jsp">주문안내</a></li>
			<li><a href="/mobile/goods/cuisine.jsp">제품소개</a></li>
			<li class="current"><a href="/mobile/intro/schedule.jsp">이달의 식단</a></li>
		</ul>
	</div>
	<!-- End ui-header --> 
	<!-- Start Content -->
	<div id="content" style="margin-top:135px;">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">식단스케쥴</span></span></h1>
		<div class="grid-navi">
			<table class="navi" cellspacing="10" cellpadding="0">
				<tr>
					<td width="55">
						<%if (preYear == 2013 && preMonth == 9) {%>
						<a class="monthnavi" href="javascript:;"><span class="prev"><%=preMonth%>월</span></a>
						<%} else {%>
						<a class="monthnavi" href="schedule.jsp?ccode=<%=cateCode%>&year=<%=preYear %>&month=<%=preMonth%>"><span class="prev"><%=preMonth%>월</span></a>
						<%}%>
					</td>
					<td><a href="schedule.jsp?ccode=<%=cateCode%>&year=<%=year%>&month=<%=month%>" class="ui-btn ui-btn-inline ui-btn-up-b"><span class="ui-btn-inner"><span class="ui-btn-text"><%=month%>월의 식단</span></span></a></td>
					<td width="55"><a class="monthnavi" href="schedule.jsp?ccode=<%=cateCode%>&year=<%=nextYear %>&month=<%=nextMonth%>"><span class="next"><%=nextMonth%>월</span></a></td>
				</tr>
			</table>
		</div>
		<ul class="ui-listview">
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow ui-first-child"> <a class="iframe" href="/mobile/shop/popup/foodplan.jsp?ccode=0300584&year=<%=year %>&month=<%=month%>"><span class="ui-btn-inner"><span class="ui-btn-text">퀴진</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow"> <a class="iframe" href="/mobile/shop/popup/foodplan.jsp?ccode=0300586&year=<%=year %>&month=<%=month%>"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼 슬림</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
			<li class="ui-li ui-btn-up-e ui-btn-icon-right ui-li-has-arrow"> <a class="iframe" href="/mobile/shop/popup/foodplan.jsp?ccode=0300965&year=<%=year %>&month=<%=month%>"><span class="ui-btn-inner"><span class="ui-btn-text">알라까르떼 헬씨</span></span></a><span class="ui-icon ui-icon-arrow-r"> </span> </li>
		</ul>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>