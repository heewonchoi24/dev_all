<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	var lCnt = 1;

	$(window).ready(function() {

	});

	function lAdd(el, idx) {
		jQuery("div#index" + idx).after(htmlLAdd());
	}

	function mAdd(el) {
		jQuery(el).parents(".mIndex").after(htmlMAdd());
	}

	function sAdd(el) {
		jQuery(el).parents(".index_list").after(htmlSAdd());
	}

	function lDel(obj, idx) {
		jQuery("div#index" + idx).remove();
	}

	function mDel(el) {
		jQuery(el).parents(".mIndex").remove();
	}

	function sDel(el) {
		jQuery(el).parents(".index_list").remove();
	}

	function htmlLAdd() { // 대분류 추가

		lCnt = lCnt + 1;
		var html = '';

		html += ' <div class="index" id="index'+lCnt+'"> ';
		html += ' <dl class="index_list depth1" id="'+lCnt+'"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>대분류</span></label> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div > ';
		html += ' <input type="text" class="lclas ipt" style="width: 89.4%;"> ';
		html += ' <button type="button" class="button btn blue" onClick="lAdd(this, ' + lCnt + ');return false;">추가</button> ';
		html += ' <button type="button" class="button btn blue red" onClick="lDel(this, ' + lCnt + ');return false;">삭제</button> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';
		html += ' <div class="mIndex"> ';
		html += ' <dl class="index_list depth2"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>중분류</span></label> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div> ';
		html += ' <input type="text" class="mlsfc ipt"> ';
		html += ' <button type="button" class="button btn blue" onClick="mAdd(this);return false;">추가</button> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';
		html += ' <dl class="index_list depth3"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>지표</span></label> ';
		html += ' <div class="chk"> ';
		html += ' <input type="checkbox" class="excpPermYn" value="1"> ';
		html += ' <label for="label4"> 예외허용</label> ';
		html += ' </div> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div> ';
		html += ' <input type="text" class="checkItem ipt"> ';
		html += ' <button type="button" class="button btn blue" onClick="sAdd(this);return false;">추가</button> ';
		html += ' </div> ';
		html += ' <div class="option" class="detailInfo"> ';
		html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
		html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';
		html += ' </div> ';
		html += ' </div> ';

		return html;
	}

	function htmlMAdd() { // 중분류 추가

		var html = '';

		html += ' <div class="mIndex"> ';
		html += ' <dl class="index_list depth2"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>중분류</span></label> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div> ';
		html += ' <input type="text" class="mlsfc ipt" style="width: 89.4%"> ';
		html += ' <button type="button" class="button btn blue" onClick="mAdd(this);return false;">추가</button> ';
		html += ' <button type="button" class="button btn blue red" onClick="mDel(this);return false;">삭제</button> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';
		html += ' <dl class="index_list depth3"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>지표</span></label> ';
		html += ' <div class="chk"> ';
		html += ' <input type="checkbox" class="excpPermYn" value="1"> ';
		html += ' <label for="label4"> 예외허용</label> ';
		html += ' </div> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div> ';
		html += ' <input type="text" class="checkItem ipt"> ';
		html += ' <button type="button" class="button btn blue" onClick="sAdd(this);return false;">추가</button> ';
		html += ' </div> ';
		html += ' <div class="option" class="detailInfo"> ';
		html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
		html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';
		html += ' </div> ';

		return html;
	}

	function htmlSAdd() { // 지표 추가

		var html = '';

		html += ' <dl class="index_list depth3"> ';
		html += ' <dt> ';
		html += ' <label for="label2"><span>지표</span></label> ';
		html += ' <div class="chk"> ';
		html += ' <input type="checkbox" class="excpPermYn" value="1"> ';
		html += ' <label for="label4"> 예외허용</label> ';
		html += ' </div> ';
		html += ' </dt> ';
		html += ' <dd> ';
		html += ' <div> ';
		html += ' <input type="text" class="checkItem ipt" style="width: 89.4%"> ';
		html += ' <button type="button" class="button btn blue" onClick="sAdd(this);return false;">추가</button> ';
		html += ' <button type="button" class="button btn blue red" onClick="sDel(this);return false;">삭제</button> ';
		html += ' </div> ';
		html += ' <div class="option" class="detailInfo"> ';
		html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
		html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
		html += ' </div> ';
		html += ' </dd> ';
		html += ' </dl> ';

		return html;
	}

	function onCrate() {
		
        var p_lclas =  [];
        var p_mlsfc =  [];
        var p_checkItem =  [];
        var p_excpPermYn =  [];
        var p_helpComment =  [];
        var index = 0;
        
        var exit = true;
        
		// 대분류 For
		$('.index').each(function (idx) {
			if(!exit) {
				return false;
			}
			// 대분류 값
			var lclas = $(this).find('.depth1').find('.lclas').val();
			if('' == lclas) {
				alert('대분류는 필수 입력입니다.');
				$(this).find('.depth1').find('.lclas').focus();
				exit = false;
				return false;
			}
			// 중분류 For
			$(this).find('.mIndex').each(function(idx1) {
				if(!exit) {
					return false;
				}
				//중분류 값
				var mlsfc = $(this).find('.mlsfc').val();
				if('' == mlsfc) {
					alert('중분류는 필수 입력입니다.');
					$(this).find('.mlsfc').focus();
					exit = false;
					return false;
				}
				// 소분류 For
				$(this).find('.depth3').each(function(idx2) {
					if(!exit) {
						return false;
					}
					// 지표
					var checkItem = $(this).find('.checkItem').val();
					if('' == checkItem) {
						alert('지표는 필수 입력입니다.');
						$(this).find('.checkItem').focus();
						exit = false;
						return false;
					}
					// 예외허용여부
					var excpPermYn = 'N';
					if($(this).find('.excpPermYn').prop("checked")) {excpPermYn = 'Y'};
					// 지표세부설명
					var helpComment = $(this).find('.helpComment').val();
					
			        p_lclas[index] = lclas;
			        p_mlsfc[index] = mlsfc;
			        p_checkItem[index] = checkItem;
			        p_excpPermYn[index] = excpPermYn;
			        p_helpComment[index] = helpComment;
			        index++;
				});
			});
		});
		
		if(!exit) {
			return;
		}
		
		var pUrl = "/admin/index/insertMngLevelIndex.do";
		
		var param = new Object();
		
        param.lclas = p_lclas;
        param.mlsfc = p_mlsfc;
        param.checkItem = p_checkItem;
        param.excpPermYn = p_excpPermYn;
        param.helpComment = p_helpComment;
        param.orderNo = $("#orderNo").val();
		if($("#label0").prop("checked")) { param.resultSe = "IR01";}
		else {param.resultSe = "IR02";}
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.indexCreateForm.action = "/admin/index/mngLevelIndexList.do";
		    document.indexCreateForm.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
	
	function fn_default() {
		
    	$("#indexCreateForm").attr({
            action : "/admin/index/mngLevelIndexList.do",
            method : "post"
        }).submit();
	}
	
</script>
<!-- content -->
<div id="main">
	<div class="group">
		<div class="header">
			<h3>지표 등록/수정</h3>
		</div>
		<div class="body">
			<div class="board_write_top"><span class="req">*</span> 지표입력 시 필요없는 항목은 삭제 버튼을 이용해 삭제해 주시기 바랍니다.</div>
			<form method="post" id="indexCreateForm" name="indexCreateForm">
				<input name="orderNo" id="orderNo" type="hidden" value="${requestZvl.orderNo }" />
				<div class="index" id="index1">
					<!-- 대분류 -->
					<dl class="index_list depth1" id="1">
						<dt>
							<label for="label2"><span>대분류</span></label>
						</dt>
						<dd>
							<div>
								<input type="text" class="lclas ipt">
								<button type="button" class="button btn blue" onclick="lAdd(this, 1);return false;">추가</button>
							</div>
						</dd>
					</dl>
					<!-- /대분류 -->

					<!-- 중분류 -->
					<div class="mIndex">
						<dl class="index_list depth2">
							<dt>
								<label for="label2"><span>중분류</span></label>
							</dt>
							<dd>
								<div>
									<input type="text" class="mlsfc ipt">
									<button type="button" class="button btn blue" onclick="mAdd(this);return false;">추가</button>
								</div>
							</dd>
						</dl>
						<!-- 지표 -->
						<dl class="index_list depth3">
							<dt>
								<label for="label2"><span>지표</span></label>
								<div class="chk">
									<input type="checkbox" class="excpPermYn" value="1"> <label for="label4"> 예외허용</label>
								</div>
							</dt>
							<dd>
								<div>
									<input type="text" class="checkItem ipt">
									<button type="button" class="button btn blue" onclick="sAdd(this);return false;">추가</button>
								</div>
								<div class="option" class="detailInfo">
									<label for="label5" style="height: 100px; margin-top: 0; line-height: 100px;">지표 세부설명</label>
									<textarea class="helpComment" title="내용을 입력하세요."></textarea>
								</div>
							</dd>
						</dl>
						<!-- /지표 -->
					</div>
				</div>
				<div class="board_list_btn right">
					<a href="#" class="btn blue" onClick="onCrate();return false;">저장</a>
					<a href="#" onclick="fn_default(); return false;" class="btn black">취소</a>
				</div>
			</form>
		</div>
	</div>
</div>
<!-- /content -->