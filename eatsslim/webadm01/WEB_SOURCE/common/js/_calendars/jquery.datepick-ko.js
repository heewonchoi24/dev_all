/* http://keith-wood.name/datepick.html
   Korean localisation for jQuery Datepicker.
   Written by DaeKwon Kang (ncrash.dk@gmail.com). */
var holidays = {
    "0101":{type:0, title:"����", year:""},
    "0301":{type:0, title:"������", year:""},
    "0505":{type:0, title:"��̳�", year:""},
    "0606":{type:0, title:"������", year:""},
    "0815":{type:0, title:"������", year:""},
    "1003":{type:0, title:"��õ��", year:""},
    "1009":{type:0, title:"�ѱ۳�", year:""},
    "1225":{type:0, title:"ũ��������", year:""},

    "0209":{type:0, title:"����", year:"2017"},
    "0210":{type:0, title:"����", year:"2017"},
    "0211":{type:0, title:"����", year:"2017"},
    "0918":{type:0, title:"�߼�", year:"2017"},
    "0919":{type:0, title:"�߼�", year:"2017"},
    "0920":{type:0, title:"�߼�", year:"2017"},
    "0517":{type:0, title:"����ź����", year:"2017"}
};


(function($) {
	$.datepick.regional['ko'] = {
		monthNames: ['1��','2��','3��','4��','5��','6��',
		'7��','8��','9��','10��','11��','12��'],
		monthNamesShort: ['1��','2��','3��','4��','5��','6��',
		'7��','8��','9��','10��','11��','12��'],
		dayNames: ['��','��','ȭ','��','��','��','��'],
		dayNamesShort: ['��','��','ȭ','��','��','��','��'],
		dayNamesMin: ['SUN','MON','TUE','WED','THU','FRI','SAT'],
		dateFormat: 'yyyy-mm-dd', firstDay: 0,
		renderer: $.extend({}, $.datepick.defaultRenderer,
			{month: $.datepick.defaultRenderer.month.
				replace(/monthHeader/, 'monthHeader:yyyy.MM')}),
		prevText: '������', prevStatus: '',
		prevJumpText: '&#x3c;&#x3c;', prevJumpStatus: '',
		nextText: '������', nextStatus: '',
		nextJumpText: '&#x3e;&#x3e;', nextJumpStatus: '',
		currentText: '����', currentStatus: '',
		todayText: '����', todayStatus: '',
		clearText: '�����', clearStatus: '',
		closeText: 'CLOSE', closeStatus: '',
		yearStatus: '', monthStatus: '',
		weekText: 'Wk', weekStatus: '',
		dayStatus: 'D, M d', defaultStatus: '',
		isRTL: false
	};
	$.datepick.setDefaults($.datepick.regional['ko']);
})(jQuery);
