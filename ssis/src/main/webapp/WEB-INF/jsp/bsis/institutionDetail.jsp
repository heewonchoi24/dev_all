<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
input[type='text'].inp_txt, input[type='password'].inp_txt, input[type='text']:disabled
	{
	line-height: 0;
}
</style>
<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

$(document).ready(function(){
	$(".selectMenu>li>a").on('click',function(e){
		$("#orderNo").val($(this).attr('value'));
		
		$("#form").attr({
	        action : "/bsis/institutionDetail.do",
	        method : "post"
	    }).submit();		
	});	
});

var rowCnt1 = 1;
var rowCnt2 = 1;
var rowCnt3 = 1;
var rowCnt4 = 1;
<c:if test="${!empty resultList}">
	rowCnt1 = "${fn:length(resultList)}";
</c:if>	
<c:if test="${!empty resultList2}">
	rowCnt2 = "${fn:length(resultList2)}";
</c:if>
<c:if test="${!empty resultList3}">
	rowCnt3 = "${fn:length(resultList3)}";
</c:if>
<c:if test="${!empty resultList4}">
	rowCnt4 = "${fn:length(resultList4)}";
</c:if>

$(window).ready(function(){
	fn_numberInit();
	
	$("#searchInsttClCd").change(function(){
		changeInsttList(this.value);
	});
	$(".btn-pk.vs.rv.blue").click(function(){
		fn_numberInit();	
	})
});

function changeInsttList(searchInsttClCd){
	
	pUrl = "/pinn/selectBoxInsttList.do";
	pParam = {};
	pParam.searchInsttClCd = searchInsttClCd;

	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		var str = '<option value="">기관명 전체</option>';
		for(var i in data.orgBoxList){
			str += '<option value=' + data.orgBoxList[i].insttCd + '>' + data.orgBoxList[i].insttNm + '</option>'; 	
		}
		$("#searchInsttCd").html(str);
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
}

function goOrderSearch() {
	
   	$("#form").attr({
           action : "/bsis/privacySttus.do",
           method : "post"
       }).submit();
}

</script>

<form action="/bsis/institutionDetail.do" method="post" id="form"
	name="form">
	<input type="hidden" id="insttCd" name="insttCd" value="${requestZvl.insttCd}" /> 
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.orderNo}" />
	<input type="hidden" id="searchInsttNm" name="searchInsttNm" value="${requestZvl.searchInsttNm}" /> 
		

	<!-- container_main -->
	<section id="container" class="sub">
		<div class="container_inner">

			<div class="layer-header1 clearfix pr-pb0">
				<div class="col-lft">
					<h1 class="title2">${requestZvl.searchInsttNm}
						<span class="fc_blue">기초현황</span>
					</h1>
				</div>
			</div>

			<div class="layer-header1 clearfix pr-pb0">
				<div class="col-lft">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0">
							<a href="#this" tabindex="-1">${requestZvl.orderNo}</a>
						</div>
						<ul class="selectMenu">
							<c:forEach var="orderList" items="${orderList}"
								varStatus="status">
								<li><a href="#" value="${orderList.orderNo}">${orderList.orderNo}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>

			<section class="area_tit1 inr-c">
				<header class="tit">
					<h2 class="h1">기관개요</h2>
				</header>
				<div class="cont">
					<div class="wrap_table3">
						<table id="table-1" class="tbl">
							<caption>기초현황 기관개요 정보</caption>
							<colgroup>
								<col class="th1_1">
								<col>
							</colgroup>
							<tbody>
								<%-- <tr>
									<th scope="col" id="th_a1">기관명</th>
									<td headers="th_a1"><c:choose>
											<c:when
												test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}"> --%>
								<input type="hidden" id="insttNm" name="insttNm"
									class="inp_txt w100p" value="${requestZvl.searchInsttNm}"
									maxLength="50">
								<%-- </c:when>
											<c:otherwise>									
													${result.insttNm}
												</c:otherwise>
										</c:choose></td>
								</tr> --%>
								<tr>
									<th scope="col" id="th_b1">임직원수</th>
									<c:choose>
										<c:when
											test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
											<td headers="th_b1"><input type="text" id="empCo"
												name="empCo" value="${result.empCo}" maxLength="11"
												class="inp_txt onlyNumber">&nbsp; 명</td>
										</c:when>
										<c:otherwise>
											<c:if test="${!empty result.empCo}">
												<td headers="th_b1">${result.empCo}명</td>
											</c:if>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
									<th scope="col" id="th_c1">주소</th>
									<td headers="th_c1"><c:choose>
											<c:when
												test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
												<input type="text" id="addr" name="addr"
													value="${result.addr}" class="inp_txt w100p"
													maxLength="100">
											</c:when>
											<c:otherwise>
			                               			${result.addr}
			                               		</c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<th scope="col" id="th_d1">사업내용</th>
									<td headers="th_d1"><c:choose>
											<c:when
												test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
												<textarea id="bsnsContents" name="bsnsContents"
													style="margin: 0px; height: 100px; width: 1203px;"
													title="내용을 입력하세요." maxLength="1000">${result.bsnsContents}</textarea>
											</c:when>
											<c:otherwise>
			                                		${result.bsnsContents}
			                                	</c:otherwise>
										</c:choose></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</section>

			<section class="area_tit1 inr-c">
				<div class="layer-header1 clearfix">
					<div class="col-lft">
						<h2 class="title4 mb0">담당자</h2>
					</div>

					<c:if
						test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
						<div class="col-rgh mt0">
							<a href="#link" onclick="addHtml1(event);"
								class="btn-pk vs rv blue"><span>추가</span></a>
						</div>
					</c:if>
				</div>

				<div id="addTable1">

					<c:choose>
						<c:when test="${!empty resultList}">
							<c:forEach var="list" items="${resultList}" varStatus="status">
								<c:choose>
									<c:when test="${status.first}">
										<div class="cont">
											<div class="wrap_table3">
												<table id="table-2" class="tbl">
													<caption>기초현황 담당자 정보</caption>
													<colgroup>
														<col class="th1_1">
														<col>
													</colgroup>
													<tbody>
														<tr>
															<th scope="col" id="th_a2">부서</th>
															<td headers="th_a2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="dept${status.index}"
																			name="dept" maxLength="25" value="${list.dept}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.dept}
								                                	</c:otherwise>
																</c:choose>
														</tr>
														<tr>
															<th scope="col" id="th_b2">직책</th>
															<td headers="th_b2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="rspofc${status.index}"
																			name="rspofc" maxLength="25" value="${list.rspofc}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.rspofc}
								                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_c2">성명</th>
															<td headers="th_c2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="userNm${status.index}"
																			name="userNm" maxLength="25" value="${list.userNm}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.userNm}
								                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_d2">연락처</th>
															<td headers="th_d2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="telNo${status.index}"
																			name="telNo" maxLength="25" value="${list.telNo}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
									                                		${list.telNo}
									                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_e2">이메일</th>
															<td headers="th_e2"><a href="mailto:${list.email}"
																class="link1"> <c:choose>
																		<c:when
																			test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="email${status.index}"
																				name="email" maxLength="25" value="${list.email}"
																				class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
								                                		${list.email}
								                                	</c:otherwise>
																	</c:choose>
															</a></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="cont">
											<div class="wrap_table3">
												<table id="table-2" class="tbl">
													<caption>기초현황 담당자 정보</caption>
													<colgroup>
														<col class="th1_1">
														<col>
													</colgroup>
													<tbody>
														<tr>
															<th scope="col" id="th_a2">부서</th>
															<td headers="th_a2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="dept${status.index}"
																			name="dept" maxLength="25" value="${list.dept}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.dept}
								                                	</c:otherwise>
																</c:choose>
														</tr>
														<tr>
															<th scope="col" id="th_b2">직책</th>
															<td headers="th_b2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="rspofc${status.index}"
																			name="rspofc" maxLength="25" value="${list.rspofc}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.rspofc}
								                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_c2">성명</th>
															<td headers="th_c2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="userNm${status.index}"
																			name="userNm" maxLength="25" value="${list.userNm}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
								                                		${list.userNm}
								                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_d2">연락처</th>
															<td headers="th_d2"><c:choose>
																	<c:when
																		test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																		<input type="text" id="telNo${status.index}"
																			name="telNo" maxLength="25" value="${list.telNo}"
																			class="inp_txt w100p">
																	</c:when>
																	<c:otherwise>
									                                		${list.telNo}
									                                	</c:otherwise>
																</c:choose></td>
														</tr>
														<tr>
															<th scope="col" id="th_e2">이메일</th>
															<td headers="th_e2"><a href="mailto:${list.email}"
																class="link1"> <c:choose>
																		<c:when
																			test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="email${status.index}"
																				name="email" maxLength="25" value="${list.email}"
																				class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
								                                		${list.email}
								                                	</c:otherwise>
																	</c:choose>
															</a></td>
														</tr>
													</tbody>
												</table>
												<c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<div class="tr mt10">
														<a class="btn-pk vs rv red" onclick="fnDelete(this);">담당자
															삭제</a>
													</div>
												</c:if>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<div class="cont">
								<div class="wrap_table3">
									<table id="table-2" class="tbl">
										<caption>기초현황 담당자 정보</caption>
										<colgroup>
											<col class="th1_1">
											<col>
										</colgroup>
										<tbody>
											<tr>
												<th scope="col" id="th_a2">부서</th>
												<td headers="th_a2"><c:choose>
														<c:when
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="dept${status.index}" name="dept"
																maxLength="25" value="${list.dept}"
																class="inp_txt w100p">
														</c:when>
														<c:otherwise>
				                                		${list.dept}
				                                	</c:otherwise>
													</c:choose></td>
											</tr>
											<tr>
												<th scope="col" id="th_b2">직책</th>
												<td headers="th_b2"><c:choose>
														<c:when
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="rspofc${status.index}"
																name="rspofc" maxLength="25" value="${list.rspofc}"
																class="inp_txt w100p">
														</c:when>
														<c:otherwise>
				                                		${list.rspofc}
				                                	</c:otherwise>
													</c:choose></td>
											</tr>
											<tr>
												<th scope="col" id="th_c2">성명</th>
												<td headers="th_c2"><c:choose>
														<c:when
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="userNm${status.index}"
																name="userNm" maxLength="25" value="${list.userNm}"
																class="inp_txt w100p">
														</c:when>
														<c:otherwise>
				                                		${list.userNm}
				                                	</c:otherwise>
													</c:choose></td>
											</tr>
											<tr>
												<th scope="col" id="th_d2">연락처</th>
												<td headers="th_d2"><c:choose>
														<c:when
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="telNo${status.index}" name="telNo"
																maxLength="25" value="${list.telNo}"
																class="inp_txt w100p">
														</c:when>
														<c:otherwise>
				                                		${list.telNo}
				                                	</c:otherwise>
													</c:choose></td>
											</tr>
											<tr>
												<th scope="col" id="th_e2">이메일</th>
												<td headers="th_e2"><a href="mailto:${list.email}"
													class="link1"> <c:choose>
															<c:when
																test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																<input type="text" id="email${status.index}"
																	name="email" maxLength="25" value="${list.email}"
																	class="inp_txt w100p">
															</c:when>
															<c:otherwise>
					                                		${list.email}
					                                	</c:otherwise>
														</c:choose>
												</a></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</section>

			<section class="area_tit1 inr-c">

				<div class="layer-header1 clearfix">
					<div class="col-lft">
						<h2 class="title4 mb0">개인정보 파일</h2>
					</div>

					<c:if
						test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
						<div class="col-rgh mt0">
							<a href="#link" onclick="addHtml2(event); return false;"
								class="btn-pk vs rv blue"><span>추가</span></a>
						</div>
					</c:if>
				</div>

				<div class="cont">
					<div class="wrap_table3 pr-mb1">
						<table id="table-4" class="tbl"
							summary="No, 개인정보 파일명, 개인정보 항목, 수집방법, 수집근거, 정보주체수, 삭제로 구성된 개인정보 파일 등록입니다.">
							<caption>기초현황 개인정보 현황 개인정보파일 정보</caption>
							<colgroup>
								<col class="th1_0">
								<col class="th1_1">
								<col>
								<col class="th1_1">
								<col class="th1_1">
								<col class="th1_1">
								<c:if
									test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
									<col class="th1_0">
								</c:if>
							</colgroup>
							<tbody id="addTable2">

								<tr class="th_color">
									<th scope="col" id="th_a4">No.</th>
									<th scope="col" id="th_b4">개인정보 파일명</th>
									<th scope="col" id="th_c4">개인정보 항목</th>
									<th scope="col" id="th_d4">수집방법</th>
									<th scope="col" id="th_e4">수집근거</th>
									<th scope="col" id="th_f4">정보주체수</th>
									<c:if
										test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<th scope="col">삭제</th>
									</c:if>
								</tr>

								<c:set var="tmpCnt2" value="0" />
								<c:set var="tmpTotal2" value="0" />

								<c:choose>
									<c:when test="${!empty resultList2}">
										<c:forEach var="list" items="${resultList2}"
											varStatus="status">
											<c:set var="tmpCnt2" value="${tmpCnt2 + 1}" />
											<c:set var="tmpTotal2"
												value="${tmpTotal2 + list.indvdlinfoCo}" />

											<c:choose>
												<c:when test="${status.first}">
													<tr>
														<td class="ta-c">${status.index + 1}</td>
														<td headers="th_a4 th_b4"><c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoFileNm${status.index}"
																		hidden>개인정보 파일명</label> --%>
																	<input type="text" id="indvdlinfoFileNm${status.index}"
																		name="indvdlinfoFileNm" maxLength="50"
																		value="${list.indvdlinfoFileNm}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoFileNm}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_c4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoItem${status.index}" hidden>개인정보
																		항목</label> --%>
																	<input type="text" id="indvdlinfoItem${status.index}"
																		name="indvdlinfoItem" maxLength="1000"
																		value="${list.indvdlinfoItem}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoItem}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_d4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoColctMethod${status.index}"
																		hidden>수집방법</label> --%>
																	<input type="text"
																		id="indvdlinfoColctMethod${status.index}"
																		name="indvdlinfoColctMethod" maxLength="500"
																		value="${list.indvdlinfoColctMethod}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoColctMethod}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_e4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoColctBasis${status.index}"
																		hidden>수집근거</label> --%>
																	<input type="text"
																		id="indvdlinfoColctBasis${status.index}"
																		name="indvdlinfoColctBasis" maxLength="500"
																		value="${list.indvdlinfoColctBasis}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoColctBasis}
										                            </c:otherwise>
															</c:choose></td>
														<c:choose>
															<c:when
																test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																<td headers="th_a4 th_f4">
																	<%-- <label
																	for="indvdlinfoCo${status.index}" hidden>정보주체수</label> --%>
																	<input type="text" id="indvdlinfoCo${status.index}"
																	name="indvdlinfoCo" maxLength="11"
																	value="${list.indvdlinfoCo}"
																	class="inp_txt w100p tr onlyNumber">
																</td>
															</c:when>
															<c:otherwise>
																<td headers="th_a4 th_f4">
																	${list.indvdlinfoCo}</td>
															</c:otherwise>
														</c:choose>
														<c:if
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<td class="tc"></td>
														</c:if>
													</tr>
												</c:when>
												<c:otherwise>
													<tr>
														<td class="ta-c">${status.index + 1}</td>
														<td headers="th_a4 th_b4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoFileNm${status.index}"
																		hidden>개인정보 파일명</label> --%>
																	<input type="text" id="indvdlinfoFileNm${status.index}"
																		name="indvdlinfoFileNm" maxLength="50"
																		value="${list.indvdlinfoFileNm}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoFileNm}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_c4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoItem${status.index}" hidden>개인정보
																		항목</label> --%>
																	<input type="text" id="indvdlinfoItem${status.index}"
																		name="indvdlinfoItem" maxLength="1000"
																		value="${list.indvdlinfoItem}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoItem}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_d4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoColctMethod${status.index}"
																		hidden>수집방법</label> --%>
																	<input type="text"
																		id="indvdlinfoColctMethod${status.index}"
																		name="indvdlinfoColctMethod" maxLength="500"
																		value="${list.indvdlinfoColctMethod}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoColctMethod}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a4 th_e4"><c:choose>
																<c:when
																	test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<%-- <label for="indvdlinfoColctBasis${status.index}"
																		hidden>수집근거</label> --%>
																	<input type="text"
																		id="indvdlinfoColctBasis${status.index}"
																		name="indvdlinfoColctBasis" maxLength="500"
																		value="${list.indvdlinfoColctBasis}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.indvdlinfoColctBasis}
										                            </c:otherwise>
															</c:choose></td>
														<c:choose>
															<c:when
																test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																<td headers="th_a4 th_f4" class="ta-r">
																	<%-- <label
																	for="indvdlinfoCo${status.index}" hidden>정보주체수</label> --%>
																	<input type="text" id="indvdlinfoCo${status.index}"
																	name="indvdlinfoCo" maxLength="11"
																	value="${list.indvdlinfoCo}"
																	class="inp_txt w100p tr onlyNumber">
																</td>
															</c:when>
															<c:otherwise>
																<td headers="th_a4 th_f4" class="ta-r">
																	${list.indvdlinfoCo}</td>
															</c:otherwise>
														</c:choose>
														<c:if
															test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<td class="tc"><a class="btn-pk vs rv red"
																onclick="fnDelete(this);"><span>삭제</span></a></td>
														</c:if>
													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="ta-c">1</td>
											<td headers="th_a4 th_b4"><c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<!-- <label for="indvdlinfoFileNm0" hidden>개인정보
														파일명</label> -->
													<input type="text" id="indvdlinfoFileNm0"
														name="indvdlinfoFileNm" maxLength="50" value=""
														class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a4 th_c4"><c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<!-- <label for="indvdlinfoItem0" hidden>개인정보 항목</label> -->
													<input type="text" id="indvdlinfoItem0"
														name="indvdlinfoItem" maxLength="1000" value=""
														class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a4 th_d4"><c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<!-- <label for="indvdlinfoColctMethod0" hidden>수집방법</label> -->
													<input type="text" id="indvdlinfoColctMethod0"
														name="indvdlinfoColctMethod" maxLength="500" value=""
														class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a4 th_e4"><c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<!-- <label for="indvdlinfoColctBasis0" hidden>수집근거</label> -->
													<input type="text" id="indvdlinfoColctBasis0"
														name="indvdlinfoColctBasis" maxLength="500" value=""
														class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a4 th_f4" class="ta-r"><c:if
													test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<!-- <label for="indvdlinfoCo0" hidden>정보주체수</label> -->
													<input type="text" id="indvdlinfoCo0" name="indvdlinfoCo"
														maxLength="11" value=""
														class="inp_txt w100p tr onlyNumber">
												</c:if></td>
											<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
												<td class="tc"></td>
											</c:if>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tfoot class="total2">
								<tr>
									<td class="ta-c">계</td>
									<td class="ta-r moneyType">${tmpCnt2}</td>
									<td class="ta-r"></td>
									<td class="ta-r"></td>
									<td class="ta-r"></td>
									<td class="ta-r moneyType">${tmpTotal2}</td>
									<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<td class="tc"></td>
									</c:if>
								</tr>
							</tfoot>
						</table>
					</div>

					<div class="layer-header1 clearfix">
						<div class="col-lft">
							<h2 class="title4 mb0">개인정보처리시스템 현황</h2>
						</div>
						<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
							<div class="col-rgh mt0">
								<a href="#link" onclick="addHtml3(event); return false;"
									class="btn-pk vs rv blue"><span>추가</span></a>
							</div>
						</c:if>
					</div>

					<div class="wrap_table3 pr-mb1">
						<table id="table-6" class="tbl"
							summary="No, 시스템명, 운영목적, DB암호화 유무, 송수신구간 암호화 유무, 영향평가 이행여부, 삭제로 구성된 개인정보처리시스템 현황 등록입니다.">
							<caption>기초현황 개인정보 현황 개인정보처리시스템 현황 정보</caption>
							<colgroup>
								<col class="th1_0">
								<col class="th1_1">
								<col>
								<col class="th1_1">
								<col class="th1_1">
								<col class="th1_1">
								<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
									<col class="th1_0">
								</c:if>

							</colgroup>
							<tbody id="addTable3">
								<tr class="th_color">
									<th scope="col" id="th_a4">No.</th>
									<th scope="col" id="th_b6">시스템명</th>
									<th scope="col" id="th_c6">운영목적</th>
									<th scope="col" id="th_d6">DB암호화<br>유무
									</th>
									<th scope="col" id="th_e6">송수신구간<br>암호화유무
									</th>
									<th scope="col" id="th_f6">영향평가<br>이행여부
									</th>
									<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<th scope="col" id="th_g4">삭제</th>
									</c:if>
								</tr>
								<c:set var="tmpCnt4" value="0" />
								<c:set var="tmpCnt4_1" value="0" />
								<c:set var="tmpCnt4_2" value="0" />
								<c:set var="tmpCnt4_3" value="0" />
								<c:choose>
									<c:when test="${!empty resultList3}">
										<c:forEach var="list" items="${resultList3}"
											varStatus="status">
											<c:set var="tmpCnt4" value="${tmpCnt4 + 1}" />
											<c:choose>
												<c:when test="${status.first}">
													<tr>
														<td class="ta-c">${status.index + 1}</td>
														<td headers="th_a6 th_b6"><c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<input type="text" id="sysNm${status.index}"
																		name="sysNm" maxLength="50" value="${list.sysNm}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.sysNm}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_c6"><c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<input type="text" id="operPurps${status.index}"
																		name="operPurps" maxLength="1000"
																		value="${list.operPurps}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.operPurps}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_d6" class="ta-c"><c:if
																test="${'Y' eq list.dbEncptYn}">
																<c:set var="tmpCnt4_1" value="${tmpCnt4_1 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="dbEncptYn${status.index}"
																			name="dbEncptYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.dbEncptYn}">selected</c:if>>유</option>
																			<option value="N"
																				<c:if test="${'N' eq list.dbEncptYn}">selected</c:if>>무</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.dbEncptYn}">
										                            			유
										                            		</c:when>
																		<c:otherwise>
										                            			무
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_e6" class="ta-c"><c:if
																test="${'Y' eq list.trsmrcvEncptYn}">
																<c:set var="tmpCnt4_2" value="${tmpCnt4_2 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="trsmrcvEncptYn${status.index}"
																			name="trsmrcvEncptYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.trsmrcvEncptYn}">selected</c:if>>유</option>
																			<option value="N"
																				<c:if test="${'N' eq list.trsmrcvEncptYn}">selected</c:if>>무</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.trsmrcvEncptYn}">
										                            			유
										                            		</c:when>
																		<c:otherwise>
										                            			무
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_f6" class="ta-c"><c:if
																test="${'Y' eq list.ipcssYn}">
																<c:set var="tmpCnt4_3" value="${tmpCnt4_3 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="ipcssYn${status.index}"
																			name="ipcssYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.ipcssYn}">selected</c:if>>이행</option>
																			<option value="N"
																				<c:if test="${'N' eq list.ipcssYn}">selected</c:if>>불이행</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.ipcssYn}">
										                            			이행
										                            		</c:when>
																		<c:otherwise>
										                            			불이행
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<td cheaders="th_g4" class="ta-r"></td>
														</c:if>
													</tr>

												</c:when>
												<c:otherwise>
													<tr>
														<td class="ta-c">${status.index + 1}</td>
														<td headers="th_a6 th_b6"><c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<input type="text" id="sysNm${status.index}"
																		name="sysNm" maxLength="50" value="${list.sysNm}"
																		class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.sysNm}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_c6"><c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<input type="text" id="operPurps${status.index}"
																		name="operPurps" maxLength="1000"
																		value="${list.operPurps}" class="inp_txt w100p">
																</c:when>
																<c:otherwise>
										                            	${list.operPurps}
										                            </c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_d6" class="ta-c"><c:if
																test="${'Y' eq list.dbEncptYn}">
																<c:set var="tmpCnt4_1" value="${tmpCnt4_1 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="dbEncptYn${status.index}"
																			name="dbEncptYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.dbEncptYn}">selected</c:if>>유</option>
																			<option value="N"
																				<c:if test="${'N' eq list.dbEncptYn}">selected</c:if>>무</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.dbEncptYn}">
										                            			유
										                            		</c:when>
																		<c:otherwise>
										                            			무
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_e6" class="ta-c"><c:if
																test="${'Y' eq list.trsmrcvEncptYn}">
																<c:set var="tmpCnt4_2" value="${tmpCnt4_2 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="trsmrcvEncptYn${status.index}"
																			name="trsmrcvEncptYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.trsmrcvEncptYn}">selected</c:if>>유</option>
																			<option value="N"
																				<c:if test="${'N' eq list.trsmrcvEncptYn}">selected</c:if>>무</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.trsmrcvEncptYn}">
										                            			유
										                            		</c:when>
																		<c:otherwise>
										                            			무
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<td headers="th_a6 th_f6" class="ta-c"><c:if
																test="${'Y' eq list.ipcssYn}">
																<c:set var="tmpCnt4_3" value="${tmpCnt4_3 + 1}" />
															</c:if> <c:choose>
																<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<div class="area_select1">
																		<select title="선택" id="ipcssYn${status.index}"
																			name="ipcssYn">
																			<option value="">선택</option>
																			<option value="Y"
																				<c:if test="${'Y' eq list.ipcssYn}">selected</c:if>>이행</option>
																			<option value="N"
																				<c:if test="${'N' eq list.ipcssYn}">selected</c:if>>불이행</option>
																		</select>
																	</div>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${'Y' eq list.ipcssYn}">
										                            			이행
										                            		</c:when>
																		<c:otherwise>
										                            			불이행
										                            		</c:otherwise>
																	</c:choose>
																</c:otherwise>
															</c:choose></td>
														<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<td headers="th_g4" class="ta-r"><a
																class="btn-pk vs rv red" onclick="fnDelete(this);"><span>삭제</span></a>
															</td>
														</c:if>
													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td class="ta-c">1</td>
											<td headers="th_a6 th_b6"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<input type="text" id="sysNm0" name="sysNm" maxLength="50"
														value="" class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a6 th_c6"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<input type="text" id="operPurps0" name="operPurps"
														maxLength="1000" value="" class="inp_txt w100p">
												</c:if></td>
											<td headers="th_a6 th_d6" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<div class="area_select1">
														<select title="선택" id="dbEncptYn0" name="dbEncptYn">
															<option value="">선택</option>
															<option value="Y">유</option>
															<option value="N">무</option>
														</select>
													</div>
												</c:if></td>
											<td headers="th_a6 th_e6" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<div class="area_select1">
														<select title="선택" id="trsmrcvEncptYn0"
															name="trsmrcvEncptYn">
															<option value="">선택</option>
															<option value="Y">유</option>
															<option value="N">무</option>
														</select>
													</div>
												</c:if></td>
											<td headers="th_a6 th_f6" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
													<div class="area_select1">
														<select title="선택" id="ipcssYn0" name="ipcssYn">
															<option value="">선택</option>
															<option value="Y">이행</option>
															<option value="N">불이행</option>
														</select>
													</div>
												</c:if></td>
											<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
												<td headers="th_g4" class="ta-r"></td>
											</c:if>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
							<tfoot class="total2">
								<tr>
									<td class="ta-c">계</td>
									<td class="ta-r moneyType">${tmpCnt4}</td>
									<td class="ta-r"></td>
									<td class="ta-r moneyType">${tmpCnt4_1}</td>
									<td class="ta-r moneyType">${tmpCnt4_2}</td>
									<td class="ta-r moneyType">${tmpCnt4_3}</td>
									<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<td class="tc"></td>
									</c:if>
								</tr>
							</tfoot>
						</table>
					</div>

					<div class="layer-header1 clearfix">
						<div class="col-lft">
							<h2 class="title4 mb0">영상정보처리기기 운영현황</h2>
						</div>
						<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
							<div class="col-rgh mt0">
								<a href="#link" onclick="addHtml4(event); return false;"
									class="btn-pk vs rv blue"><span>추가</span></a>
							</div>
						</c:if>
					</div>

					<div class="top">
						<c:set var="tmpCheck5" value="" />
						<c:choose>
							<c:when test="${!empty resultList4}">
								<c:forEach var="list" items="${resultList4}" varStatus="status">
									<c:if test="${status.first and 'Y' eq list.excpPermYn}">
										<c:set var="tmpCheck5" value="checked='checked'" />
									</c:if>
								</c:forEach>
							</c:when>
						</c:choose>

						<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
							<div style="margin-bottom: 10px;">
								<input class="ickjs" type="checkbox" id="excpPermYn5"
									name="excpPermYn5" ${tmpCheck5}> <label
									for="excpPermYn5">해당사항 없음</label>
							</div>
						</c:if>
					</div>

					<div class="wrap_table3 pr-mb1">

						<table id="table-7" class="tbl"
							summary="No, 설치위치, 목적, 대수, 공개/비공개, 안내판, 정기점검, 삭제로 구성된 영상정보처리기기 운영현황 등록입니다.">
							<caption>기초현황 개인정보 현황 영상정보처리기기 운영현황 정보</caption>
							<colgroup>
								<col class="th1_0">
								<col>
								<col>
								<col class="th1_01">
								<col>
								<col>
								<col>
								<col class="th1_0">
							</colgroup>
							<tbody id="addTable4">
								<tr class="th_color">
									<th scope="col" id="th_a4">No.</th>
									<th scope="col" id="th_b7">설치위치</th>
									<th scope="col" id="th_c7">목적</th>
									<th scope="col" id="th_d7">대수</th>
									<th scope="col" id="th_e7">공개여부</th>
									<th scope="col" id="th_f7">안내판<br>유무
									</th>
									<th scope="col" id="th_g7">정기점검<br>유무
									</th>
									<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<th scope="col" id="th_g4">삭제</th>
									</c:if>
								</tr>

								<c:choose>
									<c:when
										test="${empty tmpCheck5 or sessionScope.userInfo.authorId eq '2'}">
										<c:set var="tmpCnt5" value="0" />
										<c:set var="tmpCnt5_1" value="0" />
										<c:choose>
											<c:when test="${!empty resultList4}">
												<c:forEach var="list" items="${resultList4}"
													varStatus="status">

													<c:choose>
														<c:when test="${status.first}">

															<c:if test="${'Y' ne list.excpPermYn}">
																<c:set var="tmpCnt5" value="${tmpCnt5 + 1}" />
															</c:if>
															<tr>
																<td class="ta-c">${status.index + 1}</td>
																<td headers="th_a7 th_b7"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="instlLc${status.index}"
																				name="instlLc" maxLength="50"
																				value="${list.instlLc}" class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
												                            	${list.instlLc}
												                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_c7"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="purps${status.index}"
																				name="purps" maxLength="1000" value="${list.purps}"
																				class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
												                            	${list.purps}
												                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_d7" class="ta-r"><c:if
																		test="${!empty list.videoCo}">
																		<c:set var="tmpCnt5_1"
																			value="${tmpCnt5_1 + list.videoCo}" />
																	</c:if> <c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="videoCo${status.index}"
																				name="videoCo" maxLength="11"
																				value="${list.videoCo}"
																				class="inp_txt w100p tr onlyNumber">
																		</c:when>
																		<c:otherwise>
												                            	${list.videoCo}
												                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_e7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="othbcYn${status.index}"
																					name="othbcYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.othbcYn}">selected</c:if>>공개</option>
																					<option value="N"
																						<c:if test="${'N' eq list.othbcYn}">selected</c:if>>비공개</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.othbcYn}">
												                            			공개
												                            		</c:when>
																				<c:when test="${'N' eq list.othbcYn}">
												                            			비공개
												                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_f7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="drcbrdYn${status.index}"
																					name="drcbrdYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.drcbrdYn}">selected</c:if>>유</option>
																					<option value="N"
																						<c:if test="${'N' eq list.drcbrdYn}">selected</c:if>>무</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.drcbrdYn}">
												                            			유
												                            		</c:when>
																				<c:when test="${'N' eq list.drcbrdYn}">
												                            			무
												                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_g7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="fdrmChckYn${status.index}"
																					name="fdrmChckYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.fdrmChckYn}">selected</c:if>>유</option>
																					<option value="N"
																						<c:if test="${'N' eq list.fdrmChckYn}">selected</c:if>>무</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.fdrmChckYn}">
												                            			유
												                            		</c:when>
																				<c:when test="${'N' eq list.fdrmChckYn}">
												                            			무
												                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<td headers="th_g4" class="ta-r"></td>
																</c:if>
															</tr>
														</c:when>
														<c:otherwise>
															<c:if test="${'Y' ne list.excpPermYn}">
																<c:set var="tmpCnt5" value="${tmpCnt5 + 1}" />
															</c:if>
															<tr>
																<td class="ta-c">${status.index + 1}</td>
																<td headers="th_a7 th_b7"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="instlLc${status.index}"
																				name="instlLc" maxLength="50"
																				value="${list.instlLc}" class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
											                            	${list.instlLc}
											                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_c7"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="purps${status.index}"
																				name="purps" maxLength="1000" value="${list.purps}"
																				class="inp_txt w100p">
																		</c:when>
																		<c:otherwise>
											                            	${list.purps}
											                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_d7" class="ta-r"><c:if
																		test="${!empty list.videoCo}">
																		<c:set var="tmpCnt5_1"
																			value="${tmpCnt5_1 + list.videoCo}" />
																	</c:if> <c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<input type="text" id="videoCo${status.index}"
																				name="videoCo" maxLength="11"
																				value="${list.videoCo}"
																				class="inp_txt w100p tr onlyNumber">
																		</c:when>
																		<c:otherwise>
											                            	${list.videoCo}
											                            </c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_e7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="othbcYn${status.index}"
																					name="othbcYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.othbcYn}">selected</c:if>>공개</option>
																					<option value="N"
																						<c:if test="${'N' eq list.othbcYn}">selected</c:if>>비공개</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.othbcYn}">
											                            			공개
											                            		</c:when>
																				<c:when test="${'N' eq list.othbcYn}">
											                            			비공개
											                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_f7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="drcbrdYn${status.index}"
																					name="drcbrdYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.drcbrdYn}">selected</c:if>>유</option>
																					<option value="N"
																						<c:if test="${'N' eq list.drcbrdYn}">selected</c:if>>무</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.drcbrdYn}">
											                            			유
											                            		</c:when>
																				<c:when test="${'N' eq list.drcbrdYn}">
											                            			무
											                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<td headers="th_a7 th_g7" class="ta-c"><c:choose>
																		<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																			<div class="area_select1">
																				<select title="선택" id="fdrmChckYn${status.index}"
																					name="fdrmChckYn">
																					<option value="">선택</option>
																					<option value="Y"
																						<c:if test="${'Y' eq list.fdrmChckYn}">selected</c:if>>유</option>
																					<option value="N"
																						<c:if test="${'N' eq list.fdrmChckYn}">selected</c:if>>무</option>
																				</select>
																			</div>
																		</c:when>
																		<c:otherwise>
																			<c:choose>
																				<c:when test="${'Y' eq list.fdrmChckYn}">
											                            			유
											                            		</c:when>
																				<c:when test="${'N' eq list.fdrmChckYn}">
											                            			무
											                            		</c:when>
																				<c:otherwise>
																				</c:otherwise>
																			</c:choose>
																		</c:otherwise>
																	</c:choose></td>
																<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
																	<td headers="th_g4" class="ta-r"><a
																		class="btn-pk vs rv red" onclick="fnDelete(this);"><span>삭제</span></a>
																	</td>
																</c:if>
															</tr>

														</c:otherwise>
													</c:choose>


												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td class="ta-c">1</td>
													<td headers="th_a7 th_b7"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="instlLc0" name="instlLc"
																maxLength="50" value="" class="inp_txt w100p">
														</c:if></td>
													<td headers="th_a7 th_c7"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="purps0" name="purps"
																maxLength="1000" value="" class="inp_txt w100p">
														</c:if></td>
													<td headers="th_a7 th_d7" class="ta-r"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<input type="text" id="videoCo0" name="videoCo"
																maxLength="11" value=""
																class="inp_txt w100p tr onlyNumber">
														</c:if></td>
													<td headers="th_a7 th_d7" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<div class="area_select1">
																<select title="선택" id="othbcYn0" name="othbcYn">
																	<option value="">선택</option>
																	<option value="Y">공개</option>
																	<option value="N">비공개</option>
																</select>
															</div>
														</c:if></td>
													<td headers="th_a7 th_f7" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<div class="area_select1">
																<select title="선택" id="drcbrdYn0" name="drcbrdYn">
																	<option value="">선택</option>
																	<option value="Y">유</option>
																	<option value="N">무</option>
																</select>
															</div>
														</c:if></td>
													<td headers="th_a7 th_g7" class="ta-c"><c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
															<div class="area_select1">
																<select title="선택" id="fdrmChckYn0" name="fdrmChckYn">
																	<option value="">선택</option>
																	<option value="Y">유</option>
																	<option value="N">무</option>
																</select>
															</div>
														</c:if></td>
													<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
														<td headers="th_g4" class="ta-r"></td>
													</c:if>

												</tr>
											</c:otherwise>
										</c:choose>
							</tbody>
							<tfoot class="total2">
								<tr>
									<td class="ta-c">계</td>
									<td class="ta-r moneyType">${tmpCnt5}</td>
									<td class="ta-r"></td>
									<td class="ta-r moneyType">${tmpCnt5_1}</td>
									<td class="ta-r"></td>
									<td class="ta-r"></td>
									<td class="ta-r"></td>
									<c:if test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<td class="tc"></td>
									</c:if>
								</tr>
							</tfoot>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
										<tbody>
											<tr>
												<td colspan="8" class="tc"
													style="text-align: center; padding: 60px 0;">해당사항 없음</td>
											</tr>
										</tbody>
									</c:when>
									<c:otherwise>
										<tbody>
											<tr>
												<td colspan="7" class="tc"
													style="text-align: center; padding: 60px 0;">해당사항 없음</td>
											</tr>
										</tbody>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
							</c:choose>
						</table>
					</div>
					<c:if
						test="${requestZvl.orderNo eq currentOrderNo and sessionScope.userInfo.authorId eq '2'}">
						<div class="btn-bot2 pr-mb1 ta-c">
							<a class="btn-pk n rv blue" onclick="fn_save(); return false;"><span>저장</span></a>
						</div>
					</c:if>
				</div>
			</section>
		</div>
		<!-- //container_inner -->
	</section>
	<!-- //container_main -->
</form>

<script type="text/javascript">
  $(".wrap_table").tableFixed();
</script>

<script>

var dept = [];
var rspofc = [];
var userNm = [];
var telNo = [];
var email = [];

function validation_check_instt(){
	var insttNm = $("#insttNm").val();
	var empCo = $("#empCo").val();
	var addr = $("#addr").val();
	var bsnsContents = $("#bsnsContents").val();
	
	if('' == insttNm) {
		alert("기관명을 입력해주세요");
		return false;
	}
	if('' == empCo) {
		alert("임직원 수를 입력해주세요");
		return false;
	}
	if('' == addr) {
		alert("주소를 입력해주세요");
		return false;
	}
	if('' == bsnsContents) {
		alert("사업내용을 입력해주세요");
		return false;
	}
	
	var cnt = 0;
	var index = 0;
	$("input[name=dept]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			dept[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("부서를 입력해주세요");
		return false;
	}
	
	index = 0;
	$("input[name=rspofc]").each(function(){
		rspofc[index] = $(this).val();
		index++;
	});
	
	cnt = 0;
	index = 0;
	$("input[name=userNm]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			userNm[index] = $(this).val();
			index++;
		}
	});
	if('0' != cnt) {
		alert("성명을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	var flag = 0;
	var regExp = /^(^02.{0}|^01.\d{1}|\d{3})-\d{3,4}-\d{4}|(^02.{0}|^01.\d{1}|\d{3})\d{7,8}$/;
	$("input[name=telNo]").each(function(){
		if(!regExp.test($(this).val())){
			$(this).focus();
			flag = 1;
			return false;
		}
		if('' == $(this).val()) {
			cnt++;
		} else {
			telNo[index] = $(this).val();
			index++;
		}
	});
	if(flag == 1) {alert("연락처를 올바르게 작성해주세요"); return false; }
	else if('0' != cnt) { alert("연락처를 입력해주세요"); return false; }
	
	cnt = 0;
	index = 0;
	var cntChk = 0;
	$("input[name=email]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			email[index] = $(this).val();
			index++;
			if(!emailRegExp.test($(this).val())) {
				cntChk++;
			}
		}
	});

	if('0' != cnt) {
		alert("이메일을 입력해주세요");
		return false;
	}
	
	if('0' != cntChk) {
		alert("이메일 주소가 정확하지 않습니다.");
		return false;
	}	
	
}

var indvdlinfoFileNm = [];
var indvdlinfoItem = [];
var indvdlinfoColctMethod = [];
var indvdlinfoColctBasis = [];
var indvdlinfoCo = [];

function validation_check_indvdlinfo(){
	
	var cnt = 0;
	var index = 0;
	
	$("input[name=indvdlinfoFileNm]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			indvdlinfoFileNm[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("개인정보 파일명을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("input[name=indvdlinfoItem]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			indvdlinfoItem[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("개인정보 항목을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("input[name=indvdlinfoColctMethod]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			indvdlinfoColctMethod[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("수집방법을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("input[name=indvdlinfoColctBasis]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			indvdlinfoColctBasis[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("수집근거를 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("input[name=indvdlinfoCo]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			indvdlinfoCo[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("정보주체수를 입력해주세요");
		return false;
	}	
}

var sysNm = [];
var operPurps = [];
var dbEncptYn = [];
var trsmrcvEncptYn = [];
var ipcssYn = [];

function validation_check_sttusSys(){

	var cnt = 0;
	var index = 0;
	
	$("input[name=sysNm]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			sysNm[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("시스템명을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("input[name=operPurps]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			operPurps[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("운영목적을 입력해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("select[name=dbEncptYn]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			dbEncptYn[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("DB암호화 유무를 선택해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("select[name=trsmrcvEncptYn]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			trsmrcvEncptYn[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("송수신구간 암호화 유무를 선택해주세요");
		return false;
	}
	
	cnt = 0;
	index = 0;
	$("select[name=ipcssYn]").each(function(){
		if('' == $(this).val()) {
			cnt++;
		} else {
			ipcssYn[index] = $(this).val();
			index++;
		}
	});

	if('0' != cnt) {
		alert("영향평가 이행여부를 선택해주세요");
		return false;
	}
}

var excpPermYn = ''
var instlLc = [];
var purps = [];
var videoCo = [];
var othbcYn = [];
var drcbrdYn = [];
var fdrmChckYn = [];

function validation_check_sttusVideo(){
	
	var cnt = 0;
	var index = 0;
	
	if($("#excpPermYn5").prop("checked")) {
		excpPermYn = 'Y';
	} else {
		excpPermYn = 'N';
	}	

	if('N' == excpPermYn) {
		
		$("input[name=instlLc]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				instlLc[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("설치위치를 입력해주세요");
			return false;
		}
		
		cnt = 0;
		index = 0;
		$("input[name=purps]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				purps[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("목적을 입력해주세요");
			return false;
		}
		
		cnt = 0;
		index = 0;
		$("input[name=videoCo]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				videoCo[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("대수를 입력해주세요");
			return false;
		}
		
		cnt = 0;
		index = 0;
		$("select[name=othbcYn]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				othbcYn[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("공개/비공개를 선택해주세요");
			return false;
		}
		
		cnt = 0;
		index = 0;
		$("select[name=drcbrdYn]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				drcbrdYn[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("안내판유무를 선택해주세요");
			return false;
		}
		
		cnt = 0;
		index = 0;
		$("select[name=fdrmChckYn]").each(function(){
			if('' == $(this).val()) {
				cnt++;
			} else {
				fdrmChckYn[index] = $(this).val();
				index++;
			}
		});

		if('0' != cnt) {
			alert("정기점검 유무를 선택해주세요");
			return false;
		}
	}
	
}

function fn_save(){
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	// 기관개요 및 담당자
	if(validation_check_instt() == false) return false;
	
	// 개인정보파일
	if(validation_check_indvdlinfo() == false) return false;
	
	//개인정보처리시스템
	if(validation_check_sttusSys() == false) return false;
	
	//영상정보처리기기운영현황
	if(validation_check_sttusVideo() == false) return false;
	
	if(confirm("저장 하시겠습니까?")){
		
		var orderNo = '${requestZvl.orderNo}';
		var insttCd = '${requestZvl.insttCd}';
		
		// 기관개요 및 담당자
		var insttNm = $("#insttNm").val();
		var empCo = $("#empCo").val();
		var addr = $("#addr").val();
		var bsnsContents = $("#bsnsContents").val();
		
		pParam = {};
		pParam.gubun = '';
		
		pParam.orderNo = orderNo;
		pParam.insttCd = insttCd;
		
		pParam.insttNm = insttNm;
		pParam.empCo = empCo;
		pParam.addr = addr;
		pParam.bsnsContents = bsnsContents;
		
		pParam.dept = dept;
		pParam.rspofc = rspofc;
		pParam.userNm = userNm;
		pParam.telNo = telNo;
		pParam.email = email;
	    
	    pParam.gubun = 'all';
 
	    // 개인정보파일	    
	    pParam.indvdlinfoFileNm = indvdlinfoFileNm;
		pParam.indvdlinfoItem = indvdlinfoItem;
		pParam.indvdlinfoColctMethod = indvdlinfoColctMethod;
		pParam.indvdlinfoColctBasis = indvdlinfoColctBasis;
		pParam.indvdlinfoCo = indvdlinfoCo;
		
	    // 개인정보처리시스템
		pParam.sysNm = sysNm;
		pParam.operPurps = operPurps;
		pParam.dbEncptYn = dbEncptYn;
		pParam.trsmrcvEncptYn = trsmrcvEncptYn;
		pParam.ipcssYn = ipcssYn;
		
		// 영상정보처리기기운영현황		
		pParam.excpPermYn = excpPermYn;
		pParam.instlLc = instlLc;
		pParam.purps = purps;
		pParam.videoCo = videoCo;
		pParam.othbcYn = othbcYn;
		pParam.drcbrdYn = drcbrdYn;
		pParam.fdrmChckYn = fdrmChckYn;
	    
	    $.post("/bsis/modifyInstitutionAll.do", pParam, function(data){
	    	alert(data.message);
	    	$("#form").submit();
 		});	    
	 	
	}	
	
}
</script>

<script>
var rowCnt = 1;
<c:if test="${!empty resultList}">
rowCnt = "${fn:length(resultList)}";
</c:if>

function addHtml1(e){
	e.preventDefault();
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	$("#addTable1").append(appendHtml1());
	//fn_init();
}

function addHtml2(e){
	e.preventDefault();
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	$("#addTable2").append(appendHtml2());
	//fn_init();
}

function addHtml3(e){
	e.preventDefault();
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	$("#addTable3").append(appendHtml3());
}

function addHtml4(e){
	e.preventDefault();
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	$("#addTable4").append(appendHtml4());
	//fn_init();
}

function appendHtml1() {
	var html = '';
	
	html += '<div class="cont"> ';
	html += '<div class="wrap_table3"> ';
	html += '<table id="table-2" class="tbl" summary="기관명, 임직원 수, 주소, 사업내용으로 구성된 기초현황 등록입니다."> ';
	html += '<caption>기초현황 담당자 등록</caption> ';
	html += '<colgroup> ';
	html += '<col class="th1_1"> ';
	html += '<col> ';
	html += '</colgroup> ';
	html += '<tbody> ';
	html += '<tr> ';
	html += '<th scope="col" id="th_a2"> ';
	html += '<label for="dept'+rowCnt+'">부서</label> ';
	html += '</th> ';
	html += '<td headers="th_a2"> ';
	html += '<input type="text" id="dept'+rowCnt+'" name="dept" maxLength="25" class="inp_txt w100p" > ';
	html += '</td> ';
	html += '</tr> ';
	html += '<tr> ';
	html += '<th scope="col" id="th_b2"> ';
	html += '<label for="rspofc'+rowCnt+'">직책</label> ';
	html += '</th> ';
	html += '<td headers="th_b2"> ';
	html += '<input type="text" id="rspofc'+rowCnt+'" name="rspofc" maxLength="25" class="inp_txt w100p" > ';
	html += '</td> ';
	html += '</tr> ';
	html += '<tr> ';
	html += '<th scope="col" id="th_c2"> ';
	html += '<label for="userNm'+rowCnt+'">성명</label> ';
	html += '</th> ';
	html += '<td headers="th_c2"> ';
	html += '<input type="text" id="userNm'+rowCnt+'" name="userNm" maxLength="25" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '</tr> ';
	html += '<tr> ';	
	html += '<th scope="col" id="th_d2"> ';
	html += '<label for="telNo'+rowCnt+'">연락처</label> ';
	html += '</th> ';
	html += '<td headers="th_d2"> ';
	html += '<input type="text" id="telNo'+rowCnt+'" name="telNo" maxLength="25" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '</tr> ';
	html += '<tr> ';
	html += '<th scope="col" id="th_e2"> ';
	html += '<label for="email'+rowCnt+'">이메일</label> ';
	html += '</th> ';
	html += '<td headers="th_e2"> ';
	html += '<input type="text" id="email'+rowCnt+'" name="email" maxLength="25" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '</tr> ';
	html += '</tbody> ';
	html += '</table> ';
	html += '<div class="tr mt10"> ';
	html += '<a class="btn-pk vs rv red" onclick="fnDelete(this);">담당자 삭제</a> ';
	html += '</div> ';
	html += '</div> ';
	html += '</div> ';
	
	rowCnt1++;
	
	return html;
}

function appendHtml2() {
	var html = '';
	
	html += '<tr> ';
	html += '<td class="ta-c"></td> ';
	html += '<td headers="th_b4"> ';
	html += '<label for="indvdlinfoFileNm'+rowCnt2+'" hidden>개인정보 파일명</label> ';
	html += '<input type="text" id="indvdlinfoFileNm'+rowCnt2+'" name="indvdlinfoFileNm" maxLength="50" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_c4"> ';
	html += '<label for="indvdlinfoItem'+rowCnt2+'" hidden>개인정보 항목</label> ';
	html += '<input type="text" id="indvdlinfoItem'+rowCnt2+'" name="indvdlinfoItem" maxLength="1000" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_d4"> ';
	html += '<label for="indvdlinfoColctMethod'+rowCnt2+'" hidden>수집방법</label> ';
	html += '<input type="text" id="indvdlinfoColctMethod'+rowCnt2+'" name="indvdlinfoColctMethod" maxLength="50" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_e4"> ';
	html += '<label for="indvdlinfoColctBasis'+rowCnt2+'" hidden>수집근거</label> ';
	html += '<input type="text" id="indvdlinfoColctBasis'+rowCnt2+'" name="indvdlinfoColctBasis" maxLength="50" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_f4"> ';
	html += '<label for="indvdlinfoCo'+rowCnt2+'" hidden>정보주체수</label> ';
	html += '<input type="text" id="indvdlinfoCo'+rowCnt2+'" name="indvdlinfoCo" maxLength="11" value="" class="inp_txt w100p onlyNumber"> ';
	html += '</td> ';
	html += '<td headers="th_g4" class="ta-r"> ';
	html += '<a class="btn-pk vs rv red" onclick="fnDelete(this);"><span>삭제</span></a> ';
	html += '</td> ';
	html += '</tr> ';
	
	rowCnt2++;
	
	return html;
}

function appendHtml3() {
	var html = '';
	
	html += '<tr> ';
	html += '<td class="ta-c"></td> ';
	html += '<td headers="th_a6 th_b6"> ';
	html += '<input type="text" id="sysNm'+rowCnt4+'" name="sysNm" maxLength="50" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_a6 th_c6"> ';
	html += '<input type="text" id="operPurps'+rowCnt4+'" name="operPurps" maxLength="1000" value="" class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_a6 th_d6" class="ta-c"> ';
	html += '<div class="area_select1"> ';	
	html += '<select title="선택" id="dbEncptYn'+rowCnt4+'" name="dbEncptYn" > ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">유</option> ';
	html += '<option value="N">무</option> ';
	html += '</select> ';
	html += '</div> ';	
	html += '</td> ';
	html += '<td headers="th_a6 th_e6" class="ta-c"> ';
	html += '<div class="area_select1"> ';	
	html += '<select title="선택" id="trsmrcvEncptYn'+rowCnt4+'" name="trsmrcvEncptYn" > ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">유</option> ';
	html += '<option value="N">무</option> ';
	html += '</select> ';
	html += '</div> ';	
	html += '</td> ';
	html += '<td headers="th_a6 th_f6" class="ta-c"> ';
	html += '<div class="area_select1"> ';	
	html += '<select title="선택" id="ipcssYn'+rowCnt4+'" name="ipcssYn" > ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">이행</option> ';
	html += '<option value="N">불이행</option> ';
	html += '</select> ';
	html += '</div> ';	
	html += '</td> ';
	html += '<td headers="th_g4" class="ta-r"> ';
	html += '<a class="btn-pk vs rv red" onclick="fnDelete(this);">삭제</a> ';
	html += '</td> ';
	html += '</tr> ';
	
	rowCnt3++;
	
	return html;
}

function appendHtml4() {
	var html = '';
	
	html += '<tr> ';
	html += '<td class="ta-c"></td> ';
	html += '<td headers="th_a7 th_b7"> ';
	html += '<input type="text" id="instlLc'+rowCnt4+'" name="instlLc" maxLength="50" value=""  class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_a7 th_c7"> ';
	html += '<input type="text" id="purps'+rowCnt4+'" name="purps" maxLength="1000" value=""  class="inp_txt w100p"> ';
	html += '</td> ';
	html += '<td headers="th_a7 th_d7"> ';
	html += '<input type="text" id="videoCo'+rowCnt4+'" name="videoCo" maxLength="11" value=""  class="inp_txt w100p tr onlyNumber"> ';
	html += '</td> ';
	html += '<td headers="th_a7 th_e7" class="ta-c"> ';
	html += '<div class="area_select1"> ';
	html += '<select title="선택" id="othbcYn'+rowCnt4+'" name="othbcYn"> ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">공개</option> ';
	html += '<option value="N">비공개</option> ';
	html += '</select> ';
	html += '</div> ';
	html += '</td> ';
	html += '<td headers="th_a7 th_f7" class="ta-c"> ';
	html += '<div class="area_select1"> ';	
	html += '<select title="선택" id="drcbrdYn'+rowCnt4+'" name="drcbrdYn"> ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">유</option> ';
	html += '<option value="N">무</option> ';
	html += '</select> ';
	html += '</div> ';	
	html += '</td> ';
	html += '<td headers="th_a7 th_g7" class="ta-c"> ';
	html += '<div class="area_select1"> ';	
	html += '<select title="선택" id="fdrmChckYn'+rowCnt4+'" name="fdrmChckYn"> ';
	html += '<option value="">선택</option> ';
	html += '<option value="Y">유</option> ';
	html += '<option value="N">무</option> ';
	html += '</select> ';
	html += '</div> ';	
	html += '</td> ';
	html += '<td headers="th_g4" class="ta-r"> ';
	html += '<a class="btn-pk vs rv red" onclick="fnDelete(this)"><span>삭제</span></a> ';
	html += '</td> ';
	html += '</tr> ';
	
	rowCnt4++;
	
	return html;
}

function fnDelete(e){
	
	// READ/WRITE/DOWNLOAD 권한 체크
	if(authCheckWrite() == false) return false;
	
	$(e).parent().parent().remove(); return false;	
}

$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square',
	radioClass: 'iradio_square'
});
</script>





