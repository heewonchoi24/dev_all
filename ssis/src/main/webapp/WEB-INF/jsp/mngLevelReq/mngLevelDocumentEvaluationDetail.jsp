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
		e.preventDefault();
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
	
	document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationDetail.do";
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

/* function fobjctLayer(index_seq, order_no, instt_cd){
	
	pUrl = "/mngLevelReq/mngLevelFobjctResnAjax.do";
	pParam = {};
	pParam.s_index_seq = index_seq;
	pParam.s_order_no = order_no;
	pParam.s_instt_cd = instt_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		$("#fobjct_check_item").text(data.result.CHECK_ITEM);
		$("#fobjct_resn").text(data.result.FOBJCT_RESN); */

		/*  2018.07.20  이의 신청 첨부 파일 삭제
		var str = '';
		if(data.resultList.length > 0) {
			str += '<th scope="row">첨부파일</th>';
			str += '<td id="fobjct_file" class="option_area">';
			str += '<div class="option"><ul class="file_list">';
		}
		for(var i in data.resultList){
			str += '<li><label for='+ data.resultList[i].FILE_ID +'><a href="#" onClick="fnAttachmentEvlFileDown('+"'"+ data.resultList[i].FILE_ID +"'"+ '); return false;" class="f_'+ data.resultList[i].fileExtsn +">' + data.resultList[i].FILE_NAME + '</a></label></li>'; 	
		}
		if(data.resultList.length > 0) {
			str += '</ul></div></td>';
			$("#fobjct_file").html(str);
		} else {
			$("#fobjct_file").html(str);
		}
		*/
		
/* 	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}
 */
function detailIndex(index_seq){
	
	$('<input type="hidden" name="s_index_seq" value="' + index_seq + '" />').appendTo('#form');
	
	document.form.s_index_seq.value = index_seq;
	document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationRegist.do";
	document.form.submit();
}


function complete(){
	
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
}

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


function fnAttachmentResultReportFileDown() {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;

	var chkAttachmentFile = '';

	<c:forEach var="i" items="${mngLevelResultReportFile }" varStatus="status">
	
		var fileInfo = new Object();
		fileInfo.fileId		= '${i.fileId}';
		fileInfo.fileName	= '${i.fileId}';
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );
		
	</c:forEach>
	
	if(chkAttachmentFile == ''){
		alert("등록된 결과보고서가 없습니다.");
		return;
	}
	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

/* function fnAttachmentEvlFileDown( atchmnflId ) {
	var chkAttachmentFile = atchmnflId;

	// 목록에 넣는다 
	var chkAttachmentFileArr = chkAttachmentFile.split(",");
	if( chkAttachmentFileArr.length < 1 )
		return;
	chkAttachmentFile = "";
	for( key in chkAttachmentFileArr ) {
		var fileId = chkAttachmentFileArr[ key ];
		if( fileId == "" )
			continue;
		//
		var fileInfo = new Object();
		fileInfo.fileId		= fileId;
		fileInfo.fileName	= fileId;
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		//
		chkAttachmentFile += JSON.stringify( fileInfo );		
	}	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";    
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
} */

function fn_print() {

	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	if (confirm("직전 년도 서면평가 결과를 다운로드 하시겠습니까?")) {
		
    	$("#form").attr({
            action : "/mngLevelReq/mngLevelReqExcelDown.do",
            method : "post"
        }).submit();
	}
}

</script>
</head>

<form method="post" id="form" name="form">
	<input type="hidden" id="s_order_no" name="s_order_no" value="${s_order_no }"/>
	<input type="hidden" id="s_instt_cd" name="s_instt_cd" value="${s_instt_cd }"/>
	<input type="hidden" id="s_instt_cl_cd" name="s_instt_cl_cd" value="${s_instt_cl_cd }"/>
	<input type="hidden" id="s_instt_nm" name="s_instt_nm" value="${s_instt_nm }"/>
	<input type="hidden" id="s_status" name="s_status" value="${mngLevelInsttTotalEvl.STATUS}" />
	<input type="hidden" id="instt_cl_cd"   name="instt_cl_cd"   value="${instt_cl_cd}" /> 
	<input type="hidden" id="s_instt_cl_nm" name="s_instt_cl_nm" value="${s_instt_cl_nm}" /> 
            	    
    <!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
			
			<div class="layer-header1 mb-c3 clearfix">
				<c:if test="${'2' ne sessionScope.userInfo.authorId}">
				    <div class="col-rgh mt0 report">
				    	<a href="#" onclick="fnAttachmentResultReportFileDown(); return false;" class="btn-pk s gray rv">개인정보보호 관리수준진단결과</a>
				    	<c:choose>
				    		<c:when test="${empty mngLevelResultBeforeYear.RECENT_YEAR }">
				    			<a onclick="alert('직전 년도 서면평가 결과가 없습니다.'); return false;" class="btn-pk s blue rv">직전 년도 서면평가 결과보기</a>
				    		</c:when>
				    		<c:otherwise>
				    			<a href="#" onclick="fn_print(); return false;" class="btn-pk s blue rv">직전 년도 서면평가 결과보기</a>	
				    		</c:otherwise>
				    	</c:choose>
				    </div> 
			    </c:if> 		
			 </div>	
			        
            <!-- 기관 조회  -->
            <c:if test="${'2' ne sessionScope.userInfo.authorId and '5' ne sessionScope.userInfo.authorId }">
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
			
			<h1 class="title4">진단항목별 평가 <c:if test="${!empty mngLevelInsttTotalEvl.evalUserNm }"><span class="fc_blue">담당자 : ${mngLevelInsttTotalEvl.evalUserNm} [${mngLevelInsttTotalEvl.evalDt}]</span></c:if>
<%-- 				<c:if test="${sessionScope.userInfo.authorId eq '2'}">
					<div style="float: right;">
						<a href="/common/objectionApply.xlsx" class="btn-pk s blue rv">전체 이의 신청 양식 다운로드</a>
					</div>
				</c:if> --%>
			</h1>
			
			<div class="layer-header1 clearfix">
				<div class="col-rgh">
					<span class="ico_state i_none"><em>해당없음</em></span>
					<span class="ico_state i_eval"><em>서면평가</em></span>
					<span class="ico_state i_mid"><em>중간결과</em></span>
					<span class="ico_state i_obj"><em>이의신청</em></span>
					<span class="ico_state i_eval_total"><em>최종평가</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
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
                            <th scope="col" rowspan="2">분야</th>
                            <th scope="col" rowspan="2">진단지표</th>
                            <th scope="col" rowspan="2">진단항목</th>
                            <th scope="col" rowspan="2">상태</th>
<%--                             <c:if test="${mngLevelInsttTotalEvl.STATUS == 'ES02' || mngLevelInsttTotalEvl.STATUS == 'ES03'}">
                            	<th scope="col" rowspan="2">이의신청</th>
                            </c:if>    
 --%>                            <th scope="col" colspan="2">중간결과</th>      
                            <c:if test="${fn:contains(periodCode, 'D')}">
                            	<th scope="col" colspan="2">최종결과</th>
                            </c:if>
                        </tr>
                        <tr>
                        	<th scope="col">평가<br>점수</th>
                            <th scope="col" style="width: 70px;">환산<br>점수</th>
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
                					<c:when test="${empty i.STATUS and i.EXCP_PERM_YN =='Y'}"><td><span class="ico_state i_none"><em>해당없음</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES01'}"><td><span class="ico_state i_eval"><em>서면평가</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES02'}"><td><span class="ico_state i_mid"><em>중간결과</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES03'}"><td><span class="ico_state i_obj"><em>이의신청</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES04'}"><td><span class="ico_state i_eval_total"><em>최종평가</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES05'}"><td><span class="ico_state i_result_total"><em>최종결과</em></span></td></c:when>
                					<c:otherwise><td/></c:otherwise>
                				</c:choose>
<%--                 				<c:if test="${mngLevelInsttTotalEvl.STATUS == 'ES02' || mngLevelInsttTotalEvl.STATUS == 'ES03'}">
	                				<c:choose>
	                					<c:when test="${!empty i.FOBJCT_RESN && !empty i.FOBJCT_DE}">
	                						<td class="tc"><a href="#" onclick="fobjctLayer('${i.INDEX_SEQ}', '${i.ORDER_NO}', '${i.INSTT_CD}');" class="button bt2 layer_open">신청확인</a></td>
	                					</c:when>
	                					<c:when test="${i.EXCP_PERM_YN =='Y' }">
	                						<td class="tc" >-</td>
	                					</c:when>
	                					<c:otherwise>
	                						<td></td>
	                					</c:otherwise>
	                  				</c:choose>
	                  			</c:if> --%>
                				
                				<c:if test="${(!empty i.LCLAS_CNT && !empty i.MLSFC_CNT) or (empty i.LCLAS_CNT && !empty i.MLSFC_CNT)}">
	                				<c:choose>
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
	                					<c:otherwise>
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
	                					</c:otherwise>
	                				</c:choose>
	                			</c:if>
	                  			<c:if test="${(!empty i.LCLAS_CNT && !empty i.MLSFC_CNT) or (empty i.LCLAS_CNT && !empty i.MLSFC_CNT)}">
		                  			<c:if test="${fn:contains(periodCode, 'D')}">
	                    				<c:choose>
		                					<c:when test="${i.EXCP_PERM_YN =='N' }">
		                						<c:choose>
	                								<c:when test="${fn:contains(periodCode, 'D')}">
	                									<td class="tc" rowspan="${i.MLSFC_CNT}"><input type="text" name="RESULT_TOT_PER" id="${i.LCLAS_ORDER}|${i.MLSFC_ORDER}" class="inp_txt w100p ta-c" maxlength="5" value="${i.RESULT_TOT_PER2 }"></td>
	                									<td class="tc" rowspan="${i.MLSFC_CNT}"><input type="text" name="RESULT_TOT_SCORE" class="inp_txt w100p ta-c" maxlength="5" value="${i.RESULT_TOT_SCORE2 }"></td>
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
		            <c:if test="${(fn:contains(periodCode, 'B') || fn:contains(periodCode, 'D')) and sessionScope.userInfo.authorId ne '2' and requestZvl.s_order_no eq currentOrderNo}">
		                <a href="#" onclick="complete(); return false;" class="btn-pk n purple rv">평가완료</a>
		               <!--  <a href="/mngLevelReq/mngLevelDocumentEvaluationComplete.do" class="btn-pk n purple rv">평가완료</a> -->
					</c:if>
					<c:if test="${sessionScope.userInfo.authorId ne '2'}">
		                <a href="/mngLevelReq/mngLevelDocumentEvaluation.do" class="btn-pk n black">목록으로</a>
		            </c:if>
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
