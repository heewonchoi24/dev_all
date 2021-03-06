<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import ="java.util.regex.*"%>
<%@ page import ="javax.servlet.http.HttpSession"%>
<%@ page import ="java.text.*"%>
<%@ include file="/lib/config.jsp"%>
<%@ include file="/common/include/inc-top.jsp"%>
<%
String table		= "\n ESL_GOODS_GROUP G, ESL_ORDER_GOODS OG, ESL_ORDER O \n";
String query		= "";
String query1		= "";
String query2		= "";
Statement stmt1		= null;
ResultSet rs1		= null;
Statement stmt2		= null;
ResultSet rs2		= null;
String minDate		= "";
String maxDate		= "";
String devlDates	= "";
stmt1				= conn.createStatement();
stmt2				= conn.createStatement();
String stdate		= ut.inject(request.getParameter("stdate"));
String ltdate		= ut.inject(request.getParameter("ltdate"));
String stateType	= ut.inject(request.getParameter("state_type"));
String where		= "";
String param		= "";
String orderNum		= "";
String orderDate	= "";
/* int payPrice		= 0; */
String payType		= "";
String orderState	= "";
String gubun1		= "";
String groupId		= "";
int cnt				= 0;
String goodsList	= "";
int listSize		= 0;
String gId			= "";
String groupCode	= "";
String dispCateName		= "";
ArrayList<HashMap<String,String>> list = new ArrayList<HashMap<String,String>>();

String browser		= ut.inject(request.getHeader("User-Agent"));
//String browser		= "Mozilla/5.0 (Windows NT 10.0; Trident/4.0; rv:11.0) like Gecko";

NumberFormat nf		= NumberFormat.getNumberInstance();

where			= "  WHERE G.ID = OG.GROUP_ID\n";
where			+= " AND OG.ORDER_NUM = O.ORDER_NUM\n";
where			+= " AND O.ORDER_STATE > 0\n";
where			+= " AND O.ORDER_STATE < 90\n";
where			+= " AND O.ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')\n";
where			+= " AND TIMESTAMPDIFF(MONTH,O.ORDER_DATE,SYSDATE()) < 11\n"; //-- 10개월까지
where			+= " AND OG.DEVL_TYPE = '0001'\n";//-- 일일배송만
where			+= " AND O.ORDER_NUM IN (SELECT ORDER_NUM FROM (SELECT ORDER_NUM,MAX(DEVL_DATE) AS DEVL_DATE FROM ESL_ORDER_DEVL_DATE WHERE CUSTOMER_NUM='"+eslCustomerNum+"' GROUP BY ORDER_NUM)A WHERE DEVL_DATE >= NOW())"; //-- CUSTOMER_NUM INDEX 추가해야 함
where			+= " AND O.MEMBER_ID = '"+ eslMemberId +"'\n";


query		= "SELECT COUNT(*)";
query		+= " FROM "+ table + where; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

if (rs.next()) {
	cnt		= rs.getInt(1);
}
rs.close();

query		= "SELECT \n";
query		+= " O.ORDER_NUM, DATE_FORMAT(O.ORDER_DATE, '%Y.%m.%d') ORDER_DATE, O.ORDER_NAME, O.PAY_TYPE, O.PAY_PRICE,\n";
query		+= " O.ORDER_STATE, O.ORDER_ENV,\n";
query		+= " GROUP_NAME, GUBUN1, GUBUN2, DEVL_TYPE, ORDER_CNT, PRICE, BUY_BAG_YN,\n";
query		+= " DEVL_DAY, DEVL_WEEK, DEVL_PRICE, DATE_FORMAT(DEVL_DATE, '%Y%m%d') DEVL_DATE, OG.ID, G.GROUP_CODE,G.ID AS GROUP_ID,\n";
query		+= " RCV_ADDR1, RCV_ADDR2, DEVL_DAY, DEVL_TYPE, CART_IMG, GROUP_IMGM, PRICE, DEVL_PRICE, G.DISP_CATE_NAME\n";
query		+= " FROM "+ table + where;
query		+= " ORDER BY O.ORDER_NUM DESC, OG.DEVL_DATE"; //out.print(query); if(true)return;
try {
	rs = stmt.executeQuery(query);
} catch(Exception e) {
	out.println(e+"=>"+query);
	if(true)return;
}

//-- 자바스크립트 처음 값 설정
String jsOrderNum		 = ut.inject(request.getParameter("jsOrderNum"));
String jsGoodsId		 = ut.inject(request.getParameter("jsGoodsId"));
String jsGroupCode		 = ut.inject(request.getParameter("jsGroupCode"));
String jsStartDate		 = "";
String jsEndDate		 = "";
///////////////////////////
%>

<link rel="stylesheet" type="text/css" media="all" href="/common/css/fullcalendar_cal.css" />
<link rel="stylesheet" type="text/css" media="all" href="/common/css/datepicker.css">
<link rel="stylesheet" type="text/css" media="all" href="/common/css/mypage.css" />
<script src="/mobile/common/js/datepicker.js" charset="utf-8"></script>
<script type="text/javascript" src="/common/js/mypage.js"></script>

</head>
<body>
<div id="wrap">
	<div id="header">
		<%@ include file="/common/include/inc-header.jsp"%>
	</div>
	<!-- End header -->
	<div id="container">
		<div class="mypage_contain">
			<div class="path">
				<span>HOME</span><span>마이페이지</span><strong>배송캘린더</strong>
			</div>
			<div class="mypage_tabNavi">
				<ul>
					<li>
						<a href="index.jsp">마이페이지</a>
					</li>
					<li>
						<a href="orderList.jsp">주문내역조회</a>
					</li>
					<li class="active">
						<a href="calendar.jsp">배송캘린더</a>
					</li>
					<li>
						<a href="couponList.jsp">쿠폰리스트</a>
					</li>
					<li>
						<a href="myqna.jsp">1:1 문의내역</a>
					</li>
				</ul>
			</div>
			<div class="mypage_calendar_area calendar_area">
<%
if(browser.indexOf("Trident/4.0") > -1){
%>
				<div class="ie8Chk">
					<p>배송캘린더 기능은 <strong>익스플로러 8</strong>버전을 지원하지 않습니다.<br/> <strong>익스플로러 11</strong>이나 <strong>크롬</strong> 등의 최신 브라우저를 사용해 주세요.<p>
					<a href="https://www.google.co.kr/chrome/browser/desktop/index.html" target="_blank" class="btn sky">Chrome 다운로드</a>
				</div>

<%}else{%>
				<div class="calendar_head">
					<div class="calendar_select selectbox">
						<label></label>
						<select name="" id="" class="notCustom" onchange="selectbox(this); setOrderInfo(this);">
<%
if (cnt > 0) {
	while (rs.next()) {
		
		String goodsDiv		= "";
		String cartImg		= "";
		String groupImg		= "";
		String imgUrl		= "";
		String groupName    = "";
		int price			= 0;
		int goodsId			= 0;
		String rcvAddr1		= "";
		String rcvAddr2		= "";
		String devlDay 		= "";
		minDate				= "";
		maxDate				= "";
		devlDates			= "";

		orderNum	= rs.getString("ORDER_NUM");
		orderDate	= (rs.getString("ORDER_DATE") == null)? "" : rs.getString("ORDER_DATE");
		payPrice	= rs.getInt("PAY_PRICE");
		orderState	= rs.getString("ORDER_STATE");
		payType		= rs.getString("PAY_TYPE");
		groupName	= rs.getString("GROUP_NAME");
		dispCateName = ut.isnull(rs.getString("DISP_CATE_NAME") );


		goodsId		= rs.getInt("ID");
		devlDay		= rs.getString("DEVL_DAY");
		groupCode	= rs.getString("GROUP_CODE");
		rcvAddr1	= rs.getString("RCV_ADDR1");
		rcvAddr2	= rs.getString("RCV_ADDR2");






		/* goodsDiv		+= ut.getGubun1Name(rs.getString("GUBUN1")) +"<p class=\"option\">("+ ut.getGubun2Name(rs.getString("GUBUN2")) +": "+ rs.getString("GROUP_NAME") + ")</p>"; */

		/* 사용안함
		goodsDiv		= ut.getGubun1Name(rs.getString("GUBUN1"));
		goodsDiv		+= "(";
		if(!"&nbsp;".equals(ut.getGubun2Name(rs.getString("GUBUN2")))) goodsDiv		+= ut.getGubun2Name(rs.getString("GUBUN2")) +": ";
		goodsDiv		+= rs.getString("GROUP_NAME") + ")";
		*/

		if("".equals(dispCateName)){
			goodsDiv		= rs.getString("GROUP_NAME");
		}
		else{
			goodsDiv		= dispCateName + "(" + rs.getString("GROUP_NAME") + ")";
		}



		if (rs.getString("DEVL_TYPE").equals("0001")) {
			query2		= "SELECT MIN(DEVL_DATE) MIN_DATE, MAX(DEVL_DATE) MAX_DATE";
			query2		+= " FROM ESL_ORDER_DEVL_DATE WHERE ORDER_NUM = '"+ orderNum +"'";
			query2		+= " AND GOODS_ID = '"+ goodsId +"'";
			query2		+= " AND GROUP_CODE <> '0300668'"; //-- 장바구니는 노출하지 않는다.

			try {
				rs2			= stmt2.executeQuery(query2);
			} catch(Exception e) {
				out.println(e+"=>"+query2);
				if(true)return;
			}
			if (rs2.next()) {
				minDate			= rs2.getString("MIN_DATE");
				maxDate			= rs2.getString("MAX_DATE");
				devlDates		= ut.isnull(minDate) +"~"+ ut.isnull(maxDate);
			}
		}

		price			= (rs.getString("DEVL_TYPE").equals("0001"))? rs.getInt("PRICE") : rs.getInt("PRICE") + rs.getInt("DEVL_PRICE");
		groupImg		= rs.getString("GROUP_IMGM");
		if (groupImg.equals("") || groupImg == null) {
			imgUrl		= "/mobile/images/nivo_sample01.png";
		} else {
			imgUrl		= webUploadDir +"goods/"+ groupImg;
		}

		//-- 자바스크립트 초기값
		if("".equals(jsOrderNum) ){
			jsOrderNum = orderNum;
			jsGoodsId = goodsId+"";
			jsGroupCode = groupCode;
		}

		//-- 선택한 주문에 대한 달력표시용
		if(jsOrderNum.equals(orderNum) && jsGroupCode.equals(groupCode)){
			gubun1		= rs.getString("GUBUN1");
			groupId		= rs.getString("GROUP_ID");
			jsStartDate = minDate;
			jsEndDate = maxDate;
		}
%>
									<option value="<%=orderNum%>|<%=goodsId%>|<%=groupCode %>" <%=jsOrderNum.equals(orderNum) && jsGoodsId.equals(goodsId+"") ? " selected":"" %>><%=goodsDiv%></option>
<%
	}
%>
<% } else { %>
						<option value="">최근 구매하신 내역이 없습니다.</option>
<% } %>
						</select>
					</div>
					<div class="calendar_range">
						<dl>
							<dt>배송기간</dt>
							<dd><%=jsStartDate.replaceAll("-",".")%> ~ <%=jsEndDate.replaceAll("-",".")%></dd>
						</dl>
					</div>
				</div>
				<div class="calendar_body">
					<div id="bx_calendar">
<%
if("".equals(jsOrderNum)){
	out.print("최근 구매하신 내역이 없습니다.");
}
%>
					</div>
				</div>
<%
if(!"".equals(jsOrderNum)){
	//-- 주문된 내용이 있다면 출력
%>
				<div class="calendar_foot">
					<div class="calender_opt">
						<ul>
<%
	if(!"02".equals(gubun1) && !"110".equals(groupId)){
%>
							<li><a href="javascript:void(0);" onclick="goEditPopup('__ajax_calendar_changepattern1.jsp');">
								<div class="img"><img src="/dist/images/common/ico_calendar_pattern.png" alt="" /></div>
								<p>배송요일 변경</p>
							</a></li>
<%
	}
%>
							<li><a href="javascript:void(0);" onclick="goEditPopup('__ajax_calendar_changeschedule1.jsp');">
								<div class="img"><img src="/dist/images/common/ico_calendar_range.png" alt="" /></div>
								<p>배송일정 변경</p>
							</a></li>
							<li><a href="javascript:void(0);" onclick="goEditPopup('__ajax_calendar_changearea1.jsp');">
								<div class="img"><img src="/dist/images/common/ico_calendar_area.png" alt="" /></div>
								<p>배송지 변경</p>
							</a></li>
						</ul>
					</div>
				</div>
<% } %>
<%}%>
			</div>
		</div>
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
var orderNum = "<%=jsOrderNum%>";
var goodsId = "<%=jsGoodsId%>";
var groupCode = "<%=jsGroupCode%>";
var startDate = "";
var endDate = "";
var calData;
function setOrderInfo(me){
	var arrayOption = me.value.split("|");
	orderNum = arrayOption[0];
	goodsId = arrayOption[1];
	groupCode = arrayOption[2];
	var param = "jsOrderNum=" +  orderNum + "&jsGoodsId=" +  goodsId + "&jsGroupCode=" +  groupCode + "";
	location.href="calendar.jsp?"+param;
}

function goEditPopup(url){
	var param = "orderNum=" +  orderNum + "&goodsId=" +  goodsId + "&groupCode=" +  groupCode + "";
	modalFn.show(url+'?'+param);
}

function setReCalendar(){

    var events = [];
    for(var i = 0; i <= calData.data.length-1; i++){
    	for(var j = 0; j <= calData.data[i].list.length-1; j++){
    		//if(calData.data[i].rangetype == "start") startDate = calData.data[i].year+'-'+calData.data[i].month+'-'+calData.data[i].day;
    		//if(calData.data[i].rangetype == "end") endDate = calData.data[i].year+'-'+calData.data[i].month+'-'+calData.data[i].day;
    		events.push({
    			//title: '['+calData.data[i].list[j].title+'] \r\n'+calData.data[i].list[j].subTitle+' x'+calData.data[i].list[j].quantity,
    			//title: calData.data[i].list[j].title,
    			//title: '<div class="tit">[알라까르떼헬씨]</div><div class="subtit">새송이버섯 치킨샐러드 <span>x1</span></div>',
    			title: '<div class="tit">['+calData.data[i].list[j].title+']</div><div class="subtit">'+calData.data[i].list[j].subTitle+' <span>x'+calData.data[i].list[j].quantity+'</span></div>',
    			start: calData.data[i].year+'-'+calData.data[i].month+'-'+calData.data[i].day
    		});
    	}
    }
    return events;
}
function setMyCalendar(){
	//console.log("orderNum="+orderNum);
	//console.log("goodsId="+goodsId);
	//console.log("groupCode="+groupCode);
	//console.log("startDate= "+startDate);
	//console.log("endDate= "+endDate);
	if(orderNum != ""){
		$("#bx_calendar").html("");
		$('#bx_calendar').fullCalendar({
			hiddenDays : [0,6],
			left: "",
			center : "title",
		 	right : "",
			editable : false,
			contentHeight: 1000,
//		 	titleFormat : {
//		 		month : "yyyy년 MMMM",
//		 		week  : "[yyyy] MMM dd일{ [yyyy] MMM dd일}",
//		 		day   : "yyyy년 MMM d일 dddd"
//		 	},
			defaultView : "month",
			monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			dayNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"],
			dayNamesShort: ["SUNDAY","MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY"],
			buttonText: {
				today:"오늘",
				month:"월별",
				week:"주별",
				day:"일별"
			},
			dayRender: function(date, cell) {
				if(startDate == cell.data('date')){
		        	cell.append('<span class="fc-day-start">start</span>')
		        }else if(endDate == cell.data('date')){
		        	cell.append('<span class="fc-day-end">end</span>')
		        }
		    },
		    events: function(start, end, timezone, callback) {
		    	if(calData == null){
			        $.ajax({
			            url : '__json_calendarSample.jsp',
			            dataType:  "json",
			            type : 'GET',
					    async : false,
			            data: {
			                orderNum: orderNum,
			                goodsId: goodsId,
			                groupCode: groupCode
			            },
			            success: function(o) {
			            	calData = o || {};
			            	//console.log(calData);

			            	for(var i = 0; i <= calData.data.length-1; i++){
					            if (calData.data[i].rangetype == "start"){
					            	startDate = calData.data[i].year + "-" + calData.data[i].month + "-" + calData.data[i].day;
					            }
					            else if (calData.data[i].rangetype == "end"){
					            	endDate = calData.data[i].year + "-" + calData.data[i].month + "-" + calData.data[i].day;
					            }
					        }

			            	var events = setReCalendar();
			            	callback(events);
			            }
			        });
		    	}
		    	else{
		    		var events = setReCalendar();
	            	callback(events);
		    	}
		    },
		    eventRender: function(event, element) {
		        var html = $(element.find('.fc-title').text());
		        element.find('.fc-title').html(html);
		    },
		    eventClick: function( event, jsEvent, view ) {
		    	var currentYear = event.start._d.getFullYear();
		        var currentMonth = event.start._d.getMonth()+1;
		        var currentDate = event.start._d.getDate();

		    	var content = "";
		    	content += '<div class="pop-wrap style2">';
		    	content += 		'<div class="headpop">';
		    	content += 			'<h2>'+currentYear+'년 '+currentMonth+'월 '+currentDate+'일 <span>배송상품<span></h2>';
		    	content += 		'</div>';
		    	content += 		'<div class="contentpop">';
		    	content += 			'<div class="popup columns offset-by-one">';
		    	content += 				'<ul class="prdList">';
		    	for(var i = 0; i <= calData.data.length-1; i++){
		            if ((currentYear == parseInt(calData.data[i].year)) && (currentMonth == calData.data[i].month) && (currentDate == parseInt(calData.data[i].day))){
		                for(var j = 0; j <= calData.data[i].list.length -1; j++){
		        content +=        			'<li>';
		        content +=        				'<div class="photo"><img src="'+calData.data[i].list[j].image+'"></div>';
		        content +=        				'<div class="info">';
		        content +=        					'<div class="title">['+calData.data[i].list[j].title+']</div>';
		        content +=        					'<div class="subTitle">'+calData.data[i].list[j].subTitle+' x '+calData.data[i].list[j].quantity+'</div>';
		        content +=        				'</div>';
		        content +=        			'</li>';
		                }
		            }
		        }
		        content += 				'</ul>';

		    	content += 			'</div>';
		    	content += 		'</div>';
		    	content +=	 '</div>';



		    	var html = $(content);
		    	$.lightbox(html, {
					width   : 510,
					height  : 400
				});

		    }
		});
	}
}
setMyCalendar();
</script>

</body>
</html>
<%@ include file="/lib/dbclose.jsp"%>