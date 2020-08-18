<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var pUrl, pParam;
var chkCnt = 0;

$(document).ready(function(){
	
	// 검색 옵션 선택 시
	$(document).on("click","#insttClCdList>li>a",function(e){
		e.preventDefault();
		$("#instt_cl_cd").val(this.dataset.clcd);
		$("#instt_cl_nm").val(this.dataset.clnm);
		changeInsttList(this.dataset.clcd);
	});
	
	$(document).on("click","#insttCdList>li>a",function(){
		$("#instt_cd").val(this.dataset.cd);
		$("#instt_nm").val(this.dataset.nm);
		selectList();
	});
	
	// 차수 옵션 선택 시
	$(document).on("click","#yyyy>li>a",function(){
		$("#order_no").val(this.dataset.yyyy);
		selectList();
	});
	
	<c:if test="${sessionScope.userInfo.authorId =='5'}">
		$(".box-select-gray").hide();
	</c:if>
	
});

function fnAttachmentEvlFileDown( atchmnflId ) {
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
}

function changeInsttList(instt_cl_cd){

	pUrl = "/statusExaminReq/statusExaminInsttListAjax.do";
	pParam = {};
	pParam.instt_cl_cd = instt_cl_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '';
			str += '<div class="selectVal insttSelectVal" tabindex="0">'; 	
			str += '<a href="#this" tabindex="-1">선택해주세요</a>'; 	
			str += '</div>'; 	
			str += '<ul class="selectMenu insttSelectMenu" id="insttCdList">'; 
		for(var i in data.resultList){
			str += '<li><a href="#" data-cd="' + data.resultList[i].INSTT_CD + '" data-nm="' + data.resultList[i].INSTT_NM +'">' + data.resultList[i].INSTT_NM + '</a></li>'; 	
		}
			str += '</ul>';
		$(".box-select-ty1.type1.sec").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}

function fobjctLayer(index_seq, order_no, instt_cd){
	
	pUrl = "/statusExaminReq/statusExaminFobjctResnAjax.do";
	pParam = {};
	pParam.s_index_seq = index_seq;
	pParam.s_order_no = order_no;
	pParam.s_instt_cd = instt_cd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		$("#fobjct_check_item").text(data.result.CHECK_ITEM);
		$("#fobjct_resn").text(data.result.FOBJCT_RESN);
		var str = '';
		if(data.resultList.length > 0) {
			str += '<th scope="row">첨부파일</th>';
			str += '<td id="fobjct_file" class="option_area">';
			str += '<div class="option"><ul class="file_list">';
		}
		for(var i in data.resultList){
			str += '<li><label for='+ data.resultList[i].FILE_ID +'><a href="#" onClick="fnAttachmentEvlFileDown('+"'"+ data.resultList[i].FILE_ID +"'"+ '); return false;" class="f_' + data.resultList[i].FILE_EXTSN +'">' + data.resultList[i].FILE_NAME + '</a></label></li>'; 	
		}
		if(data.resultList.length > 0) {
			str += '</ul></div></td>';
			$("#fobjct_file").html(str);
		} else {
			$("#fobjct_file").html(str);
		}
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}

function detailIndex(index_seq,mng_seq){
	
	$('<input type="hidden" name="s_index_seq" value="' + index_seq + '" />').appendTo('#form');
	$('<input type="hidden" name="mng_index_seq" value="' + mng_seq + '" />').appendTo('#form');
	
	document.form.s_index_seq.value = index_seq;
	document.form.mng_index_seq.value = mng_seq;
	document.form.action = "/statusExaminReq/statusExaminResultMemoList.do";
	document.form.submit();
}


function registTotalEvl(atchmnflId, resultCnt){
 	if($("#periodCd").val() != "E") {
		alert( "현장점검 등록 기간이 아닙니다. 확인바랍니다.");
		return false;
	}
    $( "#atchmnfl_id").val(atchmnflId);
	var notCnt = resultCnt - chkCnt;
	if( chkCnt < resultCnt ) {
		alert( "현장점검 등록이 완료되지 않았습니다." + " 미등록 " + notCnt + "건 등록바랍니다.")
		return false;
	}
	document.form.instt_cl_nm.value = $("#instt_cl_nm").val();
	document.form.action = "/statusExaminReq/statusExaminResultModify.do";
	document.form.submit();
}  

function selectList(){
	
	$("#form").attr({
        action : "/statusExaminReq/statusExaminResultModifyList.do",
        method : "post"
    }).submit();
	
}

function fn_print() {

	var chkAttachmentFile = '';

	<c:forEach var="i" items="${mngLevelPreFileList }" varStatus="status">
	
		var fileInfo = new Object();
		fileInfo.fileId		= '${i.fileId}';
		fileInfo.fileName	= '${i.fileId}';
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );
		
	</c:forEach>	
	
	if(chkAttachmentFile == ''){
		alert("등록된 이전 점검결과 파일이 없습니다.");
		return;
	}
	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";
    //
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	//
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
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

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="order_no" name="order_no" value="${order_no }"/>
	<input type="hidden" id="instt_cd" name="instt_cd" value="${instt_cd }"/>
	<input type="hidden" id="instt_nm" name="instt_nm" value="${instt_nm }"/>
	<input type="hidden" id="instt_cl_nm" name="instt_cl_nm" value="${instt_cl_nm }"/>
	<input type="hidden" id="instt_cl_cd" name="instt_cl_cd" value="${instt_cl_cd }" />
	<input type="hidden" id="periodCd" name="periodCd" value="${requestZvl.periodCd }"/>
	<!--  파일 처리에 사용 -->
	<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="${statusExaminInsttTotalEvl.ATCHMNFL_ID }" > 
	<input type="hidden" id="indexSeq" name="indexSeq" value="" > 
	<!--  파일 처리에 사용 -->               
	
<section id="container" class="sub">
    <!-- content -->
    <div id="container" class="container_inner">
            <!-- 
            <div class="top">
                <a href="#" class="button bt3" onclick="fn_print();">이전 점검결과 보기</a>
            </div>             
             -->
             
             <div class="box-select-gray">
            	<div class="box-select-ty1 type1">
	            	<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">${instt_cl_nm }</a></div>
	            	<ul class="selectMenu" id="insttClCdList">
	            		<c:forEach var="i" items="${statusExaminInsttClCdList }" varStatus="status">
							<li><a href="#" data-clcd="${i.INSTT_CL_CD }" data-clnm="${i.INSTT_CL_NM }">${i.INSTT_CL_NM }</a></li>
						</c:forEach>
					</ul>
            	</div>
                
                <div class="box-select-ty1 type1 sec">
					<div class="selectVal insttSelectVal" tabindex="0"><a href="#this" tabindex="-1">${instt_nm }</a></div>
					<ul class="selectMenu insttSelectMenu" id="insttCdList">
                       	<c:forEach var="i" items="${statusExaminInsttSelectList }" varStatus="status">
							<li><a href="#" data-cd="${i.INSTT_CD }" data-nm="${i.INSTT_NM }">${i.INSTT_NM }</a></li>
						</c:forEach>
					</ul>
				</div>
				
				<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">${order_no}</a></div>
					<ul class="selectMenu" id="yyyy">
						<c:forEach var="i" items="${statusExaminInsttEvlOrderList}"  varStatus="status">
							<li><a href="#" data-yyyy="${i.ORDER_NO}">${i.ORDER_NO}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
             
			<div class="layer-header1 clearfix">
				<div class="col-rgh">
					<span class="ico_state i_eval"><em>현장점검</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
				</div>
			</div>
                <h3 class="h3"><c:if test="${!empty statusExaminInsttTotalEvl.evalUserNm}"><span class="appraiser">담당자 : ${statusExaminInsttTotalEvl.evalUserNm} [${statusExaminInsttTotalEvl.evalDt}]</span></c:if></h3> 
                <ul class="list01 mt10">
<!--                     <li>각 <strong class="c_orange">점검지표를 클릭</strong>하시면 현장점검 등록 화면으로 이동합니다.</li> -->
                </ul>            
            <div class="wrap_table2">
                <table id="table-1" class="tbl" summary="대분류, 중분류, 소분류, 점검지료, 상태, 이의신청, 중간결과로 구성된 현장점검 목록입니다.">
                    <caption>현장점검 등록 상세</caption>
                    <colgroup>
						<col class="th1_1">
						<col class="th1_2">
						<col>
						<col class="th1_5">
						<col class="th1_4">
					</colgroup>
                    <thead>
                        <tr>
                            <th scope="col">분야</th>
                            <th scope="col">진단지표</th>
                            <th scope="col">진단항목</th>
                            <th scope="col">상태</th>
                            <th scope="col">
                            	<c:if test="${requestZvl.periodCd=='E'}">중간</c:if>
                            		결과</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="i" items="${statusExaminInsttDetailList }" varStatus="status">
                    		<tr>
                    			<c:choose>
                     				<c:when test="${!empty i.LCLAS_CNT && !empty i.MLSFC_CNT }">
                    					<th rowspan="${i.LCLAS_CNT}" scope="rowgroup" class="bdl0">${i.LCLAS }</th>
                    					<td rowspan="${i.MLSFC_CNT}" scope="rowgroup" class="ta-l">${i.MLSFC }</td>
                    				</c:when>
                    				<c:when test="${empty i.LCLAS_CNT && !empty i.MLSFC_CNT }">
                    					<td rowspan="${i.MLSFC_CNT}" scope="rowgroup" class="ta-l">${i.MLSFC }</td>
                    				</c:when>
                    			</c:choose>
								                    			
                    			<td class="ta-l bg_orange"><a href="#" onclick="detailIndex('${i.INDEX_SEQ}','${i.MNG_LEVEL_INDEX_SEQ}');" class="link1"><span>${i.CHECK_ITEM }</span></a></td>
                				<c:choose>
                					<c:when test="${i.STATUS == 'ES01'}"><td><span class="ico_state i_eval"><em>현장점검</em></span></td></c:when>
                					<c:when test="${i.STATUS == 'ES05'}"><td><span class="ico_state i_result_total"><em>최종결과</em></span></td></c:when>
                					<c:otherwise><td><span class=""><em></em></span></td></c:otherwise>
                				</c:choose>
                    			<td>${i.RESULT_SCORE1 } <c:if test="${!empty i.STATUS}"> <script>chkCnt++ </script></c:if></td>
                    		</tr>	
                    	</c:forEach>
                    </tbody>
                </table>
            </div>
            <div class="btn-bot2">
				<a href="#" class="btn-pk s gray rv" onclick="fnAttachmentAllApplyFileDown(); return false;">관리수준 진단 제출자료 다운로드</a>
			</div>
            <div class="btn-bot noline ta-c">
                <a href="/statusExaminReq/statusExaminResultSummaryList.do" class="btn-pk n black">목록으로</a>
                <c:if test="${requestZvl.periodCd=='E'}">
                <a href="#" onclick="registTotalEvl('${statusExaminInsttTotalEvl.ATCHMNFL_ID}','${statusExaminInsttDetailList.size()}');" class="btn-pk n purple rv">점검완료</a>
                </c:if>
            </div>            
        </div>
    </div>
    <!-- /content -->
</section>
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
<!--  파일 다운로드에 사용 -->  