//Null 체크 함수 (Null 이거나 "" 이면 true)
function checkNull(inputString) {
	if (inputString == null || inputString == "" || $.trim(inputString) == "") {
		return true;
	}
	return false;
}


//체크박스 체크 (checkBoxName 을 가진 체크박스가 체크 되어있으면 true)
function checkCheckBox(objForm, checkBoxName) {
	for (var i=0; i<objForm.elements.length; i++) {
		if (objForm[i].name == checkBoxName && objForm[i].checked) {
			return true;
		}
	}
	return false;
}

// 체크박스 중 체크되어있는 값 가져오기..
function getCheckBoxCheckValue(objForm, checkBoxName) {
	for (var i=0; i<objForm.elements.length; i++) {
		if (objForm[i].name == checkBoxName && objForm[i].checked) {
			return objForm[i].value;
		}
	}
	return "";
}

// 라디오 버튼 체크 (체크된 라디오 버튼이 있으면 true)
function checkRadio(objRadio) {
	if (objRadio.length) {
		for (var i=0; i<objRadio.length; i++) {
			if (objRadio[i].checked) {
				return true;
			}
		}
	} else {
		if (objRadio.checked) {
			return true;
		}
	}
	return false;
}

// 반복 문자열 체크
function repeat_check(str, num) {
	var cnt = str.length;
	var repeat = "";
	var R=1;

	for(var i=0; i<cnt; i++) {
	  tmp = str.substr(i, 1);
	  key = tmp;
	  if(key == repeat) { R++; }
	  else { R=1; repeat = key; }
	  if(R >= num) { return repeat; }
	}
	return "";
}

// 연속 문자열 체크
function sequence_check(str, num) {
	var cnt = str.length;
	var repeat = 0;
	var R=1;

	for(var i=0; i<cnt; i++) {
	  asc = str.charCodeAt(i);
	  key = asc;
	  if(key == repeat + 1) { R++; repeat = key; }
	  else { R=1; repeat = key; }
	  if(R >= num) { return repeat; }
	}
	return 0;
}

// 숫자 체크 함수 (숫자 이외의 문자 포함시 false)
function checkNumber(inputString){
	var numPattern = /([^0-9])/;
	numPattern = inputString.match(numPattern);
	if(numPattern != null){
		return false;
	}
	return true;
}

// 공백 체크 함수 (공백 포함시 true)
function checkSpace(inputString){
	if (inputString.indexOf(" ")>=0) {
		return true;
	}
	return false;
}

// 특정 문자만으로 이루어진 입력인지 체크 함수
function containsCharsOnly(inputString,chars) {
	for (var inx = 0; inx < inputString.length; inx++) {
		if (chars.indexOf(inputString.charAt(inx)) == -1)
			return false;
	}
	return true;
}

// 도메인 체크 함수
function checkDomain(inputString) {
	var pattern = new RegExp("^(http://)?(www\.)?([가-힝a-zA-Z0-9-]+\.[a-zA-Z]{2,3}$)","i");
	if (pattern.test(inputString)) {
		return true;
	}
	return false;
}

// 입력한 정규식과 일치하는 포맷인지 체크 함수
function checkFormat(inputString,format) {
	if (inputString.search(format) != -1) {
		return true;
	}
	return false;
}

// 영문 대,소문자 이외의 입력이 있는지 체크 함수
function checkAlpha(inputString) {
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	return containsCharsOnly(inputString,chars);
}

// 영문 대,소문자,숫자 이외의 입력이 있는지 체크 함수
function checkAlphaNum(inputString) {
	var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	return containsCharsOnly(inputString,chars);
}

// 주민등록번호 체크 함수 (입력값 : nnnnnn-nnnnnnn)
function checkSN(SN) {
	var fmt = /^\d{6}-[1234]\d{6}$/;
	if (!fmt.test(SN)) {
		return false;
	}
	var birthYear = (SN.charAt(7) <= "2") ? "19" : "20";
	birthYear += SN.substr(0, 2);
	var birthMonth = SN.substr(2, 2) - 1;
	var birthDate = SN.substr(4, 2);
	var birth = new Date(birthYear, birthMonth, birthDate);
	if ( birth.getYear() % 100 != SN.substr(0, 2) || birth.getMonth() != birthMonth || birth.getDate() != birthDate) {
		return false;
	}
	var buf = new Array(13);
	for (var i = 0; i < 6; i++) buf[i] = parseInt(SN.charAt(i));
	for (var i = 6; i < 13; i++) buf[i] = parseInt(SN.charAt(i + 1));
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
	for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
	if ((11 - (sum % 11)) % 10 != buf[12]) {
		return false;
	}
	return true;
}

// 올바른 이메일 형식인지 체크 함수
function checkEmail(inputString) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	if (inputString.indexOf(";")>0) {
		var arrayEmail = inputString.split(";");
		var checkResult = true;
		for (var i=0; i<arrayEmail.length; i++) {
			checkResult = checkFormat(arrayEmail[i],format);
		}
		return checkResult;
	} else {
		return checkFormat(inputString,format);
	}
}

// 올바른 날짜 형식인지 체크 함수 (object)
function checkDateValue(obj, separator) {
	var input = obj.value.replace(/-/g,"");
	var input = input.replace(/\//g,"");
	var inputYear = input.substr(0,4);
	var inputMonth = input.substr(4,2) - 1;
	var inputDate = input.substr(6,2);
	var resultDate = new Date(inputYear, inputMonth, inputDate);
	if ( resultDate.getFullYear() != inputYear ||
		resultDate.getMonth() != inputMonth ||
		resultDate.getDate() != inputDate) {
		return false;
	} else {
		inputDate = (inputDate.length == 1)? "0" + inputDate : inputDate;
		obj.value = inputYear + separator + input.substr(4,2) + separator + inputDate;
		return true;
	}
}

// 올바른 날짜 형식인지 체크 함수
function checkDateSeparateValue(objYear, objMonth, objDay) {
	var inputYear = objYear.value
	var inputMonth = objMonth.value - 1;
	var inputDate = objDay.value;
	var resultDate = new Date(inputYear, inputMonth, inputDate);
	if ( resultDate.getFullYear() != inputYear ||
		resultDate.getMonth() != inputMonth ||
		resultDate.getDate() != inputDate) {
		return false;
	} else {
		objMonth.value	= (objMonth.value.length == 1)? "0" + objMonth.value : objMonth.value;
		objDay.value	= (objDay.value.length == 1)? "0" + objDay.value : objDay.value;
		return true;
	}
}

//올바른 년월 형식 인지 체크 함수 (YYYYMM 체크)
function checkYearMonthValue(objYearMonth) {
	if (checkNull(objYearMonth.value)) {
		alert("년월 (YYYYMM) 6자리를 입력하세요.");
		objYearMonth.focus();
		objYearMonth.select();
		return false;
	} else if (objYearMonth.value.length != 6) {
		alert("년월 (YYYYMM) 6자리를 입력하세요.");
		objYearMonth.focus();
		objYearMonth.select();
		return false;
	} else {
		var inputYear = objYearMonth.value.substring(0,4);
		var inputMonth = objYearMonth.value.substring(4,6) - 1;
		var inputDate = 1;
		var resultDate = new Date(inputYear, inputMonth, inputDate);
		if ( resultDate.getFullYear() != inputYear ||
			resultDate.getMonth() != inputMonth ||
			resultDate.getDate() != inputDate) {
			alert("잘못된 입력입니다.\n\n년월 (YYYYMM) 6자리를 입력하세요.");
			objYearMonth.focus();
			objYearMonth.select();
			return false;
		} else {
			return true;
		}
	}
}

// 올바른 날짜 형식인지 체크 함수 (자동변환)
function checkDate(obj) {
	var input = obj.value.replace(/-/g,"");
	var inputYear = input.substr(0,4);
	var inputMonth = input.substr(4,2) - 1;
	var inputDate = input.substr(6,2);
	var resultDate = new Date(inputYear, inputMonth, inputDate);
	if ( resultDate.getFullYear() != inputYear ||
		resultDate.getMonth() != inputMonth ||
		resultDate.getDate() != inputDate) {
		obj.value = "";
	} else {
		inputDate = (inputDate.length == 1)? "0" + inputDate : inputDate;
		obj.value = inputYear + "-" + input.substr(4,2) + "-" + inputDate;
	}
}

// ID 형식 체크
function checkUserID(objUserID) {
	var ID			= objUserID.value;
	var MIN_LENGTH	= 4;
	var MAX_LENGTH	= 12;

	if (checkNull(ID)) {
		alert("회원 아이디를 입력하세요.");
		//objUserID.focus();
		return false;
	} else if (ID.length < MIN_LENGTH || ID.length > MAX_LENGTH) {
		alert("회원 아이디는 " + MIN_LENGTH + "자 이상 " + MAX_LENGTH + "자 이내 이어야 합니다.");
		//objUserID.focus();
		return false;
	} else if (checkSpace(ID)) {
		alert("회원 아이디는 공백이 포함될 수 없습니다.");
		//objUserID.focus();
		return false;
	} else if (parseInt(ID.substring(0,1))) {
		//objUserID.focus();
		alert("회원 아이디는 숫자로 시작할 수 없습니다.");
		return false;
	} else if (!checkAlphaNum(ID)) {
		//objUserID.focus();
		alert("회원 아이디는 영문 소문자 및 숫자만 사용하실 수 있습니다.");
		return false;
	} else {
		return true;
	}
}

// 비밀번호 형식 체크
function checkUserPwd(objPasswd, objPasswd_re) {
	var PASSWD		= objPasswd.value;
	var PASSWD_RE	= objPasswd_re.value;
	var MIN_LENGTH	= 4;
	var MAX_LENGTH	= 12;

	if (checkNull(PASSWD)) {
		alert("비밀번호를 입력하세요.");
		//objPasswd.focus();
		return false;
	} else if (PASSWD.length < MIN_LENGTH || PASSWD.length > MAX_LENGTH) {
		alert("비밀번호는 " + MIN_LENGTH + "자 이상 " + MAX_LENGTH + "자 이내 이어야 합니다.");
		//objPasswd.focus();
		return false;
	} else if (checkSpace(PASSWD)) {
		alert("비밀번호는 공백이 포함될 수 없습니다.");
		//objPasswd.focus();
		return false;
	} else if (checkNull(PASSWD_RE)) {
		alert("비밀번호를 한번 더 입력하세요.");
		//objPasswd_re.focus();
		return false;
	} else if (PASSWD != PASSWD_RE) {
		alert("비밀번호가 일치하지 않습니다.");
		//objPasswd_re.focus();
		return false;
	} else {
		return true;
	}
}

// 주민등록번호 형식 체크
function checkSocialNumber(objSN1, objSN2) {
	var sn1_value = objSN1.value;
	var sn2_value = objSN2.value;
	if (checkNull(sn1_value)) {
		alert("주민등록번호 앞자리를 입력하세요.");
		objSN1.focus();
		return false;
	} else if (checkNull(sn2_value)) {
		alert("주민등록번호 뒷자리를 입력하세요.");
		objSN2.focus();
		return false;
	} else if (!checkNumber(sn1_value)) {
		alert("주민등록번호 앞자리는 숫자여야 합니다.");
		objSN1.focus();
		return false;
	} else if (!checkNumber(sn2_value)) {
		alert("주민등록번호 뒷자리는 숫자여야 합니다.");
		objSN2.focus();
		return false;
	} else if (!checkSN(sn1_value + "-" + sn2_value)) {
		alert("유효하지 않은 주민등록번호 입니다.");
		objSN1.focus();
		return false;
	} else {
		return true;
	}
}

// 이름 형식 체크
function checkUserName(objName) {
	var nameValue = objName.value;
	if (checkNull(nameValue)) {
		alert("이름을 입력하세요.");
		//objName.focus();
		return false;
	} else if (checkSpace(nameValue)) {
		alert("이름에 공백이 포함될 수 없습니다.");
		//objName.focus();
		return false;
	} else if (nameValue.indexOf("'")>=0) {
		alert("이름은 작은 따옴표(') 가 포함될 수 없습니다.");
		//objName.focus();
		return false;
	} else if (nameValue.indexOf("\"")>=0) {
		alert("이름은 큰 따옴표(\") 가 포함될 수 없습니다.");
		//objName.focus();
		return false;
	} else if (checkNumber(nameValue)) {
		alert("이름은 숫자가 포함될 수 없습니다..");
		//objName.focus();
		return false;
	} else if (nameValue.length < 2) {
		alert("이름은 2자 이상 입력하세요.");
		//objName.focus();
		return false;
	} else {
		return true;
	}
}

// 전화번호 형식 체크
function checkTelNumber(objP1, objP2, objP3) {
	var p1_value = objP1.value;
	var p2_value = objP2.value;
	var p3_value = objP3.value;
	if (checkNull(p1_value)) {
		alert("전화번호 지역번호를 입력하세요.");
		objP1.focus();
		return false;
	} else if (checkNull(p2_value)) {
		alert("전화번호 국번을 입력하세요.");
		objP2.focus();
		return false;
	} else if (p2_value.length <3) {
		alert("전화번호 국번은 최소 3자리 숫자입니다.");
		objP2.focus();
		return false;
	} else if (checkNull(p3_value)) {
		alert("전화번호 뒷자리를 입력하세요.");
		objP3.focus();
		return false;
	} else if (p3_value.length <4) {
		alert("전화번호 뒷자리는 최소 4자리 숫자입니다.");
		objP3.focus();
		return false;
	} else if (!checkNumber(p1_value)) {
		alert("전화번호는 숫자이어야 합니다.");
		objP1.focus();
		return false;
	} else if (!checkNumber(p2_value)) {
		alert("전화번호는 숫자이어야 합니다.");
		objP2.focus();
		return false;
	} else if (!checkNumber(p3_value)) {
		alert("전화번호는 숫자이어야 합니다.");
		objP3.focus();
		return false;
	} else {
		return true;
	}
}

// 휴대폰 형식 체크
function checkMobileNumber(objP1, objP2, objP3) {
	var p1_value = objP1.value;
	var p2_value = objP2.value;
	var p3_value = objP3.value;
	if (checkNull(p1_value)) {
		alert("휴대폰 식별번호를 입력하세요.");
		objP1.focus();
		return false;
	} else if (checkNull(p2_value)) {
		alert("휴대폰 국번을 입력하세요.");
		objP2.focus();
		return false;
	} else if (p2_value.length <3) {
		alert("휴대폰 국번은 최소 3자리 숫자입니다.");
		objP2.focus();
		return false;
	} else if (checkNull(p3_value)) {
		alert("휴대폰 뒷자리를 입력하세요.");
		objP3.focus();
		return false;
	} else if (p3_value.length <4) {
		alert("휴대폰 뒷자리는 최소 4자리 숫자입니다.");
		objP3.focus();
		return false;
	} else if (!checkNumber(p1_value)) {
		alert("휴대폰번호는 숫자이어야 합니다.");
		objP1.focus();
		return false;
	} else if (!checkNumber(p2_value)) {
		alert("휴대폰번호는 숫자이어야 합니다.");
		objP2.focus();
		return false;
	} else if (!checkNumber(p3_value)) {
		alert("휴대폰번호는 숫자이어야 합니다.");
		objP3.focus();
		return false;
	} else {
		return true;
	}
}

// 검색단어 체크
function checkSerchWord(objSearchWord) {
	var searchWord = objSearchWord.value;
	if (searchWord.length < 1) {
		alert("검색어를 한 자 이상 입력하세요.");
		objSearchWord.focus();
		return false;
	} else if (searchWord.indexOf("'")>=0) {
		alert("작은 따옴표(')가 포함된 단어는 검색하실 수 없습니다.");
		objSearchWord.focus();
		return false;
	} else if (searchWord.indexOf("\"")>=0) {
		alert("큰 따옴표(\")가 포함된 단어는 검색하실 수 없습니다.");
		objSearchWord.focus();
		return false;
	} else {
		return true;
	}
}

// 사업자등록번호 체크 object가 3개인 경우 (Boolean 리턴)
function checkCompanyNumber(formName1,formName2,formName3) {
	var str1 = formName1.value;
	var str2 = formName2.value;
	var str3 = formName3.value;

	while (str1.indexOf('-')!=-1){
		str1 = str1.replace("-","");
	}
	while (str2.indexOf('-')!=-1){
		str2 = str2.replace("-","");
	}
	while (str3.indexOf('-')!=-1){
		str3 = str3.replace("-","");
	}

	if(isNaN(str1)) {
		window.alert("사업자등록번호는 숫자로만 작성하세요.");
		formName1.value="";
		formName1.focus();
		return false;
	}
	if(isNaN(str2)) {
		window.alert("사업자등록번호는 숫자로만 작성하세요.");
		formName2.value="";
		formName2.focus();
		return false;
	}
	if(isNaN(str3)) {
		window.alert("사업자등록번호는 숫자로만 작성하세요.");
		formName3.value="";
		formName3.focus();
		return false;
	}

	if (str1.length != 3) {
		alert("사업자등록번호의 자릿수가 올바르지 않습니다.");
		formName1.focus();
		return false;
	}
	if (str2.length != 2) {
		alert("사업자등록번호의 자릿수가 올바르지 않습니다.");
		formName2.focus();
		return false;
	}
	if (str3.length != 5) {
		alert("사업자등록번호의 자릿수가 올바르지 않습니다.");
		formName3.focus();
		return false;
	}

	var str = str1 + str2 + str3;
	sumMod = 0;
	sumMod += parseInt(str.substring(0,1));
	sumMod += parseInt(str.substring(1,2)) * 3 % 10;
	sumMod += parseInt(str.substring(2,3)) * 7 % 10;
	sumMod += parseInt(str.substring(3,4)) * 1 % 10;
	sumMod += parseInt(str.substring(4,5)) * 3 % 10;
	sumMod += parseInt(str.substring(5,6)) * 7 % 10;
	sumMod += parseInt(str.substring(6,7)) * 1 % 10;
	sumMod += parseInt(str.substring(7,8)) * 3 % 10;
	sumMod += Math.floor(parseInt(str.substring(8,9)) * 5 / 10);
	sumMod += parseInt(str.substring(8,9)) * 5 % 10;
	sumMod += parseInt(str.substring(9,10));

	if (sumMod % 10 != 0) {
		alert(str + "은(는) 올바른 사업자등록번호가 아닙니다");
		formName1.focus();
		return false;
	}
	return true;
}

// 외국인 등록번호 체크
function checkForeignNumber(objRegNo1, objRegNo2) {

	var reg_no1 = objRegNo1.value;
	var reg_no2 = objRegNo2.value;
	var birthYear = "";
	if (checkNull(reg_no1)) {
		alert("외국인 등록번호 첫째 자리를 입력하세요.");
		objRegNo1.focus();
		return false;
	} else if (reg_no1.length != 6 || !checkNumber(reg_no1)) {
		alert("외국인 등록번호 첫째 자리는 6자리 숫자 입니다.");
		objRegNo1.focus();
		return false;
	} else if (checkNull(reg_no2)) {
		alert("외국인 등록번호 둘째 자리를 입력하세요.");
		objRegNo2.focus();
		return false;
	} else if (reg_no1.length != 7 || !checkNumber(reg_no1)) {
		alert("외국인 등록번호 둘째 자리는 7자리 숫자 입니다.");
		objRegNo2.focus();
		return false;
	}

	var sum = 0;
    var odd = 0;
	var reg_no = reg_no1 + reg_no2

	if ((reg_no.charAt(6) == "5") || (reg_no.charAt(6) == "6")) {
		birthYear = "19";
	} else if ((reg_no.charAt(6) == "7") || (reg_no.charAt(6) == "8")) {
		birthYear = "20";
	} else if ((reg_no.charAt(6) == "9") || (reg_no.charAt(6) == "0")) {
		birthYear = "18";
	} else {
		alert("올바르지 않은 외국인 등록번호 입니다.");
		objRegNo2.focus();
		return false;
	}

	birthYear += reg_no.substr(0, 2);
	var birthMonth = reg_no.substr(2, 2) - 1;
	var birthDate = reg_no.substr(4, 2);
	var birth = new Date(birthYear, birthMonth, birthDate);

	if ( birth.getYear() % 100 != fgn_reg_no.substr(0, 2) ||
		birth.getMonth() != birthMonth ||
		birth.getDate() != birthDate) {
		alert("외국인 등록번호의 생년월일에 오류가 있습니다.");
		objRegNo1.focus();
		return false;
	}

	var checkValue = true;
	var buf = new Array(13);
	for (i = 0; i < 13; i++) buf[i] = parseInt(reg_no.charAt(i));
	odd = buf[7]*10 + buf[8];
	if (odd%2 != 0) {
		checkValue = false;
	}
	if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9)) {
		checkValue = false;
	}
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
	for (i = 0, sum = 0; i < 12; i++) sum += (buf[i] *= multipliers[i]);
	sum=11-(sum%11);
	if (sum>=10) sum-=10;
	sum += 2;
	if (sum>=10) sum-=10;
	if (sum != buf[12]) {
		checkValue = false;
	} else {
		checkValue = true;
	}
	if (checkValue) {
		return checkValue;
	} else {
		alert("올바르지 않은 외국인 등록번호 입니다.");
		objRegNo2.focus();
		return checkValue;
	}
}
