<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
	$(window).ready(function(){
		
		// 차수 검색 옵션 선택 시
		$(".selectMenu>li>a").on('click',function(e){
			$("#orderNo").val($(this).attr('value'));
			goOrderSearch();
		});
		
	});
	
	function fn_goDtl(insttCd, insttNm) {
		
		$("#insttCd").val(insttCd);
		$("#insttNm").val(insttNm);
				
    	$("#resultSummaryForm").attr({
            action : "/statusExaminRst/statusExaminRstSummaryDtlList.do",
            method : "post"
        }).submit();
	}
	
	function goOrderSearch() {
		
    	$("#resultSummaryForm").attr({
            action : "/statusExaminRst/statusExaminRstSummaryList.do",
            method : "post"
        }).submit();
	}
</script>

<form action="/statusExaminRst/statusExaminRstSummaryList.do" method="post" id="resultSummaryForm" name="resultSummaryForm">
	
	<input name="orderNo" id="orderNo" type="hidden" value="${requestZvl.orderNo}"/>
	<input name="insttCd" id="insttCd" type="hidden" value=""/>
	<input name="insttNm" id="insttNm" type="hidden" value=""/>
	
<section id="container" class="sub">
    <!-- content -->
    <div class="container_inner">
        
        <div class="layer-header1 clearfix">
			<div class="col-lft">
        		<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.orderNo}</a></div>
					<ul class="selectMenu" >
	                    <c:forEach var="orderList" items="${orderList}"  varStatus="status" >
	                    	<li><a href="#"  value="${orderList.orderNo}">${orderList.orderNo}</a></li>
		                </c:forEach>
                	</ul>
               	</div>
        	</div>
        </div>
        
           	<c:choose>
				<c:when test="${!empty resultList}">
		           	<div class="wrap_table inr-c">
		                <table id="table-1" class="tbl table-bordered" summary="기관명, 점검수준, 점검완료 일시로 구성된 기관별 점검결과 리스트입니다.">
		                	<caption>점검결과 조회 리스트</caption>
		                    <colgroup>
		                        <col class="th1_1">
		                        <col>
		                        <col class="th1_5">
		                        <c:if test="${'A' ne evalType}">
		                        	<col class="th1_5">
		                        </c:if>
		                        <col class="th1_5">
		                    </colgroup>
		                    <thead>
		                        <tr>
			                        <th scope="col" id="th_a">구분</th>
									<th scope="col" id="th_b">기관명</th>
									<th scope="col" id="th_c">점검점수</th>
									<c:if test="${'A' ne evalType}">
										<th scope="col" id="th_d">점검수준</th>
									</c:if>
									<th scope="col" id="th_e">점검완료 일시</th>
		                        </tr>
		                    </thead>
		                    <tbody>
								<c:set var="tmpInsttCd" value=""/>
								<c:forEach var="list" items="${resultList}" varStatus="status">
			                    	<c:choose>
										<c:when test="${status.first}">
					                        <tr>
					                            <th rowspan="${list.insttClCnt}" scope="rowgroup" id="a_a">${list.insttClNm}</th>
					                            <th class="th_st1 ta-c"><a href="#" onclick="javascript:fn_goDtl('${list.insttCd}', '${list.insttNm}'); return false;" title="상세보기" class="link1">${list.insttNm}</a></th>
					                            <td>${list.totResultScore2}</td>
					                            <c:choose>
					                            	<c:when test="${!empty list.totResultScore2}">
							                            <c:if test="${'A' ne evalType}">
							                            	<c:set var="breakCnt" value="0"/>
							                            	<c:forEach var="scoreList" items="${sctnScoreList}" varStatus="status1">
								                            	<fmt:parseNumber value="${scoreList.sctnScore}" var="score"/>
					                                			<fmt:parseNumber value="${list.totResultScore2}" var="resultScore"/>
					                                			<c:if test="${score < resultScore and breakCnt eq '0'}">
							                            			<td>${scoreList.sctnNm}</td>
							                            			<c:set var="breakCnt" value="1"/>
							                            		</c:if>
							                            		<c:if test="${status1.last and breakCnt eq '0'}">
					                                				<td>${scoreList.sctnNm}</td>
					                                			</c:if>
							                            	</c:forEach>
														</c:if>
													</c:when>
													<c:otherwise>
														<c:if test="${'A' ne evalType}">
															<td></td>
														</c:if>
													</c:otherwise>
												</c:choose>
												<td>${list.evalDt}</td>
					                        </tr>
										</c:when>
										<c:otherwise>
											<tr>
												<c:if test="${list.insttClCd ne tmpInsttCd}">
													<th rowspan="${list.insttClCnt}" scope="rowgroup">${list.insttClNm}</th>
												</c:if>
												<th class="th_st1 ta-c"><a href="#" onclick="javascript:fn_goDtl('${list.insttCd}', '${list.insttNm}'); return false;" title="상세보기" class="link1">${list.insttNm}</a></th>
					                            <td>${list.totResultScore2}</td>
												<c:choose>
					                            	<c:when test="${!empty list.totResultScore2}">
							                            <c:if test="${'A' ne evalType}">
							                            	<c:set var="breakCnt" value="0"/>
							                            	<c:forEach var="scoreList" items="${sctnScoreList}" varStatus="status1">
							                            		<fmt:parseNumber value="${scoreList.sctnScore}" var="score"/>
					                                			<fmt:parseNumber value="${list.totResultScore2}" var="resultScore"/>
					                                			<c:if test="${score < resultScore and breakCnt eq '0'}">
							                            			<td>${scoreList.sctnNm}</td>
							                            			<c:set var="breakCnt" value="1"/>
							                            		</c:if>
							                            		<c:if test="${status1.last and breakCnt eq '0'}">
					                                				<td>${scoreList.sctnNm}</td>
					                                			</c:if>
							                            	</c:forEach>
														</c:if>
													</c:when>
													<c:otherwise>
														<c:if test="${'A' ne evalType}">
															<td></td>
														</c:if>
													</c:otherwise>
												</c:choose>
												<td>${list.evalDt}</td>
					                    	</tr>
										</c:otherwise>
									</c:choose>
									<c:set var="tmpInsttCd" value="${list.insttClCd}"/>
								</c:forEach>
		                    </tbody>
		                </table>
		            </div>
		    	</c:when>
		    	<c:otherwise>
		    		<div class="box1 mt20">
		                <p class="c_gray f17">점검결과가 없습니다.</p>
		            </div>
		    	</c:otherwise>
		    </c:choose>
		   
    </div>
</section>
    <!-- /content -->
</form>