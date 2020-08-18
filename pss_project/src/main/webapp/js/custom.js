/**
 * 
 */
String.prototype.money = function() {
    var num = this.trim();
    while((/(-?[0-9]+)([0-9]{3})/).test(num)) {
        num = num.replace((/(-?[0-9]+)([0-9]{3})/), "$1,$2");
    }
    return num;
}

//------------------------------------------------------------------------
// confirm for blank string
// return   : string
//------------------------------------------------------------------------
String.prototype.isBlank = function() {
    var str = this.trim();
    for(var i = 0; i < str.length; i++) {
        if ((str.charAt(i) != "\t") && (str.charAt(i) != "\n")
                && (str.charAt(i)!="\r")) {
            return false;
        }
    }
    return true;
}

$(document).ready(function(){
	$(".datepicker").datepicker({
		showOn:"both",
		buttonImage:"/images/content/btn_schedule.gif",
		buttonImageOnly:true,
		dateFormat:'yy.mm.dd',
		prevText:'이전 달',
		nextText:'다음 달',
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames:['일','월','화','수','목','금','토'],
		dayNamesShort:['일','월','화','수','목','금','토'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		showMonthAfterYear:true,
		changeMonth:true,
		changeYear:true,
		yearSuffix:'년'
	});
	
	fn_util_setTextType();
	
});

function fn_numberInit() {
	
	/*
	$(".onlyNumber").on("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if(code && (code <= 47 || code >= 58) && code != 8) {
			e.preventDefault();
		}
	});
	*/
	$(".onlyNumber").keyup(function() {
		this.value = this.value.replace(/[^0-9]/g,'');
	});
	
	/*
	$(".onlyNumber2").on("keypress", function(e) {
		var code = (e.keyCode ? e.keyCode : e.which);
		if(code && (code < 45 || code > 57)) {
			e.preventDefault();
		}
	});
	*/
	$(".onlyNumber2").keyup(function() {
		this.value = this.value.replace(/[^0-9.]/g,'');
	});
}

function fn_util_setTextType(){
    $('.moneyType').each(function(){
        if($(this).text().isBlank()){
            $(this).val($(this).val().money());
        }else{
            $(this).text($(this).text().money());
        }
    });
}