<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	.lst_tblinner .tbls > .col.list .h1 { padding: 40px 20px; } 
	.wrap_table2 tbody tr th:first-child { border-left: 1px solid #dcdbdb; }
	.wrap_table2 tbody tr th.bdl0 { border-left: none; }
	.i-aft.link a { text-decoration: underline; color: #0d6090; font-size: 13px; }
</style>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

var html = '';

$(document).ready(function(){
	
	$(".btn-pk.vs.blue").on('click',function(e){
		e.preventDefault();
	});
	
	$(".selectMenu.fir>li>a").on('click',function(e){
		e.preventDefault();
		$("#s_instt_cl_nm").val(this.dataset.clnm);
		$("#instt_cl_cd").val(this.dataset.clcd);
		changeSecSearchMenu(this.dataset.clcd);
	});
	
	$(".selectMenu.sec>li>a").on('click',function(e){
		e.preventDefault();
		$("#s_instt_cd").val(this.dataset.cd);
		$("#s_instt_nm").val(this.dataset.nm);
		
		changeInsttList();
	});		

	$(".ickjs").on('ifChanged', function(e){
		if($( ".lst_all_chk #"+ e.target.id ).is(":checked") == true){
			$(".lst_answer."+e.target.id+" .icheckbox_square").addClass("checked");
			$(".lst_answer."+e.target.id+" .ickjs").prop("checked", true);
		}else if($( ".lst_all_chk #"+ e.target.id ).is(":checked") == false){
			$(".lst_answer."+e.target.id+" .icheckbox_square").removeClass("checked");
			$(".lst_answer."+e.target.id+" .ickjs").prop("checked", false);
		}
	})
	
});

function requestPopup(sInsttCd, indexSeq, checkItem){
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	layerPopup3.open('/mngLevelRes/requestPopup.do?s_instt_cd='+sInsttCd+'&&indexSeq='+indexSeq+'&&check_item='+encodeURIComponent(checkItem),'request2', request1Callback);
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

function request1Callback(){
	// 재등록 요청
};	

function changeSecSearchMenu(instt_cl_cd){
	
	pUrl = "/mngLevelRes/mngLevelInsttListAjax.do";
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
		changeInsttList();
	});		
	
}

function changeInsttList(){
	
	document.form.action = "/mngLevelRes/mngLevelSummaryListDetail.do";
	document.form.submit();	
	
}

//<!--  파일 업로드에 사용 -->  
var attachmentFileArray       = new Array();
var attachmentFileDeleteArray = new Array();

function fnAttachmentFileDown( index, atchmnflId ) {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	var chkAttachmentFile = atchmnflId;
	if( atchmnflId == "" ) {
		$( "input:checkbox[name=chkAttachmentFile_" + index + "]" ).each( function() {
			if( $(this).prop( "checked" ) ) 
				chkAttachmentFile += "," + $(this).attr("id");
		});
		chkAttachmentFile = chkAttachmentFile.substring( 1, chkAttachmentFile.length )
	}
	if( chkAttachmentFile == "" ) {
		alert( "다운로드할 파일을 선택 하십시요.")
		return;
	}
	// 삭제 목록에 넣는다 
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

function fnAttachmentResultReportFileDown() {

	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;

	var chkAttachmentFile = '';

	<c:forEach var="i" items="${mngLevelResultReportFile }" varStatus="status">
	
		var fileInfo = new Object();
		fileInfo.fileId		= '${i.FILE_ID}';
		fileInfo.fileName	= '${i.FILE_ID}';
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );
		
	</c:forEach>
	
	if(chkAttachmentFile == ''){
		alert("등록된 개인정보보호 관리수준진단결과가 없습니다.");
		return;
	}
	
	chkAttachmentFile = "["+ chkAttachmentFile +"]";
	var CD_DOWNLOAD_FILE_INFO = chkAttachmentFile;
	$( "#CD_DOWNLOAD_FILE_INFO" ).val( CD_DOWNLOAD_FILE_INFO );
	$( "#__downForm" ).submit();
}

</script>

<form action="/mngLevelRes/mngLevelSummaryListDetail.do" method="post" id="form" name="form">
	
	<input name="lclas" id="lclas" type="hidden" value=""/>
	<input type="hidden" id="instt_cl_cd"  name="instt_cl_cd" value="${instt_cl_cd}" /> 
	<input type="hidden" id="s_instt_cl_nm"  name="s_instt_cl_nm" value="${s_instt_cl_nm}" /> 
	<input type="hidden" id="s_instt_cd" name="s_instt_cd" value="${s_instt_cd}">
	<input type="hidden" id="s_instt_nm" name="s_instt_nm" value="${s_instt_nm}">
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.orderNo}" />
	
    <!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
            
			<h1 class="title4"><c:out value='${s_instt_nm}'/> 실적등록</h1>
			
			<div class="layer-header1 mb-c3 clearfix">
			    <div class="col-rgh mt0 report">
			    	<a href="#" onclick="fnAttachmentResultReportFileDown(); return false;" class="btn-pk s blue rv">개인정보보호 관리수준진단결과</a>
			    </div>
		    </div>
			 			            
            <!-- 기관 조회  -->
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
			<!-- //기관 조회  -->
			
			<div class="layer-header1 clearfix">
				<div class="col-rgh">
					<span class="ico_state i_none"><em>해당없음</em></span>
					<span class="ico_state i_reg_comp"><em>등록완료</em></span>
					<span class="ico_state i_rereg"><em>재등록요청</em></span>
					<span class="ico_state i_rereg_comp"><em>재등록완료</em></span>
					<span class="ico_state i_noreg"><em>미등록</em></span>
				</div>
			</div>
			
                <c:choose>
					<c:when test="${!empty resultList}">
                		
		                <div class="wrap_table2">
		                    <table class="tbl">
		                        <caption>실적등록및조회 상세</caption>
		                        <colgroup>
		                            <col class="th1_1">
									<col class="th1_6">
									<col>
									<col class="th1_3">
									<col class="th1_4">
		                        </colgroup>
		                        <thead>
		                            <tr>
		                                <th scope="col">분야</th>
		                                <th scope="col">진단지표</th>
		                                <th scope="col">진단항목</th>
		                                <th scope="col">상태</th>
		                                <th scope="col">재등록요청</th>		                                
		                            </tr>
		                        </thead>
		                        <tbody>
		                        	<c:set var="tmpLclas" value=""/>
                                    <c:set var="tmpMlsfc" value=""/>
                                    
                                    <c:forEach var="list" items="${resultList}" varStatus="status">
                                    	<c:choose>
											<c:when test="${status.first}">
												<tr>
					                                <th rowspan="${list.maxlclasCnt}" scope="col" class="bdl0">${list.lclas}</th>
					                                <th scope="row" class="ta-l">${list.mlsfc}</th>
					                                <td colspan="3" class="pd0">
					                                
					                                <!-- 파일이 있을때 -->
					                                <c:if test="${list.fileId !='' }">
					                                	<div class="lst_tblinner">
															<div class="tbls">
																<div class="col list">
																	<p class="h1">${list.checkItem}</p>
																	<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																		<div>
																			<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																			<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																		</div>
													</c:if>	
													
													<!-- 파일이 없을때 -->
													<c:if test="${list.fileId =='' }">
														<div class="lst_tblinner">
															<div class="tbls">
																<div class="col list">
																	<p class="h1">${list.checkItem}</p>
																</div>
																<div class="col state">
						                                			<c:choose>
						                                				<c:when test="${list.excpYn == 'Y'}">
																			<span class="ico_state i_none"><em>해당없음</em></span>
																		</c:when>
																		<c:when test="${list.status == ''}">
																			<span class="ico_state i_noreg"><em>미등록</em></span>
																		</c:when>
																		<c:when test="${list.status == 'RS03'}">
																			<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																		</c:when>
																		<c:when test="${list.status == 'RS04'}">
																			<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																		</c:when>
																		<c:when test="${list.status == 'RS05'}">
																			<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																		</c:when>
																	</c:choose>								                          
			                                					</div>
																<div class="col btns">
																	<c:choose>
						                                				<c:when test="${list.excpYn == 'Y'}">
						                                					<span class="ico_state i_none"><em>해당없음</em></span>
						                                				</c:when>																	
						                            					<c:when test="${list.status == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
						                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
						                                    			</c:when>
						                            					<c:when test="${list.status == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
						                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
						                                    			</c:when>
																		<c:when test="${list.status == 'RS04'}">
																			${list.requstDe}
																		</c:when>
																	</c:choose>																
																</div>
															</div>	
														</div>															
													</c:if>		
																		
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${list.lclas != tmpLclas}">
																<c:if test="${fileId !='' }">
																	</div><!-- //lst_answer -->
																	<div class="lst_all_chk">
																		<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onclick="fnCheckAttachmentFile('${indexSeq}');">
																		<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																		<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																	</div>
                                    							</div><!-- //col list -->
                                    							
                                    							<div class="col state">
                                    								<c:choose>
																		<c:when test="${reqStatus == ''}">
																			<span class="ico_state i_noreg"><em>미등록</em></span>
																		</c:when>
																		<c:when test="${reqStatus == 'RS03'}">
																			<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																		</c:when>
																		<c:when test="${reqStatus == 'RS04'}">
																			<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																		</c:when>
																		<c:when test="${reqStatus == 'RS05'}">
																			<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																		</c:when>
																	</c:choose>
                                    							</div>
                                    							
																<div class="col btns">
																	<c:choose>
						                            					<c:when test="${reqStatus == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
						                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
						                                    			</c:when>
						                            					<c:when test="${reqStatus == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
						                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
						                                    			</c:when>
																		<c:when test="${reqStatus == 'RS04'}">
																			${requstDe}
																		</c:when>
																	</c:choose>
																</div>
															</div> <!-- //tbls -->
															<div class="lst_log">
																<span>Log.</span>
																<div class="log ${indexSeq}"></div>
															</div>
														</div><!--// lst_tblinner -->
															</td>
															</tr>
															<script>
																$(".log."+${indexSeq}).append(html); html = '';
																$(".lst_log .log").each(function(){
																	if($(this).html() == '') $(this).prev().css("top", "14px");	
																})
															</script>
	                										</c:if>
													
														<tr>
															<th rowspan="${list.maxlclasCnt}" scope="col" class="bdl0">${list.lclas}</th>
							                                <th scope="row" class="ta-l">${list.mlsfc}</th>
							                                <td colspan="3" class="pd0">
							                                		
							                                		<!-- 파일이없을때 -->
							                                		<c:if test="${list.fileId =='' }">
								                                		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																				</div>
				                                    							<div class="col state">
										                                			<c:choose>
										                                				<c:when test="${list.excpYn == 'Y'}">
																							<span class="ico_state i_none"><em>해당없음</em></span>
																						</c:when>
																						<c:when test="${list.status == ''}">
																							<span class="ico_state i_noreg"><em>미등록</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS03'}">
																							<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS04'}">
																							<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS05'}">
																							<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																						</c:when>
																					</c:choose>					                                    							
				                                    							</div>
																				<div class="col btns">
																					<c:choose>
										                                				<c:when test="${list.excpYn == 'Y'}">
										                                					<span class="ico_state i_none"><em>해당없음</em></span>
										                                				</c:when>																	
										                            					<c:when test="${list.status == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
										                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
										                                    			</c:when>
										                            					<c:when test="${list.status == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
										                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
										                                    			</c:when>
																						<c:when test="${list.status == 'RS04'}">
																							${list.requstDe}
																						</c:when>
																					</c:choose>																						
																				</div>																					
																			</div>
																		</div>
							                                		</c:if>
																	
																	<!-- 파일이있을때 -->                            							                                									                                									                                		
							                                		<c:if test="${list.fileId !='' }">
							                                		<div class="lst_tblinner">
																		<div class="tbls">
																			<div class="col list">
																				<p class="h1">${list.checkItem}</p>
																				<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																					<div>
																						<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																						<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																					</div>
                            										</c:if>                                 							                                									                                									                                		
 													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${list.mlsfc != tmpMlsfc}">
					                                			 <c:if test="${fileId !='' }">
		                           											</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																		
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
		                                    							<div class="col state">
		                                    								<c:choose>
																				<c:when test="${reqStatus == ''}">
																					<span class="ico_state i_noreg"><em>미등록</em></span>
																				</c:when>
																				<c:when test="${reqStatus == 'RS03'}">
																					<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																				</c:when>
																				<c:when test="${reqStatus == 'RS04'}">
																					<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																				</c:when>
																				<c:when test="${reqStatus == 'RS05'}">
																					<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																				</c:when>
																			</c:choose>
		                                    							</div>
																		<div class="col btns">
																			<c:choose>
								                            					<c:when test="${reqStatus == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
								                            					<c:when test="${reqStatus == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
																				<c:when test="${reqStatus == 'RS04'}">
																					${requstDe}
																				</c:when>
																			</c:choose>
																		</div>
																	</div> <!-- tbls -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
                           											</td>
							                                		</tr>
							                                		<script>
							                                			$(".log."+${indexSeq}).append(html); html = ''; 
								                                		$(".lst_log .log").each(function(){
																			if($(this).html() == '') $(this).prev().css("top", "14px");	
																		})
							                                		</script>
		                										</c:if>
															
																<tr>
									                                <th scope="row" class="ta-l">${list.mlsfc}</th>
									                                <td colspan="3" class="pd0">
							                                		
							                                		<!-- 파일이없을때 -->
							                                		<c:if test="${list.fileId =='' }">
							                                			<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																				</div>
				                                    							<div class="col state">
										                                			<c:choose>
										                                				<c:when test="${list.excpYn == 'Y'}">
																							<span class="ico_state i_none"><em>해당없음</em></span>
																						</c:when>
																						<c:when test="${list.status == ''}">
																							<span class="ico_state i_noreg"><em>미등록</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS03'}">
																							<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS04'}">
																							<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																						</c:when>
																						<c:when test="${list.status == 'RS05'}">
																							<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																						</c:when>
																					</c:choose>					                                    							
				                                    							</div>
																				<div class="col btns">
																					<c:choose>
										                                				<c:when test="${list.excpYn == 'Y'}">
										                                					<span class="ico_state i_none"><em>해당없음</em></span>
										                                				</c:when>																	
										                            					<c:when test="${list.status == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
										                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
										                                    			</c:when>
										                            					<c:when test="${list.status == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
										                            						<a href="#" class="btn-pk vs blue" id="btn_${list.indexSeq}" onclick="requestPopup('${s_instt_cd}','${list.indexSeq}','${list.checkItem}');"><span>요청</span></a>
										                                    			</c:when>
																						<c:when test="${list.status == 'RS04'}">
																							${list.requstDe}
																						</c:when>
																					</c:choose>																					
																				</div>																				
																			</div>
																		</div>
                            										</c:if>
																	
																	<!-- 파일이있을때 -->                            										                              							                                									                                									                                		
							                                		<c:if test="${list.fileId !='' }">
																		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																					<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																						<div>
																							<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																							<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																						</div>
                            										</c:if>                
															</c:when>
															<c:otherwise>
																<c:choose>
																<c:when test="${list.checkItem != checkItem}">
					                                			 <c:if test="${fileId !='' }">
                            											</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																		
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
		                                    							<div class="col state">
		                                    								<c:choose>
																					<c:when test="${reqStatus == ''}">
																						<span class="ico_state i_noreg"><em>미등록</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS03'}">
																						<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS04'}">
																						<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS05'}">
																						<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																					</c:when>
																				</c:choose>
		                                    							</div>
																		<div class="col btns">
																			<c:choose>
								                            					<c:when test="${reqStatus == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
								                            					<c:when test="${reqStatus == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
																				<c:when test="${reqStatus == 'RS04'}">
																					${requstDe}
																				</c:when>
																			</c:choose>
																		</div>
																	</div> <!-- tbls -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
																<script>
																	$(".log."+${indexSeq}).append(html); html = ''; 
																	$(".lst_log .log").each(function(){
																		if($(this).html() == '') $(this).prev().css("top", "14px");	
																	})
																</script>
		                										</c:if>
																
																<%-- <tr>
																	<th scope="row" class="ta-l">${list.mlsfc}</th>
																	<td colspan="3" class="pd0"> --%>
											                       	
											                       	<!-- 파일이없을때 -->
							                                	<%-- 	<c:if test="${list.fileId =='' }">
                            										</c:if> --%>
																	<!-- 파일이있을때 -->                           										                              							                                									                                									                                		
							                                		 <c:if test="${list.fileId !='' }">
																		<div class="lst_tblinner">
																			<div class="tbls">
																				<div class="col list">
																					<p class="h1">${list.checkItem}</p>
																					<div class="lst_answer chkAttachmentFile_${list.indexSeq}">
																						<div>
																							<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																							<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																						</div>
                            										</c:if> 
																                       							                                									                                									                                		
																</c:when>
																<c:otherwise>
	                                    							<div>
																		<input type="checkbox" id="${list.fileId}" name="chkAttachmentFile_<c:out value='${list.indexSeq}'/>" class="ickjs">
																		<label for="${list.fileId}"><span class="i-aft i_${list.fileExtsn} link"><a href="#"  onClick="javascript:fnAttachmentFileDown('${list.indexSeq}','${list.fileId }'); return false;" class="f_<c:out value='${list.fileExtsn}'/>">${list.fileName}</a></span></label>
																	</div>
                                                           		</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
				                                <c:set var="tmpLclas" value="${list.lclas}"/>
                                   				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
				                    			<c:set var="checkItem" value="${list.checkItem}"/>  
				                    			<c:set var="fileId" value="${list.fileId}"/>                                   				
				                    			<c:set var="atchmnflId" value="${list.atchmnflId}"/>                                   				
				                    			<c:set var="indexSeq" value="${list.indexSeq}"/>                                   				
				                    			<c:set var="excpPermYn" value="${list.excpPermYn}"/>                                   				
				                    			<c:set var="excpYn" value="${list.excpYn}"/>                                   				
				                    			<c:set var="reqStatus" value="${list.status}"/>                                   				
				                    			<c:set var="requstDe" value="${list.requstDe}"/>                                   				
				                    			<c:set var="fileExtsn" value="${list.fileExtsn}"/>                                   				
										<c:if test="${list.fileId !='' }">
					                                <script>
					                            	var fileInfo = new Object();
					                            	fileInfo.idx			= "<c:out value="${list.indexSeq}"/>";
					                            	fileInfo.atchmnflId		= "<c:out value="${list.atchmnflId}"/>";
					                            	fileInfo.fileId			= "<c:out value="${list.fileId}"/>";
					                            	fileInfo.fileName		= "<c:out value="${list.fileName}"/>";
					                            	fileInfo.saveFileName	= "<c:out value="${list.saveFileName}"/>";
					                            	fileInfo.filePath		= "<c:out value="${list.filePath}"/>";
					                            	fileInfo.mimeType		= "<c:out value="${list.mimeType}"/>";
					                            	fileInfo.isDeleted		= "false";
					                            	fileInfo.modifiedFileId	= "<c:out value="${list.fileId}"/>";
					                            	fileInfo.fileUrl	= "";											// 각 파일의 URL이 다르거나 SingleFileDownload일 때 사용됩니다.
					                            	attachmentFileArray.push( fileInfo );
					                            	
					                            	// 첨부파일 업로드시 변경 사유 메모/ 입력 날짜
					                            	fileInfo.memo			= "<c:out value="${list.memo}"/>";
					                            	fileInfo.memoRegistDt	= "<c:out value="${list.memoRegistDt}"/>";
					                            	
					                            	if(fileInfo.memo != ''){
					                            		html += '<p><span class="fileInfoP">['+ fileInfo.memoRegistDt +'] ' + fileInfo.fileName +' 업로드</span><span class="t_memo"> 메모 : ' + fileInfo.memo + '</span></p>';
					                            	}		
					                                </script>										
										</c:if>										
									</c:forEach>
												<c:if test="${fileId !='' }">
																		</div><!-- lst_answer -->
																			<div class="lst_all_chk">
																				<input type="checkbox" id="chkAttachmentFile_<c:out value='${indexSeq}'/>" class="ickjs" onClick="javascript:fnCheckAttachmentFile('${indexSeq}');">
																				<label for="chkAttachmentFile_<c:out value='${indexSeq}'/>">전체선택</label>
																		
																				<a href="#" class="btn-pk ss gray2 rv fl-r" onClick="javascript:fnAttachmentFileDown('${indexSeq}',''); return false;"><span>다운로드</span></a>
																			</div>
		                                    							</div><!-- col list -->
		                                    							
		                                    							<div class="col state">
		                                    								<c:choose>
																					<c:when test="${reqStatus == ''}">
																						<span class="ico_state i_noreg"><em>미등록</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS03'}">
																						<span class="ico_state i_reg_comp"><em>등록완료</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS04'}">
																						<span class="ico_state i_rereg"><em>재등록 요청</em></span>
																					</c:when>
																					<c:when test="${reqStatus == 'RS05'}">
																						<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
																					</c:when>
																				</c:choose>
		                                    							</div>
		                                    							
																		<div class="col btns">
																			<c:choose>
								                            					<c:when test="${reqStatus == 'RS03' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
								                            					<c:when test="${reqStatus == 'RS05' and requestZvl.orderNo eq currentOrderNo}">
								                            						<a href="#" class="btn-pk vs blue" id="btn_${indexSeq}" onclick="requestPopup('${s_instt_cd}','${indexSeq}','${checkItem}');"><span>요청</span></a>
								                                    			</c:when>
																				<c:when test="${reqStatus == 'RS04'}">
																					${requstDe}
																				</c:when>
																			</c:choose>
																		</div>
																	</div> <!-- tbls -->
																	<div class="lst_log">
																		<span>Log.</span>
																		<div class="log ${indexSeq}"></div>
																	</div>
																</div><!--// lst_tblinner -->
																</td>
                       										</tr>
                       										<script>
                       											$(".log."+${indexSeq}).append(html); html = ''; 
                       											$(".lst_log .log").each(function(){
																	if($(this).html() == '') $(this).prev().css("top", "14px");	
																})
                       										</script>
                            					</c:if>                                 							                                									                                									                                											
		                        </tbody>
		                    </table>
		                </div>
		            </c:when>
                    <c:otherwise>
                        <div class="box1 mt20">
		                    <p class="c_gray f17">등록된 지표가 없습니다.</p>
		                    <p class="mt20">※ <strong class="c_blue">지표등록</strong>을 관리자에게 문의해주세요.</p>
		                </div>
                    </c:otherwise>
                </c:choose>
                
	            <div class="mt10 ta-c">
	            	<a href="/mngLevelRes/mngLevelSummaryList.do" class="btn-pk n black" style="margin-top: 30px;">목록으로</a>
	            </div>
	                
				<div class="btn-bot2">
					<a href="#" onclick="fnAttachmentAllApplyFileDown(); return false;" class="btn-pk s gray rv"><span class="i-aft i_down">실적등록 전체 파일 다운로드</span></a>
				</div>                
                
        </div>
    </section>
    		<!--  파일 업로드에 사용 -->
			<input type="hidden" id="atchmnfl_id" name="atchmnfl_id" value="" > 
			<input type="hidden" id="indexSeq" name="indexSeq" value="" > 
			<input type="hidden" id="attachmentFileCallback" name="attachmentFileCallback" value="fnAttachmentFileCallback" > 
			<input type="hidden" id="uploadedFilesInfo" name="uploadedFilesInfo" value="[]" > 
			<input type="hidden" id="modifiedFilesInfo" name="modifiedFilesInfo" value="[]" > 
			<!--  파일 업로드에 사용 -->               
    
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
<!--  파일 다운로드에 사용 -->  


<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>
