<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
    .board_list_normal .sms { display: inline-block; margin-left: 2px; color: #21619e; }
</style>

<script>

$(document).ready(function(){
	clickInsttList($('#insttClCd').val());
	
	$('[name=sendType]').change(function(e) {
        if($(this).attr('id') == 'sendType1'){
            $('#sendTime').prop('disabled', true);
        }else{
            $('#sendTime').prop('disabled', false);
        }
    });

    $('#sendTime').datetimepicker({
        format: 'YYYY-MM-DD hh:mm:ss'
    });
    
    $('[name=template]').change(function(e) {
    	clickTemplate($(this).val());
    });
    
});

//기관 선택 시의 AJAX
function clickInsttList(InsttClCd){
	pUrl = "/admin/sms/smsInsttUserList.do";
	pParam = {};
	pParam.instt_cl_cd = InsttClCd;
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		 var str = "";
		for(var i in data.smsInsttUserList){
			str += "	<li data-idx='"+ i +"' data-name='" + data.smsInsttUserList[i].USER_NM + "' data-mobile='" + data.smsInsttUserList[i].MOBLPHON_NO + "'>";
			str += "           <div class='tit'>";
			str += " <div id='insttNM'><strong>" + data.smsInsttUserList[i].INSTT_NM + "</strong></div>";
			str += " <div id='userINFO'>" + data.smsInsttUserList[i].USER_NM + ": " + data.smsInsttUserList[i].MOBLPHON_NO + "</div>";
            str += "			</div>";
            str += "			<div class='btns'>";
            str += "    			<button type='button' class='btn blue' onclick='addThis(this);''>+</button> ";
            str += "    			<button type='button' class='btn' onclick='delThis(this);''>─</button> ";
            str += "			</div>";
        	str += "	</li> ";
		}
		$("#insttList").html(str); 
		
		smsTabs.init();
	}, function(jqXHR, textStatus, errorThrown){
	});
}

// 템플릿 radio 버튼 누를 때의 AJAX  
function clickTemplate(smsTemplate){
	pUrl = "/admin/sms/smsTemplateSet.do";
	pParam = {};
	pParam.sms_template = smsTemplate;

	var txt = "";
	if(smsTemplate == 4){
		txt = "[사회보장정보원]";
	}else{
		txt = "[보건복지부]";
	}
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = "";
			str += "<td colspan='2'>";
			str += "	<input type='hidden' id='smsSubject' name='smsSubject' value='" + data.smsSubject + "'/>";
			str += "	<textarea type='text' id='smsCont' name='smsCont' rows='10' class='ipt w100p' style='height: 197px;'>"+txt+"\n";
			str += data.smsTemplate ;
			str += "\n감사합니다.\n\n";
			str += "문의 : 02.6360.6574(내선:6574)";
			str += "</textarea>";
			str += "	<div class='smsWordChk' style='text-align: right;'>0/1000byte</div>";
			str += "</td>";
			
		$("#textareaSet").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

$(function () {
    $('#smsCont').on('keyup', function() {
        if($(this).val().length > 1000) {
            $(this).val($(this).val().substring(0, 1000));
        }
        $('.smsWordChk').text($(this).val().length+'/1000byte');
    }).keyup();
});

var smsTabs = {
	init: function() {
		$(".smsAgencyList .tit a").click(function(e) {
		  e.preventDefault();
		  if(!$(this).hasClass('active')){
		    $(this).closest('li').siblings('.active').removeClass('active').end().addClass('active');
		    smsTabs.active();
		  }
		});
		smsTabs.active();
	},
	active: function() {
		$(".smsAgencyList li").each(function(index, el) {
			var t = $(this).find('a').attr('href');
			if($(this).hasClass('active')){
				$(t).addClass('active').css({display:''});
			}else{
				$(t).removeClass('active').css({display:'none'});
			}
		});
	}
}
smsTabs.init();

/* 버튼 제어 */
function addThisAll(t, insttClCd) {
	clickInsttList(insttClCd);
	
	$(t).closest('li').siblings('.active').removeClass('active').end().addClass('active');
	smsTabs.active();
	
	$('#insttList').find('li').addClass('add');
	$('#insttList').find('li').each( function() {
    	var addVar = $(this).data('mobile');
    	setAddList(addVar);
    }); 
}

function delThisAll(t) {
	$(t).closest('li').siblings('.active').removeClass('active').end().addClass('active');
	smsTabs.active();
	
	$('#insttList').find('li').removeClass('add');
	$('#insttList').find('li').each( function() {
    	var delVar = $(this).data('mobile');
    	setDelList(delVar);
    }); 
}

function addThis(t) {
    $(t).closest('li').addClass('add');
    var addVar = $(t).closest('li').data('mobile');
    setAddList(addVar);
}
function delThis(t) {
    $(t).closest('li').removeClass('add');
    var delVar = $(t).closest('li').data('mobile');
    setDelList(delVar);
}

function setAddList(addVar) {
    $("#insttList>li.add").each( function() {
    	if($(this).data('mobile') == addVar){
    		 var item = '<li data-mobile="' + $(this).data('mobile') + '">'+$(this).data('name')+': '+$(this).data('mobile')+'</li>';
    	 	$('.smsUserList').append(item);
    	}
	});  
}

function setDelList(delVar) {
    $('.smsUserList>li').each( function() {
    	if($(this).data('mobile') == delVar){
    		$(this).remove();
    	}
	}); 
    
}


// 발송
function fn_sendSms(){
	var smsCont = $("#smsCont").val();
	var smsSubject = $("#smsSubject").val();
	var smsCallback = $("#smsCallback").val();
	
 	var userTelList = "";
	var p_cnt = 0;
	$(".smsUserList>li").each(function( key ) {
		p_cnt++ ;
		userTelList += "," + $(this).data('mobile');
	});
	if(p_cnt == 0){ alert("받는 사람을 선택하세요."); return false; }
	
	if(smsCont == "") { alert("내용을 입력하세요"); return false; }
	if(smsCallback == "") { alert("보내는 번호를 입력하세요"); return false; }

 	var sendType = "";
 	var sendTime = "";
 	$("input:radio[name=sendType]").each(function( key ) {
         if($(this).prop("checked")) {
             sendType = $(this).val();
         }
     });
 	if (sendType != "imd"){
 		sendTime = $("#sendTime").val();
	 	if("" == sendTime) { alert("발송 타입을 선택하세요"); return false; }
 	}
	
	if(confirm(p_cnt + "건의 문자를 발송 하시겠습니까?")){
		var pUrl = "/admin/sms/insertSms.do";
		var param = new Object();
	    param.sms_cont = smsCont;
	    param.sms_subject = smsSubject;
	    param.sendTime = sendTime;
	    param.sendType = sendType;
	    param.sms_callback = smsCallback;
	    param.user_telno_arr = userTelList;

		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			// 발송 후 화면 작업
		}, function(jqXHR, textStatus, errorThrown){
			
		});

	} 
}

</script>

<form method="post" id="form"  name="form">
	
	<!-- content -->
<div id="main">
	<div class="group"><div class="header"><h3>SMS 발송</h3></div></div>
    <div class="group col3">
        <div class="body">
            <ul class="smsAgencyList" >
				<c:if test="${!empty smsInsttClCdList}">
					<c:forEach var="list" items="${smsInsttClCdList }" varStatus="status">
						<li <c:if test="${requestZvl.instt_cl_cd eq list.INSTT_CL_CD}"> class="active"</c:if>>
							<div class="tit"><a href="#" onclick="clickInsttList('${list.INSTT_CL_CD }');">${list.INSTT_CL_NM }</a></div>
							<input type="hidden" id="insttClCd" value="${list.INSTT_CL_CD }"/>
							<div class="btns">
								<button type="button" class="btn blue" onclick="addThisAll(this, '${list.INSTT_CL_CD}');">+</button>
								<button type="button" class="btn" onclick="delThisAll(this);">─</button>
		                    </div>
		                </li>
	               </c:forEach>
				</c:if>
            </ul>
        </div>
    </div>
    <div class="group col3">
        <div class="body">
	        <ul class="smsAgencyList" id="insttList">
				<c:if test="${!empty smsInsttUserList}">
					<c:forEach var="list" items="${smsInsttUserList }" varStatus="status">
						<li id="reprsntTelno" value="${list.MOBLPHON_NO }">
	              		</li>
              		</c:forEach>
				</c:if>
       		 </ul>
        </div>
    </div>
    <div class="group col3">
        <div class="body">
            <table class="board_list_write">
                <tbody>
					<tr>
						<td colspan="2">
							<input name="template" type="radio" id="template1"  value="1" class="custom" checked="true"/>
							<label for="template1">점검시작</label>
							<input name="template" type="radio" id="template2"  value="2" class="custom" />
							<label for="template2">자료제출독려</label>
							<input name="template" type="radio" id="template3"  value="3" class="custom" />
							<label for="template3">이의신청기간</label>
							<input name="template" type="radio" id="template4"  value="4" class="custom" />
							<label for="template4">신규자료공유</label>
						</td>
					</tr>
                    <tr id="textareaSet">
                        <td colspan="2">
	                        <input type="hidden" id="smsSubject" name="smsSubject" value="${requestZvl.smsSubjectIni }"/>
                            <textarea type="text" id="smsCont" name="smsCont" rows="10" class="ipt w100p" style="height: 197px;">[보건복지부]
${requestZvl.smsTemplateIni }
감사합니다.

문의 : 02.6360.6574(내선:6574)
</textarea>
                            <div class="smsWordChk" style="text-align: right;">0/1000byte</div>
                        </td>
                    </tr>
                    <tr>
                        <th>보내는 번호</th>
                        <td><input type="text" id="smsCallback" name="smsCallback" class="ipt" value="010-6559-5250" /></td>
                    </tr>
                    <tr>
                        <th>발송타입</th>
                        <td>
                            <input name="sendType" type="radio" id="sendType1"  value="imd" class="custom" checked="">
                            <label for="sendType1">즉시발송</label>
                            <input name="sendType" type="radio" id="sendType2" value="resv" class="custom">
                            <label for="sendType2">예약발송</label>
                            <div class="ipt_group datepicker" style="margin-top: 10px;">
                                <input type="text" name="" class="ipt w100p" id="sendTime" value="" disabled="">
                                <label for="sendTime" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="board_list_btn right">
                <a href="javascript:fn_sendSms();" class="btn blue">SMS 발송</a>
            </div>
        </div>
    </div>
    <div class="group">
        <div class="body" style="min-height: auto; height: 200px;">
            <ul class="smsUserList"></ul>
        </div>
    </div>
</div>
<!-- main -->
</form>

