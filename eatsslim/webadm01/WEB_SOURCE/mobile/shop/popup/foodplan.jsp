<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.*"%>
<%@ page import = "javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/mobile/common/include/inc-top.jsp"%>
<%@ include file="/lib/config.jsp"%>
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
int setId			= 0;
String setName		= "";
String prdtName		= "";
String cateName		= "";
int weekDay			= 0;
String[] weekName	= {"토","일","월","화","수","목","금"};
String addClass		= "";

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

if (cateCode.equals("") || cateCode == null) {
	cateCode		= (Integer.parseInt(cDate) >= 20140101)? "0300700" : "0300584";
} else {
	if (Integer.parseInt(cDate) >= 20140101) {
		if (cateCode.equals("0300585")) {
			cateCode		= "0300701";
		} else if (cateCode.equals("0300586")) {
			cateCode		= "0300702";
		} else if (cateCode.equals("0300584")) {
			cateCode		= "0300700";
		} else {
			cateCode		= cateCode;
		}
	} else {
		if (cateCode.equals("0300701")) {
			cateCode		= "0300585";
		} else if (cateCode.equals("0300702")) {
			cateCode		= "0300586";
		} else if (cateCode.equals("0300700")) {
			cateCode		= "0300584";
		} else {
			cateCode		= cateCode;
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

query		= "SELECT CATE_NAME FROM ESL_GOODS_CATEGORY WHERE CATE_CODE = '"+ cateCode +"'";
try {
	rs	= stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}


if (rs.next()) {
	cateName		= rs.getString("CATE_NAME");
}

rs.close();
%>
</head>
<body>
	<div class="ui-header-fixed ui-shadow" style="overflow:hidden;">
		<%@ include file="/mobile/common/include/inc-header.jsp"%>
	</div>
	<div id="scheduleMonth">
	<div class="scheduleMonth_head">
		<%if (preYear == 2013 && preMonth == 9) {%>
		<a href="javascript:void(0);" class="prevMonth"><img src="/mobile/common/images/ico/ico_prevMonth.png" alt=""> </a>
		<%} else {%>
		<a href="foodplan.jsp?ccode=<%=cateCode%>&year=<%=preYear %>&month=<%=preMonth%>" class="prevMonth"></a>
		<%}%>
		<div class="currentMonth"><%=month%>월의 식단</div>
		<a href="foodplan.jsp?ccode=<%=cateCode%>&year=<%=nextYear %>&month=<%=nextMonth%>" class="nextMonth"></a>
	</div>	
	</div>
	<div id="cboxContent">
		<div class="pop_header">
		    <h1><%=cateName%> 식단표</h1>
		</div>
	    <div class="pop_content">
		    <ul class="foodplan">
				<%
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
					nDayCnt++;
				}

				int j = 0;
				boolean bHoliday;

				for (i = startDay; i <= endDay; i++) {
					bHoliday = false;
					weekDay		= week % 7;
					chkMonth	= (month < 10)? "0" + Integer.toString(month) : Integer.toString(month);
					chkDay		= (i < 10)? "0" + Integer.toString(i) : Integer.toString(i);
					nowDate		= Integer.toString(year) +"-"+ chkMonth +"-"+ chkDay;

					for (j=0;j<nDayCnt;j++) {
						if (nowDate.equals(arrholidayId[j])) {
							bHoliday = true;
							break;
						}
					}

					// 2015-05-05, 2015-05-25 휴무로 인한 추가 요청 반영
					if (bHoliday || nowDate.equals("2015-01-01") || nowDate.equals("2015-02-18") || nowDate.equals("2015-02-19") || nowDate.equals("2015-02-20") || nowDate.equals("2015-05-05") || nowDate.equals("2015-05-25")) {
						setName		= arrholidayName[j];
						prdtName	= arrholidayName[j];
						addClass	= "";
					} else {
						query		= "SELECT S.ID, SET_NAME";
						query		+= " FROM ESL_GOODS_CATEGORY_SCHEDULE CS, ESL_GOODS_SET S, ESL_GOODS_SET_ORIGIN SO";
						query		+= " WHERE CS.SET_CODE = S.SET_CODE AND S.ID = SO.SET_ID";
						query		+= " AND CATEGORY_CODE = '"+ cateCode +"'";
						query		+= " AND DEVL_DATE = '"+ nowDate +"'";
						query		+= " ORDER BY PRDT_NAME";
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
							setName		= rs.getString("SET_NAME");
						}

						if (weekDay == 6) {
							addClass	= "fri";
						} else {
							addClass	= "";
						}
						
						query		= "SELECT PRDT_NAME FROM ESL_GOODS_SET_ORIGIN WHERE SET_ID = "+ setId +" ORDER BY ID";
						try {
							rs	= stmt.executeQuery(query);
						} catch(Exception e) {
							out.println(e+"=>"+query);
							if(true)return;
						}
						prdtName	= "";
						while (rs.next()) {
							prdtName = rs.getString("PRDT_NAME");
						}
						//rs.close();						
					}
					if(weekDay != 0 && weekDay != 1){
						if (cateCode.equals("0301590")) {
				%>
                <li><span class="day"><%=chkMonth%>/<%=chkDay%> <%=weekName[weekDay]%></span><span class="foodtag"><%=prdtName%></span></li>
				<%
						} else {
				%>
                <li class="<%=addClass%>"><span class="day"><%=chkMonth%>/<%=chkDay%> <%=weekName[weekDay]%></span><span class="foodtag"><%=setName%></span></li>
				<%
						}
					} else if (cateCode.equals("0301590")) {
						if(weekDay == 0){
				%>
                <li><span class="day"><%=chkMonth%>/<%=chkDay%> <%=weekName[weekDay]%></span><span class="foodtag"><%=prdtName%></span></li>
				<%
						} else {
				%>
                <li class="fri"><span class="day"><%=chkMonth%>/<%=chkDay%> <%=weekName[weekDay]%></span><span class="foodtag"><%=prdtName%></span></li>
				<%							
						}
					}
					week++;
				}
				%>
            </ul>
	    </div>
		<!-- End contentpop -->
	</div>
</body>
</html>