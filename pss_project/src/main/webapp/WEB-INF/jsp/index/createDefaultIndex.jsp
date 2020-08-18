<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
	$(window).ready(function(){
		fn_numberInit();
		
        $('[name="tmpScoreSe"]').change(function() {
            if($('#scoreCheck2').prop('checked')){
                modalFn.show($('#method_class'));
            }
        });
        $('[id*="listChk_"]').change(function() {
            if(!$(this).prop('checked')) $('.tabCont.active [id*="allChk_"]').prop('checked', false);
        });
	});
	
	function fn_next(checkVal) {
		
		var checkCnt = 0;
		if($("input:radio[id=scoreCheck1]" ).prop( "checked")) {
			checkCnt++;
		}
		if($("input:radio[id=scoreCheck2]" ).prop( "checked")) {
			checkCnt++;
		}
		if(0 == checkCnt) {
			alert('결과산정 방법을 선택해 주세요');
			return;
		}
		
		var url;
		
		if('1' == checkVal) {
			url = "/admin/index/mngLevelIndexList.do";
		} else {
			url = "/admin/index/statusExaminIndexList.do";
		}
		
    	$("#defaultForm").attr({
            action : url,
            method : "post"
        }).submit();
	}
	
	function fn_score() {
		
		if("Y" == $("#modifyFlag").val()) {
			var pUrl = "/admin/index/deleteDefaultIndex.do";
			
			var param = new Object();
	        param.orderNo = $("#orderNo").val();
	        param.mngLevelCd = $("#mngLevelCd").val();
	        param.scoreSe = 'A';
			
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				fn_closeScore();
				$("#scoreCheck1").prop("checked", true);
			    alert("수정이 완료되었습니다.");
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
		
		return true;
	}
	/*
	function scoreAdd(el) {
		jQuery(el).parents(".scoreList").after(htmlScoreAdd());
		fn_numberInit();
	}
	
	function sctnScoreAdd(el) {
		jQuery(el).parents(".sctnScoreList").after(htmlSctnScoreAdd());
		fn_numberInit();
	}
	
	function scoreDel(el) {
		jQuery(el).parents(".scoreList").remove();
	}
	
	function sctnScoreDel(el) {
		jQuery(el).parents(".sctnScoreList").remove();
	}
	*/
	/*
	function htmlScoreAdd() {
		
		var html = '';
		
		html += ' <tr class="scoreList"> ';
		html += ' <td class="tc"> ';
		html += ' <input type="text" value="" class="w95 scoreSeNm" maxLength="10"> ';
		html += ' </td> ';
		html += ' <td class="tc"> ';
		html += ' <input type="text" value="" class="w95 score onlyNumber2" maxLength="5"> ';
		html += ' </td> ';
		html += ' <td class="tc"> ';
		html += ' <button type="button" class="button bt2" onClick="scoreAdd(this);return false;">추가</button> ';
		html += ' <button type="button" class="button bt2 red_l" onClick="scoreDel(this);return false;">삭제</button> ';
		html += ' </td> ';
		html += ' </tr> ';
		
		return html;
	}
	
	function htmlSctnScoreAdd() {
		
		var html = '';
		
		html += ' <tr class="sctnScoreList"> ';
		html += ' <td class="tc"> ';
		html += ' <input type="text" class="w95 sctnScore onlyNumber" maxLength="3"> ';
		html += ' </td> ';
		html += ' <td class="tc"> ';
		html += ' <input type="text" class="w95 sctnNm" maxLength="25"> ';
		html += ' </td> ';
		html += ' <td class="tc"> ';
		html += ' <button type="button" class="button bt2" onClick="sctnScoreAdd(this);return false;">추가</button> ';
		html += ' <button type="button" class="button bt2 red_l" onClick="sctnScoreDel(this);return false;">삭제</button> ';
		html += ' </td> ';
		html += ' </tr> ';
		
		return html;
	}
	*/
	
	function add_type(t) {
        var html = '<tr class="scoreList">';
            html += '    <td class="center"><input type="text" class="ipt scoreSeNm" maxLength="10"/></td>';
            html += '    <td class="center"><input type="text" class="ipt score onlyNumber2" style="width: 100px;" maxLength="5"/></td>';
            html += '    <td class="center">';
            html += '        <button type="button" class="btn blue" onclick="add_type(this);">추가</button>';
            html += '        <button type="button" class="btn red" onclick="remove(this);">삭제</button>';
            html += '    </td>';
            html += '</tr>';

        $(t).closest('tr').after(html);
        $(window).resize();
    }

    function add_level(t) {
        var html = '<tr class="sctnScoreList">';
            html += '    <td class="center"><input type="text" class="ipt sctnScore onlyNumber" style="width: 100px;" maxLength="3"/></td>';
            html += '    <td class="center"><input type="text" class="ipt sctnNm"  maxLength="25"/></td>';
            html += '    <td class="center">';
            html += '        <button type="button" class="btn blue" onclick="add_level(this);">추가</button>';
            html += '        <button type="button" class="btn red" onclick="remove(this);">삭제</button>';
            html += '    </td>';
            html += '</tr>';

        $(t).closest('tr').after(html);
        $(window).resize();
    }
	function fn_createScore() {
		
        var p_scoreSeNm =  [];
        var p_score =  [];
        var p_sctnScore =  [];
        var p_sctnNm =  [];
        
        var index = 0;
        var exit = true;
        
		$('.scoreList').each(function (idx) {
			
			var scoreSeNm = $(this).find('.scoreSeNm').val();
			var score = $(this).find('.score').val();
			
			if('' == scoreSeNm) {
				exit = false;
				alert('등급은 필수 입력입니다.');
				$(this).find('.scoreSeNm').focus();
				return false;
			}
		
			if('' == score) {
				exit = false;
				alert('점수는 필수 입력입니다.');
				$(this).find('.score').focus();
				return false;
			}
			
			p_scoreSeNm[index] = scoreSeNm;
			p_score[index] = score;
	        index++;
		});
		
		if(!exit) {
			return;
		}
        
		index = 0;
		
		$('.sctnScoreList').each(function (idx) {
			var sctnScore = $(this).find('.sctnScore').val();
			var sctnNm = $(this).find('.sctnNm').val();
			
			if('' == sctnScore) {
				exit = false;
				alert('점수는 필수 입력입니다.');
				$(this).find('.sctnScore').focus();
				return false;
			}
			if('' == sctnNm) {
				exit = false;
				alert('수준은 필수 입력입니다.');
				$(this).find('.sctnNm').focus();
				return false;
			}
			
			p_sctnScore[index] = sctnScore;
			p_sctnNm[index] = sctnNm;
	        index++;
		});

		if(!exit) {
			return;
		}
		
		var pUrl = "/admin/index/modifyDefaultIndex.do";
		
		var param = new Object();
		
        param.scoreSeNm = p_scoreSeNm;
        param.score = p_score;
        param.sctnScore = p_sctnScore;
        param.sctnNm = p_sctnNm;
        param.orderNo = $("#orderNo").val();
		param.mngLevelCd = $("#mngLevelCd").val();
		param.scoreSe = 'B';
        
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			$(".layer_bg, .layer").hide();
			$("#scoreCheck2").prop("checked", true);
						
		}, function(jqXHR, textStatus, errorThrown){
			
		});
		modalFn.hide($('#method_class'));
		return true;
	}
	
	function fn_closeScore() {
        var index = 0;
        
		$('.scoreList').each(function (idx) {
			
			if(index == 0) {
				$(this).find('.scoreSeNm').val("");
				$(this).find('.score').val("");
			} else {
				$(this).remove();
			}
			index++;
		});
        
		index = 0;
		
		$('.sctnScoreList').each(function (idx) {
			
			if(index == 0) {
				$(this).find('.sctnScore').val("");
				$(this).find('.sctnNm').val("");
			} else {
				$(this).remove();
			}
			index++;
		});
		
		if('A' == $("#resultCheck").val()) {
			$("#scoreCheck1").prop("checked", true);
		} else if('B' == $("#resultCheck").val()) {
			$("#scoreCheck2").prop("checked", true);
		}
	}
	
	function remove(t) {
        $(t).closest('tr').remove();
        $(window).resize();
    }
	
</script>
</head>

<form method="post" id="defaultForm" name="defaultForm">
<!-- <form action="/admin/index/createDefaultIndex.do" method="post" id="defaultForm" name="defaultForm"> -->
	
	<input name="orderNo" id="orderNo" type="hidden" value="${zvl.orderNo }"/>
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="${zvl.mngLevelCd }"/>
	<input name="scoreSe" id="scoreSe" type="hidden" value=""/>
	<input name="modifyFlag" id="modifyFlag" type="hidden" value="${modifyFlag}" />
	<input name="resultCheck" id="resultCheck" type="hidden" value="${resultCheck}" />
	
	<!-- main -->
	<div id="main">
	    <div class="group">
	        <div class="header">
	            <h3>기본정보 입력</h3>
	        </div>
	        <div class="body" style="min-height: auto;">
	            <table class="board_list_write" summary="차수선택, 결과산정 방법으로 구성된 지표 기본정보 등록입니다.">
	                <tbody>
	                    <tr>
	                        <th>차수</th>
	                        <td>${zvl.orderNo }</td>
	                        <th>결과산정 방법</th>
	                        <td>
                                <c:set var="radioDisabledA" value=""/>
                            	<c:set var="radioDisabledB" value=""/>
                            	<c:if test="${'N' eq modifyFlag}">
                            		<c:set var="radioDisabledA" value="disabled='disabled'"/>
                            	</c:if>
                            	<c:if test="${'N' eq modifyFlag and resultCheck == 'A'}">
                            		<c:set var="radioDisabledB" value="disabled='disabled'"/>
                            	</c:if>
	                            <input type="radio" class="custom" id="scoreCheck1" name="tmpScoreSe" ${radioDisabledA} value="1" onChange="fn_score();return false;" <c:if test="${resultCheck == 'A'}">checked="true"</c:if>>
	                            <label for="scoreCheck1">점수산정 방법</label>
	                            <input type="radio" class="custom" id="scoreCheck2" name="tmpScoreSe" ${radioDisabledB} value="2" class="layer_open" <c:if test="${resultCheck == 'B'}">checked="true"</c:if>>
	                            <label for="scoreCheck2">등급산정 방법</label>
	                        </td>
	                    </tr>
	                </tbody>
	            </table>
	            <div class="board_list_btn center">
         	        <c:choose>
	            		<c:when test="${'ML01' eq zvl.mngLevelCd}">
	                		<input type="button" onClick="fn_next(1); return false;" style="cursor: pointer; " class="btn blue" value="목록으로">
	                	</c:when>
	                	<c:otherwise>
	                		<input type="button" onClick="fn_next(2); return false;" style="cursor: pointer; " class="btn blue" value="목록으로">
	                	</c:otherwise>
	                </c:choose>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- main -->
	
	<!-- 레이어 팝업 -->
	<section id="method_class" class="modal layer">
	    <div class="inner">
	        <div class="modal_header">
	            <h2>등급산정 방법</h2>
	            <button class="btn square trans modal_close" onClick="fn_closeScore();return false;"><i class="ico close_w"></i></button>
	        </div>
	        <div class="modal_content">
	            <div class="inner">
	                <div class="board_list_title">등급 및 점수입력</div>
	                <table class="board_list_normal" summary="등급, 점수, 추가/삭제로 구성된 등급 및 점수 등록입니다.">
	                    <thead>
	                        <tr>
	                            <th>등급</th>
	                            <th>점수</th>
	                            <th style="width: 150px;">추가/삭제</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:choose>
	                    		<c:when test="${!empty scoreList}">
	                    			<c:forEach var="list" items="${scoreList}" varStatus="status">
	                    				<c:choose>
	                    					<c:when test="${status.first}">
	                    						<tr class="scoreList">
						                            <td class="center"><input type="text" class="ipt scoreSeNm" value="${list.scoreSeNm}" maxLength="10"/></td>
						                            <td class="center"><input type="text" class="ipt score onlyNumber2" value="${list.score}" style="width: 100px;" maxLength="5"/></td>
						                            <td class="center">
						                            	<c:if test="${'Y' eq modifyFlag}">
							                                <button type="button" class="btn blue" onclick="add_type(this);">추가</button>
						                                </c:if>
						                            </td>
						                        </tr>
	                    					</c:when>
	                    					<c:otherwise>
	                    						<tr class="scoreList">
						                            <td class="center"><input type="text" class="ipt scoreSeNm" value="${list.scoreSeNm}" maxLength="10"/></td>
						                            <td class="center"><input type="text" class="ipt score onlyNumber2" value="${list.score}" style="width: 100px;" maxLength="5"/></td>
						                            <td class="center">
						                            	<c:if test="${'Y' eq modifyFlag}">
							                                <button type="button" class="btn blue" onclick="add_type(this);">추가</button>
							                                <button type="button" class="btn red"  onClick="remove(this);">삭제</button>
						                                </c:if>
						                            </td>
						                        </tr>
	                    					</c:otherwise>
	                    				</c:choose>
	                    			</c:forEach>
	                    		</c:when>
	                    		<c:otherwise>
	                    			<tr class="scoreList">
			                            <td class="center"><input type="text" class="ipt scoreSeNm" value="${list.scoreSeNm}" maxLength="10"/></td>
			                            <td class="center"><input type="text" class="ipt score onlyNumber2" value="${list.score}" style="width: 100px;" maxLength="5"/></td>
			                            <td class="center">
			                            	<c:if test="${'Y' eq modifyFlag}">
				                                <button type="button" class="btn blue" onclick="add_type(this);">추가</button>
			                                </c:if>
			                            </td>
			                        </tr>
	                    		</c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                </table>
	
	                <div class="board_list_title">진단수준 입력</div>
	                <table class="board_list_normal" summary="점수, 수준, 추가/삭제로 구성된 진단수준 등록입니다.">
	                    <thead>
	                        <tr>
	                            <th>점수</th>
	                            <th>수준</th>
	                            <th style="width: 150px;">추가/삭제</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:choose>
	                    		<c:when test="${!empty sctnScoreList}">
	                    			<c:forEach var="list" items="${sctnScoreList}" varStatus="status">
	                    				<c:choose>
	                    					<c:when test="${status.first}">
	                    						<tr class="sctnScoreList">
						                            <td class="center"><input type="text" value="${list.sctnScore}" class="ipt sctnScore onlyNumber" style="width: 100px;" maxLength="3"/></td>
						                            <td class="center"><input type="text" value="${list.sctnNm}" class="ipt sctnNm"  maxLength="25"/></td>
						                            <td class="center">
						                            	<c:if test="${'Y' eq modifyFlag}">
						                                	<button type="button" class="btn blue" onclick="add_level(this);">추가</button>
						                                </c:if>
						                            </td>
						                        </tr>
	                    					</c:when>
	                    					<c:otherwise>
		                    					<tr class="sctnScoreList">
						                            <td class="center"><input type="text" value="${list.sctnScore}" class="ipt sctnScore onlyNumber" style="width: 100px;" maxLength="3"/></td>
						                            <td class="center"><input type="text" value="${list.sctnNm}" class="ipt sctnNm"  maxLength="25"/></td>
						                            <td class="center">
						                            	<c:if test="${'Y' eq modifyFlag}">
						                                	<button type="button" class="btn blue" onclick="add_level(this);">추가</button>
						                                	<button type="button" class="btn red" onclick="remove(this);">삭제</button>
						                                </c:if>
						                            </td>
						                        </tr>
	                    					</c:otherwise>
	                    				</c:choose>
	                    			</c:forEach>
	                    		</c:when>
	                    		<c:otherwise>
		                    		<tr class="sctnScoreList">
			                            <td class="center"><input type="text" value="${list.sctnScore}" class="ipt sctnScore onlyNumber" style="width: 100px;" maxLength="3"/></td>
			                            <td class="center"><input type="text" value="${list.sctnNm}" class="ipt sctnNm"  maxLength="25"/></td>
			                            <td class="center">
			                            	<c:if test="${'Y' eq modifyFlag}">
			                                	<button type="button" class="btn blue" onclick="add_level(this);">추가</button>
			                                </c:if>
			                            </td>
			                        </tr>
			                    </c:otherwise>
	                    	</c:choose>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	        <div class="modal_footer">
	            <div class="board_list_btn center" style="margin-top: 0;">
	            	<c:if test="${'Y' eq modifyFlag}">
		                <a href="#" class="btn blue" onClick="fn_createScore();return false;">등록완료</a>
		                <!-- <input type="button" onClick="fn_createScore();return false;" class="button bt3" value="등록완료"> -->
	                </c:if>
	                <a href="javascript:void(0);" class="btn black" onclick="modalFn.hide($('#method_class'))">취소</a>
	                <!-- <a href="#"  onClick="fn_closeScore();return false;" class="button bt3 gray close">취소</a> -->
	            </div>
	        </div>
	    </div>
	</section>
	<!-- /레이어 팝업 -->
</form>