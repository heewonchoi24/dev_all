<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var pUrl, pParam;
var chkCnt = 0;

$(document).ready(function(){
	
});

function fn_print() {
	if (confirm("설문조사 결과를 다운로드 하시겠습니까?")) {
		
    	$("#form").attr({
            action : "/qestnar/qestnarExcelDown.do",
            method : "post"
        }).submit();
	}
}

function pollResultPop(seq, itemSeq, itemNo) {
	var str = '';
	str += '<strong>설문 '+ itemNo +'- 응답결과</strong>'; 
	$("#layer_top").html(str);
	
	pUrl = "/qestnar/qestnarResultListAjax.do";
	pParam = {};
	pParam.qestnarSeq = seq;
	pParam.qesitmSeq = itemSeq;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		str = '';
		var j = 0;
		for(var i in data.resultList){
			j++;
			str += ' <li>'; 	
			str += '<div class="title" style="white-space: pre;">' + data.resultList[i].SBJCT_ANSWER + '</td>'; 	
			str += '</li>'; 	
		}
		$(".surveyResultList.popup").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
	modalFn.show($('#pollResultPop'));
	
}

function modal_close(e){
	e.preventDefault();
	modalFn.hide($('#pollResultPop'));
}
</script>
<form method="post" id="form" name="form">
<input name="qestnarSeq" id="qestnarSeq" type="hidden" value="${qestnarMastr.SEQ}"/>
	
    <!-- 레이어 팝업 -->
<section id="pollResultPop" class="modal" style="max-width: 640px;">
    <div class="inner">
	    <div id="layer1" >
	        <div class="modal_header" >
	            <h2>주관식 응답결과</h2>
	            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modal_close(this)"></i></button>
	        </div>
	        <div class="modal_content">
	            <div class="inner">
	            	<ul class="surveyResultList popup">
	            		<li><div class="title"></div></li>
	            	</ul>
	            </div>
             </div>
        </div>
    </div>
</section>
    <!-- /레이어 팝업 --> 
    <!-- main -->
<div id="main">
    <div class="group">
    <!-- content -->
		<div class="header">
            <h3>기본설정</h3>
        </div>
    	<div id="container" class="body" style="min-height: auto;">
                <table class="board_list_write" summary="설문제목, 설문기간, 참여현황으로 구성된 기본정보입니다.">
                    <colgroup>
                        <col style="width:15%;">
                        <col style="width:*;">                        
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row">설문제목</th>
                            <td>${qestnarMastr.SUBJECT}</td>
                        </tr> 
                        <tr>
                            <th scope="row">설문기간</th>
                            <td>${qestnarMastr.BEGIN_DT} ~ ${qestnarMastr.END_DT}</td>
                        </tr>
                        <tr>
                            <th scope="row">참여현황</th>
                            <td>총 응답자 ${qestnarMastr.USER_CNT}명</td>
                        </tr>                        
                    </tbody>
                </table>
            </div>
		</div>
		
		<div class="group">
	        <div class="header">
	            <h3>설문항목</h3>
	        </div>
            <div class="body" style="min-height: auto;">
				<table class="board_list_write surveyItem" summary="객관식-설문내용, 총 응답자, 응답결과, 주관식-설문내용, 총응답자로 구성된 설문 상세결과 리스트입니다.">
					<tbody>
						<c:forEach var="list" items="${qestnarItemList}" varStatus="status">
						<c:choose>
						<c:when test="${list.QESITM_CD == 'QQ01'}">
                            <!-- 객관식 설문 -->
							<tr>
								<th scope="rowgroup" rowspan="3">설문 ${list.QESITM_NO} [객관식]</th>
								<th scope="row">설문내용</th>
								<td>${list.QESITM_CN}</td>
							</tr>
                            <tr>
                                <th scope="row">총 응답자</th>
                                <td>${list.RESULT_CNT}명</td>
                            </tr>                            
                            <tr>
                                <th scope="row">응답결과</th>
                                <td>
									<c:set var="tmpDetail" value="${list.SEQ }"/>
									<c:forEach var="list2" items="${qestnarDetailList}" varStatus="status">
										<c:if test="${list2.QESITM_SEQ == tmpDetail}">
		                                	<ul class="surveyResultList">
		                               			<li>
	                                                <div class="title2">${list2.QESITM_DETAIL_CN}</div>
	                                                <div class="result">${list2.DETAIL_CNT}명(${list2.PERCENT}%)</div>
												</li>
											</ul>
										</c:if>
									</c:forEach>
                                </td>
                            </tr>
                            <!-- /객관식 설문 --> 
                  		</c:when>
                  		
                		<c:otherwise>
                            <!-- 주관식 설문 -->
                            <tr>
                                <th scope="rowgroup" rowspan="2">
                                    설문 ${list.QESITM_NO}
                                    <span class="d_block">[주관식]</span>
                                </th>
                                <th scope="row">설문내용</th>
                                <td>${list.QESITM_CN}</td>
                            </tr>
                            <tr>
                                <th scope="row">총 응답자</th>
                                <td>
                                    ${list.RESULT_CNT}명
                                    <a href="#" class="btn small blue" style="margin-left: 10px;" onclick="javascript:pollResultPop('${list.QESTNAR_SEQ}', '${list.SEQ}', '${list.QESITM_NO}');">응답결과 보기</a>
                                </td>
                            </tr>                            
                            <!-- /주관식 설문 --> 
                        </c:otherwise>
                		</c:choose>
                        </c:forEach>
                        </tbody>
                    </table>
            <div class="board_list_btn right">
                <a href="/admin/qestnar/qestnarList.do" class="btn blue">목록</a>
                <a class="btn green" onclick="fn_print(); return false;" >엑셀다운로드</a>
            </div>
            </div>
        </div>
    <!-- /content -->
	</div>
</form>
 