<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

$(window).ready(function(){
	
	// 검색 옵션 선택 시
	$(document).on("click",".selectMenu>li>a",function(){
		$("#orderNo").val(this.dataset.yyyy);
		goOrderSearch();
	});
	
});

function fn_goList() {
   	$("#resultSummaryForm").attr({
           action : "/statusExaminRst/statusExaminRstSummaryList.do",
           method : "post"
       }).submit();
}

function detailIndex(indexSeq){		

	$("#indexSeq").val(indexSeq);
   	$("#resultSummaryForm").attr({
           action : "/statusExaminRst/statusExaminRstDtl.do",
           method : "post"
       }).submit();
}

function fn_print() {
	
	// WRITE 권한 체크
	if(authCheckWrite() == false) return false;
	
	if (confirm("관리수준 현황조사 결과를 다운로드 하시겠습니까?")) {
		
    	$("#resultSummaryForm").attr({
            action : "/statusExaminRst/statusExaminRstExcelDown.do",
            method : "post"
        }).submit();
	}
}

function goOrderSearch() {
	
   	$("#resultSummaryForm").attr({
           action : "/statusExaminRst/statusExaminRstSummaryDtlList.do",
           method : "post"
       }).submit();
}

function fnAttachmentFinFileDown() {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;

	var chkAttachmentFile = '';

	<c:forEach var="i" items="${resultFile}" varStatus="status">
	
		var fileInfo = new Object();
		fileInfo.fileId		= '${i.fileId}';
		fileInfo.fileName	= '${i.fileId}';
		fileInfo.fileSize	= "0";
		fileInfo.fileUrl	= "";
		
		chkAttachmentFile += JSON.stringify( fileInfo );
		
	</c:forEach>	
	
	if(chkAttachmentFile == ''){
		alert("등록된 현황조사 결과보고서가 없습니다.");
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

<form action="/statusExaminRst/statusExaminRstSummaryDtlList.do" method="post" id="resultSummaryForm" name="resultSummaryForm">
	<input name="orderNo" id="orderNo" type="hidden" value="${requestZvl.orderNo}"/>
	<input name="insttCd" id="insttCd" type="hidden" value="${requestZvl.insttCd}"/>
	<input name="insttNm" id="insttNm" type="hidden" value="${requestZvl.insttNm}"/>
	<input name="indexSeq" id="indexSeq" type="hidden" value=""/>
	
    <!-- content -->
	<section id="container" class="sub">
       <div class="container_inner">
       
			<div class="layer-header1 mb-3c clearfix">
				<div class="col-lft">
		            <h1 class="title2">${requestZvl.orderNo }년 ${requestZvl.insttNm } <span class="fc_blue">점검결과</span></h1>
				</div>
		        <c:if test="${'5' ne sessionScope.userInfo.authorId}">
					<div class="col-rgh">
						<div class="box-select-ty1 type1">
								<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.orderNo}</a></div>
							<ul class="selectMenu">
			                    <c:forEach var="orderList" items="${orderList}"  varStatus="status" >
			                    	<li><a href="#" data-yyyy="${orderList.orderNo}">${orderList.orderNo}</a></li>
				                </c:forEach>
		                	</ul>
                		</div>
                	</div>
                </c:if>
			</div>
			<c:if test="${!empty result.gnrlzEvl2 and evalYn.sttusExaminYn eq 'Y'}">
				<div class="layer-header1 clearfix mb0" style="margin-top: 40px;">
					<div class="col-lft">
						<h1 class="title4">종합평가</h1>
					</div>
					<div class="col-rgh">
						<a href="#" class="btn-pk l blue" onclick="fnAttachmentFinFileDown(); return false;"><span>현황조사 결과 보고서</span></span></a>
					</div>
	            </div>
				<div class="box-gray mb-c1">
					<p>${result.gnrlzEvl2}</p>
				</div>
            </c:if>
           	
			
           		<c:if test="${!empty result.gnrlzEvl2 and evalYn.sttusExaminYn eq 'Y'}">
	                <h1 class="title4">분야별 결과<c:if test="${!empty result.evalUserNm and sessionScope.userInfo.authorId ne '2' }"><span class="appraiser">담당자 : ${result.evalUserNm} [${result.evalDt}]</span></c:if></h1>
	                <ul class="list01 mt10">
	                    <!-- <li>각 <strong class="c_orange">점검지표를 클릭</strong>하시면 상세정보를 확인하실 수 있습니다.</li> -->
	                </ul>
                </c:if>
           	
	           	<c:choose>
					<c:when test="${!empty result.gnrlzEvl2 and evalYn.sttusExaminYn eq 'Y'}">
	                	<c:set var="rowCnt" value="0"/>
		                    <table class="wrap_table2" summary="대분류, 중분류, 소분류, 점검지표, 점검결과-환산점수, 점검수준으로 구성된 분야별 결과 리스트입니다.">
		                        <caption>분야별 결과 리스트</caption>
		                        <colgroup>
		                            <col style="width:10%">
			                        <col style="width:17%">
			                        <col style="width:*">
	                        		<c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
	                        			<c:forEach var="list" items="${scoreSeList}" varStatus="status">
	                        				<c:set var="rowCnt" value="${rowCnt + 1}"/>
				                        	<col style="width:50px">
				                        </c:forEach>
				                        <col style="width:10%">
				                    </c:if>
				                    <col style="width:10%">
		                        </colgroup>
		                        <thead>
		                            <tr>
			                            <th rowspan="2" scope="col">대분류</th>
			                            <th rowspan="2" scope="col">중분류</th>
			                            <th rowspan="2" scope="col">점검지표</th>
		                            	<c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
		                            		<th colspan="${rowCnt}" scope="colgroup">점검결과</th>
		                            		<th rowspan="2" scope="col">환산점수</th>
		                            	</c:if>
		                            	<th rowspan="2" scope="col">점검수준</th>
			                        </tr>
			                        <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
			                        	<tr>
			                        		<c:forEach var="list" items="${scoreSeList}" varStatus="status">
			                        			<th scope="col">${list.scoreSeNm}</th>
				                        	</c:forEach>
			                        	</tr>
			                        </c:if>
		                        </thead>
		                        <tbody>
		                        	<c:set var="tmpLclas" value=""/>
                                    <c:set var="tmpMlsfc" value=""/>
                                    <c:set var="tmpSclas" value=""/>
                                    <c:forEach var="list" items="${resultList}" varStatus="status">
                                    	<c:choose>
											<c:when test="${status.first}">
												<tr>
					                                <th rowspan="${list.lclasCnt}" scope="rowgroup">${list.lclas}</th>
					                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
					                                <td class="ta-l bg_orange"><a href="#" onclick="detailIndex('${list.indexSeq}');" class="link1"><span>${list.checkItem}</span></a></td>
					                                <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
					                                	<c:forEach var="scoreSeList" items="${scoreSeList}">
					                                		<c:set var="scoreCnt" value="0"/>
					                                		<c:forEach var="resultDtlList" items="${resultDtlList}">
					                                			<c:if test="${list.indexSeq eq resultDtlList.indexSeq and scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
					                                				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
					                                			</c:if>
					                                		</c:forEach>
					                                		<td class="tc">${scoreCnt}</td>
					                                	</c:forEach>
					                                	<td class="tc result">${list.resultScore2}</td>
					                                </c:if>
					                                <c:choose>
					                                	<c:when test="${'A' eq evalType}">
					                                		<td class="tc result">${list.resultScore2}</td>
					                                	</c:when>
					                                	<c:otherwise>
					                                		<c:choose>
					                                			<c:when test="${!empty list.resultScore2}">
							                                		<c:set var="scoreScoreCnt" value="0"/>
							                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
							                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
							                                			<fmt:parseNumber value="${list.resultScore2}" var="resultScore"/>
							                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
							                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
							                                				<c:set var="scoreScoreCnt" value="1"/>
							                                			</c:if>
							                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
							                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
							                                			</c:if>
							                                		</c:forEach>
							                                	</c:when>
							                                	<c:otherwise>
							                                		<td class="tc result">-</td>
							                                	</c:otherwise>
							                                </c:choose>
					                                	</c:otherwise>
					                                </c:choose>
					                                <c:set var="tmpLclas" value="${list.lclas}"/>
                                    				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
                                    				<c:set var="tmpSclas" value="${list.sclas}"/>
				                            	</tr>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${list.lclas != tmpLclas}">
														<tr>
							                                <th rowspan="${list.lclasCnt}" scope="rowgroup">${list.lclas}</th>
							                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
							                                <td class="ta-l bg_orange"><a href="#" onclick="detailIndex('${list.indexSeq}');" class="link1"><span>${list.checkItem}</span></a></td>
							                                <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
							                                	<c:forEach var="scoreSeList" items="${scoreSeList}">
							                                		<c:set var="scoreCnt" value="0"/>
							                                		<c:forEach var="resultDtlList" items="${resultDtlList}">
							                                			<c:if test="${list.indexSeq eq resultDtlList.indexSeq and scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
							                                				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
							                                			</c:if>
							                                		</c:forEach>
							                                		<td class="tc">${scoreCnt}</td>
							                                	</c:forEach>
							                                	<td class="tc result">${list.resultScore2}</td>
							                                </c:if>
							                                <c:choose>
							                                	<c:when test="${'A' eq evalType}">
							                                		<td class="tc result">${list.resultScore2}</td>
							                                	</c:when>
							                                	<c:otherwise>
							                                		<c:choose>
							                                			<c:when test="${!empty list.resultScore2}">
									                                		<c:set var="scoreScoreCnt" value="0"/>
									                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
									                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
									                                			<fmt:parseNumber value="${list.resultScore2}" var="resultScore"/>
									                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
									                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
									                                				<c:set var="scoreScoreCnt" value="1"/>
									                                			</c:if>
									                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
									                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
									                                			</c:if>
									                                		</c:forEach>
									                                	</c:when>
									                                	<c:otherwise>
									                                		<td class="tc result">-</td>
									                                	</c:otherwise>
									                                </c:choose>
							                                	</c:otherwise>
							                                </c:choose>
						                            	</tr>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${list.mlsfc != tmpMlsfc}">
																<tr>
									                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
									                                <td class="ta-l bg_orange"><a href="#" onclick="detailIndex('${list.indexSeq}');" class="link1"><span>${list.checkItem}</span></a></td>
																	<c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
									                                	<c:forEach var="scoreSeList" items="${scoreSeList}">
									                                		<c:set var="scoreCnt" value="0"/>
									                                		<c:forEach var="resultDtlList" items="${resultDtlList}">
									                                			<c:if test="${list.indexSeq eq resultDtlList.indexSeq and scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
									                                				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
									                                			</c:if>
									                                		</c:forEach>
									                                		<td class="tc">${scoreCnt}</td>
									                                	</c:forEach>
									                                	<td class="tc result">${list.resultScore2}</td>
									                                </c:if>
									                                <c:choose>
									                                	<c:when test="${'A' eq evalType}">
									                                		<td class="tc result">${list.resultScore2}</td>
									                                	</c:when>
									                                	<c:otherwise>
									                                		<c:choose>
									                                			<c:when test="${!empty list.resultScore2}">
											                                		<c:set var="scoreScoreCnt" value="0"/>
											                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
											                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
											                                			<fmt:parseNumber value="${list.resultScore2}" var="resultScore"/>
											                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
											                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
											                                				<c:set var="scoreScoreCnt" value="1"/>
											                                			</c:if>
											                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
											                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
											                                			</c:if>
											                                		</c:forEach>
											                                	</c:when>
											                                	<c:otherwise>
											                                		<td class="tc result">-</td>
											                                	</c:otherwise>
											                                </c:choose>
									                                	</c:otherwise>
									                                </c:choose>
								                            	</tr>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${list.sclas != tmpSclas}">
																		<tr>
																			<td rowspan="${list.sclasCnt}">${list.sclas}</td>
									                                		<td class="ta-l bg_orange"><a href="#" class="link1" onclick="detailIndex('${list.indexSeq}');"><span>${list.checkItem}</span></a></td>
									                                		<c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
											                                	<c:forEach var="scoreSeList" items="${scoreSeList}">
											                                		<c:set var="scoreCnt" value="0"/>
											                                		<c:forEach var="resultDtlList" items="${resultDtlList}">
											                                			<c:if test="${list.indexSeq eq resultDtlList.indexSeq and scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
											                                				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
											                                			</c:if>
											                                		</c:forEach>
											                                		<td class="tc">${scoreCnt}</td>
											                                	</c:forEach>
											                                	<td class="tc result">${list.resultScore2}</td>
											                                </c:if>
											                                <c:choose>
											                                	<c:when test="${'A' eq evalType}">
											                                		<td class="tc result">${list.resultScore2}</td>
											                                	</c:when>
											                                	<c:otherwise>
											                                		<c:choose>
											                                			<c:when test="${!empty list.resultScore2}">
													                                		<c:set var="scoreScoreCnt" value="0"/>
													                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
													                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
													                                			<fmt:parseNumber value="${list.resultScore2}" var="resultScore"/>
													                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
													                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
													                                				<c:set var="scoreScoreCnt" value="1"/>
													                                			</c:if>
													                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
													                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
													                                			</c:if>
													                                		</c:forEach>
													                                	</c:when>
													                                	<c:otherwise>
													                                		<td class="tc result">-</td>
													                                	</c:otherwise>
													                                </c:choose>
											                                	</c:otherwise>
											                                </c:choose>
								                            			</tr>
								                            		</c:when>
								                            		<c:otherwise>
								                            			<tr>
									                                		<td class="ta-l bg_orange"><a href="#" class="link1" onclick="detailIndex('${list.indexSeq}');"><span>${list.checkItem}</span></a></td>
									                                		<c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
											                                	<c:forEach var="scoreSeList" items="${scoreSeList}">
											                                		<c:set var="scoreCnt" value="0"/>
											                                		<c:forEach var="resultDtlList" items="${resultDtlList}">
											                                			<c:if test="${list.indexSeq eq resultDtlList.indexSeq and scoreSeList.scoreSeNm eq resultDtlList.resultScore2}">
											                                				<c:set var="scoreCnt" value="${scoreCnt + 1}"/>
											                                			</c:if>
											                                		</c:forEach>
											                                		<td class="tc">${scoreCnt}</td>
											                                	</c:forEach>
											                                	<td class="tc result">${list.resultScore2}</td>
											                                </c:if>
											                                <c:choose>
											                                	<c:when test="${'A' eq evalType}">
											                                		<td class="tc result">${list.resultScore2}</td>
											                                	</c:when>
											                                	<c:otherwise>
											                                		<c:choose>
											                                			<c:when test="${!empty list.resultScore2}">
													                                		<c:set var="scoreScoreCnt" value="0"/>
													                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
												                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
												                                			<fmt:parseNumber value="${list.resultScore2}" var="resultScore"/>
												                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
													                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
													                                				<c:set var="scoreScoreCnt" value="1"/>
													                                			</c:if>
													                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
													                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
													                                			</c:if>
													                                		</c:forEach>
													                                	</c:when>
													                                	<c:otherwise>
													                                		<td class="tc result">-</td>
													                                	</c:otherwise>
													                                </c:choose>
											                                	</c:otherwise>
											                                </c:choose>
								                            			</tr>
								                            		</c:otherwise>
								                            	</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
				                                <c:set var="tmpLclas" value="${list.lclas}"/>
                                   				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
                                    			<c:set var="tmpSclas" value="${list.sclas}"/>
											</c:otherwise>
										</c:choose>
									</c:forEach>
		                        </tbody>
		                        <tfoot class="total">
			                        <tr>
			                            <td colspan="3">종합수준</td>
			                            <c:if test="${'A' ne evalType and '2' ne sessionScope.userInfo.authorId}">
			                            	<c:forEach var="scoreSeList" items="${scoreSeList}" varStatus="status">
			                            		<c:set var="sum" value="0"/>
			                            		<c:forEach var="resultDtlSum" items="${resultDtlSum}" varStatus="status">
													<c:if test="${scoreSeList.scoreSeNm eq resultDtlSum.resultScore2}">
														<c:set var="sum" value="${resultDtlSum.sumCnt}"/>
													</c:if>
			                        			</c:forEach>
												<td>${sum}</td>
				                        	</c:forEach>
				                        	<td>${result.totResultScore2}</td>
			                            </c:if>
			                            <c:choose>
		                                	<c:when test="${'A' eq evalType}">
		                                		<td>${result.totResultScore2}</td>
		                                	</c:when>
		                                	<c:otherwise>
		                                		<c:choose>
		                                			<c:when test="${!empty result.totResultScore2}">
				                                		<c:set var="scoreScoreCnt" value="0"/>
				                                		<c:forEach var="sctnScoreList" items="${sctnScoreList}" varStatus="status1">
				                                			<fmt:parseNumber value="${sctnScoreList.sctnScore}" var="score"/>
				                                			<fmt:parseNumber value="${result.totResultScore2}" var="resultScore"/>
				                                			<c:if test="${score < resultScore and scoreScoreCnt eq '0'}">
				                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
				                                				<c:set var="scoreScoreCnt" value="1"/>
				                                			</c:if>
				                                			<c:if test="${status1.last and scoreScoreCnt eq '0'}">
				                                				<td class="tc result">${sctnScoreList.sctnNm}</td>
				                                			</c:if>
				                                		</c:forEach>
				                                	</c:when>
				                                	<c:otherwise>
				                                		<td></td>
				                                	</c:otherwise>
				                                </c:choose>
		                                	</c:otherwise>
		                                </c:choose>
			                        </tr>
			                    </tfoot>
		                    </table>
		                <div class="btn-bot2 ta-c">
		                	<c:if test="${sessionScope.userInfo.authorId ne '2' }">
		                		<a href="#" onclick="fn_goList(); return false;" class="btn-pk n black">목록</a>
		                	</c:if>
			                <a href="#" class="btn-pk n purple rv" onclick="fn_print();">출력</a>
			            </div>
	           		</c:when>
	               	<c:otherwise>
	              		<div class="bbs-blank  pr-mb1">
	                  		<p class="txt">수준진단 현황조사 결과가 없습니다.</p>
	              		</div>
	              		<div class="btn-bot2 ta-c">
		                	<c:if test="${sessionScope.userInfo.authorId ne '2' }">
		                		<a href="#" onclick="fn_goList(); return false;" class="btn-pk n rv blue bt1 gray">목록</a>
		                	</c:if>
			            </div>
	               	</c:otherwise>
				</c:choose>
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
<!--  파일 다운로드에 사용 -->  