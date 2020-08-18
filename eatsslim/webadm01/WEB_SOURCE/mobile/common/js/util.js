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

// 3�ڸ����� , �ڵ��Է�
function commaInsert(field) {
	if (!TypeCheck(field.value , "0123456789,")) {
		alert('���ڸ� �Է��� �ּ���.');
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

// �ɼ��� �����ϴ� �Լ�
// newOptions : �ɼ�, select : select��, selectedOption : ���ð�
function makeOption(newOptions, select, selectedOption) {
	var options	= select.prop('options');

	$('option', select).remove();
	$.each(newOptions, function(val, text) {
		options[options.length]	= new Option(text, val);
	});
	select.val(selectedOption);
}

// �̸��� ����
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

// ���ڸ� �Է¹޴� �Լ�
function onlyNum(field) {
	if (!TypeCheck(field.value, "0123456789")) {
		alert('���ڸ� �Է��� �ּ���.');
		field.value = '';
		field.focus();
		return false;
	}
}

//iframe ���� �θ�â���� �̵�
function frameMove(url) {
	parent.location.href = url;
}