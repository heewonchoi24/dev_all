<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style> .dtlCheckItem { width: 99% !important; } </style>
<script type="text/javascript">
	
	var lCnt = 1;
	
	$(window).ready(function(){
		
	});

	function mAdd(el) {
		jQuery(el).parents(".mIndex").after(htmlMAdd());
	}

	function sAdd(el) {		
		jQuery(el).parents(".sIndex").after(htmlSAdd());
	}

	function dAdd(el) {		
		jQuery(el).parents(".dIndex").after(htmlDAdd());
	}

	function mDel(el) {
		jQuery(el).parents(".mIndex").remove();
	}

	function sDel(el) {
		jQuery(el).parents(".sIndex").remove();
	}

	function dDel(el) {
		jQuery(el).parents(".dIndex").remove();
	}

	function ssDel(el) {
		jQuery(el).parents(".ssIndex").remove();
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
	    html += ' <input type="text" class="mlsfc ipt" style="width: 89.4%;"> ';
	    html += ' <button type="button" class="button btn blue" onClick="mAdd(this); return false;">추가</button> ';
	    html += ' <button type="button" class="button btn blue red" onClick="mDel(this); return false;">삭제</button> ';
	    html += ' </div> ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <div class="sIndex"> ';
	    html += ' <dl class="index_list depth3"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>소분류</span></label> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div> ';
	    html += ' <input type="text" class="sclas ipt"> ';
	    html += ' <button type="button" class="button btn blue" onclick="sAdd(this); return false;">추가</button> ';
	    html += ' </div>  ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <div class="dIndex"> ';
	    html += ' <dl class="index_list depth4"> ';
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
	    html += ' <button type="button" class="button btn blue" onClick="dAdd(this); return false;">추가</button> ';
	    html += ' </div> ';
	    html += ' <div class="option"> ';
	    html += ' <label for="label5">관리수준 지표</label> ';
	    html += ' <select class="mngLevelIndexSeq ipt"> ';
	    html += ' <option value="">관리수준 지표 선택</option> ';
	    <c:forEach var="seqList" items="${seqList}"  varStatus="status" >
	    html += ' <option value="${seqList.indexSeq}">${seqList.checkItem}</option> ';
	    </c:forEach>
	    html += ' </select> ';
	    html += ' </div> ';
	    html += ' <div class="option" class="detailInfo"> ';
	    html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
	    html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
	    html += ' </div> ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <dl class="index_list depth5"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>세부지표</span></label> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div class="ssIndex"> ';
	    html += ' <input type="text" class="dtlCheckItem ipt"> ';
	    html += ' </div>  ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' </div> ';
	    html += ' </div> ';
	    html += ' </div> ';
		
		return html;
	}

	function htmlSAdd() {
		
		var html = '';
		
		html += ' <div class="sIndex"> ';
	    html += ' <dl class="index_list depth3"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>소분류</span></label> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div> ';
	    html += ' <input type="text" class="sclas ipt" style="width: 89.4%"> ';
	    html += ' <button type="button" class="button btn blue" onclick="sAdd(this); return false;">추가</button> ';
	    html += ' <button type="button" class="button btn blue red" onClick="sDel(this); return false;">삭제</button> ';
	    html += ' </div>  ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <div class="dIndex"> ';
	    html += ' <dl class="index_list depth4"> ';
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
	    html += ' <button type="button" class="button btn blue" onClick="dAdd(this); return false;">추가</button> ';
	    html += ' </div> ';
	    html += ' <div class="option"> ';
	    html += ' <label for="label5">관리수준 지표</label> ';
	    html += ' <select class="mngLevelIndexSeq ipt"> ';
	    html += ' <option value="">관리수준 지표 선택</option> ';
	    <c:forEach var="seqList" items="${seqList}"  varStatus="status" >
	    html += ' <option value="${seqList.indexSeq}">${seqList.checkItem}</option> ';
	    </c:forEach>
	    html += ' </select> ';
	    html += ' </div> ';
	    html += ' <div class="option" class="detailInfo"> ';
	    html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
	    html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
	    html += ' </div> ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <dl class="index_list depth5"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>세부지표</span></label> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div class="ssIndex"> ';
	    html += ' <input type="text" class="dtlCheckItem ipt"> ';
	    html += ' </div>  ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' </div> ';
	    html += ' </div> ';
		
		return html;
	}
	
	function htmlDAdd() {
		
		var html = '';
		
		html += ' <div class="dIndex"> ';
	    html += ' <dl class="index_list depth4"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>지표</span></label> ';
	    html += ' <div class="chk"> ';
	    html += ' <input type="checkbox" class="excpPermYn" value="1"> ';
	    html += ' <label for="label4"> 예외허용</label> ';
	    html += ' </div> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div> ';
	    html += ' <input type="text" class="checkItem ipt" style="width: 89.4%;"> ';
	    html += ' <button type="button" class="button btn blue" onClick="dAdd(this); return false;">추가</button> ';
	    html += ' <button type="button" class="button btn blue red" onClick="dDel(this); return false;">삭제</button> ';
	    html += ' </div> ';
	    html += ' <div class="option"> ';
	    html += ' <label for="label5">관리수준 지표</label> ';
	    html += ' <select class="mngLevelIndexSeq ipt"> ';
	    html += ' <option value="">관리수준 지표 선택</option> ';
	    <c:forEach var="seqList" items="${seqList}"  varStatus="status" >
	    html += ' <option value="${seqList.indexSeq}">${seqList.checkItem}</option> ';
	    </c:forEach>
	    html += ' </select> ';
	    html += ' </div> ';
	    html += ' <div class="option" class="detailInfo"> ';
	    html += ' <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label> ';
	    html += ' <textarea class="helpComment" title="내용을 입력하세요."></textarea> ';
	    html += ' </div> ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' <dl class="index_list depth5"> ';
	    html += ' <dt> ';
	    html += ' <label for="label2"><span>세부지표</span></label> ';
	    html += ' </dt> ';
	    html += ' <dd> ';
	    html += ' <div class="ssIndex"> ';
	    html += ' <input type="text" class="dtlCheckItem ipt"> ';
	    html += ' </div>  ';
	    html += ' </dd> ';
	    html += ' </dl> ';
	    html += ' </div> ';
		
		return html;
	}
	
	function onUpdate() {
		
	    var p_lclas =  [];
	    var p_mlsfc =  [];
	    var p_sclas =  [];
	    var p_checkItem =  [];
	    var p_excpPermYn =  [];
	    var p_helpComment =  [];
	    var p_mngLevelIndexSeq = [];
	    var p_dtlCheckItem = [];
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
				$(this).find('.sIndex').each(function(idx2) {
					if(!exit) {
						return false;
					}
					//중분류 값
					var sclas = $(this).find('.sclas').val();
					if('' == sclas) {
						alert('소분류는 필수 입력입니다.');
						$(this).find('.sclas').focus();
						exit = false;
						return false;
					}
					// 지표 For
					$(this).find('.dIndex').each(function(idx3) {
						if(!exit) {
							return false;
						}
						//중분류 값
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
						var mngLevelIndexSeq = $(this).find('.mngLevelIndexSeq').val();
						
						// 세부 For
						$(this).find('.ssIndex').each(function(idx4) {
							if(!exit) {
								return false;
							}
							// 지표
							var dtlCheckItem = $(this).find('.dtlCheckItem').val();
							if('' == dtlCheckItem) {
								alert('세부지표는 필수 입력입니다.');
								$(this).find('.dtlCheckItem').focus();
								exit = false;
								return false;
							}						
					        p_lclas[index] = lclas;
					        p_mlsfc[index] = mlsfc;
					        p_sclas[index] = sclas;
					        p_checkItem[index] = checkItem;
					        p_excpPermYn[index] = excpPermYn;
					        p_helpComment[index] = helpComment;
					        p_mngLevelIndexSeq[index] = mngLevelIndexSeq;
					        p_dtlCheckItem[index] = dtlCheckItem;
					        index++;
						});
					});
				});
			});
		});
		
		if(!exit) {
			return false;
		}
		
		var pUrl = "/admin/index/updateStatusExaminIndex.do";
		
		var param = new Object();
		
	    param.lclas = p_lclas;
	    param.mlsfc = p_mlsfc;
	    param.sclas = p_sclas;
	    param.checkItem = p_checkItem;
	    param.excpPermYn = p_excpPermYn;
	    param.helpComment = p_helpComment;
	    param.mngLevelIndexSeq = p_mngLevelIndexSeq;
	    param.dtlCheckItem = p_dtlCheckItem;
	    
		if($("#label0").prop("checked")) { param.resultSe = "IR01";}
		else {param.resultSe = "IR02";}
		param.beforeLclas = $("#lclas").val();
		param.lclasOrder = $("#lclasOrder").val();
		param.orderNo = $("#orderNo").val();
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.indexModifyForm.action = "/admin/index/statusExaminIndexList.do";
		    document.indexModifyForm.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
	
	function onDelete() {
		
		if (confirm("전체 삭제하시겠습니까?")) {
			
			var pUrl = "/admin/index/deleteStatusExaminIndex.do";
			
			var param = new Object();
			
			param.beforeLclas = $("#lclas").val();
			param.lclasOrder = $("#lclasOrder").val();
			param.orderNo = $("#orderNo").val();
			
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				
				$("#lclas").val("");
				$("#lclasOrder").val("");
				document.indexModifyForm.action = "/admin/index/statusExaminIndexList.do";
			    document.indexModifyForm.submit();
				
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
	}
	
	function fn_default() {
		
    	$("#indexModifyForm").attr({
            action : "/admin/index/statusExaminIndexList.do",
            method : "post"
        }).submit();
	}
	
</script>

<form method="post" id="indexModifyForm" name="indexModifyForm">
	<input name="orderNo" id="orderNo" type="hidden" value="${requestZvl.orderNo }"/>
    <!-- content -->
    <div id="main">
        <div class="group">
			<div class="header"><h3>지표 등록/수정</h3></div>            
            <div class="body">
            	<div class="board_write_top"><span class="req">*</span> 지표입력 시 필요없는 항목은 삭제 버튼을 이용해 삭제해 주시기 바랍니다.</div>
                <c:set var="tmpMlsfc" value=""/>
                <c:set var="tmpSclas" value=""/>
                <c:set var="tmpCheckItem" value=""/>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                	<c:choose>
						<c:when test="${status.first}">
							<input name="lclasOrder" id="lclasOrder" type="hidden" value="${list.lclasOrder}"/>
							<input name="lclas" id="lclas" type="hidden" value="${list.lclas}"/>
			                <div class="index" id="index1">
			                    <!-- 대분류 -->
			                    <dl class="index_list depth1" id="1">
			                        <dt>
			                            <label for="label2"><span>대분류</span></label>
			                        </dt>
			                        <dd>
			                            <div >
			                                <input type="text" class="lclas ipt" value="${list.lclas}" style="width: 99%;">
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
				                                <input type="text" class="mlsfc ipt" value="${list.mlsfc}">
				                                <button type="button" class="button btn blue" onClick="mAdd(this);return false;">추가</button>                        
				                            </div>                            
				                        </dd>
				                    </dl>
				                    <div class="sIndex">
										<dl class="index_list depth3">
					                        <dt>
					                            <label for="label2"><span>소분류</span></label>
					                        </dt>
					                        <dd>
					                            <div>
					                                <input type="text" class="sclas ipt" value="${list.sclas}" />
					                                <button type="button" class="button btn blue" onClick="sAdd(this);return false;">추가</button>
					                            </div>                            
					                        </dd>
					                    </dl>
										<div class="dIndex">
						                    <!-- 지표 -->
						                    <dl class="index_list depth4">
						                        <dt>
						                            <label for="label2"><span>지표</span></label>
						                            <div class="chk">
						                                <input type="checkbox" class="excpPermYn" value="1" <c:if test="${list.excpPermYn eq 'Y'}">checked="true"</c:if> />
						                                <label for="label4"> 예외허용</label>
						                            </div>                        
						                        </dt>
						                        <dd>
						                            <div>
						                                <input type="text" class="checkItem ipt"  value="${list.checkItem}" />
						                                <button type="button" class="button btn blue" onClick="dAdd(this);return false;">추가</button>
						                            </div>
						                            <div class="option">
						                                <label for="label5">관리수준 지표</label>
						                                <select class="mngLevelIndexSeq ipt">
						                                	<option value="">관리수준 지표 선택</option>
						                                	<c:forEach var="seqList" items="${seqList}"  varStatus="status" >
											                    <option value="${seqList.indexSeq}" <c:if test="${list.mngLevelIndexSeq eq seqList.indexSeq}">selected</c:if>>${seqList.checkItem}</option>
											                </c:forEach>
						                                </select>
						                            </div>
						                            <div class="option" class="detailInfo">
						                                <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label>
						                                <textarea class="helpComment" title="내용을 입력하세요.">${list.helpComment}</textarea>
						                            </div>
						                        </dd>
						                    </dl>
						                    <!-- 세부지표 -->
						                    <dl class="index_list depth5">
						                        <dt>
						                            <label for="label2"><span>세부지표</span></label>
						                        </dt>
						                        <dd>
						                            <div class="ssIndex">
						                                <input type="text" class="dtlCheckItem ipt" value="${list.dtlCheckItem}">
						                            </div>
                		</c:when>
                		<c:otherwise>
                			<c:choose>
								<c:when test="${list.mlsfc eq tmpMlsfc}">
									<c:choose>
										<c:when test="${list.sclas eq tmpSclas}">
											<c:choose>
												<c:when test="${list.checkItem eq tmpCheckItem}">
													<div class="ssIndex">
						                                <input type="text" class="dtlCheckItem ipt" value="${list.dtlCheckItem}">
						                            </div>
												</c:when>
												<c:otherwise>
															</dd>
						                    			</dl>
													</div>
													<div class="dIndex">
								                    <!-- 지표 -->
								                    <dl class="index_list depth4">
								                        <dt>
								                            <label for="label2"><span>지표</span></label>
								                            <div class="chk">
								                                <input type="checkbox" class="excpPermYn" value="1" <c:if test="${list.excpPermYn eq 'Y'}">checked="true"</c:if> />
								                                <label for="label4"> 예외허용</label>
								                            </div>                        
								                        </dt>
								                        <dd>
								                            <div>
								                                <input type="text" class="checkItem ipt"  value="${list.checkItem}" style="width: 89.4%;" />
								                                <button type="button" class="button btn blue" onClick="dAdd(this); return false;">추가</button>
								                                <button type="button" class="button btn blue red" onClick="dDel(this); return false;">삭제</button>
								                            </div>
								                            <div class="option">
								                                <label for="label5">관리수준 지표</label>
								                                <select class="mngLevelIndexSeq ipt">
								                                	<option value="">관리수준 지표 선택</option>
								                                	<c:forEach var="seqList" items="${seqList}" varStatus="status" >
													                    <option value="${seqList.indexSeq}" <c:if test="${list.mngLevelIndexSeq eq seqList.indexSeq}">selected</c:if>>${seqList.checkItem}</option>
													                </c:forEach>
								                                </select>
								                            </div>
								                            <div class="option" class="detailInfo">
								                                <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label>
								                                <textarea class="helpComment" title="내용을 입력하세요.">${list.helpComment}</textarea>
								                            </div>
								                        </dd>
								                    </dl>
								                    <!-- 세부지표 -->
								                    <dl class="index_list depth5">
								                        <dt>
								                            <label for="label2"><span>세부지표</span></label>
								                        </dt>
								                        <dd>
								                            <div class="ssIndex">
								                                <input type="text" class="dtlCheckItem ipt" value="${list.dtlCheckItem}">
								                            </div>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
														</dd>
						                    		</dl>
						            			</div>      
											</div>
											<div class="sIndex">
												<dl class="index_list depth3">
							                        <dt>
							                            <label for="label2"><span>소분류</span></label>
							                        </dt>
							                        <dd>
							                            <div>
							                                <input type="text" class="sclas ipt" value="${list.sclas}" style="width: 89.4%;" />
							                                <button type="button" class="button btn blue" onClick="sAdd(this); return false;">추가</button>
							                                <button type="button" class="button btn blue red" onClick="sDel(this); return false;">삭제</button>
							                            </div>                            
							                        </dd>
							                    </dl>
												<div class="dIndex">
								                    <!-- 지표 -->
								                    <dl class="index_list depth4">
								                        <dt>
								                            <label for="label2"><span>지표</span></label>
								                            <div class="chk">
								                                <input type="checkbox" class="excpPermYn" value="1" <c:if test="${list.excpPermYn eq 'Y'}">checked="true"</c:if> />
								                                <label for="label4"> 예외허용</label>
								                            </div>                        
								                        </dt>
								                        <dd>
								                            <div>
								                                <input type="text" class="checkItem ipt"  value="${list.checkItem}" />
								                                <button type="button" class="button btn blue" onClick="dAdd(this);return false;">추가</button>
								                            </div>
								                            <div class="option">
								                                <label for="label5">관리수준 지표</label>
								                                <select class="mngLevelIndexSeq ipt">
								                                	<option value="">관리수준 지표 선택</option>
								                                	<c:forEach var="seqList" items="${seqList}"  varStatus="status" >
													                    <option value="${seqList.indexSeq}" <c:if test="${list.mngLevelIndexSeq eq seqList.indexSeq}">selected</c:if>>${seqList.checkItem}</option>
													                </c:forEach>
								                                </select>
								                            </div>
								                            <div class="option" class="detailInfo">
								                                <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label>
								                                <textarea class="helpComment" title="내용을 입력하세요.">${list.helpComment}</textarea>
								                            </div>
								                        </dd>
								                    </dl>
								                    <!-- 세부지표 -->
								                    <dl class="index_list depth5">
								                        <dt>
								                            <label for="label2"><span>세부지표</span></label>
								                        </dt>
								                        <dd>
								                            <div class="ssIndex">
								                                <input type="text" class="dtlCheckItem ipt" value="${list.dtlCheckItem}">
								                            </div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>                     
						                        	</dd>
						                    	</dl>
											</div>
						            	</div>      
									</div>
									<div class="mIndex">
					                    <dl class="index_list depth2">
					                        <dt>
					                            <label for="label2"><span>중분류</span></label>
					                        </dt>
					                        <dd>
					                            <div>
					                                <input type="text" class="mlsfc ipt" value="${list.mlsfc}" style="width: 89.4%;">
					                                <button type="button" class="button btn blue" onClick="mAdd(this); return false;">추가</button>
					                                <button type="button" class="button btn blue red" onClick="mDel(this); return false;">삭제</button>
					                            </div>                            
					                        </dd>
					                    </dl>
					                    <div class="sIndex">
											<dl class="index_list depth3">
						                        <dt>
						                            <label for="label2"><span>소분류</span></label>
						                        </dt>
						                        <dd>
						                            <div>
						                                <input type="text" class="sclas ipt" value="${list.sclas}" />
						                                <button type="button" class="button btn blue" onClick="sAdd(this);return false;">추가</button>
						                            </div>                            
						                        </dd>
						                    </dl>
											<div class="dIndex">
							                    <!-- 지표 -->
							                    <dl class="index_list depth4">
							                        <dt>
							                            <label for="label2"><span>지표</span></label>
							                            <div>
							                                <input type="checkbox" class="excpPermYn" value="1" <c:if test="${list.excpPermYn eq 'Y'}">checked="true"</c:if> />
							                                <label for="label4"> 예외허용</label>
							                            </div>                        
							                        </dt>
							                        <dd>
							                            <div>
							                                <input type="text" class="checkItem ipt"  value="${list.checkItem}" />
							                                <button type="button" class="button btn blue" onClick="dAdd(this);return false;">추가</button>
							                            </div>
							                            <div class="option">
							                                <label for="label5">관리수준 지표</label>
							                                <select class="mngLevelIndexSeq ipt">
							                                	<option value="">관리수준 지표 선택</option>
							                                	<c:forEach var="seqList" items="${seqList}"  varStatus="status" >
												                    <option value="${seqList.indexSeq}" <c:if test="${list.mngLevelIndexSeq eq seqList.indexSeq}">selected</c:if>>${seqList.checkItem}</option>
												                </c:forEach>
							                                </select>
							                            </div>
							                            <div class="option">
							                                <label for="label5" style="height: 100px; margin-top: 0; line-height: 100px; ">지표 세부설명</label>
							                                <textarea class="helpComment" title="내용을 입력하세요.">${list.helpComment}</textarea>
							                            </div>
							                        </dd>
							                    </dl>
							                    <!-- 세부지표 -->
							                    <dl class="index_list depth5">
							                        <dt>
							                            <label for="label2"><span>세부지표</span></label>
							                        </dt>
							                        <dd>
							                            <div class="ssIndex">
							                                <input type="text" class="dtlCheckItem ipt" value="${list.dtlCheckItem}">
							                            </div>
								</c:otherwise>
							</c:choose>
                		</c:otherwise>
                	</c:choose>
           			<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
           			<c:set var="tmpSclas" value="${list.sclas}"/>
           			<c:set var="tmpCheckItem" value="${list.checkItem}"/>
                	<c:if test="${status.last}"></c:if>
                </c:forEach>
                </dd></dl></div></div></div></div>
            </div>
            
            <div class="board_list_btn right">
            	<c:if test="${requestZvl.addFlag == 'Y'}"><a href="#" class="btn red" onClick="onDelete(); return false;">전체삭제</a></c:if>
                <a href="#" class="btn blue" onClick="onUpdate(); return false;">수정완료</a>
                <a href="#" class="btn black" onclick="fn_default(); return false;">취소</a>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>