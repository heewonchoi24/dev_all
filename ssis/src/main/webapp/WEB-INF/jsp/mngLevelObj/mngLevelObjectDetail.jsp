<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var pUrl, pParam, msg;

$(document).ready(function(){
	
	$(".selectMenu.fir>li>a").on('click',function(e){
		$("#s_instt_cl_nm").val(this.dataset.clnm);
		$("#instt_cl_cd").val(this.dataset.clcd);
		changeSearchMenu(this.dataset.clcd);
	});
	
	$(".selectMenu.sec>li>a").on('click',function(e){
		$("#s_instt_cd").val(this.dataset.cd);
		$("#s_instt_nm").val(this.dataset.nm);
		changeDetailList();
	});		
	
});

function changeDetailList(){
	
	document.form.action = "/mngLevelObj/mngLevelObjectDetail.do";
	document.form.submit();	
	
}

function changeSearchMenu(instt_cl_cd){
	
	pUrl = "/mngLevelReq/mngLevelInsttListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		
		var str = '';
		str += '<div class="selectVal insttSelectVal" tabindex="0">'; 	
		str += '<a href="#this" tabindex="-1">선택해주세요</a>'; 	
		str += '</div>'; 	
		str += '<ul class="selectMenu sec insttSelectMenu">'; 
		for(var i in data.resultList){
			str += '<li><a href="#" data-cd=' + data.resultList[i].INSTT_CD + ' data-nm=' + data.resultList[i].INSTT_NM + '>' + data.resultList[i].INSTT_NM + '</a></li>'; 	
		}
		str += '</ul>'
			
		$(".box-select-ty1.type1.sec").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
	$(".selectMenu.sec>li>a").on('click',function(e){
		$("#s_instt_cd").val(this.dataset.cd);
		$("#s_instt_nm").val(this.dataset.nm);
		changeDetailList();
	});		
	
}

function detailIndex(index_seq){
	
	$('<input type="hidden" name="s_index_seq" value="' + index_seq + '" />').appendTo('#form');
	
	document.form.s_index_seq.value = index_seq;
	document.form.action = "/mngLevelObj/mngLevelObjectRegist.do";
	document.form.submit();
}


/* function complete(){
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;

	var evlDone = true;
	var evlPoint = 0;
	$("td[name=result_score1]").each(function(){
		if($(this).text() == '' || $(this).text() == null){
			evlDone = false;
		}
	});
	if(!evlDone){alert("서면평가가 완료되지 않은 항목이 있습니다."); return false;}
	
	var resultTotPer = [];
	var resultTotScore = [];
	var lclasOrder = [];
	var mlsfcOrder = [];
	var insttCd = $("#s_instt_cd").val();
	var orderNo = $("#s_order_no").val();
	
	var cnt = 0;
	var index = 0;
	$("input[name=RESULT_TOT_PER]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			resultTotPer[index] = $(this).val();
			var idval = this.id.split("|");
			lclasOrder[index] = idval[0];
			mlsfcOrder[index] = idval[1];
			index++;
		}
	});
	
	if('0' != cnt) {
		alert("평가점수를 입력해주세요");
		return false;
	}
	
	index = 0;
	$("input[name=RESULT_TOT_SCORE]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			resultTotScore[index] = $(this).val();
			index++;
		}
	});
	
	if('0' != cnt) {
		alert("환산점수를 입력해주세요");
		return false;
	}
	
	var pParam = {};
	pParam.resultTotPer = resultTotPer;
	pParam.resultTotScore = resultTotScore;
	pParam.lclasOrder = lclasOrder;
	pParam.mlsfcOrder = mlsfcOrder;
	pParam.insttCd = insttCd;
	pParam.orderNo = orderNo;
	$.post("/mngLevelReq/updateResultTotPerScoreAjax.do", pParam, function(data){
    	if('0' == data.message) {
    		document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationComplete.do";
    		document.form.submit();	
    	}
    });
} */

function fnAttachmentAllApplyFileDown() {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;

	var chkAttachmentFile = '';

	<c:forEach var="i" items="${mngLevelAllFileList }" varStatus="status">
	
		var fileInfo = new Object();
		fileInfo.fileId		= '${i.fileId}';
		fileInfo.fileName	= '${i.fileId}';
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );
		
	</c:forEach>	
	
	if(chkAttachmentFile == ''){
		alert("등록된 실적 파일이 없습니다.");
		return;
	}
	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}
</script>
</head>

<form method="post" id="form" name="form">
	<input type="hidden" id="s_order_no" name="s_order_no" value="${s_order_no }"/>
	<input type="hidden" id="s_instt_cd" name="s_instt_cd" value="${s_instt_cd }"/>
	<input type="hidden" id="s_instt_cl_cd" name="s_instt_cl_cd" value="${s_instt_cl_cd }"/>
	<input type="hidden" id="s_instt_nm" name="s_instt_nm" value="${s_instt_nm }"/>
	<input type="hidden" id="s_status" name="s_status" value="${mngLevelInsttTotalEvl.STATUS}" />
	
	<input type="hidden" id="instt_cl_cd"   name="instt_cl_cd" value="${instt_cl_cd}" /> 
	<input type="hidden" id="s_instt_cl_nm" name="s_instt_cl_nm" value="${s_instt_cl_nm}" /> 
            	    
    <!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
			
            <!-- 기관 조회  -->
            <c:if test="${'5' ne sessionScope.userInfo.authorId and '2' ne sessionScope.userInfo.authorId}">
				<div class="box-select-gray">
					<div class="box-select-ty1 type1">
					
						<div class="selectVal" tabindex="0">
	            			<a href="#this" tabindex="-1">${s_instt_cl_nm }</a>
		            	</div>
	      				<ul class="selectMenu fir">
	      					<c:forEach var="i" items="${mngLevelInsttClCdList }" varStatus="status">
	      						<li><a href="#" data-clcd="${i.INSTT_CL_CD }" data-clnm="${i.INSTT_CL_NM }">${i.INSTT_CL_NM }</a></li>
	      					</c:forEach>
	      				</ul>
					</div>
					<div class="box-select-ty1 type1 sec">
						<div class="selectVal insttSelectVal" tabindex="0">
	            			<a href="#this" tabindex="-1">${s_instt_nm }</a>
		            	</div>
	      				<ul class="selectMenu sec insttSelectMenu">
	      					<c:forEach var="i" items="${mngLevelInsttSelectList }" varStatus="status">
	      						<li><a data-cd="${i.INSTT_CD }" data-nm="${i.INSTT_NM }" href="#">${i.INSTT_NM }</a></li>
	      					</c:forEach>
	      				</ul>
					</div>	
				</div>
			</c:if>
			<!-- //기관 조회  -->
			
<!-- 			<div class="box-info mb30">
				<div class="icon"><span class="i-set i_info_i"></span></div>
				<div class="cont">
					<ul class="lst-dots">
						<li>진단항목을 클릭하시면 서면평가 화면으로 이동합니다.</li>
					</ul>
				</div>
			</div>	 -->		

			<div class="layer-header1 clearfix">
				<div class="col-rgh">
					<span class="ico_state i_none"><em>해당없음</em></span>
					<span class="ico_state i_obj"><em>이의신청</em></span>
				</div>
			</div>
			
			<div class="wrap_table2">
                <table id="table-1" class="tbl">
                    <caption>분야, 진단지표, 진단항목, 상태, 중간결과, 이의신청, 최종결과로 구성된 서면평가 목록</caption>
                    <colgroup>
                        <col class="th1_1">
                        <col class="th1_2">
                        <col>
                        <col class="th1_5">
 						<c:if test="${mngLevelInsttTotalEvl.STATUS == 'ES02' || mngLevelInsttTotalEvl.STATUS == 'ES03'}"> 
                        	<col style="width:8%">                        
                        </c:if> 
                        <col class="th1_50">
                        <col class="th1_50">
                        <c:if test="${fn:contains(periodCode, 'D')}">
                        	<col class="th1_50">
                        	<col class="th1_50">
                        </c:if>
                    </colgroup>
                    <thead class="bd">
                        <tr>
                            <th scope="col" rowspan="2" >분야</th>
                            <th scope="col" rowspan="2">진단지표</th>
                            <th scope="col" rowspan="2">진단항목</th>
                            <th scope="col" rowspan="2">상태</th>
                            <th scope="col" colspan="2">중간결과</th>      
                            <c:if test="${fn:contains(periodCode, 'D')}">
                            	<th scope="col" colspan="2">최종결과</th>
                            </c:if>
                        </tr>
                        <tr>
                        	<th scope="col">평가<br>점수</th>
                            <th scope="col">환산<br>점수</th>
                            <c:if test="${fn:contains(periodCode, 'D')}">
	                            <th scope="col">평가<br>점수</th>
	                            <th scope="col">환산<br>점수</th>
							</c:if>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="i" items="${mngLevelInsttDetailList }" varStatus="status">
                    		<tr>
                    			<c:choose>
                    				<c:when test="${!empty i.LCLAS_CNT && !empty i.MLSFC_CNT}">
                    					<th rowspan="${i.LCLAS_CNT}" scope="rowgroup" class="bdl0">${i.LCLAS }</th>
                    					<td rowspan="${i.MLSFC_CNT}" class="ta-l">${i.MLSFC }</td>
                    				</c:when>
                    				<c:when test="${empty i.LCLAS_CNT && !empty i.MLSFC_CNT}">
                    					<td rowspan="${i.MLSFC_CNT}" class="ta-l">${i.MLSFC }</td>
                    				</c:when>
                    			</c:choose>
								                    			
                    			<td class="ta-l bg_orange"><a href="#" onclick="detailIndex('${i.INDEX_SEQ}');" class="link1">${i.CHECK_ITEM }</a></td>
                				<c:choose>
                					<c:when test="${empty i.STATUS and i.EXCP_PERM_YN =='Y'}"><td><span class="ico_state i_none"><em class="hidden">해당없음</em></span></td></c:when>
                					<c:when test="${i.FOBJCT_RESN ne ''}"><td><span class="ico_state i_obj"><em class="hidden">이의신청</em></span></td></c:when>
                					<c:otherwise><td/></c:otherwise>
                				</c:choose>
                				
                				<c:if test="${(!empty i.LCLAS_CNT && !empty i.MLSFC_CNT) or (empty i.LCLAS_CNT && !empty i.MLSFC_CNT)}">
	                			<%-- 	<c:choose>
	                					<c:when test="${fn:contains(periodCode, 'B')}">
	                						<c:choose>
	                							<c:when test="${i.EXCP_PERM_YN =='N' || empty i.EXCP_PERM_YN}">
	                								<td class="tc" rowspan="${i.MLSFC_CNT}"><input type="text" name="RESULT_TOT_PER" id="${i.LCLAS_ORDER}|${i.MLSFC_ORDER}" class="inp_txt w100p ta-c" maxlength="5" value="${i.RESULT_TOT_PER1 }"></td>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}"><input type="text" name="RESULT_TOT_SCORE" class="inp_txt w100p ta-c" maxlength="5" value="${i.RESULT_TOT_SCORE1 }"></td>
	                							</c:when>
	                							<c:otherwise>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
	                							</c:otherwise>
	                						</c:choose>
	                					</c:when>
	                					<c:otherwise> --%>
	                						<c:choose>
	                							<c:when test="${i.EXCP_PERM_YN =='N' || empty i.EXCP_PERM_YN}">
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_PER1 }</td>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_SCORE1 }</td>
	                							</c:when>
	                							<c:otherwise>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
	                								<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
	                							</c:otherwise>
	                						</c:choose>
	                					<%-- </c:otherwise>
	                				</c:choose> --%>
	                			</c:if>
	                  			<c:if test="${(!empty i.LCLAS_CNT && !empty i.MLSFC_CNT) or (empty i.LCLAS_CNT && !empty i.MLSFC_CNT)}">
		                  			<c:if test="${fn:contains(periodCode, 'D')}">
	                    				<c:choose>
		                					<c:when test="${i.EXCP_PERM_YN =='N' }">
		                						<c:choose>
	                								<c:when test="${fn:contains(periodCode, 'D')}">
	                									<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_PER2 }</td>
	                									<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_SCORE2 }</td>
	                								</c:when>
	                								<c:otherwise>
	                									<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_PER2 }</td>
	                									<td class="tc" rowspan="${i.MLSFC_CNT}">${i.RESULT_TOT_SCORE2 }</td>
	                								</c:otherwise>
	                							</c:choose>
		                					</c:when>
		                					<c:when test="${i.EXCP_PERM_YN =='Y' }">
		                						<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
		                						<td class="tc" rowspan="${i.MLSFC_CNT}">-</td>
		                					</c:when>
		                					<c:otherwise>
		                						<td rowspan="${i.MLSFC_CNT}"></td>
		                						<td rowspan="${i.MLSFC_CNT}"></td>
		                					</c:otherwise>
	                					</c:choose>
	                    			</c:if>
	                    		</c:if>
                    		</tr>	
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
			<div class="btn-bot2">
				<a href="#" class="btn-pk s gray rv" onclick="fnAttachmentAllApplyFileDown(); return false;">실적등록 파일 전체 다운로드</a>
				
	            <div class="mt10 ta-c">
<%-- 		            <c:if test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
		                <a href="#" onclick="complete(); return false;" class="btn-pk n purple rv">평가완료</a>
					</c:if> --%>
		                <a href="/mngLevelReq/mngLevelDocumentEvaluation.do" class="btn-pk n black">목록으로</a>
	            </div>  
	        </div>
    </section>
    <!-- /content -->
</form>

<!--  파일 다운로드에 사용 -->  
<form id="__downForm" name="__downForm" action="<c:url value='/crossUploader/fileDownload.do'/>" method="post">
	<input type="hidden" id="CD_DOWNLOAD_FILE_INFO" name="CD_DOWNLOAD_FILE_INFO" value="" > 
	<input type="hidden" id="fileExt" name="fileExt" value="xlsx;jpg;gif;png;bmp;zip;">
	<input type="hidden" id="maxFileSize" name="maxFileSize" value="">
	<input type="hidden" id="maxTotFileSize" name="maxTotFileSize" value="">
	<input type="hidden" id="maxFileSize1" name="maxFileSize1" value="">
	<input type="hidden" id="maxTotFileSize1" name="maxTotFileSize1" value="">
	<input type="hidden" id="applyFlag" name="applyFlag" value="N">
</form>

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>
