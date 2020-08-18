<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-login-check.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
request.setCharacterEncoding("euc-kr");

String query		= "";
String query1		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
stmt1				= conn.createStatement();
int goodsCnt		= 0;
String devlDate		= ut.inject(request.getParameter("devl_date").replace(".","-"));
String devlDay		= ut.inject(request.getParameter("devl_day"));
String devlWeek		= ut.inject(request.getParameter("devl_week"));
String gid			= ut.inject(request.getParameter("gid"));
String groupCode	= "";
int devlDays		= Integer.parseInt(devlDay) * Integer.parseInt(devlWeek);
int chkCnt			= 0;
String minDate		= "";
String maxDate		= "";
String chkMonth		= "";
String chkDay		= "";
String nowDate		= "";
int i				= 0;
String groupName	= "";
int groupId			= 0;
String addClass		= "";
String memo			= "";
String payDate		= ut.inject(request.getParameter("pdate"));
int linkWeek		= 0;
Calendar cal		= Calendar.getInstance();
int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);

String today		= nowYear +"-"+ nowMonth +"-"+ nowDay;
String strYear		= request.getParameter("year");
String strMonth		= request.getParameter("month");
String week_day		= ut.inject(request.getParameter("week_day"));
int schWeek			= 0;
if (request.getParameter("sch_week") != null && request.getParameter("sch_week").length()>0)
	schWeek			= Integer.parseInt(request.getParameter("sch_week"));
int weekDay			= (week_day.equals("") || week_day == null || week_day.equals("undefined"))? 0 : Integer.parseInt(week_day);
int cnt				= 0;

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

SimpleDateFormat dt	= new SimpleDateFormat("yyyy-MM-dd");
Date date			= null;
int j				= 0;
int k				= 0;
int maxK			= 0;
for (j = 0; j < 50; j++) {
	date			= dt.parse(devlDate);
	cal.setTime(date);
	cal.add(Calendar.DATE, j);
	if (devlDay.equals("6")) {
		if (cal.get(cal.DAY_OF_WEEK) == 1) {
			k++;
		} else {
			maxK++;
		}
	} else {
		if (cal.get(cal.DAY_OF_WEEK) == 7 || cal.get(cal.DAY_OF_WEEK) == 1) {
			k++;
		} else {
			maxK++;
		}
	}

	if (maxK > devlDays) break;
}
devlDays		= (devlDays + k) - 1;

query		= "SELECT GROUP_CODE FROM ESL_GOODS_GROUP WHERE ID = "+ gid;
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	groupCode		= rs.getString("GROUP_CODE");
}
%>

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar.css" />
	<link rel="stylesheet" type="text/css" media="print" href="/common/css/fullcalendar.print.css" />
	<style>
	#calendar {
		width: 800px;
		margin: 0 auto;
	}
	</style>
</head>
<body>
<div class="pop-wrap">
	<div class="headpop">
		<h2>첫 배송일 확인</h2>
		<p>고객님께서 선택하신 배송기간에 공휴일이 있습니다. 배송여부를 확인해 주십시오.</p>
	</div>
	<div class="contentpop">
		<div class="popup columns offset-by-one">
			<div class="row">
				<div class="one last col">
					<p class="floatleft">첫 배송일</p>
					<div class="floatleft">
						<input name="set_devl_date" id="set_devl_date" class="date-pick" value="<%=devlDate%>" readonly="readonly" style="width:80px;" />
					</div>
					<div class="clear"></div>
				</div>
				<div class="one last col">
					<form name="frm_devl" id="frm_devl" method="post">
						<input type="hidden" name="mode" value="ins" />
						<input type="hidden" name="group_code" value="<%=groupCode%>" />
						<table class="spectable" width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<th>휴무일</th>
								<th>휴무명</th>
								<th>배송여부확인</th>
							</tr>
							<%
							query		= "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME FROM ESL_SYSTEM_HOLIDAY";
							query		+= " WHERE HOLIDAY BETWEEN '"+ devlDate +"' AND DATE_ADD('"+ devlDate +"', INTERVAL "+ devlDays +" DAY)";
							query		+= " AND HOLIDAY_TYPE = '01'";
							try {
								rs	= stmt.executeQuery(query);
							} catch(Exception e) {
								out.println(e+"=>"+query);
								if(true)return;
							}

							while (rs.next()) {
							%>
							<input type="hidden" name="holiday" value="<%=rs.getString("HOLIDAY")%>" />
							<tr>
								<td><%=rs.getString("HOLIDAY")%></td>
								<td><%=rs.getString("HOLIDAY_NAME")%></td>
								<td class="last" style="text-align:center;">
									<select name="devl_yn" class="formsel">
										<option value="Y" selected="selected">배송을 받습니다.</option>
										<option value="N">배송을 받지 않습니다.</option>
									</select>
								</td>
							</tr>
							<%
							}
							%>
						</table>
					</form>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="one last col center">
				<span class="button large light"><a href="javascript:;" onclick="setHoliday();">확인</a></span>
			</div>
		</div>
		<!-- End row -->
		<div class="divider"></div>
		<div class="row">
			<div class="one last col">
					<div id="calendar" class="fc fc-ltr">
						<table class="fc-header" style="width:100%">
							<tbody>
								<tr>
									<td class="fc-header-left"></td>
									<td class="fc-header-center">
										<span class="fc-button fc-button-prev fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onClick="location.href='deliveryDate.jsp?year=<%=preYear%>&month=<%=preMonth%>&devl_date=<%=devlDate%>&devl_day=<%=devlDay%>&devl_week=<%=devlWeek%>&gid=<%=gid%>'">
											<span class="fc-text-arrow"></span>
										</span>
										<span class="fc-header-title">
											<h2><%=year%> <b><%=month%></b></h2>
										</span>
										<span class="fc-button fc-button-next fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onClick="location.href='deliveryDate.jsp?year=<%=nextYear%>&month=<%=nextMonth%>&devl_date=<%=devlDate%>&devl_day=<%=devlDay%>&devl_week=<%=devlWeek%>&gid=<%=gid%>'">
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
										<th class="fc-day-header fc-sun fc-widget-header fc-first" style="width: 100px;">일(Sun)</th>
										<th class="fc-day-header fc-mon fc-widget-header" style="width: 100px;">월(Mon)</th>
										<th class="fc-day-header fc-tue fc-widget-header" style="width: 100px;">화(Tue)</th>
										<th class="fc-day-header fc-wed fc-widget-header" style="width: 100px;">수(Wed)</th>
										<th class="fc-day-header fc-thu fc-widget-header" style="width: 100px;">목(Thu)</th>
										<th class="fc-day-header fc-fri fc-widget-header" style="width: 100px;">금(Fri)</th>
										<th class="fc-day-header fc-sat fc-widget-header fc-last">토(Sat)</th>
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
									week		= (schWeek > 0)? schWeek : 1;
									for (i = startDay; i <= endDay; i++) {										
										chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
										chkDay		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
										nowDate		= Integer.toString(year) +"-"+ chkMonth +"-"+ chkDay;
										date			= dt.parse(nowDate);
										cal.setTime(date);
										weekDay		= cal.get(cal.DAY_OF_WEEK);
										addClass	= "";
										memo		= "";
										groupName	= "";
										%>
										<input type="hidden" name="week_day" value="<%=weekDay%>" />
										<%
										query		= "SELECT COUNT(*) FROM DUAL";
										query		+= " WHERE '"+ nowDate +"' BETWEEN '"+ devlDate +"' AND DATE_ADD('"+ devlDate +"', INTERVAL "+ devlDays +" DAY)";
										try {
											rs	= stmt.executeQuery(query);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										if (rs.next()) {
											chkCnt		= rs.getInt(1);
										}
										rs.close();

										if (chkCnt > 0) {
											if (devlDay.equals("6")) {
												if (weekDay == 1) { //일요일은 배송을 하지 않는다
												} else {
													addClass		= " deliday";
													memo			= "<span class=\"memo\">잇슬림 오는날</span>";
												}
											} else {
												if (weekDay == 1 || weekDay == 7) { //토,일요일은 배송을 하지 않는다
												} else {
													addClass		= " deliday";
													memo			= "<span class=\"memo\">잇슬림 오는날</span>";
												}
											}
										}
									%>
										<td class="fc-day fc-sun fc-widget-content fc-past fc-first<%=addClass%><%if (newLine == 6) out.println(" fc-last");%>" data-date="<%=nowDate%>">	
											<div>
												<div class="fc-day-number"><%=i%><%=memo%></div>
												<div class="fc-day-content"><%=groupName%></div>
											</div>
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
										<td class="fc-day fc-sun fc-widget-content fc-past<%if (newLine == 6) out.println(" fc-last");%>">
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
		</div>
		<!-- End popup columns offset-by-one --> 
	</div>
	<!-- End contentpop --> 
	<div id="floatMenu" style="display:none;">
		<%@ include file="/common/include/inc-floating.jsp"%>
	</div>
</div>
<script type="text/javascript">
function setHoliday() {
	$.post("deliveryDate_ajax.jsp", $("#frm_devl").serialize(),
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				$("#set_holiday", opener.document).val("Y");
				self.close();
			} else {
				$(data).find("error").each(function() {
					$(data).find("error").each(function() {
						alert($(this).text());
					});
				});
			}
		});
	}, "xml");
	return false;
}
</script>
</body>
</html>