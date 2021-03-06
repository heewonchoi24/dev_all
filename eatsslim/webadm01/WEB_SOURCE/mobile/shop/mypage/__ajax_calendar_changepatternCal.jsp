<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
SimpleDateFormat dt		= new SimpleDateFormat("yyyy-MM-dd");
String today			= dt.format(new Date());
Date date			= null;
Calendar cal		= Calendar.getInstance();

String mindate		= ut.inject(request.getParameter("mindate"));
if(mindate == null || "".equals(mindate)){
	date			= dt.parse(today);
	cal.add(Calendar.DATE, 5);
	mindate		  	= dt.format(cal.getTime());
	date			= dt.parse(mindate);

}
else{
	date			= dt.parse(mindate);
}
String maxdate		= ut.inject(request.getParameter("maxdate"));
if(maxdate == null || "".equals(maxdate)){
	cal.add(Calendar.MONTH, 6);
	maxdate		  	= dt.format(cal.getTime());
}
String patternType  = request.getParameter("ptype");
String caltype		= ut.inject(request.getParameter("caltype"));

//-- 휴무일정보
String query        = "";
query       = "SELECT DATE_FORMAT(HOLIDAY, '%Y.%m.%d') HOLIDAY, HOLIDAY_NAME";
query       += " FROM ESL_SYSTEM_HOLIDAY WHERE HOLIDAY_TYPE = '02' ";
query       += " ORDER BY HOLIDAY DESC, ID DESC";
pstmt       = conn.prepareStatement(query);
rs        = pstmt.executeQuery();

ArrayList<String> holiDay = new ArrayList();
while (rs.next()) {
    holiDay.add(rs.getString("HOLIDAY"));
}
rs.close();
%>
<div id="changeDateCal" class="expansioncss">
    <div class="inner">
        <header class="pop_header">
            <button class="pop_close close2">닫기</button>
            <h1>배송요일 변경 (1/2)</h1>
        </header>
        <div class="pop_content">
            <input type="hidden" class="startDate">
            <input type="hidden" class="endDate">
            <div class="tip_scheduler">
                <p class="moveText"><span>배송을 원하는 일자를 선택해주세요.</span></p>
            </div>
            <div id="pop_scheduler"></div>
        </div>
    </div>
</div>
<script>
    moveText($('.moveText'));

    $('.pop_close.close2').off('click').on('click',function(){
        var $this = $(".content.on");
        var $siblings = $this.siblings(".content");

        $this.removeClass("on");
        $siblings.addClass("on");

        TweenMax.to($siblings,0.5,{'top' : '0vh', ease: Power3.easeInOut});
        TweenMax.to($this,0.5,{'top' : 150+'vh', ease: Power3.easeInOut});
    });

    var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
    holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
    var caltype = "<%=caltype%>";
    $('#pop_scheduler').datepicker({
    	dateFormat: 'yyyy-mm-dd',
        range :     false,
        toggleSelected: false,
        onlyDateSelect : true,
        inline :    true,
        language :  "ko",
        minDate : new Date('<%=mindate%>'),
        maxDate : new Date('<%=maxdate%>'),
        navTitles: {
            days: 'yyyy. MM'
        },
        onRenderCell: function (date, cellType) {
            currentYear = date.getFullYear();
            currentMonth = date.getMonth()+1;
            currentDate = date.getDate();
            var currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);

            var daycnt = 0; //-- 수량합계

            var html = "";
            var isDisabled = true;

            if(caltype == "")  isDisabled = false; //-- 일반선택일경우 전체 선택 가능하도록 처리

            contentText = '';
            if(cellType == 'day'){
                for(var i = 0; i <= o.data.length-1; i++){
                    if ((currentYear == o.data[i].year) && (currentMonth == o.data[i].month) && (currentDate == Number(o.data[i].day))){
                    	if(caltype == "start") isDisabled = false; //-- 배송일만 선택할수 있도록 버튼을 활성화 시킨다.

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
                            html = currentDate + '<span class="dp-note">'+daycnt+'</span>' +contentText;
                        }else{
                        	html = currentDate + ' '+contentText;
                        }
                    }
                };

                if(holiDays.indexOf(currentToday) != -1){
                    return {
                        classes : '-holiday-',
                        disabled: true
                    }
                }

                return {
                    html: html,
                    disabled: isDisabled
                }
            }
        },
        onSelect: function onSelect(fd, date, picker) {
        //	calendarPop.addCont({url : '__ajax_calendar_changepattern.jsp?orderNum='+order+'&subNum='+subNum+'&groupCode='+groupCode+'&devlDates='+devlDates+'&devlDay='+devlDay+'&goods='+goods+'', direc : 'up', selectDate : fd, targetInput : '#devl_date_pattern'});
            var $this = $(".content.on");
        	var $siblings = $this.siblings(".content");

            var weekday = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
            var dd = date.getDate();
            var mm = date.getMonth()+1; //January is 0!
            var yyyy = date.getFullYear();
            var dateText = yyyy +"년 "+ mm +"월 "+ dd + "일 ";

        	//console.log(order +"/"+ subNum +"/"+ groupCode +"/"+ devlDates +"/"+ devlDay +"/"+ goods);

        	$this.removeClass("on");
        	$siblings.addClass("on");

        	TweenMax.to($siblings,0.5,{'top' : '0vh', ease: Power3.easeInOut});
            TweenMax.to($this,0.5,{'top' : 150+'vh', ease: Power3.easeInOut});

            if (<%=patternType%> == 0){
            	$siblings.find("#devl_date_pattern").val(fd);
                $siblings.find("#devl_date_pattern_text").val(dateText);
            }else {
            	$siblings.find("#start_date_pattern").val(fd);
                $siblings.find("#start_date_pattern_text").val(dateText);
            }
            //$siblings.find("#devl_date_pattern").val(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate());


        }
    });
    $('#pop_scheduler').data('datepicker');
</script>