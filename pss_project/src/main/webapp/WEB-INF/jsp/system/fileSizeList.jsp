<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>

	$(document).ready(function(){
		
		$("#searchInsttClCd").change(function(){
			changeInsttList(this.value);
		});
		
		fn_util_setTextType();
	});
	
	function fileVolumeSet() {
        modalFn.show($('#fileVolumeSet'));
    }	
	
	function changeInsttList(searchInsttClCd){
		pUrl = "/pinn/selectBoxInsttList.do";
		pParam = {};
		pParam.insttClCd = searchInsttClCd;
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			var str = '<option value="">기관명 전체</option>';
			for(var i in data.orgBoxList){
				str += '<option value=' + data.orgBoxList[i].insttCd + '>' + data.orgBoxList[i].insttNm + '</option>'; 	
			}
			$("#searchInsttCd").html(str);
		}, function(jqXHR, textStatus, errorThrown){
			
		});
		
	}
	
	function listThread(pageNo) {
		$("#pageIndex").val(pageNo);
		$("#form").attr({
			method : "post"
		}).submit();
	}
	
	function goSearch(){
		
		$("#pageIndex").val("1");
		
		$("#form").attr({
			method : "post",
			action : "/admin/system/fileSizeList.do"
		}).submit();
	}
	
	function modify(seq, insttCd, modeFlag){
		
		var maxFileSize = $("#oneMaxFileSize"+seq).val();
		var maxTotalFileSize = $("#oneMaxTotalFileSize"+seq).val();
		
		if('' == maxFileSize) {
			alert("개별 파일 사이즈를 입력해주세요");
			return false;
		}
		if('' == maxTotalFileSize) {
			alert("전체 파일 사이즈를 입력해주세요");
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			var pUrl = "/admin/system/modifyFileSize.do";
			var param = new Object();
		    param.maxFileSize = maxFileSize * 1024 * 1024;
		    param.maxTotalFileSize = maxTotalFileSize * 1024 * 1024;
		    param.orderNo = $("#orderNo").val();
		    param.insttCd = insttCd;
		    param.modeFlag = modeFlag;
			
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				goSearch();
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
	}

	function allModify(){
		
		var maxFileSize = $("#allMaxFileSize").val();
		var maxTotalFileSize = $("#allMaxTotalFileSize").val();
		
		if('' == maxFileSize) {
			alert("개별 파일 사이즈를 입력해주세요");
			return false;
		}
		if('' == maxTotalFileSize) {
			alert("전체 파일 사이즈를 입력해주세요");
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			var pUrl = "/admin/system/modifyAllFileSize.do";
			var param = new Object();
		    param.maxFileSize = maxFileSize * 1024 * 1024;
		    param.maxTotalFileSize = maxTotalFileSize * 1024 * 1024;
		    param.orderNo = $("#orderNo").val();
			
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				goSearch();
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
	}
</script>

<form action="/admin/system/fileSizeList.do" method="post" id="form" name="form">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${requestZvl.pageIndex}"/>
	<input type="hidden" name="orderNo" id="orderNo" value="${requestZvl.orderNo}"/>
	
<section id="fileVolumeSet" class="modal" style="max-width: 400px;">
	<div id="layer1" class="inner">
		<div class="modal_header">
			<h2>전체 파일용량 수정</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#fileVolumeSet'))"></i></button>
		</div>
		<div class="modal_content">
			<div class="inner">
				<table class="board_list_write" summary="개별 파일 용량, 전체 파일 용량으로 구성된 전체 파일 용량 수정입니다.">
					<colgroup>
						<col style="width:150px;">
						<col style="width:*">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">개별 파일용량</th>
                            <td>
                                <input type="text" id="allMaxFileSize" name="allMaxFileSize" class="ipt" style="width: 100px;" title="개별 파일 용량을 입력하세요" maxLength="5" value="50"/> MB
                            </td>
						</tr>
						<tr>
							<th scope="row">전체 파일용량</th>
							<td>
                                <input type="text" id="allMaxTotalFileSize" name="allMaxTotalFileSize" class="ipt" style="width: 100px;" title="전체 파일 용량을 입력하세요" maxLength="5" value="1024" /> MB
                            </td>
						</tr>
					</tbody>
				</table>
				<div class="board_list_btn center">
					<a href="#" class="btn blue" onclick="allModify(); return false;">저장</a>
					<a href="#" class="btn black" onclick="modalFn.hide($('#fileVolumeSet'))">취소</a>
				</div>
			</div>
		</div>
	</div>
</section>
	
	<!-- content -->
<div id="main">
    <div class="group">
    	<div class="header"><h3>파일용량관리</h3></div>
		<div id="container" class="body">
	
			<div class="board_list_top">
				<div class="board_list_info">
					전체 <span id="totalCount">${totalCnt}</span>개, 현재 페이지 
	                <span id="totalCount">${requestZvl.pageIndex}</span>/${totalPageCnt }
			   </div>		
				<div class="board_list_filter">
					<select title="년도 선택" id="searchOrderNo" name="searchOrderNo" class="ipt" style="width: 100px;">
						<c:forEach var="orderList" items="${orderList}"  varStatus="status" >
						<option value="${orderList.orderNo}" <c:if test="${requestZvl.orderNo eq orderList.orderNo}">selected</c:if>>${orderList.orderNo}</option>
						</c:forEach>
					</select>
	                <select name="searchInsttClCd" id="searchInsttClCd" title="기관구분 선택" class="ipt" style="width: 250px;">
	                    <option value="">기관구분 전체</option>
	                    <c:forEach var="list" items="${orgBoxClList }" varStatus="status">
	                    	<option value="${list.code }" <c:if test="${list.code eq requestZvl.searchInsttClCd}">selected</c:if>>${list.codeNm }</option>
	                	</c:forEach>
	                </select>
	                <select name="searchInsttCd" id="searchInsttCd" title="기관명 선택" class="ipt" style="width: 250px;">
	                	<option value="">기관명 전체</option>
	                	<c:forEach var="list" items="${orgBoxList }" varStatus="status">
	                		<option value="${list.insttCd }" <c:if test="${list.insttCd eq requestZvl.searchInsttCd}">selected</c:if>>${list.insttNm }</option>
	                	</c:forEach>
	                </select>
	                <input type="button" onclick="goSearch();" class="btn blue" value="조회">
	            </div>
			</div>			
						 
				<table class="board_list_normal" summary="기관명, 개별 파일용량, 전체 파일용량, 사용용량, 수정일시, 수정으로 구성된 파일용량관리 리스트입니다.">
					<colgroup>
						<col style="width:20%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:18%">
						<col style="width:6%">
					</colgroup>
					<thead>
						<tr>					
							<th scope="col">기관명</th>
							<th scope="col">개별 파일용량</th>
							<th scope="col">전체 파일용량</th>
							<th scope="col">사용용량</th>							
							<th scope="col">수정일시</th>							
							<th scope="col">수정</th>
						</tr>
					</thead>
					<tbody>
		                <c:choose>
 		                	<c:when test="${!empty resultList}">
								<c:forEach var="list" items="${resultList }" varStatus="status">
									<tr>
										<td class="center">${list.insttNm }</td>
										<td class="center">
											<input type="text" id="oneMaxFileSize${status.index}" name="oneMaxFileSize${status.index}" class="ipt" style="width: 100px;" title="개별 파일 용량을 입력하세요" maxLength="5" value="${list.maxFileSize}"/> MB
										</td>
										<td class="center">
											<input type="text" id="oneMaxTotalFileSize${status.index}" name="oneMaxTotalFileSize${status.index}" class="ipt" style="width: 100px;" title="개별 파일 용량을 입력하세요" maxLength="5" value="${list.maxTotalFileSize}"/> MB
										</td>
										<td class="center">${list.totfileSize } MB</td>
										<td class="date">${list.updateDt }</td>
										<c:set var="modeFlag" value="I"/>
										<c:if test="${!empty list.updateDt }">
											<c:set var="modeFlag" value="U"/>
										</c:if>
										<td class="center"><a href="#" class="link" onclick="modify('${status.index }','${list.insttCd }','${modeFlag}'); return false;">수정</a></td>
									</tr>
								</c:forEach>
			                </c:when>
			                <c:otherwise>
			                	<tr>
			                		<td class="none" colspan="6">등록된 데이터가 없습니다.</td>
			                	</tr>
			                </c:otherwise>
		                </c:choose>
					</tbody>
				</table>
				
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="listThread" />
				</div>
				
				<div class="board_list_btn right"">
					<a href="#" class="btn blue" onclick="fileVolumeSet();">일괄용량등록</a>
				</div>	
			</div>
		</div>
	</div>
	<!-- /content -->
</form>