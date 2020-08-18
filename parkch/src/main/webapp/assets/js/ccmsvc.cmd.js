if (!$.ccmsvc){
	$.ccmsvc = function(){};
}

$.extend({
	getUrlParamNames : function() {
		var vars = [], hash;
		var hashes = window.location.href.slice(
				window.location.href.indexOf('?') + 1).split('&');
		for ( var i = 0; i < hashes.length; i++) {
			hash = hashes[i].split('=');
			vars.push(hash[0]);
			vars[hash[0]] = hash[1];
		}
		return vars;
	},
	getUrlParam : function(name) {
		return $.getUrlParamNames()[name];
	}
});

//	String객체 trim 기능 추가
String.prototype.trim = function() {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
}

//이메일 유효성 정규식
var emailRegExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

//아이디 유효성 검증 함수
function idChk(str){
	
	if(str.length > 12){
		alert("아이디는 최대 12자 이하로 작성해야 합니다.");
		return false;
	}else if(str.length < 6){
		alert("아이디는 최소 6자 이상으로 작성해야 합니다.");
		return false;
	}else{
		var v = 1;
		var p = 0;
		
		var num = "(?=(?:.*[0-9]){"+v+",})";
		var alpha = "(?=(?:.*[a-z]){"+v+",})";
		
		var num_regex = new RegExp(num, "m");
		var alpha_regex = new RegExp(alpha, "m");
		
		if(num_regex.test(str)){p++;}
		if(alpha_regex.test(str)){p++;}
		
		if(p >= 1){
			return true;
		}else{
			alert("아이디는 영문(소문자)와 숫자를 조합하여 작성해야 합니다.");
			return false;
		}
	}
}

//숫자 입력 함수
function fn_numberInit() {
	$(".onlyNumber").keyup(function() {
		$(this).val($(this).val().replace(/^[0-9]+$/,''));
	});
	$(".onlyNumber").blur(function(){
		$(this).val($(this).val().replace(/^[0-9]+$/,''));
	})
	$(".onlyNumber2").keyup(function() {
		this.value = this.value.replace(/^[0-9]+$/,'');
	});
}

//암호 유효성 검증 함수
function pwdChk(str){
	if(str.length >= 10){
		var v = 1;
		var p = 0;
		
		var num = "(?=(?:.*[0-9]){"+v+",})";
		var alpha = "(?=(?:.*[a-zA-Z]){"+v+",})";
		var sChar = "(?=(?:.*[~!@#\$%^&*()\=\\]\\[-_+}{:;'\",./<>?]){"+v+",})";
		
		var num_regex = new RegExp(num, "m");
		var alpha_regex = new RegExp(alpha, "m");
		var sChar_regex = new RegExp(sChar, "m");
		
		if(num_regex.test(str)){p++;}
		if(alpha_regex.test(str)){p++;}
		if(sChar_regex.test(str)){p++;}
		
		if(p>=2){
			return true;
		}else{
			alert("비밀번호는 영문자, 숫자, 특수문자 중 \n최소 2가지 이상을 조합하여 작성해야 합니다.");
			return false;
		}
	}else{
		alert("비밀번호는 최소 10자 이상 작성해야 합니다.");
		return false;
	}
	//console.log("숫자 : " + num_regex.test(str) + ", 영문자 : " + alpha_regex.test(str) + ", 특수문자 : " + sChar_regex.test(str));
}

$.ccmsvc.nonAsyncCall = function( pUrl, pParam, pSuccessCallback, pFailCallback ){ 
 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false,
		async: false, 
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;  
}; 

$.ccmsvc.nonAsyncCall2 = function( pUrl, pParam, pObjid, pTempid, pSuccessCallback, pFailCallback ){ 

	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false,
		async: true, 
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		success : function(data) {pSuccessCallback( data, pObjid, pTempid ); },
		error : pFailCallback
	});
	return ajaxCall;  
}; 


$.ccmsvc.chartCall = function( pUrl, pParam, pObjid, pSuccessCallback, pFailCallback ){ 
 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false,
		async: false, 
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		success : function(data) {pSuccessCallback( data, pObjid ); },
		error : pFailCallback
	});
	return ajaxCall;  
}; 


$.ccmsvc.asyncCall = function( pUrl, pParam, pSuccessCallback, pFailCallback ){ 
	 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false, 
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;  
};

$.ccmsvc.asyncCall2 = function( pUrl, pParam, pObjid, pTempid, pSuccessCallback, pFailCallback ){ 
	 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false,
		async: true, 
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8", 
		success : function(data) {pSuccessCallback( data, pObjid, pTempid ); }, 
		error : pFailCallback
	});
	return ajaxCall;  
}; 

$.ccmsvc.selectboxCall = function( pUrl, pParam, pObjid, pTempid,  pSuccessCallback, pFailCallback ){ 
	 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false, 
		async: false,  
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8", 
		success : function(data) {pSuccessCallback( data, pObjid, pTempid); }, 
		error : pFailCallback
	});
	return ajaxCall;  
}; 

$.ccmsvc.checkboxCall = function( pUrl, pParam, pObjid, pTempid,  pSuccessCallback, pFailCallback ){ 
	 
	var ajaxCall = 
	$.ajax({
		type : 'POST',
		cache : false, 
		async: false,  
		url : pUrl,
		data : pParam,
		dataType : "json",   
		contentType : "application/x-www-form-urlencoded;charset=utf-8", 
		success : function(data) {pSuccessCallback( data, pObjid, pTempid); }, 
		error : pFailCallback
	});
	return ajaxCall;  
}; 
 
$.ccmsvc.makeSelectbox = function( data, pObjid, pTempid ){  
	 
	$('#' + pObjid).empty();   
	$("#" + pObjid).append("<option value=''>전체</option> ");
	$('#' + pTempid).tmpl(data).appendTo('#' + pObjid); 
}; 

$.ccmsvc.makeSelectbox_choice = function( data, pObjid, pTempid ){  
	 
	$('#' + pObjid).empty();   
	$("#" + pObjid).append("<option value=''>== 선택하세요 ==</option> ");
	$('#' + pTempid).tmpl(data).appendTo('#' + pObjid); 
};

$.ccmsvc.makeSelectbox_empty = function( data, pObjid, pTempid ){  
	 
	$('#' + pObjid).empty();
	$('#' + pTempid).tmpl(data).appendTo('#' + pObjid); 
}; 

$.ccmsvc.makeSelectbox_keyword = function( data, pObjid, pTempid, keyword ){  
	 
	$('#' + pObjid).empty();
	$("#" + pObjid).append("<option value=''>" + keyword + "</option> ");
	$('#' + pTempid).tmpl(data).appendTo('#' + pObjid); 
};

 
$.ccmsvc.drawSparklineChart = function(data, container_class, option){  
	$('.' + container_class).sparkline(data, option);
};




function excelDownload(sqlid, fileName, contentPage) {

	$('#frm').clone()
	.attr('id', 'excelFrm')
	.css('display', 'none')
	.insertAfter( $('#frm') );
	
	var selects = $('#frm').find('select');
	$(selects).each(function(i) {
		var select = this; 
		$('#excelFrm').find('select').eq(i).val($(select).val());
	});
	
	
	var idsite = '';
	
	// idsite 값
	if ( $('#selSiteGroup').val() != '' && $('#selSite').val() == '' ) {
		
		var cnt = 0;

		$('#selSite > option').each(function() {
			
			if ( $(this).val() != '' ) {

				if (cnt > 0) idsite += ',';
				
				idsite += " '" + $(this).val() + "' "; 
											
				cnt++;
			}
			
		}
		); 
		
	} else if ($('#selSiteGroup').val() != '' && $('#selSite').val() != '') {
		
		idsite = $('#selSite').val();
		
	}
	
	$('#excelFrm').append('<input type="hidden" name="idsite" id="idsite" />');
	$('#idsite').val(idsite);
	
	$('#excelFrm').append('<input type="hidden" name="sqlid" id="sqlid" />');
	$('#excelFrm').append('<input type="hidden" name="fileName" id="fileName" />');
	$('#excelFrm').append('<input type="hidden" name="contentPage" id="contentPage" />');
	
	$('#sqlid').val(sqlid);
	$('#fileName').val(fileName);
	$('#contentPage').val(contentPage);
	
	$('#excelFrm').attr('action', '/wn/common/excelDownload.do');
	$('#excelFrm').attr('method', 'post'); 
	
	$('#excelFrm').submit();
	
	$('#excelFrm').remove();
	
}



/**
 * Get 방식의 API AJAX호출함수
 * 
 * @param pAjaxUrl		AJAX 호출주소
 * @param pAjaxParam	AJAX 호출에 필요한 parameter
 * @param pSuccessCallback	AJAX 성공 콜백	
 * @param pFailCallback		AJAX 실패 콜백
 */
$.ccmsvc.ajaxRequestGet = function(pAjaxUrl, pAjaxParam, pSuccessCallback, pFailCallback){

	if (pAjaxParam.params){
		pAjaxParam.params = encodeURIComponent($.toJSON(pAjaxParam.params));
	}
	if (pAjaxParam.json_param){
		pAjaxParam.json_param = encodeURIComponent($.toJSON(pAjaxParam.json_param));
	}

	var ajaxCall =
	$.ajax({
		type : 'GET',
		cache : false,
		url : pAjaxUrl,
		data : pAjaxParam,
		dataType : "json",
		callbackParameter : "callback",
		timeout : 20000,
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;
};

/**
 * POST 방식의 API AJAX 호출함수
 * 
 * @param pAjaxUrl		AJAX 호출주소
 * @param pAjaxParam	AJAX 호출에 필요한 parameter
 * @param pSuccessCallback	AJAX 성공 콜백	
 * @param pFailCallback		AJAX 실패 콜백
 */
$.ccmsvc.ajaxRequestPost = function(pAjaxUrl, pAjaxParam, pSuccessCallback, pFailCallback){

	if (pAjaxParam.params){
		pAjaxParam.params = $.toJSON(pAjaxParam.params);
	}
	if (pAjaxParam.json_param){
		pAjaxParam.json_param = $.toJSON(pAjaxParam.json_param);
	}
	
	
	var ajaxCall =
	$.ajax({
		type : 'POST',
		cache : false,
		url : pAjaxUrl,
		data : pAjaxParam,
		dataType : "json",
		callbackParameter : "callback",
		timeout : 20000,
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;
};


/**
 * Get 방식의 API 동기식 AJAX 호출함수
 * 
 * @param pAjaxUrl		AJAX 호출주소
 * @param pAjaxParam	AJAX 호출에 필요한 parameter
 * @param pSuccessCallback	AJAX 성공 콜백	
 * @param pFailCallback		AJAX 실패 콜백
 */
$.ccmsvc.ajaxSyncRequestGet = function(pAjaxUrl, pAjaxParam, pSuccessCallback, pFailCallback){

	if (pAjaxParam.params){
		pAjaxParam.params = encodeURIComponent($.toJSON(pAjaxParam.params));
	}
	if (pAjaxParam.json_param){
		pAjaxParam.json_param = encodeURIComponent($.toJSON(pAjaxParam.json_param));
	}

	var ajaxCall =
	$.ajax({
		type : 'GET',
		async : false,
		cache : false,
		url : pAjaxUrl,
		data : pAjaxParam,
		dataType : "json",
		callbackParameter : "callback",
		timeout : 20000,
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;
};

/**
 * POST 방식의 API 동기식 AJAX 호출함수
 * 
 * @param pAjaxUrl		AJAX 호출주소
 * @param pAjaxParam	AJAX 호출에 필요한 parameter
 * @param pSuccessCallback	AJAX 성공 콜백	
 * @param pFailCallback		AJAX 실패 콜백
 */
$.ccmsvc.ajaxSyncRequestPost = function(pAjaxUrl, pAjaxParam, pSuccessCallback, pFailCallback){

	if (pAjaxParam.params){
		pAjaxParam.params = $.toJSON(pAjaxParam.params);
	}
	if (pAjaxParam.json_param){
		pAjaxParam.json_param = $.toJSON(pAjaxParam.json_param);
	}
	alert(1);
	
	
	var ajaxCall =
	$.ajax({
		type : 'POST',
		cache : false,
		async : false,
		url : pAjaxUrl,
		data : pAjaxParam,
		dataType : "json",
		callbackParameter : "callback",
		timeout : 20000,
		success : pSuccessCallback,
		error : pFailCallback
	});
	return ajaxCall;
};

/**
 * 특정  form에 file input을 추가한 후, 파일 다이얼로그를 열음
 */
$.ccmsvc.addFileInputAndOpenFileDialog = function(formId){
	
	//	해당  form이 존재하지 않을 경우, 생성
	if ( $('#'+formId).size() == 0){
		$('<form id="'+formId+'"  style="display: none;"/>').appendTo('body');
	}
	
	//	파일 업로드를 위한 input 생성
	var lastInputIndex = -1;
	$('#'+formId+' input').each(function(){
		var tempIndex = parseInt($(this).attr('index'));
		if (lastInputIndex < tempIndex){
			lastInputIndex = tempIndex;
		}
	});
	var input = $('<input type="file" name="file_'+(lastInputIndex+1)+'" index="'+(lastInputIndex+1)+'" />').appendTo('#'+formId).trigger('click');
	
	return input;
}

/**
 * 특정  form에 hidden input을 추가한 후, 파일 다이얼로그를 열음
 */
$.ccmsvc.addHiddenInput =  function(formId, inputName, value){

	//	해당  form이 존재하지 않을 경우, 생성
	if ( $('#'+formId).size() == 0){
		$('<form id="'+formId+'"  style="display: none;"/>').appendTo('body');
	}
	
	//	파일 업로드를 위한 input 생성
	var inputCount = $('#'+formId+' *').size();
	var input = $('<input type="hidden" name="'+inputName+'" value="'+encodeURIComponent(value)+'" />').appendTo('#'+formId);
	
	return input;
};

/**
 * 특정 form을 특정 action에 전송
 * 
 * @param formId	form ID
 * @param pAjaxUrl	ajaxUrl
 * @param pResponseCallback		
 * @param pFailCallback;		실패 콜백
 * @param redirectUrl submit 수행후, 이동되는 페이지
 */
$.ccmsvc.submitForm = function(formId, pAjaxUrl,  pSuccessCallback, pSuccessCallbackOption){

	//	form 설정 및 submit 
	$('#'+formId).attr('action', pAjaxUrl);
	$('#'+formId).attr('method', 'POST');
	$('#'+formId).attr('enctype', 'multipart/form-data');
	$('#'+formId).ajaxSubmit({
		success: function(responseText, statusText, xhr){
			if (pSuccessCallback != null){
				pSuccessCallback(responseText, statusText, xhr, pSuccessCallbackOption);
			}
		},
		url: pAjaxUrl,
		dataType: 'json'
	});
};

/**
 * HTML 페이지를 읽어들어, 특정 container에 import
 * 
 * @param importPageUrl	로드되는 페이지의 주소
 * @param containerSelector 페이지가 담겨질 container 선택자
 */
$.ccmsvc.loadPage = function(importPageUrl, containerSelector){
    if(importPageUrl == undefined)return;
	$.ajax({
		type : 'GET',
		async : false,
		cache : false,
		url : importPageUrl,
		timeout : 20000,
		success : function (data){
			$(containerSelector).append(data);
		}
	});
};
function logout(){
    alert("로그아웃 되었습니다.");
    location.href='/login/logout.do';
}
$(function(){
	$("label:contains('전체선택')").css("width", "auto");	
	$("label:contains('오늘 하루 열지 않음')").css("width", "auto");	
	
	// 마이페이지 드롭다운 메뉴 hover시 on
	$(".btn_mypage_top").on("mouseenter mouseleave",function(e){
	    var $this = $(this);
	    var $dep2 = $(".dep2");
	    if(e.type == "mouseenter"){
	        $dep2.css("display","block");
	        TweenLite.set($dep2, {css:{y:20,opacity:0}});
	        TweenLite.to($dep2, 0.6, {opacity:1, y:0, ease:Back.easeOut.config(0) });
	    }else{
	        TweenLite.to($dep2, 0.3, {opacity:0, y:15, ease:Back.easeOut.config(0) ,onComplete:function(){
	          $dep2.css({
	            "display":"",
	            "opacity":"",
	            "transform":"",
	          });
	        }});
	    }
	});
	
	// 마이페이지 드롭다운 메뉴 클릭했을 시 on
	/*
	$(".btn_mypage_top").on("click", function(e){
		var $this = $(this);
		var $dep2 = $this.find(".dep2");
		
		var open = function(){
			$dep2.css("display", "block");
			TweenLite.set($dep2, {css: {y:20, opacity:0}});
			TweenLite.to($dep2, 0.6, {opacity:1, y:0, ease:Back.easeOut.config(0)});
			
			$(document).off("touchstart.my focusin.my mouseup.my").on("touchstart.my focusin.my mouseup.my", function(e){
				var container = $(".btn_mypage_top");
				if(container.has(e.target).length == 0) close();
			});
		}
		
		var close = function(){
			$(document).off("touchstart.my focusin.my mouseup.my");
			TweenLite.to($dep2, 0.3, {opacity:0, y:15, ease:Back.easeOut.config(0), onComplete:function(){
				$dep2.css({"display" : "", "opacity" : "", "transform" : ""});
			}});
		};
		
		if($dep2.css("display") == "none") open();
	})*/
})

