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
String orderNum		= ut.inject(request.getParameter("ono"));
System.out.println("orderNum : "+orderNum);
String rsOrderNum	= "";
String rsGroupCode	= "";
String minDate		= "";
String maxDate		= "";
String chkMonth		= "";
String chkDay		= "";
String nowDate		= "";
int i				= 0;
String groupName	= "";
String gubunCode	= "";
int groupId			= 0;
String ordState		= "";
String addClass		= "";
String memo			= "";
String payDate		= ut.inject(request.getParameter("pdate"));
int linkWeek		= 0;
int goodsId			= 0;
if (request.getParameter("gid") != null && request.getParameter("gid").length()>0)
	goodsId			= Integer.parseInt(request.getParameter("gid"));

Calendar cal		= Calendar.getInstance();

int nowYear			= cal.get(Calendar.YEAR);
int nowMonth		= cal.get(Calendar.MONTH)+1;
int nowDay			= cal.get(Calendar.DAY_OF_MONTH);
int nowHour			= cal.get(Calendar.HOUR_OF_DAY);

String today		= nowYear +"-"+ nowMonth +"-"+ nowDay;
String strYear		= request.getParameter("year");
String strMonth		= request.getParameter("month");

String week_day		= ut.inject(request.getParameter("week_day"));
int schWeek			= 0;
if (request.getParameter("sch_week") != null && request.getParameter("sch_week").length()>0)
	schWeek			= Integer.parseInt(request.getParameter("sch_week"));
System.out.println("schWeek : "+schWeek);
int weekDay			= (week_day.equals("") || week_day == null || week_day.equals("undefined"))? 0 : Integer.parseInt(week_day);
int cnt				= 0;

int year			= nowYear;
int month			= nowMonth;

String groupCode	= ut.inject(request.getParameter("gno"));
if (year > 2013 && month > 1) {
	if (groupCode.equals("0300601")) {
		groupCode		= "0300717";
	} else if (groupCode.equals("0300602")) {
		groupCode		= "0300718";
	} else if (groupCode.equals("0300603")) {
		groupCode		= "0300719";
	} else if (groupCode.equals("0300604")) {
		groupCode		= "0300720";
	} else if (groupCode.equals("0300605")) {
		groupCode		= "0300721";
	} else if (groupCode.equals("0300606")) {
		groupCode		= "0300722";
	} else if (groupCode.equals("0300607")) {
		groupCode		= "0300723";
	} else if (groupCode.equals("0300608")) {
		groupCode		= "0300724";
	} else {
		groupCode		= groupCode;
	}
} else {
	if (groupCode.equals("0300717")) {
		groupCode		= "0300601";
	} else if (groupCode.equals("0300718")) {
		groupCode		= "0300602";
	} else if (groupCode.equals("0300719")) {
		groupCode		= "0300603";
	} else if (groupCode.equals("0300720")) {
		groupCode		= "0300604";
	} else if (groupCode.equals("0300721")) {
		groupCode		= "0300605";
	} else if (groupCode.equals("0300722")) {
		groupCode		= "0300606";
	} else if (groupCode.equals("0300723")) {
		groupCode		= "0300607";
	} else if (groupCode.equals("0300724")) {
		groupCode		= "0300608";
	} else {
		groupCode		= groupCode;
	}
}

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

	<link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar.css" />
	<link rel="stylesheet" type="text/css" media="print" href="/common/css/fullcalendar.print.css" />
	<style>
	#calendar {
		width: 100%;
		margin: 0 auto;
	}
	</style>
	<link rel="stylesheet" type="text/css" href="/common/js/_calendars/jquery.datepick.layer.css" />
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick.ext.js"></script>
	<script type="text/javascript" src="/common/js/_calendars/jquery.datepick-ko.js"></script>
</head>
<body>
<div style="display: none;">
	<img id="calImg" src="/images/calendar.png" alt="Popup" class="trigger" style="vertical-align:middle;" />
</div>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div class="container">
		<div class="maintitle">
			<div class="pageDepth">
				<span>홈</span><span>마이페이지</span><strong>주문내역조회</strong>
			</div>
			<div class="clear"></div>
		</div>
		<div class="sixteen columns offset-by-one">
			<div class="row">
				<div class="one last  col">
					<ul class="tabNavi">
						<li><a href="index.jsp">마이페이지</a></li>
						<li class="active"><a href="orderList.jsp">주문내역조회</a></li>
						<li><a href="calendar.jsp">배송캘린더</a></li>
						<li><a href="couponList.jsp">쿠폰리스트</a></li>
						<li><a href="myqna.jsp">1:1 문의내역</a></li>
						<div class="button small iconBtn light">
							<% if("U".equals(eslMemberCode) ){ %><a href="https://member.pulmuone.co.kr/customer/custModify_R1.jsp?siteno=0002400000" target="_blank"><span class="gear"></span> 회원정보수정</a><% } %>
						</div>
					</ul>
				<div class="clear"></div>
			</div>
		</div>
		<div class="row">
			<div class="one last col">
				<ul class="listSort">
					<li><a href="/shop/mypage/orderList.jsp">주문/배송조회</a></li>
					<li><a href="/shop/mypage/reorderList.jsp">취소/교환/반품조회</a></li>
					<li><span class="current">배송일자변경</span></li>
				</ul>
				<div class="clear"></div>
			</div>
		</div>
		<div class="row">
			<div class="one last col">
				<div class="orderSearch">
					<label for="select">주문</label>
						<%
						query		= "SELECT OG.ID, G.GROUP_NAME, G.GROUP_CODE, OG.ORDER_NUM, DATE_FORMAT(O.PAY_DATE, '%Y-%m-%d') PAY_DATE";
						query		+= " FROM ESL_ORDER O, ESL_ORDER_GOODS OG, ESL_GOODS_GROUP G ";
						query		+= " WHERE O.ORDER_NUM = OG.ORDER_NUM AND OG.GROUP_ID = G.ID";
						query		+= " AND OG.DEVL_TYPE = '0001'";
						query		+= " AND O.MEMBER_ID ='"+ eslMemberId +"'";
						query		+= " AND OG.ORDER_STATE in ( 1, 911 )";
						query		+= " ORDER BY OG.ORDER_NUM DESC";
						try {
							rs	= stmt.executeQuery(query);
						} catch(Exception e) {
							out.println(e+"=>"+query);
							if(true)return;
						}
						%>
						<select name="order_num" id="order_num" onChange="cngGoods();">
							<%
							while (rs.next()) {
								if (i == 0) {
									orderNum	= (orderNum.equals("") || orderNum == null)? rs.getString("ORDER_NUM") : orderNum;
									groupCode	= (groupCode.equals("") || groupCode == null)? rs.getString("GROUP_CODE") : groupCode;
									payDate		= (payDate.equals("") || payDate == null)? rs.getString("PAY_DATE") : payDate;
									goodsId		= (goodsId > 0)? goodsId : rs.getInt("ID");
								}
								rsOrderNum	= rs.getString("ORDER_NUM");
								rsGroupCode	= rs.getString("GROUP_CODE");

								// 프로그램 다이어트와 수프의 경우 유저 배송일 조정은 일시적으로 막는다
								//if (rsGroupCode.length() > 6) {
							%>
							<option value="<%=rsOrderNum%>|<%=rsGroupCode%>|<%=rs.getString("PAY_DATE")%>|<%=rs.getInt("ID")%>"<%if (rs.getInt("ID") == goodsId) out.println(" selected=\"selected\"");%>><%=rs.getString("GROUP_NAME")%></option>
							<%
								//}
								i++;
							}
							rs.close();

							if (orderNum != null && orderNum.length()>0)
							{
								query		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
								query		+= " FROM ESL_ORDER_DEVL_DATE";
								query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
								query		+= " 	AND STATE < 91 ";
								try {
									rs	= stmt.executeQuery(query);
								} catch(Exception e) {
									out.println(e+"=>"+query);
									if(true)return;
								}

								if (rs.next()) {
									minDate		= rs.getString("MIN_DATE");
									maxDate		= rs.getString("MAX_DATE");
								}
							}
							%>
						</select>
						<span class="padl50">기간 : <%=ut.isnull(minDate)%> ~ <%=ut.isnull(maxDate)%></span>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="one last col">
					<div id="calendar" class="fc fc-ltr">
						<table class="fc-header" style="width:100%">
							<tbody>
								<tr>
									<td class="fc-header-left"></td>
									<td class="fc-header-center">
										<span class="fc-button fc-button-prev fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onclick="location.href='delichange.jsp?year=<%=preYear %>&month=<%=preMonth%>&ono=<%=orderNum%>&gid=<%=goodsId%>&gno=<%=groupCode%>&pdate=<%=payDate%>'">
											<span class="fc-text-arrow"></span>
										</span>
										<span class="fc-header-title">
											<h2><%=year%> <b><%=month%></b></h2>
										</span>
										<span class="fc-button fc-button-next fc-state-default fc-corner-left fc-corner-right" unselectable="on" style="-moz-user-select: none;" onclick="nextMonth();">
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
										<th class="fc-day-header fc-sun fc-widget-header fc-first" style="width: 126px;">일(Sun)</th>
										<th class="fc-day-header fc-mon fc-widget-header" style="width: 126px;">월(Mon)</th>
										<th class="fc-day-header fc-tue fc-widget-header" style="width: 126px;">화(Tue)</th>
										<th class="fc-day-header fc-wed fc-widget-header" style="width: 126px;">수(Wed)</th>
										<th class="fc-day-header fc-thu fc-widget-header" style="width: 126px;">목(Thu)</th>
										<th class="fc-day-header fc-fri fc-widget-header" style="width: 126px;">금(Fri)</th>
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
									week			= (schWeek > 0)? schWeek : 1;
									for (i = startDay; i <= endDay; i++) {
										chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
										chkDay		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
										nowDate		= Integer.toString(year) +"-"+ chkMonth +"-"+ chkDay;

										query		= "SELECT COUNT(ID)";
										query		+= " FROM ESL_ORDER_DEVL_DATE";
										query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
										query		+= " AND DEVL_DATE = '"+ nowDate +"'";
										query		+= " AND STATE in ('01', '02')";
										try {
											rs	= stmt.executeQuery(query);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										if (rs.next()) {
											cnt			= rs.getInt(1);
										} else {
											cnt			= 0;
										}

										rs.close();

										query		= "SELECT ";
										query		+= "	(SELECT GROUP_NAME FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"') GROUP_NAME, ";
										query		+= "	(SELECT ID FROM ESL_GOODS_GROUP WHERE GROUP_CODE = '"+ groupCode +"') GROUP_ID, ";
										query		+= "	GROUP_CODE, STATE ";
										query		+= " FROM ESL_ORDER_DEVL_DATE";
										query		+= " WHERE ORDER_NUM = '"+ orderNum +"' AND GOODS_ID = "+ goodsId;
										query		+= " AND DEVL_DATE = '"+ nowDate +"'";
										query		+= " AND STATE in ('01', '02')";
										try {
											rs	= stmt.executeQuery(query);
										} catch(Exception e) {
											out.println(e+"=>"+query);
											if(true)return;
										}

										memo = "";
										int memoIdx = 0;
										while (rs.next()) {
											/* System.out.println("groupCode ::::"+ groupCode);
											System.out.println("orderNum ::::"+ orderNum);
											System.out.println("goodsId ::::"+ goodsId);
											System.out.println("nowDate ::::"+ nowDate); */
											groupId			= rs.getInt("GROUP_ID");
											ordState		= rs.getString("STATE");
											if (memoIdx == 0 ) {
												groupName		= rs.getString("GROUP_NAME") +"("+ cnt +")<br />";
											}
											gubunCode		= rs.getString("GROUP_CODE");
											addClass		= " deliday";
											memo			= "<span class=\"memo\">잇슬림 오는날</span>";

											if (groupCode.length() < 7) {
												if (gubunCode.equals("0300668")) {
													groupName		+= "ㄴ 배송가방<br />";
												} else if (gubunCode.equals("0071285")) {
													groupName		+= "ㄴ 리프레시클렌즈 세트<br />";
												} else if (ordState.equals("02")) {
													groupName		+= "ㄴ 증정<br />";
												} else {
													query1		= "SELECT CATEGORY_NAME, AMOUNT";
													query1		+= " FROM ESL_GOODS_GROUP_EXTEND";
													query1		+= " WHERE GROUP_ID = "+ groupId;
													query1		+= " AND WEEK = "+ week;
													linkWeek	= week;
													try {
														rs1 = stmt1.executeQuery(query1);
													} catch(Exception e) {
														out.println(e+"=>"+query1);
														if(true)return;
													}

													while (rs1.next()) {
														groupName		+= "ㄴ"+ rs1.getString("CATEGORY_NAME") + rs1.getInt("AMOUNT") + "<br />";
													}
													weekDay++;
											%>
											<input type="hidden" name="week_day" value="<%=weekDay%>" />
											<%

													if (weekDay == 5) {
														week++;
														weekDay	= 0;
													}

												}
											} else {
												if (gubunCode.equals("0300668")) {
													groupName		+= "ㄴ 배송가방<br />";
												} else if (gubunCode.equals("0071199")) {
													groupName		+= "ㄴ 리프레시클렌즈 세트<br />";
												} else if (gubunCode.equals("0070817")) {
													groupName		+= "ㄴ 자몽&마테 발효녹즙<br />";
												} else if (ordState.equals("02")) {
													groupName		+= "ㄴ 증정<br />";
												} else {
													query1		= "SELECT SET_NAME, THUMB_IMG, AMOUNT";
													query1		+= " FROM ESL_GOODS_GROUP_EXTEND G, ESL_GOODS_SET S, ESL_GOODS_CATEGORY_SCHEDULE CS";
													query1		+= " WHERE G.CATEGORY_ID = S.CATEGORY_ID AND CS.SET_CODE = S.SET_CODE";
													query1		+= " AND CS.DEVL_DATE = '"+ nowDate +"' AND G.GROUP_ID = "+ groupId;
													try {
														rs1 = stmt1.executeQuery(query1);
													} catch(Exception e) {
														out.println(e+"=>"+query1);
														if(true)return;
													}

													while (rs1.next()) {
														groupName		+= "ㄴ"+ rs1.getString("SET_NAME") + rs1.getInt("AMOUNT") + "<br />";
													}
												}
											}

											memoIdx++;
										}
										if (memo.equals("")) {
											groupId			= 0;
											groupName		= "";
											if (nowDate.equals(payDate)) {
												addClass		= " payday";
												memo			= "<span class=\"memo\">결제일</span>";
											} else {
												addClass		= "";
												memo			= "";
											}
										}
										rs.close();
										%>
										<td class="fc-day fc-sun fc-widget-content fc-past fc-first<%=addClass%><%if (newLine == 6) out.println(" fc-last");%>" data-date="<%=nowDate%>">
											<%if ((groupName.equals("") || groupName == null) || groupId < 1) {%>
											<div>
												<div class="fc-day-number"><%=i%><%=memo%></div>
												<div class="fc-day-content"></div>
											</div>
											<%} else {%>
											<%if (groupCode.length()< 7) {%>
											<!--a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740&gid=<%=groupId%>&week=<%=linkWeek%>"-->
												<div>
													<div class="fc-day-number"><%=i%><%=memo%></div>
													<div class="fc-day-content"><%=groupName%></div>
												</div>
											<!--/a-->
											<%} else {%>
											<a class="lightbox" href="/shop/popup/foodplan.jsp?lightbox[width]=640&lightbox[height]=740&gid=<%=groupId%>&sdate=<%=nowDate%>">
												<div>
													<div class="fc-day-number"><%=i%><%=memo%></div>
													<div class="fc-day-content"><%=groupName%></div>
												</div>
											</a>
											<%}%>
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
		<div class="row">
			<div class="one last  col">
				<div class="sectionHeader">
					<h4><span class="f18 font-blue">배송일 변경</span></h4>
				</div>
				<div class="line-box line-blue">
					<span>
						<label>변경 가능한 배송일</label>
						<input name="devl_date1" id="devl_date1" class="date-pick" />
					</span>
					<span class="padl50">
						<label>변경될 배송일</label>
						<input name="devl_date2" id="devl_date2" class="date-pick" />
						<span class="button dark small"><a href="javascript:;" onClick="editDevlDate()">배송일 변경</a></span>
					</span>
				</div>
			</div>
		</div>
		<!-- End row -->
		<!--div class="row">
			<div class="one last  col">
				<div class="sectionHeader">
					<h4><span class="f18 font-green">배송일 변경 내역</span></h4>
				</div>
				<div class="line-box line-green">
					<p>첫 배송일 변경 8.12 => 8.14 [수정일:08.07]</p>
				</div>
			</div>
		</div>
		<!-- End row -->
		<div class="row">
			<div class="one last  col">
				<div class="sectionHeader">
					<h4><span class="f18">배송일 변경 안내</span></h4>
				</div>
				<div class="line-box line-black">
					<p>변경 가능한 배송일과 변경될 배송일 날짜를 입력하신 후 배송일 변경 버튼을 누르시면 적용됩니다.</p>
					<p>배송일 변경은 수령일로부터 D-3일 이후부터 "연기, 취소"에 대한 수정이 가능하고,</p>
					<p>D-6일 이후부터는 "연기, 취소, 앞당기기" 등에 대한 모든 수정이 가능합니다 .</p>
					<p>주말 및 공휴일은 별도 배송이 이루어지지 않으며, 공휴일 배송 수량은 영업일 기준으로, 기존에 등록된 마지막 배송일 다음 날에 수령하실 수 있습니다. </p>
					<p>배송일 변경 시 해당 배송 일자에 적용된 주소지도 함께 변경되오니 참고 부탁드립니다.</p>
					<p>"헬씨퀴진" 단일 제품은 수령일 기준 D-2일 15시 이전까지 "연기,변경,취소"에 대한 수정이 가능합니다.</p>
				</div>
			</div>
		</div>
		<!-- End row -->
	</div>
	<!-- End sixteen columns offset-by-one -->
	<div class="clear"></div>
</div>
<!-- End container -->
<div id="footer">
	<%@ include file="/common/include/inc-footer.jsp"%>
</div>
<!-- End footer -->
<div id="floatMenu">
	<%@ include file="/common/include/inc-floating.jsp"%>
</div>
<%@ include file="/common/include/inc-bottompanel.jsp"%>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#devl_date1").datepick({
		dateFormat: "yyyy-mm-dd",
		minDate: +3,
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
	});
	$("#devl_date2").datepick({
		dateFormat: "yyyy-mm-dd",
<% if (gubunCode.equals("0301369") ) {
		if (nowHour<=14) {
%>
		minDate: +2,
<% 		} else {
%>
		minDate: +3,
<%
		}
	} else if (gubunCode.equals("0301385") ) {
%>
		minDate: +4,
<%
	} else {
%>
		minDate: +6,
<% } %>
		onDate: $.datepick.noSundays,
		showTrigger: '#calImg'
	});
});

(function($) {
	$.extend($.datepick, {
		noSundays: function(date) {
			return {selectable: date.getDay() != 0};
		}
	});
})(jQuery);

function cngGoods() {
	var orderArr	= $("#order_num").val().split("|");
	location.href = "delichange.jsp?ono="+ orderArr[0] +"&gno="+ orderArr[1] +"&pdate="+ orderArr[2] +"&gid="+ orderArr[3];
}

function editDevlDate() {
	var orderArr	= $("#order_num").val().split("|");
	$.post("delichange_ajax.jsp", {
		mode: "editDevl",
		order_num: orderArr[0],
		group_code: orderArr[1],
		subnum: orderArr[3],
		devl_date1: $("#devl_date1").val(),
		devl_date2: $("#devl_date2").val()
	},
	function(data) {
		$(data).find("result").each(function() {
			if ($(this).text() == "success") {
				alert("정상적으로 처리되었습니다.");
				document.location.reload();
			} else {
				$(data).find("error").each(function() {
					alert($(this).text());
				});
			}
		});
	}, "xml");
	return false;
}

function nextMonth() {
	location.href='delichange.jsp?year=<%=nextYear %>&month=<%=nextMonth%>&ono=<%=orderNum%>&gid=<%=goodsId%>&gno=<%=groupCode%>&pdate=<%=payDate%>&week_day=' + $("input[name=week_day]:last").val() + "&sch_week=<%=week%>";
}
</script>
</body>
</html>