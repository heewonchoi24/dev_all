/* http://keith-wood.name/datepick.html
   Korean localisation for jQuery Datepicker.
   Written by DaeKwon Kang (ncrash.dk@gmail.com). */
var holidays = {
    "0101":{type:0, title:"신정", year:""},
    "0301":{type:0, title:"삼일절", year:""},
    "0505":{type:0, title:"어린이날", year:""},
    "0606":{type:0, title:"현충일", year:""},
    "0815":{type:0, title:"광복절", year:""},
    "1003":{type:0, title:"개천절", year:""},
    "1009":{type:0, title:"한글날", year:""},
    "1225":{type:0, title:"크리스마스", year:""},

    "0209":{type:0, title:"설날", year:"2017"},
    "0210":{type:0, title:"설날", year:"2017"},
    "0211":{type:0, title:"설날", year:"2017"},
    "0918":{type:0, title:"추석", year:"2017"},
    "0919":{type:0, title:"추석", year:"2017"},
    "0920":{type:0, title:"추석", year:"2017"},
    "0517":{type:0, title:"석가탄신일", year:"2017"}
};


(function($) {
	$.datepick.regional['ko'] = {
		monthNames: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월',
		'7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['SUN','MON','TUE','WED','THU','FRI','SAT'],
		dateFormat: 'yyyy-mm-dd', firstDay: 0,
		renderer: $.extend({}, $.datepick.defaultRenderer,
			{month: $.datepick.defaultRenderer.month.
				replace(/monthHeader/, 'monthHeader:yyyy.MM')}),
		prevText: '이전달', prevStatus: '',
		prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
		nextText: '다음달', nextStatus: '',
		nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
		currentText: '오늘', currentStatus: '',
		todayText: '오늘', todayStatus: '',
		clearText: '지우기', clearStatus: '',
		closeText: 'CLOSE', closeStatus: '',
		yearStatus: '', monthStatus: '',
		weekText: 'Wk', weekStatus: '',
		dayStatus: 'D, M d', defaultStatus: '',
		isRTL: false
	};
	$.datepick.setDefaults($.datepick.regional['ko']);
})(jQuery);
