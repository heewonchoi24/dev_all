<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
String gId			= "";
String payDate		= "";
//int goodsId			= 0;
int i				= 0;
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
int payPrice		= 0;
String payType		= "";
String orderState	= "";
String gubun1		= "";
String goodsList	= "";
int listSize		= 0;
String chkMonth		= "";
String chkDay		= "";
String nowDate		= "";
String memo			= "";
String ordState		= "";
String addClass		= "";
//int groupId			= 0;
String groupId		= "";
//String groupName	= "";
String gubunCode	= "";
String dispCateName		= "";
int linkWeek		= 0;

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


where			= "  WHERE G.ID = OG.GROUP_ID\n";
where			+= " AND OG.ORDER_NUM = O.ORDER_NUM\n";
where			+= " AND O.ORDER_STATE > 0\n";
where			+= " AND O.ORDER_STATE < 90\n";
where			+= " AND O.ORDER_NUM NOT IN (SELECT ORDER_NUM FROM ESL_ORDER WHERE ORDER_STATE = '00' AND PAY_TYPE = '10')\n";
where			+= " AND TIMESTAMPDIFF(MONTH,O.ORDER_DATE,SYSDATE()) < 11\n"; //-- 10개월 까지
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
String jsOrderNum		 = ut.inject(request.getParameter("ordno"));
String jsGoodsId		 = ut.inject(request.getParameter("goodsId"));
String jsGroupCode		 = ut.inject(request.getParameter("groupCode"));
String jsStartDate		 = "";
String jsEndDate		 = "";
%>
<div class="shop_title">
	<button type="button" class="loc_back" onclick="pSlideFn.onAddCont({direction:'prev'});"><img src="/mobile/common/images/ico/ico_loc_back.png" alt=""></button>
	<p>배송캘린더</p>
</div>
<div class="shop_filter">
	<div class="refreshCalendar">
		<select name="menuSelect" id="menuSelect" class="inp_st" onchange="menuSelectChange(this.value);" class="">
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
		<input type="hidden" id="currentYear" name="currentYear" value=""/>
		<input type="hidden" id="currentMonth" name="currentMonth" value=""/>
		<input type="hidden" id="orderNum" name="orderNum" value="<%=jsOrderNum%>"/>
		<input type="hidden" id="groupCode" name="groupCode" value="<%=jsGroupCode%>"/>
		<input type="hidden" id="goodsId" name="goodsId" value="<%=jsGoodsId%>"/>
		<input type="hidden" id="devlDates" name="devlDates" value=""/>
		<input type="hidden" id="devlDay" name="devlDay" value=""/>
		<input type="hidden" id="goods" name="goods" value=""/>
	</div>
	<div class="date">배송기간 <span><%=jsStartDate%> ~ <%=jsEndDate%></span></div>
</div>
<div class="content">
	<div id="scheduler"></div>
	<div class="scheduler_rangectrl">
		<ul>
<%
	if(!"02".equals(gubun1) && !"110".equals(groupId)){
%>							
			<li><a href="javascript:void(0);" onclick="calendarFn.changePattern();">
			<img src="/mobile/common/images/mypage/ico_d_patternAll.png"><p>배송요일 변경</p></a></li>
<%
	}
%>
			<li><a href="javascript:void(0);" onclick="calendarFn.selectTerm();">
			<img src="/mobile/common/images/mypage/ico_d_scheduleAll.png"><p>배송일정 변경</p></a></li>
			<li><a href="javascript:void(0);" onclick="calendarFn.selectDelivery();">
			<img src="/mobile/common/images/mypage/ico_d_areaAll.png"><p>배송지 변경</p></a></li>
		</ul>
	</div>
</div>


<script src="/mobile/common/js/calendar.js"></script>

<script>
var orderNum = "<%=jsOrderNum%>";
var goodsId = "<%=jsGoodsId%>";
var groupCode = "<%=jsGroupCode%>";
var startDate = "";
var endDate = "";

// 셀렉트 박스 값
function menuSelectChange(v){
	var optionArry = new Array();
	optionArry = v.split("|");
	var option1 = optionArry[0];
	var option2 = optionArry[1];
	var option3 = optionArry[2];

 	pSlideFn.onAddCont({direction:'next',url:'__ajax_mypage_calendar.jsp?ordno='+option1+'&goodsId='+option2+'&groupCode='+option3+''});	//selectBox 선택시 선택한 값 유지
}

var o = o || {},
	h = h || {};
$(function(){
	var Now = new Date();
	if($("#currentYear").val() === undefined){
		currentYear = Now.getFullYear();
    }else{
    	if($("#currentMonth").val() == ""){
    		currentYear	 = Now.getFullYear();
    	}else{
    		currentYear = $("#currentYear").val();
    	}
    }
    if($("#currentMonth").val() === undefined){
    	currentMonth	 = Now.getMonth() + 1;
    }else{
    	if($("#currentMonth").val() == ""){
    		currentMonth	 = Now.getMonth() + 1;
    	}else{
    		currentMonth = $("#currentMonth").val();
    	}

    }

	var $picker = $('#scheduler'),
    $content = $('.datepicker--celllist .inner');

    $.ajax({
    	/*url : '/mobile/shop/mypage/__json_calendarSample.jsp?orderNum='+order+'&goodsId='+subNum+'&groupCode='+groupCode+'&currentYear='+currentYear+'&currentMonth='+currentMonth+'&currentDate='+currentDate,*/
    	url : '/mobile/shop/mypage/__json_calendarSample.jsp?orderNum='+orderNum+'&goodsId='+goodsId+'&groupCode='+groupCode+'',
        type : 'GET',
        data : {},
        async : false,
        dataType : 'json',
        success : function(data){
            o = data;
        },
        error : function(xhr, option, error){
        	alert("에러가 발생했습니다. 잠시 후에 다시하세요.");
        }
    });


 $.ajax({
    	url : '/mobile/shop/mypage/__json_holidaySample.html',
        type : 'GET',
        data : {},
        async : false,
        dataType : 'json',
        success : function(data){
            h = data;
        },
        error : function(xhr, option, error){
        	alert("에러가 발생했습니다. 잠시 후에 다시하세요.");
        }
    });


    $picker.datepicker({
        range :     false,
        inline :    true,
        onlyDateSelect : true,
        language :  "ko",
        navTitles: {
            days: 'yyyy. MM'
        },
        onRenderCell: function (date, cellType) {
            var content2 = '';
            
            var daycnt = 0; //-- 수량합계

            currentYear = date.getFullYear();
            currentMonth = date.getMonth();
            currentDate = date.getDate();

        	$("#currentYear").val(currentYear);
        	$("#currentMonth").val(currentMonth);

			function pad(numb) {
			    return (numb < 10 ? '0' : '') + numb;
			}


            contentText = '';
            if(cellType == 'day'){

					var date2 = currentYear +'-'+ pad(currentMonth+1) +'-'+ pad(currentDate);

					for(var i = 0; i <= h.data.length-1; i++){
						if (date2 == h.data[i].date){
							currentDate +=  '<div class="datepicker--addedtext holiday">'+h.data[i].title+'</div>';
						}
					}


                for(var i = 0; i <= o.data.length-1; i++){
                    if ((currentYear == o.data[i].year) && (currentMonth == o.data[i].month -1) && (currentDate == Number(o.data[i].day))){

                        if (o.data[i].rangetype === "end"){                         //배송끝지점 보여줄 클래스명
                            contentText += '<span class="orderedEnd"></span>';
                        }else if (o.data[i].rangetype === "start"){                 //배송시작지점 보여줄 클래스명
                            contentText += '<span class="orderedStart"></span>';
                        }

                        for(var j = 0; j <= o.data[i].list.length; j++){
                        	daycnt = o.data[i].list[j].daycnt;
                            if (o.data[i].list[j].seasonmenu == 1){
                                contentText += '<div class="datepicker--addedtext">계절메뉴</div>';
                            }else{
                                contentText += '';
                            }
                        break;
                        }
                        if(daycnt >= 1){
                        	//var listLength = o.data[i].list.length > 1 ? "x"+o.data[i].list.length : "";
                            return {
                                html: currentDate + '<span class="dp-note">'+daycnt+'</span>' +contentText
                            };
                        }else{
                            return {
                                html: currentDate + ' '+contentText
                            };
                        }
                    }
                };

				return {
                    html: currentDate
                };


            }
        },
        onSelect: function onSelect(fd, date, picker) {
        	if(date == "") return false;

            var title = '', content = '', btn = '';
            var currentYear = date.getFullYear();
            var currentMonth = date.getMonth();
            var currentMonth2 = date.getMonth();
            var currentDate = date.getDate();
            var _dayOfWeek = date.getDay();
            //var _wk = parseInt((6 + currentDate - _dayOfWeek) / 7) +1;
            var _wka = parseInt((6 + currentDate - _dayOfWeek) / 7) +1;
            var _wk = '';

            var lastDate = (new Date(currentYear, currentMonth+1, 0)).getDate();  //한달의 마지막날 날짜
            var lastDay = (new Date(currentYear, currentMonth+1, 0)).getDay();  //한달의 마지막날 요일
            var firstDay = (new Date(currentYear, currentMonth, 1)).getDay();  //한달의 첫날 요일
            
			if(lastDay == 6 || lastDay == 0){
				var _wk = parseInt((6 + currentDate - _dayOfWeek) / 7) +1;
				var currentMonth = date.getMonth();

			}else{	 // 그 달의 마지막날이 금,토,일이 아닌경우
				if(_wka == Math.ceil((lastDate+firstDay) / 7)){  // _wk는 클릭한날의 주가 마지막주인경우
					var _wk = 1;
					var currentMonth = currentMonth + 1;
				}else if(_wka == Math.ceil( (lastDate - firstDay) / 7 ) + 1 ){
					var _wk = 1;
					var currentMonth = currentMonth + 1;
				}else {
					var _wk = parseInt((6 + currentDate - _dayOfWeek) / 7) +1;
					var currentMonth = date.getMonth();
				}
			}
            

            $.ajax({
            	//url : '/mobile/shop/mypage/__json_calendarSample.html?orderNum='+order+'&goodsId='+subNum+'&groupCode='+groupCode+'&currentYear='+currentYear+'&currentMonth='+currentMonth+'&currentDate='+currentDate,
            	url : '/blank.jsp',
                type:"GET",
                // data :   data,
                dataType :  "html",
                success : function(data){
                    for(var i = 0; i <= o.data.length-1; i++){
                        if ((currentYear == o.data[i].year) && (currentMonth2 == o.data[i].month - 1) && (currentDate == Number(o.data[i].day))){
                        	title = o.data[i].year +"년 "+ (Number(o.data[i].month)) +"월 "+ Number(o.data[i].day) +"일";
                            content += '<ul>';
                            for(var j = 0; j <= o.data[i].list.length -1; j++){
                                content += '<li>';
                                content += '<div class="photo">';
                                content += '<img src="'+o.data[i].list[j].image+'"/>';
                                content += '</div>';
                                content += '<div class="info">';
                                content += '<div class="datepicker--celllist-summary">';
                                content += (j+1)+". ";
                                content += o.data[i].list[j].title;
                                content += '</div>';
                		        content += '<div class="subTitle">'+o.data[i].list[j].subTitle+' x '+o.data[i].list[j].quantity+'</div>';
                                content += '<div class="datepicker--celllist-period">';
                                content += o.data[i].list[j].startdate + ' ~ ' + o.data[i].list[j].enddate;
                                content += '</div>';
                                content += '</div>';
                                content += '</li>';
                            }
                            content += '</ul>';
                        }
                    }
                    btn = '<button type="button"></button>';
                    
                    if(content){
                        $("#wk"+currentMonth+"_"+_wk).toggleClass("open");
                        $("#wk"+currentMonth+"_"+_wk).find(".inner").append('<div class="datepicker--celllist-title"></div><div class="datepicker--celllist-list"></div><div class="datepicker--celllist-button"></div>');
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-title").html(title);
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-list").html(content);
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-button").html(btn);
                    }else{
                        $("#wk"+currentMonth+"_"+_wk).toggleClass("open");
                        $("#wk"+currentMonth+"_"+_wk).find(".inner").append('<div class="datepicker--celllist-title"></div><div class="datepicker--celllist-desc"><p class="txt1"></p><p class="txt2"></p></div><div class="datepicker--celllist-button"></div>');
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-title").html(title);
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-desc p.txt1").html('배송될 상품이 없습니다.');
                        /*$("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-desc p.txt2").html('다음 배송일:12월 16일 <br>(헬씨퀴진) 유자간장삼치구이세트(1ea) 외 2건');*/
                        $("#wk"+currentMonth+"_"+_wk).find(".datepicker--celllist-button").html(btn);
                    }

                    $(".datepicker--celllist-button").on("click",function(){
                        $(this).closest(".datepicker--celllist").removeClass("open");
                        $(this).closest(".datepicker--cells").find(".-selected-").trigger("click");
                    });
                    
                    return false;

                },
                error : function(a,b,c){
                    alert('error : ' + c);
                }
            });
        }
    });
    var currentDate = currentDate = new Date();
    $picker.data('datepicker');
});
</script>