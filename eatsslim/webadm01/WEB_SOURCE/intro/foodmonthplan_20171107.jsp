<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
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
String categoryCode	= ut.inject(request.getParameter("ccode"));
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
String cDate		= (new SimpleDateFormat("yyyyMMdd")).format(cal.getTime());

int year			= nowYear;
int month			= nowMonth;

if (strYear != null) {
	year				= Integer.parseInt(strYear);
}
if (strMonth != null) {
	month				= Integer.parseInt(strMonth);
}

if (!ut.isNaN(categoryCode)) {
	categoryCode = "0300700";
}

if (categoryCode.equals("") || categoryCode == null) {
	categoryCode		= (Integer.parseInt(cDate) >= 20140101)? "0300700" : "0300584";
} else {
	if (Integer.parseInt(cDate) >= 20140101) {
		if (categoryCode.equals("0300585")) {
			categoryCode		= "0300701";
		} else if (categoryCode.equals("0300586")) {
			categoryCode		= "0300702";
		} else if (categoryCode.equals("0300584")) {
			categoryCode		= "0300700";
		} else {
			categoryCode		= categoryCode;
		}
	} else {
		if (categoryCode.equals("0300701")) {
			categoryCode		= "0300585";
		} else if (categoryCode.equals("0300702")) {
			categoryCode		= "0300586";
		} else if (categoryCode.equals("0300700")) {
			categoryCode		= "0300584";
		} else {
			categoryCode		= categoryCode;
		}
	}
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

	<link rel="stylesheet" type="text/css" href="/common/css/fullcalendar.print.css" />

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<h1>
				�ս��� �̴��� �Ĵ�
			</h1>
			<div class="pageDepth">
				<span>HOME</span><strong>�ս��� �̴��� �Ĵ�</strong>
			</div>
			<div class="clear">
			</div>
		</div>
		<div class="sixteen columns offset-by-one">
			<!-- <div class="row">
				<div class="one last col">
					<div class="foodplan-topnavi">
						<div class="navicaption">
							<p class="f18">�ս����� ���ִ� �Ĵ�</p>
							<p class="monthtitle"><%=month%>���� �Ĵ�</p>
							<p class="description">�ս����� ü������ �Ѵ� �Ĵ��� �Ѵ��� �� �� �ֽ��ϴ�.</p>
						</div>
						<div class="navi-wrapper">
							<div class="button darkgreen small">
								<%if (preYear == 2013 && preMonth == 9) {%>
								<a href="javascript:;">&lt; &nbsp;&nbsp;<%=preMonth%>���� �Ĵ�</a>
								<%} else {%>
								<a href="foodmonthplan.jsp?ccode=<%=categoryCode%>&year=<%=preYear %>&month=<%=preMonth%>">&lt; &nbsp;&nbsp;<%=preMonth%>���� �Ĵ�</a>
								<%}%>
							</div>
							<div class="button darkgreen small">
								<a href="foodmonthplan.jsp?ccode=<%=categoryCode%>&year=<%=nextYear %>&month=<%=nextMonth%>"><%=nextMonth%>���� �Ĵ�&nbsp;&nbsp; &gt;</a>
							</div>

						</div>
						End navi-wrapper

					</div>
				</div>
			</div> -->

			<div class="row">
					<ul class="foodmonthtab floatleft">
						<li<%if (categoryCode.equals("0301368") || categoryCode.equals("0301368")) out.println(" class=\"current\"");%>><a href="foodmonthplan.jsp?ccode=0301368">�ﾾ����</a></li>
						<li<%if (categoryCode.equals("0300584") || categoryCode.equals("0300700")) out.println(" class=\"current\"");%>><a href="foodmonthplan.jsp?ccode=0300584">����</a></li>
						<li<%if (categoryCode.equals("0300586") || categoryCode.equals("0300702")) out.println(" class=\"current\"");%>><a href="foodmonthplan.jsp?ccode=0300586">�˶��� ����</a></li>
						<li<%if (categoryCode.equals("0300965")) out.println(" class=\"current\"");%>><a href="foodmonthplan.jsp?ccode=0300965">�˶��� �ﾾ</a></li>
					</ul>
			</div>
			<!-- <%if (categoryCode.equals("0300584") || categoryCode.equals("0300700")) { %>
			<div class="row">
			<p><font style="font-weight:bold; color:blue;"> �� ù ����� ���ÿ� ���� �������� ��ǰ ��� �ȳ� �� </font> </p>
			<p style="margin-left:10px">����������ǰ �ֹ� ��, ù ����� ���ÿ� ���� �ֹ��Ϸκ��� 4������ 5�������� ���������ڳӿ��߲����� �޴��� ����Ÿ�������Ұ�⼼Ʈ�� �޴��� ���� ��۵˴ϴ�.(���� ���� ����) <br>
			���� �Ĵ��� ���� ���� �Ĵ� �����ٴ�� ��۵Ǹ�, �ֹ��Ϸκ��� ù ������� 6�� ���� ����, ���� ���� �Ĵ� �����ٴ�� ��۵˴ϴ�.</p>
			</div>
			<% } %> -->
			<!-- End row -->
			<div class="row">
				<div class="one last col">
					<div id="calendar" class="fc fc-ltr">
						<table class="fc-header" style="width:100%">
							<tbody>
								<tr>
									<td class="fc-header-left"></td>
									<td class="fc-header-center">
										<span class="fc-button fc-button-prev fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onClick="location.href='foodmonthplan.jsp?ccode=<%=categoryCode%>&year=<%=preYear %>&month=<%=preMonth%>'">
											<span class="fc-text-arrow"></span>
										</span>
										<span class="fc-header-title">
											<h2><%=year%> <b><%=month%></b></h2>
										</span>
										<span class="fc-button fc-button-next fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onClick="location.href='foodmonthplan.jsp?ccode=<%=categoryCode%>&year=<%=nextYear %>&month=<%=nextMonth%>'">
											<span class="fn-text-arrow"></span>
										</span>
									</td>
									<td class="fc-header-right"></td>
								</tr>
							</tbody>
						</table>
						<div class="fc-content" style="position: relative;">
							<div class="fc-view fc-view-month fc-grid" style="position: relative; -moz-user-select: none;" unselectable="on">
								<table class="fc-border-separate" cellspacing="0" style="width:100%">
									<thead>
										<tr class="fc-first fc-last">
										<th class="fc-day-header fc-sun fc-widget-header fc-first" style="width: 70px;">��(Sun)</th>
										<th class="fc-day-header fc-mon fc-widget-header" style="width: 185px;">��(Mon)</th>
										<th class="fc-day-header fc-tue fc-widget-header" style="width: 185px;">ȭ(Tue)</th>
										<th class="fc-day-header fc-wed fc-widget-header" style="width: 185px;">��(Wed)</th>
										<th class="fc-day-header fc-thu fc-widget-header" style="width: 185px;">��(Thu)</th>
										<th class="fc-day-header fc-fri fc-widget-header" style="width: 185px;">��(Fri)</th>
										<th class="fc-day-header fc-sat fc-widget-header fc-last" style="width: 70px;">��(Sat)</th>
										</tr>
									</thead>
									<tbody>
									<%
									int newLine=0;
									out.print("<tr class='fc-week fc-first'>");
									for (i = 1; i < week; i++) {
									%>
										<td class="fc-day fc-sun fc-widget-content fc-past fc-first">
											<div>
												<div class="fc-day-content"></div>
											</div>
										</td>
									<%
										newLine++;
									}
									chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
									query		= "SELECT DATE_FORMAT(HOLIDAY, '%Y-%m-%d') HOLIDAY, HOLIDAY_NAME";
									query		+= " FROM ESL_SYSTEM_HOLIDAY WHERE DATE_FORMAT(HOLIDAY, '%Y') =  '"+ year  + "' AND DATE_FORMAT(HOLIDAY, '%m') =  '"+  chkMonth  + "' AND HOLIDAY_TYPE = '02' ";
									query		+= " ORDER BY HOLIDAY DESC, ID DESC";
									//out.println(query);
									pstmt		= conn.prepareStatement(query);
									rs			= pstmt.executeQuery();

									String arrholidayId[] =  new String[31];
									String arrholidayName[] =  new String[31];
									int nDayCnt = 0;
									while (rs.next()) {
										arrholidayId[nDayCnt]		= rs.getString("HOLIDAY");
										arrholidayName[nDayCnt]		= rs.getString("HOLIDAY_NAME");
										System.out.println("arrholidayId[nDayCnt] ::"+arrholidayId[nDayCnt]);
										System.out.println("arrholidayName[nDayCnt] ::"+arrholidayName[nDayCnt]);
										nDayCnt++;
									}

									int j = 0;
									boolean bHoliday;
									String surHolidayName = "";
									for (i = startDay; i <= endDay; i++) {
										bHoliday = false;
										chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
										chkDay		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
										nowDate		= Integer.toString(year) +"-"+ chkMonth +"-"+ chkDay;

										for (j=0;j<nDayCnt;j++) {
											if (nowDate.equals(arrholidayId[j])) {
												bHoliday = true;
												surHolidayName = arrholidayName[j];
												System.out.println("surHolidayName ::"+surHolidayName);
											}
										}

										// 2015-05-05, 2015-05-25 �޹��� ���� �߰� ��û �ݿ�
										if (bHoliday || nowDate.equals("2015-01-01") || nowDate.equals("2015-02-18") || nowDate.equals("2015-02-19") || nowDate.equals("2015-02-20") || nowDate.equals("2015-05-05") || nowDate.equals("2015-05-25")) {
											setName		= "";
											prdtName		= "";
										} else {
											query		= "SELECT S.ID, SET_NAME";
											query		+= " FROM ESL_GOODS_CATEGORY_SCHEDULE CS, ESL_GOODS_SET S";
											query		+= " WHERE CS.SET_CODE = S.SET_CODE";
											query		+= " AND CATEGORY_CODE = '"+ categoryCode +"'";
											query		+= " AND DEVL_DATE = '"+ nowDate +"'";
											query		+= " ORDER BY SET_NAME";
											try {
												rs	= stmt.executeQuery(query);
											} catch(Exception e) {
												out.println(e+"=>"+query);
												if(true)return;
											}

											setName		= "";
											prdtName	= "";
											while (rs.next()) {
												setId		= rs.getInt("ID");
												setName		= "<span class=\"memo\"><strong>"+ rs.getString("SET_NAME") +"</strong></span><br />";
											}
											rs.close();

											query		= "SELECT PRDT_NAME FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = "+ setId +" ORDER BY ID";
											try {
												rs	= stmt.executeQuery(query);
											} catch(Exception e) {
												out.println(e+"=>"+query);
												if(true)return;
											}
											prdtName	= "";
											while (rs.next()) {
												prdtName	+= "��"+ rs.getString("PRDT_NAME") +"<br />";
											}
											rs.close();
										}
									%>
										<td class="fc-day fc-mon fc-widget-content fc-past<%if (newLine == 6) out.println(" fc-last");%>" data-date="<%=nowDate%>">
											<%if (setName.equals("") || setName == null) {%>
												<div>
													<div class="fc-day-number"><%=i%></div>
													<div class="fc-day-content">
													<%
														if (bHoliday) { out.print("<strong>"+ surHolidayName +"</strong>"); }
													%>
													</div>
												</div>
											<%} else {%>
											<a class="lightbox" href="/shop/cuisineinfo/cuisineA.jsp?lightbox[width]=780&lightbox[height]=645&set_id=<%=setId%>">
												<div>
													<div class="fc-day-number"><%=i%></div>
													<div class="fc-day-content"><%=setName+prdtName%></div>
												</div>
											</a>
											<%}%>
										</td>
									<%
										newLine++;
										if (newLine == 7 && i != endDay) {
											out.print("</tr><tr class='fc-week fc-last'>");
											newLine=0;
										}
									}

									while (newLine > 0 && newLine < 7) {
									%>
										<td class="fc-day fc-sat fc-widget-content fc-past<%if (newLine == 6) out.println(" fc-last");%>">
											<div>
												<div class="fc-day-content"></div>
											</div>
										</td>
									<%
										newLine++;
									}
									out.print("</tr>");
									%>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End row -->
		<div class="clear"></div>
			<div class="floatright">
				<a href="javascript:;" onClick="window.print();return false;"><img src="/dist/images/ico/ico_print.png"/> �μ��ϱ�</a>
			</div>

			<div class="row">
				<div class="foodmonthNotice">
					<div class="em">�� ù ����� ���ÿ� ���� �������� ��ǰ �޴� �ȳ� ��</div>
					<p><span>1.</span> �ֹ��Ϸκ��� ù ������� 4�� �Ǵ� 5�� ���� ��� :  4������ 5�������� ���������ڳӿ��߲����� �Ǵ�  ����Ÿ�������Ұ�⼼Ʈ�� �� ���� ���<br/> 6�������� ����  �Ĵ� �����ٴ�� ���</p>
					<p><span>2.</span> �ֹ��Ϸκ��� ù ������� 6�� ���� ��� :  ���� �Ĵ� �����ٴ�� ���</p>
					<div class="em">�� �����޴�, �Ÿ޴� ��� ���� �̽��� ���� �Ϻ� �޴��� �Ĵ�ǥ�� ������ �� �ֽ��ϴ�.</div>
				</div>
			</div>

		</div>
		<!-- End sixteen columns offset-by-one -->
		<div class="clear"></div>
	</div>
	<!-- End container -->
    <%@ include file="/common/include/inc-cart.jsp"%>
	<!-- End container -->
	<div id="footer">
		<%@ include file="/common/include/inc-footer.jsp"%>
	</div>
	<!-- End footer -->
	<div id="floatMenu">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
</body>
</html>