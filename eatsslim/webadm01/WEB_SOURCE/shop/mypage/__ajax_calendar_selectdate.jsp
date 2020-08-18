<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="/lib/config.jsp"%>
<%
SimpleDateFormat dt		= new SimpleDateFormat("yyyy-MM-dd");
String today			= dt.format(new Date());
Date date			= null;
String orderNum		= ut.inject(request.getParameter("orderNum"));
String goodsId		= ut.inject(request.getParameter("goodsId"));
String groupCode	= ut.inject(request.getParameter("groupCode"));
String caltype		= ut.inject(request.getParameter("caltype"));
Calendar cal		= Calendar.getInstance();
String mindate		= ut.inject(request.getParameter("mindate"));
if(mindate == null || "".equals(mindate)){
	date			= dt.parse(today);
	cal.add(Calendar.DATE, 3);
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
<section id="calendarPop" class="modal">
    <div class="inner">
    	<button class="modal_close"></button>
    	<div class="modal_header">
			<h1>날짜선택</h1>
    	</div>
        <div class="modal_content">
        	<div class="inner">
				<div id="pop_scheduler"></div>
        	</div>
        </div>
    </div>
    <script type="text/javascript">
    	var caltype = "<%=caltype%>";
    	var o = o || {};
    	$.ajax({
	    	url : '/shop/mypage/__json_calendarSample.jsp?orderNum='+orderNum+'&goodsId='+goodsId+'&groupCode='+groupCode+'',
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

   		var holiDays = new Array();
<%
for(int i=0; i<holiDay.size(); i++){
%>
    holiDays[<%=i%>]='<%=holiDay.get(i)%>';
<%
}
%>
	    $('#pop_scheduler').datepicker({
	    	dateFormat: 'yyyy-mm-dd',
	        range :     false,
	        toggleSelected: false,
	        inline :    true,
	        language :  "ko",
	        minDate : new Date('<%=mindate%>'),
	        maxDate : new Date('<%=maxdate%>'),
	        navTitles: {
	            days: '<i>yyyy</i>. MM'
	        },
	        onRenderCell: function (date, cellType) {

	            var currentYear = date.getFullYear();
	            var currentMonth = date.getMonth()+1;
	            var currentDate = date.getDate();
	            var currentToday = currentYear +"."+ (currentMonth<10 ? "0"+currentMonth : currentMonth) +"."+ (currentDate<10 ? "0"+currentDate : currentDate);

	            var daycnt = 0; //-- 수량합계

	            var html = "";
	            var isDisabled = true;

	            if(caltype == "")  isDisabled = false; //-- 일반선택일경우 전체 선택 가능하도록 처리

	            var contentText = '';
	            if(cellType == 'day'){
	                for(var i = 0; i <= o.data.length-1; i++){
	                    if ((currentYear == parseInt(o.data[i].year,10)) && (currentMonth == parseInt(o.data[i].month,10)) && (currentDate == parseInt(o.data[i].day,10))){

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
	                        	//var listLength = o.data[i].list.length > 1 ? "x"+o.data[i].list.length : "&nbsp;";
	                            html = currentDate + '<span class="dp-note">'+daycnt+'</span>' +contentText;
	                        }else{
	                            html = currentDate + ' '+contentText
	                        }
	                    }
	                }

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
	        onSelect: function(fd, date, picker) {
	        	var weekday = ["일요일","월요일","화요일","수요일","목요일","금요일","토요일"];
				var dd = date.getDate();
				var mm = date.getMonth()+1; //January is 0!
				var yyyy = date.getFullYear();
				var dateText = yyyy +"년 "+ mm +"월 "+ dd + "일 "/* + weekday[date.getDay()]*/;
				//var dateText = fd;



				if(iptTarget.attr('id') == "ca_startDate"){
					iptTarget.val(fd);
					iptTargetText.val(dateText+ "부터");
				}else if(iptTarget.attr('id') == "ca_startDate2"){
					//iptTarget.html('<option value="1">배송완료시</option><option value="selectDate">--- 원하는 날짜선택 ---</option>');
					iptTarget.prepend('<option value="'+fd+'">'+dateText+' 까지의</option>').val(fd);
					selectbox("#ca_startDate2");
				}else{
					iptTarget.val(fd);
					iptTargetText.val(dateText);
				}

				modalFn.hide($('#calendarPop'), parentTarget);
	        }
	    });
	</script>
</section>