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

function goOrderSearch() {
	
   	$("#resultSummaryForm").attr({
           action : "/mngLevelRst/mngLevelRstSummaryDtlList.do",
           method : "post"
       }).submit();
}

function fn_goList() {
   	$("#resultSummaryForm").attr({
           action : "/mngLevelRst/mngLevelRstSummaryList.do",
           method : "post"
       }).submit();
}

function detailIndex(indexSeq){		

	$("#indexSeq").val(indexSeq);
   	$("#resultSummaryForm").attr({
           action : "/mngLevelRst/mngLevelRstDtl.do",
           method : "post"
       }).submit();
}

function fn_print(e) {
	
	e.preventDefault();
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
	if (confirm("진단결과를 다운로드 하시겠습니까?")) {
		
    	$("#resultSummaryForm").attr({
            action : "/mngLevelRst/mngLevelRstExcelDown.do",
            method : "post"
        }).submit();
	}
}
</script>

<form action="/mngLevelRst/mngLevelRstSummaryDtlList.do" method="post"
	id="resultSummaryForm" name="resultSummaryForm"
	enctype="multipart/form-data">
	<input name="orderNo" id="orderNo" type="hidden"
		value="${requestZvl.orderNo}" /> <input name="insttCd" id="insttCd"
		type="hidden" value="${requestZvl.insttCd}" /> <input name="insttNm"
		id="insttNm" type="hidden" value="${requestZvl.insttNm}" /> <input
		name="indexSeq" id="indexSeq" type="hidden" value="" />

	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">

			<div class="layer-header1 mb-3c clearfix">
				<div class="col-lft">
					<h1 class="title2">${requestZvl.orderNo }년
						${requestZvl.insttNm } <span class="fc_blue">수준진단 결과</span>
					</h1>
				</div>
				<div class="col-rgh">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0">
							<a href="#this" tabindex="-1">${requestZvl.orderNo}</a>
						</div>
						<ul class="selectMenu">
							<c:forEach var="orderList" items="${orderList}"
								varStatus="status">
								<li><a href="#" data-yyyy="${orderList.orderNo}">${orderList.orderNo}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>

			<c:if test="${!empty result.gnrlzEvl2 and evalYn.mngLevelYn eq 'Y'}"> 
          		<h1 class="title4">종합평가</h1>
				<div class="box-gray mb-c1">
					<p>${result.gnrlzEvl2}</p>
				</div>
			</c:if>
			
			<c:if test="${!empty result.gnrlzEvl2 and evalYn.mngLevelYn eq 'Y'}">
				<h1 class="title4">분야별 평가 <c:if test="${!empty mngLevelInsttTotalEvl.evalUserNm }"><span class="appraiser">담당자 : ${mngLevelInsttTotalEvl.evalUserNm} [${mngLevelInsttTotalEvl.evalDt}]</span></c:if></h1>
            </c:if>			
			
<%-- 

			<c:choose>
				<c:when test="${!empty result.gnrlzEvl2 and evalYn.mngLevelYn eq 'Y'}"> --%>
				
						<div class="layer-header1 clearfix">
							<div class="col-rgh ">
								<span class="ico_state i_none"><em>해당없음</em></span> 
								<span class="ico_state i_obj"><em>이의신청</em></span>
							</div>
						</div>
							
		                <div class="wrap_table2">
						<table id="table-1" class="tbl"
							summary="분야, 진단지표, 진단항목, 이의신청, 평가점수, 환산점수로 구성된 분야별 결과 리스트입니다.">
							<caption>분야별 결과 리스트</caption>
							<colgroup>
								<col class="th1_1">
								<col class="th1_2">
								<col>
								<col class="th1_5">
								<col class="th1_4">
								<col class="th1_4">
							</colgroup>
							<thead class="bd">
								<tr>
									<th rowspan="2" scope="col" id="th_a">분야</th>
									<th rowspan="2" scope="col" id="th_b">진단지표</th>
									<th rowspan="2" scope="col" id="th_c">진단항목</th>
									<th rowspan="2" scope="col" id="th_d">이의신청</th>
									<th colspan="2" scope="col" id="th_e">평가결과</th>
								</tr>
								<tr>
									<th scope="col" id="th_e">평가점수</th>
									<th scope="col" id="th_f">환산점수</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="tmpLclas" value="" />
								<c:set var="tmpMlsfc" value="" />
								<c:forEach var="list" items="${resultList}" varStatus="status">
									<c:choose>
										<c:when test="${status.first}">
											<tr>
												<th scope="col" class="bdl0" rowspan="${list.lclasCnt}"
													scope="rowgroup">${list.lclas}</th>
												<td scope="row" class="ta-l" rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
												<td headers="" class="ta-l bg_orange"><a href="#"
													class="link1" onclick="detailIndex('${list.indexSeq}');">${list.checkItem}</a></td>
												<c:choose>
													<c:when test="${empty list.fobjctResn}">
														<td headers=""><span class="ico_state i_none"><em>해당없음</em></span></td>
													</c:when>
													<c:otherwise>
														<td headers=""><span class="ico_state i_obj"><em>이의신청</em></span></td>
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${empty list.resultTotPer2}">
														<td headers="" rowspan="${list.mlsfcCnt}">-</td>
														<td headers="" rowspan="${list.mlsfcCnt}">-</td>
													</c:when>
													<c:otherwise>
														<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotPer2}</td>
														<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotScore2}</td>
													</c:otherwise>
												</c:choose>
											</tr>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${list.lclas != tmpLclas}">
													<tr>
														<th scope="col" class="bdl0" rowspan="${list.lclasCnt}"
															scope="rowgroup">${list.lclas}</th>
														<td scope="row" class="ta-l" rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
														<td headers="" class="ta-l bg_orange"><a href="#"
															class="link1" onclick="detailIndex('${list.indexSeq}');">${list.checkItem}</a></td>
														<c:choose>
															<c:when test="${empty list.fobjctResn}">
																<td headers=""><span class="ico_state i_none"><em>해당없음</em></span></td>
															</c:when>
															<c:otherwise>
																<td headers=""><span class="ico_state i_obj"><em>이의신청</em></span></td>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${empty list.resultTotPer2}">
																<td headers="" rowspan="${list.mlsfcCnt}">-</td>
																<td headers="" rowspan="${list.mlsfcCnt}">-</td>
															</c:when>
															<c:otherwise>
																<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotPer2}</td>
																<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotScore2}</td>
															</c:otherwise>
														</c:choose>
													</tr>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${list.mlsfc != tmpMlsfc}">
															<tr>
																<td scope="row" class="ta-l" rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
																<td headers="" class="ta-l bg_orange"><a href="#"
																	class="link1"
																	onclick="detailIndex('${list.indexSeq}');">${list.checkItem}</a></td>
																<c:choose>
																	<c:when test="${empty list.fobjctResn}">
																		<td headers=""><span class="ico_state i_none"><em>해당없음</em></span></td>
																	</c:when>
																	<c:otherwise>
																		<td headers=""><span class="ico_state i_obj"><em>이의신청</em></span></td>
																	</c:otherwise>
																</c:choose>
																<c:choose>
																	<c:when test="${empty list.resultTotPer2}">
																		<td headers="" rowspan="${list.mlsfcCnt}">-</td>
																		<td headers="" rowspan="${list.mlsfcCnt}">-</td>
																	</c:when>
																	<c:otherwise>
																		<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotPer2}</td>
																		<td headers="" rowspan="${list.mlsfcCnt}">${list.resultTotScore2}</td>
																	</c:otherwise>
																</c:choose>
															</tr>
														</c:when>
														<c:otherwise>
															<tr>
																<td headers="" class="ta-l bg_orange"><a href="#"
																	class="link1"
																	onclick="detailIndex('${list.indexSeq}');">${list.checkItem}</a></td>
																<c:choose>
																	<c:when test="${empty list.fobjctResn}">
																		<td headers=""><span class="ico_state i_none"><em>해당없음</em></span></td>
																	</c:when>
																	<c:otherwise>
																		<td headers=""><span class="ico_state i_obj"><em>이의신청</em></span></td>
																	</c:otherwise>
																</c:choose>
															</tr>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
									<c:set var="tmpLclas" value="${list.lclas}" />
									<c:set var="tmpMlsfc" value="${list.mlsfc}" />
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="5" class="ta-c">총점</td>
									<td>${result.totResultScore2}</td>
								</tr>
							</tfoot>
						</table>
					</div>
					<div class="btn-bot2 ta-c" style="margin-top: 30px;">
						<c:if test="${sessionScope.userInfo.authorId ne '2' }">
							<a href="#" onclick="fn_goList(); return false;"
								class="btn-pk n black">목록으로</a>
						</c:if>
						<a href="#" class="btn-pk n purple rv" onclick="fn_print(event);">출력</a>
					</div>
				<%-- </c:when>
				<c:otherwise>
					<div class="bbs-blank  pr-mb1">
						<p class="txt">관리수준 진단 결과가 없습니다.</p>
					</div>
					<div class="btn-bot2 ta-c">
						<c:if test="${sessionScope.userInfo.authorId ne '2' }">
							<a href="#" onclick="fn_goList(); return false;"
								class="btn-pk n rv blue bt1 gray">목록</a>
						</c:if>
					</div>
				</c:otherwise>
			</c:choose> --%>
		</div>
	</section>
	<!-- /content -->
</form>