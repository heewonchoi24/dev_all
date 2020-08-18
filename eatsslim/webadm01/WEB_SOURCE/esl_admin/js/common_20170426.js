function chkForm(obj){
	if (!checkForm(obj)){
		return;
	}else{
		obj.submit();
	}
}
function checkForm(form){ //using : onsubmit="return checkForm(this)"
	if (typeof(mini_obj)!="undefined" || document.getElementById('_mini_oHTML')) mini_editor_submit();

	for (var i=0;i<form.elements.length;i++){
		currEl = form.elements[i];
		if (currEl.disabled) continue;
		if (currEl.getAttribute("required")!=null || currEl.getAttribute("label")!=null){
			if (currEl.type=="checkbox" || currEl.type=="radio"){
				if (!chkSelect(form,currEl,currEl.getAttribute("msgR"))) return false;
			} else {
				if (!chkText(currEl,currEl.value,currEl.getAttribute("msgR"))) return false;
			}
		}
		if (currEl.getAttribute("option")!=null && currEl.value.length>0){
			if (!chkPatten(currEl,currEl.getAttribute("option"),currEl.getAttribute("msgO"))) return false;
		}
		if (currEl.getAttribute("minlength")!=null){
			if (!chkLength(currEl,currEl.getAttribute("minlength"))) return false;
		}
		if (currEl.getAttribute("maxlen")!=null){
			if(!chkMaxLength(currEl,currEl.getAttribute("maxlen"))) return false;
		}
	}
	if (form.password2){
		if (form.password.value!=form.password2.value){
			alert("ºñ¹Ð¹øÈ£°¡ ÀÏÄ¡ÇÏÁö ¾Ê½À´Ï´Ù");
			form.password.value = "";
			form.password2.value = "";
			return false;
		}
	}

	if (form['resno[]'] && !chkResno(form)) return false;
	if (form.chkSpamKey) form.chkSpamKey.value = 1;
	if (document.getElementById('avoidDbl')) document.getElementById('avoidDbl').innerHTML = "--- µ¥ÀÌÅ¸ ÀÔ·ÂÁßÀÔ´Ï´Ù ---";
	return true;
}

function chkMaxLength(field,len){
	if (chkByte(field.value) > len){
		if (!field.getAttribute("label")) field.setAttribute("label", field.name);
		alert("["+field.getAttribute("label") + "]Àº "+ len +"Byte ÀÌÇÏ ¿©¾ß ÇÕ´Ï´Ù.");
		return false;
	}
	return true;
}

function chkLength(field,len)
{
	text = field.value;
	if (text.trim().length<len){
		alert(len + "ÀÚ ÀÌ»ó ÀÔ·ÂÇÏ¼Å¾ß ÇÕ´Ï´Ù");
		field.focus();
		return false;
	}
	return true;
}

function chkText(field,text,msg)
{
	text = text.replace("¡¡", "");
	text = text.replace(/\s*/, "");
	if (text==""){
		var caption = field.parentNode.parentNode.firstChild.innerText;
		if (!field.getAttribute("label")) field.setAttribute("label",(caption)?caption:field.name);
		if (!msg) msg = "[" + field.getAttribute("label") + "] ÇÊ¼ö ÀÔ·Â »çÇ×ÀÔ´Ï´Ù";
		alert(msg);
		if (field.tagName!="SELECT") field.value = "";
		if (field.type!="hidden") field.focus();
		return false;
	}
	return true;
}

function chkSelect(form,field,msg)
{
	var ret = false;
	fieldname = eval("form.elements['"+field.name+"']");
	if (fieldname.length){
		for (var j=0;j<fieldname.length;j++) if (fieldname[j].checked && !fieldname[j].disabled) ret = true;
	} else {
		if (fieldname.checked && !fieldname.disabled) ret = true;
	}
	if (!ret){
		if (!field.getAttribute("label")) field.setAttribute("label", field.name);
		if (!msg) msg = "[" + field.getAttribute("label") + "] ÇÊ¼ö ¼±ÅÃ »çÇ×ÀÔ´Ï´Ù.";
		alert(msg);
		field.focus();
		return false;
	}
	return true;
}

function chkPatten(field,patten,msg)
{
	var regNum			= /^[0-9]+$/;
	var regEmail		= /^[^"'@]+@[._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	var regUrl			= /^(http\:\/\/)*[.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	var regAlpha		= /^[a-zA-Z]+$/;
	var regHangul		= /[°¡-ÆR]/;
	var regHangulEng	= /[°¡-ÆRa-zA-Z]/;
	var regHangulOnly	= /^[°¡-ÆR]*$/;
	var regId			= /^[a-zA-Z0-9]{1}[^"']{3,9}$/;
	var regPass			= /^[a-zA-Z0-9_-]{4,12}$/;
	var regPNum			= /^[0-9]*(,[0-9]+)*$/;
	
	patten = eval(patten);
	if (!patten.test(field.value)){
		if (!field.getAttribute("label")) field.setAttribute("label", field.name);
		if (!msg) msg = "[" + field.getAttribute("label") + "] ÀÔ·ÂÇü½Ä¿À·ù";
		alert(msg);
		field.focus();
		return false;
	}
	return true;
}

function formOnly(form){
	var i,idx = 0;
	var rForm = document.getElementsByTagName("form");
	for (i=0;i<rForm.length;i++) if (rForm[i].name==form.name) idx++;
	return (idx==1) ? form : form[0];
}

/**
 * chkBox(El,mode)
 *
 * µ¿ÀÏÇÑ ÀÌ¸§ÀÇ Ã¼Å©¹Ú½ºÀÇ Ã¼Å© »óÈ² ÄÁÆ®·Ñ
 *
 * -mode	true	ÀüÃ¼¼±ÅÃ
 *			false	¼±ÅÃÇØÁ¦
 *			'rev'	¼±ÅÃ¹ÝÀü
 * @Usage	<input type=checkbox name=chk[]>
 *			<a href="javascript:void(0)" onClick="chkBox(document.getElementsByName('chk[]'),true|false|'rev')">chk</a>
 */

function chkBox(El,mode)
{
	if (!El) return;
	for (i=0;i<El.length;i++){
		if(!El[i].disabled){
			El[i].checked = (mode=='rev') ? !El[i].checked : mode;
		}
	}
}

/**
 * isChked(El,msg)
 *
 * Ã¼Å©¹Ú½ºÀÇ Ã¼Å© À¯¹« ÆÇº°
 *
 * -msg		null	¹Ù·Î ÁøÇà
 *			msg		confirmÃ¢À» ¶ç¾î ½ÇÇà À¯¹« Ã¼Å© (msg - confirmÃ¢ÀÇ ÁúÀÇ ³»¿ë)
 * @Usage	<input type=checkbox name=chk[]>
 *			<a href="javascript:void(0)" onClick="return isChked(document.getElementsByName('chk[]'),null|msg)">del</a>
 */

function isChked(El,msg)
{
	if (!El) return;
	if (typeof(El)!="object") El = document.getElementsByName(El);
	if (El) for (i=0;i<El.length;i++) if (El[i].checked) var isChked = true;
	if (isChked){
		return (msg) ? confirm(msg) : true;
	} else {
		alert ("¼±ÅÃµÈ Ç×¸ñÀÌ ¾ø½À´Ï´Ù");
		return false;
	}
}
function isChecked(El,msg,msg2)
{
	if (!El) return;
	if (typeof(El)!="object") El = document.getElementsByName(El);
	if (El) for (i=0;i<El.length;i++) if (El[i].checked) var isChked = true;
	if (isChked){
		return (msg) ? confirm(msg) : true;
	} else {
		alert (msg2);
		return false;
	}
}

function get_no_str(f)
{	
	str_select_index = "";
	var ele_name = new String("");	
	for(i=0;i<f.elements.length;i++){
		ele_name = f.elements[i].name;
		if(ele_name.substring(0,3) == "chk"){
			if(f.elements[i].checked == true){
				if(str_select_index == ""){
					str_select_index = f.elements[i].value;
				}else{
					str_select_index += ","+f.elements[i].value;
				}
			}
		}
	}
	//alert(str_select_index);
	return str_select_index;
}
/**
 * comma(x), uncomma(x)
 *
 * ¼ýÀÚ Ç¥½Ã (3ÀÚ¸®¸¶´Ù ÄÞ¸¶Âï±â)
 *
 * @Usage	var money = 1000;
 *			money = comma(money);
 *			alert(money);
 *			alert(uncomma(money));
 */

function comma(x)
{
	var temp = "";
	var x = String(uncomma(x));

	num_len = x.length;
	co = 3;
	while (num_len>0){
		num_len = num_len - co;
		if (num_len<0){
			co = num_len + co;
			num_len = 0;
		}
		temp = ","+x.substr(num_len,co)+temp;
	}
	return temp.substr(1);
}

function uncomma(x)
{
	var reg = /(,)*/g;
	x = parseInt(String(x).replace(reg,""));
	return (isNaN(x)) ? 0 : x;
}

/**
 * tab(El)
 *
 * textarea ÀÔ·Â ¹Ú½º¿¡¼­ tabÅ°·Î °ø¹é ¶ç¿ì±â ±â´É Ãß°¡
 *
 * @Usage	<textarea onkeydown="return tab(this)"></textarea>
 */

function tab(El)
{
	if ((document.all)&&(event.keyCode==9)){
		El.selection = document.selection.createRange();
		document.all[El.name].selection.text = String.fromCharCode(9)
		document.all[El.name].focus();
		return false;
	}
}

function enter()
{
    if (event.keyCode == 13){
        if (event.shiftKey == false){
            var sel = document.selection.createRange();
            sel.pasteHTML('<br>');
            event.cancelBubble = true;
            event.returnValue = false;
            sel.select();
            return false;
        } else {
            return event.keyCode = 13;
		}
    }
}

/**
 * strip_tags(str)
 *
 * ÅÂ±×¾ÈÀÇ ¹®ÀÚ¸¸ °¡Á®¿À´Â ÇÔ¼ö
 */

function strip_tags(str)
{
	var reg = /<\/?[^>]+>/gi;
	str = str.replace(reg,"");
	return str;
}


/**
 * ¹®ÀÚ¿­ Byte Ã¼Å© (ÇÑ±Û 2byte)
 */
function chkByte(str)
{
	var length = 0;
	for(var i = 0; i < str.length; i++)
	{
		if(escape(str.charAt(i)).length >= 4)
			length += 2;
		else
			if(escape(str.charAt(i)) != "%0D")
				length++;
	}
	return length;
}

/**
 * ¹®ÀÚ¿­ ÀÚ¸£±â (ÇÑ±Û 2byte)
 */
function strCut(str, max_length)
{
	var str, msg;
	var length = 0;
	var tmp;
	var count = 0;
	length = str.length;

	for (var i = 0; i < length; i++){
		tmp = str.charAt(i);
		if(escape(tmp).length > 4) count += 2;
		else if(escape(tmp) != "%0D") count++;
		if(count > max_length) break;
	}
	return str.substring(0, i);
}


function mv_focus(field,num,target)
{
	len = field.value.length;
	if (len==num && event.keyCode!=8) target.focus();
}

function onlynumber()
{
	var e = event.keyCode;
	window.status = e;
	if (e>=48 && e<=57) return;
	if (e>=96 && e<=105) return;
	if (e>=37 && e<=40) return;
	if (e==8 || e==9 || e==13 || e==46) return;
	event.returnValue = false;
}

function explode(divstr,str)
{
	var temp = str;
	var i;
	temp = temp + divstr;
	i = -1;
	while(1){
		i++;
		this.length = i + 1;
		this[i] = temp.substring(0, temp.indexOf( divstr ) );
		temp = temp.substring(temp.indexOf( divstr ) + 1, temp.length);
		if (temp=="") break;
	}
}

function getCookie( name )
{
	var nameOfCookie = name + "=";
	var x = 0;
	while ( x <= document.cookie.length )
	{
		var y = (x+nameOfCookie.length);
		if ( document.cookie.substring( x, y ) == nameOfCookie ) {
			if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
				endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 )
			break;
	}
	return "";
}

function setCookie( name, value, expires, path, domain, secure ){

	var curCookie = name + "=" + escape( value ) +
		( ( expires ) ? "; expires=" + expires.toGMTString() : "" ) +
		( ( path ) ? "; path=" + path : "" ) +
		( ( domain ) ? "; domain=" + domain : "" ) +
		( ( secure ) ? "; secure" : "" );

	document.cookie = curCookie;
}


String.prototype.trim = function(){ return this.replace(/(^\s*)|(\s*$)/g, ""); }

/** Ãß°¡ ½ºÅ©¸³ **/


function popup(src,width,height,nm){
	if(!width)width=980; if(!height)height=720;
	var pop=window.open(src,nm,'width='+width+',height='+height+',scrollbars=1');
	if(pop)pop.focus();
}

function popup2(src,width,height,scrollbars)
{
	if ( scrollbars=='' ) scrollbars=1;
	window.open(src,'','width='+width+',height='+height+',scrollbars='+scrollbars);
}

/*-------------------------------------
 °ø¿ë - À©µµ¿ì ÆË¾÷Ã¢ È£Ãâ / ¸®ÅÏ
-------------------------------------*/
function popup_return( theURL, winName, Width, Height, left, top, scrollbars ){

	if ( !Width ) Width=500;
	if ( !Height ) Height=415;
	if ( !left ) left=200;
	if ( !top ) top=10;
	if ( scrollbars=='' ) scrollbars=0;
	features = "loaction=no, directories=no, Width="+Width+", Height="+Height+", left="+left+", top="+top+", scrollbars="+scrollbars;
	var win = window.open( theURL, winName, features );

	return win;
}

/*** ÇÒÀÎ¾× °è»ê ***/
function getDcprice(price,dc)
{
	if (!dc) return 0;
	var ret = (dc.match(/%$/g)) ? price * parseInt(dc.substr(0,dc.length-1)) / 100 : parseInt(dc);
	return parseInt(ret / 100) * 100;
}

/*-------------------------------------
ÀÚ¹Ù½ºÅ©¸³Æ® µ¿Àû ·Îµù
-------------------------------------*/
function exec_script(src)
{
	var scriptEl = document.createElement("script");
	scriptEl.src = src;
	if(_ID('dynamic'))_ID('dynamic').appendChild(scriptEl);
}


function setDate(obj1,obj2,from,to)
{
	document.getElementById(obj1).value = (from) ? from : "";
	document.getElementById(obj2).value = (from) ? to : "";
}


function inArray( needle, haystack )
{
	for ( i = 0; i < haystack.length; i++ )
		if ( haystack[i] == needle ) return true;
	return false;
}

/**
 * extComma(x), extUncomma(x)
 *
 * ¼ýÀÚ Ç¥½Ã (3ÀÚ¸®¸¶´Ù ÄÞ¸¶Âï±â, ¸¶ÀÌ³Ê½º ¹× ¼Ò¼öÁ¡ À¯Áö)
 *
 * @Usage	var money = -1000.12;
 *			money = extComma(money);
 *			alert(money);	// -1,000.12
 *			alert(extUncomma(money));	// -1000.12
 */
function extComma(x){
	var head = '', tail = '', minus = '';
	if (x < 0){
		minus = '-';
		x = x * (-1) + "";
	}
    if ( x.indexOf(".") >= 0 ) {
        head = comma(x.substring ( 0 , x.indexOf(".") ));
        tail = uncomma(x.substring ( x.indexOf(".") + 1, x.length ));
    }
    else head = comma(x);
	x = minus + head;
    if ( tail.toString().length > 0 ) x += "." + tail;
	return x;
}

function extUncomma(x){
	var head = '', tail = '', minus = '';
	if (x < 0){
		minus = '-';
		x = x * (-1) + "";
	}
    if ( x.indexOf(".") >= 0 ) {
        head = uncomma(x.substring ( 0 , x.indexOf(".") ));
        tail = uncomma(x.substring ( x.indexOf(".") + 1, x.length ));
    }
    else head = uncomma(x);
	x = minus + head;
    if ( tail.toString().length > 0 ) x += "." + tail;
	return x;
}

function isAlpha(arg_v) // ¿µ¹® ÆÇº°
{
	var cnt=0;
	var str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for(var i = 0; i < arg_v.length; i++) {
		var substr = arg_v.substring(i, i + 1);
		if(str.indexOf(substr) < 0) return true;
	}
	return false;
}
function isNumeric(arg_v) //¼ýÀÚÆÇº°
{
	var cnt=0;
	var str = "0123456789";
	for(var i = 0; i < arg_v.length; i++) {
		var substr = arg_v.substring(i, i + 1);
		if(str.indexOf(substr) < 0) return true;
	}
	return false;
}
function trim(txt){return txt.replace(/(^\s*)|(\s*$)/g, "");}

// ¿É¼ÇÀ» »ý¼ºÇÏ´Â ÇÔ¼ö
// newOptions : ¿É¼Ç, select : select¸í, selectedOption : ¼±ÅÃ°ª
function makeOption(newOptions, select, selectedOption) {
	var options	= select.prop('options');

	$('option', select).remove();
	$.each(newOptions, function(val, text) {
		options[options.length]	= new Option(text, val);
	});
	select.val(selectedOption);
}

function frmReset() {
	$("form[name=frm_search]").each(function() {
		$('input').val('').removeAttr('checked').removeAttr('selected');
	});
}

function TypeCheck (s, spc) {
	var i;

	for(i=0; i< s.length; i++) {
		if (spc.indexOf(s.substring(i, i+1)) < 0) {
			return false;
		}
	}
	return true;
}

// ¼ýÀÚ¸¸ ÀÔ·Â¹Þ´Â ÇÔ¼ö
function onlyNum(field) {
	if (!TypeCheck(field.value, "0123456789")) {
		alert('¼ýÀÚ¸¸ ÀÔ·ÂÇØ ÁÖ¼¼¿ä.');
		field.value = '';
		field.focus();
		return false;
	}
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

// 3ÀÚ¸®¸¶´Ù , ÀÚµ¿ÀÔ·Â
function commaInsert(field) {
	if (!TypeCheck(field.value , "0123456789,")) {
		alert('¼ýÀÚ¸¸ ÀÔ·ÂÇØ ÁÖ¼¼¿ä.');
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