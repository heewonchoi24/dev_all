<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");
NumberFormat nf		= NumberFormat.getNumberInstance();
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
} else if (!ut.isNaN(cateCode)) {
	cateCode = "0300584";
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
	</div>
	<!-- End ui-header -->
	<!-- Start Content -->
	<div id="content" class="oldClass">
		<h1 class="ui-bar-a"><span class="ui-btn-inner"><span class="ui-btn-text">식단스케쥴</span></span></h1>
		<div id="scheduleMonth">
			<div class="scheduleMonth_head">
				<%if (preYear == 2013 && preMonth == 9) {%>
				<a href="javascript:void(0);" class="prevMonth"><img src="/mobile/common/images/ico/ico_prevMonth.png" alt=""> </a>
				<%} else {%>
				<a href="schedule.jsp?ccode=<%=cateCode%>&year=<%=preYear %>&month=<%=preMonth%>" class="prevMonth"></a>
				<%}%>
				<div class="currentMonth"><%=month%>월의 식단</div>
				<a href="schedule.jsp?ccode=<%=cateCode%>&year=<%=nextYear %>&month=<%=nextMonth%>" class="nextMonth"></a>
			</div>
			<div class="scheduleMonth_body">
				<ul>
					<li><a href="/mobile/shop/popup/foodplan.jsp?ccode=0301368&year=<%=year %>&month=<%=month%>" class="iframe cboxElement">헬씨퀴진</a></li>
					<li><a href="/mobile/shop/popup/foodplan.jsp?ccode=0300584&year=<%=year %>&month=<%=month%>" class="iframe cboxElement">퀴진</a></li>
					<li><a href="/mobile/shop/popup/foodplan.jsp?ccode=0300586&year=<%=year %>&month=<%=month%>" class="iframe cboxElement">알라까르떼 슬림</a></li>
					<li><a href="/mobile/shop/popup/foodplan.jsp?ccode=0300965&year=<%=year %>&month=<%=month%>" class="iframe cboxElement">알라까르떼 헬씨</a></li>
					<li><a href="/mobile/shop/popup/foodplan.jsp?ccode=0301590&year=<%=year %>&month=<%=month%>" class="iframe cboxElement">미니밀</a></li>
				</ul>
			</div>
			<div class="scheduleMonth_foot">
				※ 잇슬림 식단은 계절 메뉴, 신메뉴 출시 등의 이슈에 따라 일부 메뉴가 식단표와 상이할 수 있습니다.
			</div>
		</div>
	</div>
	<!-- End Content -->
	<div class="ui-footer">
		<%@ include file="/mobile/common/include/inc-footer.jsp"%>
	</div>
</div>
</body>
</html>