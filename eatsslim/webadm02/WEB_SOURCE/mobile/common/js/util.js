function TypeCheck (s, spc) {
	var i;

	for(i=0; i< s.length; i++) {
		if (spc.indexOf(s.substring(i, i+1)) < 0) {
			return false;
		}
	}
	return true;
}

function commaSplit(srcNumber) {
	var txtNumber = '' + srcNumber;

	var rxSplit = new RegExp('([0-9])([0-9][0-9][0-9][,.])');
	var arrNumber = txtNumber.split('.');
	arrNumber[0] += '.';
	do {
		arrNumber[0] = arrNumber[0].replace(rxSplit, '$1,$2');
	}
	while (rxSplit.test(arrNumber[0]));
	if (arrNumber.length > 1) {
		return arrNumber.join('');
	}
	else {
		return arrNumber[0].split('.')[0];
	}
}

// 3자리마다 , 자동입력
function commaInsert(field) {
	if (!TypeCheck(field.value , "0123456789,")) {
		alert('숫자만 입력해 주세요.');
		field.value = '';
		field.focus();
		return false;
	}
	field.value = commaSplit(filterNum(field.value));
}

function filterNum(str) {
	re = /^\$|,/g;
	return str.replace(re, "");
}

// 옵션을 생성하는 함수
// newOptions : 옵션, select : select명, selectedOption : 선택값
function makeOption(newOptions, select, selectedOption) {
	var options	= select.prop('options');

	$('option', select).remove();
	$.each(newOptions, function(val, text) {
		options[options.length]	= new Option(text, val);
	});
	select.val(selectedOption);
}

// 이메일 설정
function setEmail() {
	if ($("#email_sel").val() != "self") {
		$("#email_addr").val($("#email_sel").val());
		$("#email_addr").attr("readonly", "readonly");
	} else {
		$("#email_addr").val("");
		$("#email_addr").focus();
		$("#email_addr").removeAttr("readonly", "");
	}
}

// 숫자만 입력받는 함수
function onlyNum(field) {
	if (!TypeCheck(field.value, "0123456789")) {
		alert('숫자만 입력해 주세요.');
		field.value = '';
		field.focus();
		return false;
	}
}

//iframe 에서 부모창으로 이동
function frameMove(url) {
	parent.location.href = url;
}