function chkForm(obj)
{
	if (!checkForm(obj)){
		return;
	}else{
		obj.submit();
	}
}
function checkForm(form){ //using : onsubmit="return checkForm(this)"
	if (typeof(mini_obj)!="undefined" || document.getElementById('_mini_oHTML')) mini_editor_submit();
	var currEl;

	for (var i=0;i<form.elements.length;i++){
		currEl = form.elements[i];
		//alert(currEl.name+","+currEl.getAttribute("required")+","+currEl.getAttribute("label"));
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
			alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�");
			form.password.value = "";
			form.password2.value = "";
			return false;
		}
	}

	if (form['resno[]'] && !chkResno(form)) return false;
	if (form.chkSpamKey) form.chkSpamKey.value = 1;
	if (document.getElementById('avoidDbl')) document.getElementById('avoidDbl').innerHTML = "--- ����Ÿ �Է����Դϴ� ---";
	return true;
}

function chkMaxLength(field,len){
	if (chkByte(field.value) > len){
		if (!field.getAttribute("label")) field.setAttribute("label", field.name);
		alert("["+field.getAttribute("label") + "]�� "+ len +"Byte ���� ���� �մϴ�.");
		return false;
	}
	return true;
}

function chkLength(field,len)
{
	text = field.value;
	if (text.trim().length<len){
		alert(len + "�� �̻� �Է��ϼž� �մϴ�");
		field.focus();
		return false;
	}
	return true;
}

function chkText(field,text,msg)
{
	text = text.replace("��", "");
	text = text.replace(/\s*/, "");
	if (text==""){
		var caption = field.parentNode.parentNode.firstChild.innerText;
		if (!field.getAttribute("label")) field.setAttribute("label",(caption)?caption:field.name);
		if (!msg) msg = "[" + field.getAttribute("label") + "] �ʼ� �Է� �����Դϴ�";
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
		if (!msg) msg = "[" + field.getAttribute("label") + "] �ʼ� ���� �����Դϴ�.";
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
	var regHangul		= /[��-�R]/;
	var regHangulEng	= /[��-�Ra-zA-Z]/;
	var regHangulOnly	= /^[��-�R]*$/;
	var regId			= /^[a-zA-Z0-9]{1}[^"']{3,9}$/;
	var regPass			= /^[a-zA-Z0-9_-]{4,12}$/;
	var regPNum			= /^[0-9]*(,[0-9]+)*$/;
	
	patten = eval(patten);
	if (!patten.test(field.value)){
		if (!field.getAttribute("label")) field.setAttribute("label", field.name);
		if (!msg) msg = "[" + field.getAttribute("label") + "] �Է����Ŀ���";
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
 * ������ �̸��� üũ�ڽ��� üũ ��Ȳ ��Ʈ��
 *
 * -mode	true	��ü����
 *			false	��������
 *			'rev'	���ù���
 * @Usage	<input type=checkbox name=chk[]>
 *			<a href="javascript:void(0)" onClick="chkBox(document.getElementsByName('chk[]'),true|false|'rev')">chk</a>
 */

function chkBox(El,mode){
	if (!El) return;
	for (i=0;i<El.length;i++){
		if(!El[i].disabled){
			El[i].checked = (mode=='rev') ? !El[i].checked : mode;			
		}
	}
}
function ckBox(El,thisObj){
	if (!El) return;
	for (i=0;i<El.length;i++){
		if(!El[i].disabled){
			if(thisObj.checked)
				El[i].checked=true;
			else
				El[i].checked=false;
		}
	}
}
/**
 * isChked(El,msg)
 *
 * üũ�ڽ��� üũ ���� �Ǻ�
 *
 * -msg		null	�ٷ� ����
 *			msg		confirmâ�� ��� ���� ���� üũ (msg - confirmâ�� ���� ����)
 * @Usage	<input type=checkbox name=chk[]>
 *			<a href="javascript:void(0)" onClick="return isChked(document.getElementsByName('chk[]'),null|msg)">del</a>
 */

function isChked(El,msg)
{
	if (!El) return;
	//if (typeof(El)!="object") El = document.getElementsByName(El);
	if (El) for (i=0;i<El.length;i++) if (El[i].checked) var isChked = true;
	if (isChked){
		return (msg) ? confirm(msg) : true;
	} else {
		alert ("���õ� �׸��� �����ϴ�");
		return false;
	}
}

function isChecked(El,msg,msg2)
{
	if (!El) return;
	//if (typeof(El)!="object") El = document.getElementsByName(El);
	if (El) for (i=0;i<El.length;i++) if (El[i].checked) var isChecked = true;
	if (isChecked){
		return (msg) ? confirm(msg) : true;
	} else {
		alert (msg2);
		return false;
	}
}

function get_no_str(f)
{	
	var str_select_index = "";
	var ele_name = new String("");	
	for(var i=0;i<f.elements.length;i++){
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
 * ���� ǥ�� (3�ڸ����� �޸����)
 *
 * @Usage	var money = 1000;
 *			money = comma(money);
 *			alert(money);
 *			alert(uncomma(money));
 */

function comma(x)
{
	var temp = "";
	x = String(uncomma(x));

	var num_len = x.length;
	var co = 3;
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
 * textarea �Է� �ڽ����� tabŰ�� ���� ���� ��� �߰�
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
 * �±׾��� ���ڸ� �������� �Լ�
 */

function strip_tags(str)
{
	var reg = /<\/?[^>]+>/gi;
	str = str.replace(reg,"");
	return str;
}


/**
 * ���ڿ� Byte üũ (�ѱ� 2byte)
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
 * ���ڿ� �ڸ��� (�ѱ� 2byte)
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

/** �߰� ��ũ�� **/


function popup(src,width,height,scrollbars,nm,add){
	if ( scrollbars=='' ) scrollbars=1;
	if(!width)width=980; if(!height)height=720;
	var pop=window.open(src,nm,'width='+width+',height='+height+',scrollbars='+scrollbars+add);
	if(pop)pop.focus();
}

/*-------------------------------------
 ���� - ������ �˾�â ȣ�� / ����
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

/*** ���ξ� ��� ***/
function getDcprice(price,dc)
{
	if (!dc) return 0;
	var ret = (dc.match(/%$/g)) ? price * parseInt(dc.substr(0,dc.length-1)) / 100 : parseInt(dc);
	return parseInt(ret / 100) * 100;
}

/*-------------------------------------
�ڹٽ�ũ��Ʈ ���� �ε�
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
 * ���� ǥ�� (3�ڸ����� �޸����, ���̳ʽ� �� �Ҽ��� ����)
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

function isAlpha(arg_v) // ���� �Ǻ�
{
	var cnt=0;
	var str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	for(var i = 0; i < arg_v.length; i++) {
		var substr = arg_v.substring(i, i + 1);
		if(str.indexOf(substr) < 0) return true;
	}
	return false;
}
function isNumeric(arg_v) //�����Ǻ�
{
	var cnt=0;
	var str = "0123456789";
	for(var i = 0; i < arg_v.length; i++) {
		var substr = arg_v.substring(i, i + 1);
		if(str.indexOf(substr) < 0) return false;
	}
	return true;
}
function trim(txt){return txt.replace(/(^\s*)|(\s*$)/g, "");}

function doGetAjax(filename,param,obj){
	$.ajax({ 
		type: "GET", 
		url: filename, //���� ������
		data: param,  //������ �������� "id=ddd&name=������&age=22" ó�� �ۼ�
		dataType:"JSON",
		success: function(data) {
			if(obj)obj.innerHTML=data; //������ ����κ�			
		},
		error: function(result) {
			//$("#debug").text(filename+"?"+param);
		}
	}); 
}

//2013-06-05 ���� 09:20�� ha �α��� �b��â�� ���� ��δ� /popup/popup_ha_login.jsp �̿����� /ha/login.jsp �� �����Ͽ����ϴ�.
function login_ha_popup(){
	if(navigator.userAgent.indexOf("Chrome") > 0){
		var w=window.open('/ha/login.jsp','popup_ha_login','width=473,height=380,resizable=true,scrollbars=no');
		w.focus();

	}else if(navigator.userAgent.indexOf("Safari") > 0){
		var w=window.open('/ha/login.jsp','popup_ha_login','width=473,height=320,resizable=true,scrollbars=no');
		w.focus();

	}else{
		var w=window.open('/ha/login.jsp','popup_ha_login','width=473,height=380,resizable=true,scrollbars=no');
		w.focus();
	}
}

function login_popup(){
	if(navigator.userAgent.indexOf("Chrome") > 0){
		var w=window.open('/popup/popup_login.jsp','popup_login','width=456,height=385,resizable=true,scrollbars=no');
		w.focus();

	}else if(navigator.userAgent.indexOf("Safari") > 0){
		var w=window.open('/popup/popup_login.jsp','popup_login','width=456,height=325,resizable=true,scrollbars=no');
		w.focus();

	}else{
		var w=window.open('/popup/popup_login.jsp','popup_login','width=456,height=385,resizable=true,scrollbars=no');
		w.focus();
	}
}
function login_mobile(){
	location.href="/mobile/login.jsp";
	return;

	if(navigator.userAgent.indexOf("Chrome") > 0){
		var w=window.open('/mobile/login.jsp','popup_login','width=465,height=345,resizable=true,scrollbars=no');
		w.focus();

	}else if(navigator.userAgent.indexOf("Safari") > 0){
		var w=window.open('/mobile/login.jsp','popup_login','width=465,height=285,resizable=true,scrollbars=no');
		w.focus();

	}else{
		var w=window.open('/mobile/login.jsp','popup_login','width=465,height=345,resizable=true,scrollbars=no');
		w.focus();
	}
}

//��ƮȮ�� 
function FontPlus(objName){ 
	var l = document.getElementById(objName); 
	var nSize = l.style.fontSize  ? l.style.fontSize  : '9pt'; 
	var iSize = parseInt(nSize.replace('pt','')); 

	if (iSize < 20){ 
		l.style.fontSize  = (iSize + 1) + 'pt'; 
		//l.style.lineHeight = '140%'; 
	} 
} 
//��Ʈ��� 
function FontMinus(objName){ 
	var l = document.getElementById(objName); 
	//alert(l.style.fontSize);
	var nSize = l.style.fontSize ? l.style.fontSize : '9pt'; 
	var iSize = parseInt(nSize.replace('pt','')); 

	if(iSize<9)iSize=9;

	if (iSize > 6){ 
		l.style.fontSize = (iSize - 1) + 'pt'; 
		//l.style.lineHeight = '140%'; 
	} 
}
//���� ��Ʈ�ѷ� ��Ŀ�� �̵� onkeyup="nextFocus(this,4,'cp2')"
function nextFocus(obj,cnt,obj2){
	if(obj.value.length>=cnt){
		if(document.getElementById(obj2))document.getElementById(obj2).focus();
	}
}

function cal_cart_sum_money(){
	var sum_money_val = 0;
	$("#cart_list li").each(function(e){		
		sum_money_val += eval($(this).find("#cart_p_listprice").text().replace(/,/gi,"") * eval($(this).find("#cart_p_cnt").text()));
		//sum_money_val += eval($(this).find("#cart_p_money").text() * eval($(this).find("#cart_p_cnt").text()));		
		//alert($(this).find("#cart_p_money").text());		
	});
	
	//alert(sum_money_val);
	/*
	setCookie("pno",goodsno,'','/','','');
	setCookie("ea",ea,'','/','','');
	setCookie("freegift",freegift,'','/','','');*/

	$("#cart_total_money").text(comma(String(sum_money_val)));
}

function cartDB(){
	var cnt=0;
	var pno="";
	var ea="";
	var freegift="";
	var tmp="";
	$("#cart_list li").each(function(e){
		if(cnt>0)pno+=",";
		pno += $(this).find("#cart_p_goodsno").text();

		if(cnt>0)ea+=",";
		ea += eval($(this).find("#cart_p_cnt").text());

		if(cnt>0)freegift+=",";
		//freegift += encodeURIComponent($(this).find("#cart_p_freegift").text());
		if($(this).find("#cart_p_freegift").text()){
			freegift += $(this).find("#cart_p_freegift").text();
		}else{
			freegift += "0";
		}

		cnt++;
		
	});
	//alert("mode=reg&pno="+pno+"&ea="+ea+"&freegift="+freegift);return;	
	doGetAjax("/proc/cart_proc.jsp","mode=reg&pno="+pno+"&ea="+ea+"&freegift="+freegift,"");
}
function cartOrder(){
	if($("#cart_total_money").text()==0){
		alert("��ٱ��Ͽ� ��� ��ǰ�� �������� �ʽ��ϴ�.");
		return;
	}
	location.href="/shopping/checkout.jsp?mode=cart";
}
//��ǰã��===========
function searchProduct(){
	var param="";
	if($('input:radio[name=health_style]:checked').val()=="5"){ //�ӽ����̿���� ���� ����.
		param+="&dog_etc="+$('input:radio[name=health_style]:checked').val();
	}else{
		param="dog_kind="+$('#kindbox option:selected').val();
		param+="&dog_age="+$('#agebox option:selected').val();
		param+="&dog_weight="+$('input:radio[name=dog_style]:checked').val();
		param+="&dog_etc="+$('input:radio[name=health_style]:checked').val();
	}
	//alert(param);
	var html="",ht1="",ht2="";	
	
	$.ajax({ 
		type: "get", 
		url: "/inc/getProductSearch.jsp?"+param, //���� ������		
		dataType:"json",
		beforeSend: function() {			
			$("#psearchResult1").html("");
			$("#psearchResult2").html("");
		},
		success: function(data) {
			$.each(data, function (index) {				
				if(this.no != undefined && this.no){
					html="";
					html+="<ul class=\"probox1\" onMouseOver=\"img_box"+this.no+".className='probox1_over';\" onMouseout=\"img_box"+this.no+".className='probox1_out';\">";
					html+="	<li class=\"img\" style=\"text-align:center;\"><a href=\"javascript:searchViewProduct("+this.no+");\"><img src=\"/data/goods/"+this.img+"\" height=\"104\" id=\"pd_img_"+this.no+"\"></a></li>";
					html+="	<ul id=\"img_box"+this.no+"\" class=\"probox1_out\" onClick=\"img_box"+this.no+".className='probox1_out';\" onMouseOver=\"img_box"+this.no+".className='probox1_over';\" onMouseout=\"img_box"+this.no+".className='probox1_out';\">";
					if(!$("#smember_id").text()){
					html+="		<li class=\"style1\" id=\"pd_act1_"+this.no+"\"><a href=\"javascript:login_popup();\"><img src=\"../images/common/btn/btn_pro_search1.png\" alt=\"�����ϱ�\"></a></li>";
					html+="		<li class=\"style2\" id=\"pd_act2_"+this.no+"\"><a href=\"javascript:login_popup();\"><img src=\"../images/common/btn/btn_pro_search2.png\" alt=\"��ٱ���\"></a></li>";
					}else{
					html+="		<li class=\"style1\" id=\"pd_act1_"+this.no+"\"><a href=\"javascript:searchDirectOrderProduct("+this.no+");\"><img src=\"../images/common/btn/btn_pro_search1.png\" alt=\"�����ϱ�\"></a></li>";
					html+="		<li class=\"style2\" id=\"pd_act2_"+this.no+"\"><a href=\"javascript:searchAddCart("+this.no+");\"><img src=\"../images/common/btn/btn_pro_search2.png\" alt=\"��ٱ���\"></a></li>";
					}
					html+="	</ul>";
					html+="	<li class=\"protxtbox1\" id=\"pd_name_"+this.no+"\">"+this.goodsnm+"</li>";
					html+="	<li class=\"protxtbox2\">";
					html+="		<span class=\"txtstyle1\" id=\"pd_price_"+this.no+"\">"+comma(this.price)+"��</span> <span class=\"txtstyle2\" id=\"pd_sell_price_"+this.no+"\">"+comma(this.sell_price)+"��</span>";
					html+="		<span id=\"pd_goodsno_"+this.no+"\" style=\"display:none\">"+this.goodsno+"</span>";
					html+="		<span id=\"pd_stock_"+this.no+"\" style=\"display:none\">"+this.stock+"</span>";
					html+="	</li>";
					html+="</ul>";
					if(this.gubun=="1"){
						ht1+=html;
					}else if(this.gubun=="2"){
						ht2+=html;
					}
				}
			});			
			$("#psearchResult1").html(ht1);
			$("#psearchResult2").html(ht2);
		},
		error: function(e) {
			alert(e.text);
		}
	});
}
function searchReset(){
	document.getElementById("kindbox").selectedIndex=0;
	document.getElementById("agebox").selectedIndex=0;
	document.getElementById("dog_style3").checked=true;
	document.getElementById("health_style1").checked=true;
}

function searchViewProduct(no){
	if($("#pd_goodsno_"+no).text())location.href="/shopping/product.jsp?pno="+$("#pd_goodsno_"+no).text();
}
function searchDirectOrderProduct(no){
	if($("#pd_goodsno_"+no).text())location.href="/shopping/checkout.jsp?pno="+$("#pd_goodsno_"+no).text();
}
function searchAddCart(no){
	if(eval($("#pd_stock_"+no).val())==0){
		alert("ǰ�� ��ǰ�Դϴ�.");return;
	}
	var flag_p_exist;
	$("#cart_list #cart_p_name").each(function(e){
		if($("#pd_name_"+no).text() == $(this).text()){
			flag_p_exist="Y";alert("�ش� ��ǰ�� �̹� ��ٱ��Ͽ� ����� �ֽ��ϴ�.");
		}
	});
	if(flag_p_exist=="Y" || $("#pd_name_"+no).text()==""){
		return;
	}
	//��ٱ��� ����
	var default_shop_list_html;	
	default_shop_list_html = "<li class=\"first\">";
	default_shop_list_html += "						<div class=\"group\">";
	default_shop_list_html += "							<span class=\"span_chk\"></span>";
	default_shop_list_html += "							<p class=\"img1\"><img src=\"../images/common/layout/img_shoppingcart.jpg\" alt=\"\" width=\"47\" height=\"47\" id=\"cart_p_img\" /></p>";
	default_shop_list_html += "							<p class=\"txt1\" id=\"cart_p_name\">�ɴ� ĳ��� �׷������� ���ǵ��22 - 2kg</p>";
	default_shop_list_html += "						</div>";
	default_shop_list_html += "						<div class=\"total_box\">";
	default_shop_list_html += "							<span><strong id=\"cart_p_money\">15,200</strong>��</span> <strong id=\"cart_p_cnt\">1</strong>��";
	default_shop_list_html += "							<p class=\"btn1\">";
	default_shop_list_html += "								<a href=\"#this\" id=\"cart_plus_btn\"><img src=\"../images/common/layout/btn_add.gif\" alt=\"\" /></a>";
	default_shop_list_html += "								<a href=\"#this\" id=\"cart_minus_btn\"><img src=\"../images/common/layout/btn_cut.gif\" alt=\"\" /></a>";
	default_shop_list_html += "							</p>";
	default_shop_list_html += "						</div>";
	default_shop_list_html += "						<div><span id=\"cart_p_listprice\" style='display:none'></span></div>";
	default_shop_list_html += "						<span id=\"cart_p_freegift\" style='display:none'></span>";
	default_shop_list_html += "						<span id=\"cart_p_goodsno\" style='display:none'></span>";
	default_shop_list_html += "					</li>";

	//$("#shopcart_open_btn").trigger("click");
	$("#open_shoppingcart").hide();
	$("#shopping_cart").show();

	$("#cart_list").prepend(default_shop_list_html);
	$("#cart_list li").removeClass();
	$("#cart_list li:first").addClass("first");	
	$("#cart_list li:first").find("#cart_p_name").text($("#pd_name_"+no).text());	 //��ǰ��
	$("#cart_list li:first").find("#cart_p_img").attr("src",$("#pd_img_"+no).attr("src"));	 //�̹���
	$("#cart_list li:first #cart_p_listprice").text($("#pd_sell_price_"+no).text().replace(/,/gi,"").replace("��","")); //�ܰ�
	$("#cart_p_money").text($("#pd_sell_price_"+no).text().replace("��","")); //�⺻1�� ���� ǥ��
	$("#cart_p_cnt").text(1); //����
	$("#cart_p_goodsno").text($("#pd_goodsno_"+no).text());
	cal_cart_sum_money();
	cartDB();
	$(".product_close").trigger("click");
}
//===========��ǰã�� ��