<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../layout/mainTop.jsp"%>
<style>
#wrap-total{min-width:750px;overflow-X: hidden;}
</style>

<script>
var p_no =  []; p_no.push('${qestnarMastr.SEQ}');
var p_itemCd =  []; p_itemCd.push('${qestnarMastr.SEQ}');

function fnSaveQestnesult(size) {
	var p_result =  [];
	for(var i=1; i <= size; i++){
		p_result[i] ="";
	}
	//alert(p_no);
	$("input:radio").each(function( key ) {
		if($(this).prop("checked")) {
			p_result[$(this).attr('name').substr(2,$(this).attr('name').length)] = $(this).val();
		}
	});
	
	$(".textarea").each(function( key ) {
		p_result[$(this).attr('id').substr(2,$(this).attr('id').length)] = $(this).val();
	});
	
	for(var i=1; i <= size; i++){
		if(p_result[i] =="") {
			alert(i+ "번 문항에 답을 안하셨습니다.");
			return false;			
		}
	}

	var pUrl = "/qestnar/saveQestnarResult.do";
	
	var param = new Object();

    param.qesitmSeq      = p_no;
    param.qesitmAns      = p_result;
    param.qesitmCd       = p_itemCd;
    
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		alert(data.message);
		
		window.close();
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

</script>   

<form method="post" id="form"  name="form">
	<input name="qestnarSeq" id="qestnarSeq" type="hidden" value="${qestnarMastr.SEQ}"/>

<div class="survey_pop">
    <div class="layer_top">
       <strong>설문조사</strong>
    </div>
    <div class="layer_content">
        <div class="layer_in">
            <div>
                <p class="survey_title">${qestnarMastr.SUBJECT}</p>
                <p class="survey_info">${qestnarMastr.CONTENTS}</p>
                <p class="blet01"><strong class="c_blue">설문기간</strong> : ${qestnarMastr.BEGIN_DT} ~ ${qestnarMastr.END_DT}</p>
            </div>

			<div class="mt30">
        	<c:forEach var="list" items="${qestnarItemList }" varStatus="status">
                <c:choose>
				<c:when test="${list.QESITM_CD == 'QQ01'}">
        		<c:set var="tmpDetail" value="${list.SEQ }"/>
	            <dl>
	                <dt title="설문내용">${list.QESITM_NO }. ${list.QESITM_CN}</dt>
					<c:forEach var="list2" items="${qestnarDetailList}" varStatus="status">
 					<c:if test="${list2.QESITM_SEQ == tmpDetail}"> 
						<dd>
						<input type="radio" id="rd${list2.QESITM_NO}${list2.QESITM_DETAIL_NO}" name="no${list2.QESITM_NO}" value="${list2.QESITM_DETAIL_NO}"> <label for="rd${list2.QESITM_NO}${list2.QESITM_DETAIL_NO}"> ${list2.QESITM_DETAIL_CN}</label>
						</dd>
					</c:if>
 					</c:forEach>
	            </dl>
                </c:when>
                <c:otherwise>
	            <dl>
	                <dt title="제목">${list.QESITM_NO }. ${list.QESITM_CN}</dt>
	                <dd>
	                    <textarea class="textarea wa" name="no${list.QESITM_NO}" id="no${list.QESITM_NO}" maxLength="1000"></textarea>
	                </dd>
	            </dl>
                </c:otherwise>
                </c:choose>
					<script>p_no.push('${list.SEQ}');p_itemCd.push('${list.QESITM_CD}');</script>
	        </c:forEach>
	        </div>
	        <div class="btn-bot2 ta-c">
	         	<a href="#" class="btn-pk n rv mem2" onclick="fnSaveQestnesult('${qestnarItemList.size()}');">저장</a>
	            <a href="#" class="btn-pk n rv mem3" onclick="javascript:window.close();" >취소</a>
	        </div>
        </div>
    </div>
</div>
</form>
