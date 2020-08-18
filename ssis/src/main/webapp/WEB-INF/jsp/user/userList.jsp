<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>.board_list_filter .stateFilter input + label{line-height: 37px;}</style>
<script>
	var pUrl, pParam, selectUserArr, html;

	$(document).ready(function(){
		$("input[name='stateFilter']").on("click", function(){
			go_search();
		});
	});
	
    function sms(user_id, user_nm, instt_nm, mobile_no) {
    	$("#user_id").val(user_id);
    	$("#user_nm").val(user_nm);
    	$("#instt_nm").val(instt_nm);
    	$("#mobile_no").val(mobile_no);

    	var userInfo = instt_nm + " " + user_nm + "<br/>" + mobile_no;
    	userInfo += "<input type='hidden' id='mobile_no' name='mobile_no' value='" + mobile_no + "' />";
    	$("#receiverInfo").html(userInfo);
    	
        modalFn.show($('#smsPop'));
    }
	
	function listThread(pageNo) {
		$("#pageIndex").val(pageNo);
		$("#form").attr({
			method : "post"
		}).submit();
	}
	
	function go_search() {
		$("#pageIndex").val("1");
		$("#form").attr({
			method : "post",
			action : "/admin/user/userList.do"
		}).submit();
	}

	function modify(user_id) {
		$("#isModify").val("Y");
		$("#user_id").val(user_id);
		$("#form").attr({
			method : "post",
			action : "/admin/user/userModify.do"
		}).submit();
	}

	function create() {
		$("#isModify").val("N");
		$("#form").attr({
			method : "post",
			action : "/admin/user/userModify.do"
		}).submit();
	}

	function fn_print() {
		if (confirm("사용자 정보를 다운로드 하시겠습니까?")) {

			$("#form").attr({
				action : "/user/userExcelDown.do",
				method : "post"
			}).submit();
		}
	}
	
	function fn_sendSms(){
		var smsCont = $("#smsCont").val();
		var smsCallback = $("#smsCallback").val();
		var userTelNo = $("#mobile_no").val();
		var smsSubject = "[사회보장정보원]"; 
		
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
	 	
	 	if(confirm("문자를 발송 하시겠습니까?")){
			var pUrl = "/admin/sms/insertSms.do";
			var param = new Object();
		    param.sms_cont = smsCont;
		    param.sms_subject = smsSubject;
		    param.sendTime = sendTime;
		    param.sendType = sendType;
		    param.sms_callback = smsCallback;
		    param.user_telno = userTelNo;

			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				// 발송 후 화면 작업
			}, function(jqXHR, textStatus, errorThrown){
				
			});
	 	
		}
	}
	
</script>

<form action="/admin/user/userList.do" method="post" id="form" name="form">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" name="isModify" id="isModify" /> 
	<input type="hidden" name="user_id" id="user_id" />

	<!-- main -->
	<div id="main">
		<div class="group">
			<div class="header"><h3>사용자 관리</h3></div>
			<div class="body">
				<div class="board_list_top">
	                <div class="board_list_info">
		                전체 <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>개, 현재 페이지 
	                    <span id="totalCount">${paginationInfo.getCurrentPageNo()}</span>/${paginationInfo.getLastPageNo()}
	                </div>
	                <div class="board_list_filter">
	                    <div class="stateFilter">
	                        <input name="stateFilter" type="radio" id="stateFilterAll" class="" value="" checked >
	                        <label for="stateFilterAll">전체</label>
	                        <input name="stateFilter" type="radio" id="stateFilter1" class="" value="stateFilter1" <c:if test="${ stateFilter eq 'stateFilter1' }">checked</c:if>>
	                        <label for="stateFilter1">승인완료</label>
	                        <input name="stateFilter" type="radio" id="stateFilter2" class="" value="stateFilter2" <c:if test="${ stateFilter eq 'stateFilter2' }">checked</c:if>>
	                        <label for="stateFilter2">처리중</label>
	                        <input name="stateFilter" type="radio" id="stateFilter3" class="" value="stateFilter3" <c:if test="${ stateFilter eq 'stateFilter3' }">checked</c:if>>
	                        <label for="stateFilter3">반려</label>
	                    </div>
	                </div>
	                <div class="board_list_search">
	                    <div class="ipt_group">
	                        <input type="text" id="search" name="search" value="${param.search}" class="ipt" placeholder="검색어를 입력하세요">
	                        <span class="ipt_right addon"><button type="submit" class="btn searhBtn" onclick="go_search();">검색</button></span>
	                    </div>
	                </div>
	            </div>
	            <table class="board_list_normal">
	                <thead>
	                    <tr>
	                        <th>번호</th>
	                        <th>아이디</th>
	                        <th>이름</th>
	                        <th>기관명</th>
	                        <th>연락처</th>
	                        <th>휴대폰</th>
	                        <th>최종로그인</th>
	                        <th>승인여부</th>
	                        <th>관리</th>
	                    </tr>
	                </thead>
	                <tbody>
                    	<c:choose>
                    		<c:when test="${empty userList}">
                    			<tr><td class="none" colspan="9">리스트가 없습니다.</td></tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="i" items="${userList}" varStatus="status">
	                    		<tr>
	                    			<td class="num">${i.ROWNUM}</td>
			                        <td class="center">${i.USER_ID}</td>
			                        <td class="center">${i.USER_NM}</td>
			                        <td class="center">${i.INSTT_NM}</td>
			                        <td class="center">${i.TEL_NO}</td>
			                        <td class="center">
			                        	${i.MOBLPHON_NO}
			                        	<a href="javascript:void(0);" class="sms" title="SMS 발송" onclick="sms('${i.USER_ID}','${i.USER_NM}','${i.INSTT_NM}','${i.MOBLPHON_NO}');">
			                        		<span class="k-icon k-i-comment"></span>
			                        	</a>
			                        </td>
			                        <td class="center" style="width: 125px;">
			                        	<%-- <fmt:parseDate  value="${i.LAST_CONNECT_DT}" var="lastLoginDT" pattern="yyyy-MM-dd HH:mm" /> --%>
			                        	<fmt:parseDate  value="${i.LAST_LOGIN_DT}" var="lastLoginDT" pattern="yyyy-MM-dd HH:mm" />
										<fmt:formatDate value="${lastLoginDT}" var="lastLoginDate" pattern="yyyy.MM.dd" />
										<fmt:formatDate value="${lastLoginDT}" var="lastLoginTime" pattern="HH:mm" />
										${lastLoginDate}<br/>${lastLoginTime}
			                        </td>
			                        <td class="state">
			                        	<c:choose>
											<c:when test="${empty i.STATUS_CD || i.STATUS_CD == 'SS01'}">
												<span class="progress">처리중</span>
											</c:when>
											<c:when test="${i.STATUS_CD == 'SS02'}">
												<span class="active">승인완료</span>
											</c:when>
											<c:when test="${i.STATUS_CD == 'SS03'}">
												<span class="fail">반려</span>
											</c:when>
										</c:choose>
			                        </td>
			                        <td class="center">
		                        		<a href="#" class="link" onclick="modify('${i.USER_ID}');">관리</a>
									</td>
								</tr>
								</c:forEach>
                    		</c:otherwise>
						</c:choose>
	                </tbody>
	            </table>
	            
	            <div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image"
						jsFunction="listThread" />
				</div>
				
				<div class="board_list_btn right">
	                <a href="#" onclick="create(); return false;" class="btn blue">사용자 등록</a>
	                <a href="#" class="btn green" onclick="fn_print();">엑셀다운</a>
	            </div>
	            
			</div>
		</div>
	</div>
	<!-- /main -->
	
</form>
<!-- sms발송 레이어팝업 --> 
<section id="smsPop" class="modal" style="max-width: 500px;">
    <div class="inner">
        <div class="modal_header">
            <h2>SMS 발송</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#smsPop'))"></i></button>
        </div>
        <div class="modal_content">
            <div class="inner">
                <table class="board_list_write">
                    <tbody>
                        <tr>
                            <th>수신자</th>
                            <td>
                            	<label id="receiverInfo" name="receiverInfo" /> 
                            	<input type="hidden" id="mobile_no" name="mobile_no" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea type="text" name="smsCont" rows="10" class="ipt w100p" id="smsCont">
[사회보장정보원]



문의 : 02.6360.6574(내선:6574)</textarea>
                                <div class="smsWordChk" style="text-align: right;">0/1000byte</div>
                            </td>
                        </tr>
                        <tr>
                            <th>보내는 번호</th>
                            <td><input type="text" id="smsCallback" name="smsCallback" class="ipt" value="" /></td>
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
                <div class="board_list_btn center">
                    <a href="javascript:fn_sendSms();" class="btn blue">발송</a>
                    <a href="javascript:void(0);" class="btn black" onclick="modalFn.hide($('#smsPop'))">취소</a>
                </div>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript" src="/resources/admin/js/bootstrap-datetimepicker.min.js"></script>
<link rel="stylesheet" href="/resources/admin/css/bootstrap-datetimepicker.css" type="text/css">
<script type="text/javascript">
    $(function () {
        $('[name=sendType]').change(function(e) {
            if($(this).attr('id') == 'sendType1'){
                $('#sendTime').prop('disabled', true);
            }else{
                $('#sendTime').prop('disabled', false);
            }
        });

        $('#sendTime').datetimepicker({
            format: 'YYYY.MM.DD HH:mm:ss'
        });

        $('#smsCont').on('keyup', function() {
            if($(this).val().length > 1000) {
                $(this).val($(this).val().substring(0, 1000));
            }
            $('.smsWordChk').text($(this).val().length+'/1000byte');
        }).keyup();
    });
</script>
<style type="text/css">
    .board_list_normal .sms { display: inline-block; margin-left: 2px; color: #21619e; }
</style>
