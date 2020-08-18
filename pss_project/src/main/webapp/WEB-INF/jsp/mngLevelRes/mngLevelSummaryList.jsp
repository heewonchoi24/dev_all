<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
$(document).ready(function(){
	$(".selectMenu>li>a").on('click',function(e){
		$("#orderNo").val($(this).attr('value'));
		goAjax();
	});	
	
	$(".link1").on('click',function(e){
		e.preventDefault();
	});
});

function fn_detail(instt_cl_cd, instt_cl_nm, instt_cd, instt_nm){
	document.form.instt_cl_cd.value = instt_cl_cd;
	document.form.s_instt_cl_nm.value = instt_cl_nm;
    document.form.s_instt_cd.value = instt_cd;
	document.form.s_instt_nm.value = instt_nm;
	document.form.action = "/mngLevelRes/mngLevelSummaryListDetail.do";
	document.form.submit();
}

function goAjax(){
	document.form.action = "/mngLevelRes/mngLevelSummaryListAjax.do";
	document.form.submit();
}
</script>

<form method="post" id="form" name="form">
	<input type="hidden" name="s_instt_cl_nm" value="" /> 
	<input type="hidden" name="instt_cl_cd" value="" />
	<input type="hidden" name="s_instt_cd" value="" /> 
	<input type="hidden" name="s_instt_nm" value="" />
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.order_no}" />

	<!-- content -->
	<section id="container" class="sub">
		<div class="container_inner">

			<div class="box-info mb30">
				<div class="icon">
					<span class="i-set i_info_i"></span>
				</div>
				<div class="cont">
					<ul class="lst-dots">
						<li>기관명을 클릭하시면 실적등록 정보를 확인하실 수 있습니다.</li>
						<li>진단항목에 마우스 오버를 하시면 진단항목에 대한 자세한 설명을 보실 수 있습니다.</li>
					</ul>
				</div>
			</div>

			<div class="layer-header1 clearfix">
				<div class="col-lft">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.order_no}</a></div>
						<ul class="selectMenu">
							<c:forEach var="orderList" items="${orderList}"  varStatus="status" >
								<li><a href="#" value="${orderList.orderNo}">${orderList.orderNo}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="col-rgh">
					<span class="ico_state i_none"><em>해당없음</em></span> 
					<span class="ico_state i_reg_comp"><em>등록완료</em></span> 
					<span class="ico_state i_rereg"><em>재등록요청</em></span> 
					<span class="ico_state i_rereg_comp"><em>재등록완료</em></span> 
					<span class="ico_state i_noreg"><em>미등록</em></span>
				</div>
			</div>

			<div class="wrap_table">
				<div class="header-fixed abs"><table class="tb_1"></table><table class="tb_2"></table></div>
				<div class="header-tbody-th"><table class="tb_1"></table></div>
				<div id="wrap-Iscroll" class="inr-c">
					<div class="scroller">
						<table id="table-1" class="tbl">
							<caption>실적등록및조회 목록</caption>
							<colgroup>
								<col class="th1_6">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" rowspan="3" id="th_a">진단항목</th>
									<c:forEach var="i" items="${mngLevelIdxList }"
										varStatus="status">
										<c:if test="${i.LV == '1' }">
											<c:if test="${i.IDX == '1' }">
												<th scope="colgroup" colspan="${i.DCNT }">
													<span class="tooltip" title="${i.CONTENTS }">${i.IDX }</span>
													<div class="tooltip_cont"><span>${i.CONTENTS }</span></div>
												</th>
											</c:if>
											<c:if test="${i.IDX == '2' }">
												<th scope="colgroup" colspan="${i.DCNT }"><span class="tooltip" title="${i.CONTENTS }">${i.IDX }</span>
													<div class="tooltip_cont"><span>${i.CONTENTS }</span>
													</div>
												</th>
											</c:if>
											<c:if test="${i.IDX == '3' }">
												<th scope="colgroup" colspan="${i.DCNT }"><span class="tooltip" title="${i.CONTENTS }">${i.IDX }</span>
													<div class="tooltip_cont"><span>${i.CONTENTS }</span></div>
												</th>
											</c:if>
										</c:if>
									</c:forEach>
									</th>
								</tr>
								<tr class="th_small1">
									<c:forEach var="i" items="${mngLevelIdxList }" varStatus="status">
										<c:if test="${i.LV == '2' }">
											<th colspan="${i.DCNT }"><span title="${i.CONTENTS }" class="tooltip">${i.IDX }</span>
												<div class="tooltip_cont"><span>${i.CONTENTS }</span></div>
											</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr class="th_small1">
									<c:forEach var="i" items="${mngLevelIdxList }" varStatus="status">
										<c:if test="${i.LV == '3' }">
											<th colspan="${i.DCNT }"><span title="${i.CONTENTS }" class="tooltip">${i.IDX }</span>
												<div class="tooltip_cont"><span>${i.CONTENTS }</span></div>
											</th>
										</c:if>
									</c:forEach>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="i" items="${mngLevelInsttList }" varStatus="status">	
									<tr>	
									<c:set var="tmpInsttCd" value="${i.INSTT_CD }" />						
										<c:choose>
											<c:when test="${status.first }">
												<th scope="row" class="th_st1 cate1">
													<a href="#" class="link1" onclick="fn_detail('${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }', '${i.INSTT_CD }', '${i.INSTT_NM }');" title="실적등록">${i.INSTT_NM }</a>
												</th>
												<c:set var="tmpInsttClCd" value="${i.INSTT_CL_CD }" />
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${i.INSTT_CL_CD != tmpInsttClCd}">
														<th scope="row" class="th_st1 th_st1 cate1">
															<a href="#" class="link1" onclick="fn_detail('${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }', '${i.INSTT_CD }', '${i.INSTT_NM }');" title="실적등록">${i.INSTT_NM }</a>
														</th>
													</c:when>
													<c:otherwise>
														<th scope="row" class="th_st1 cate1"><a href="#" class="link1" onclick="fn_detail('${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }', '${i.INSTT_CD }', '${i.INSTT_NM }');" title="실적등록">${i.INSTT_NM }</a></th>
													</c:otherwise>
												</c:choose>
												<c:set var="tmpInsttClCd" value="${i.INSTT_CL_CD }" />
											</c:otherwise>
										</c:choose>
										<c:forEach var="x" items="${mngLevelInsttEvlList }" varStatus="status">
											<c:if test="${x.INSTT_CD == tmpInsttCd}">
												<td headers="">
													<c:choose>
														<c:when test="${x.EXCP_PERM_YN == 'Y' }">
															<span class="ico_state i_none"><em>해당없음</em></span>
														</c:when>
														<c:when test="${x.STATUS == '' || empty x.STATUS}">
															<span class="ico_state i_noreg"><em>미등록</em></span>
														</c:when>														
														<c:when test="${x.STATUS == 'RS03' }">
															<span class="ico_state i_reg_comp"><em>등록완료</em></span>
														</c:when>
														<c:when test="${x.STATUS == 'RS04' }">
															<span class="ico_state i_rereg"><em>재등록 요청</em></span>
														</c:when>
														<c:when test="${x.STATUS == 'RS05' }">
															<span class="ico_state i_rereg_comp"><em>재등록 완료</em></span>
														</c:when>
													<%-- 	<c:when test="${empty x.STATUS }">
															<c:choose>
																<c:when test="${empty x.ATCHMNFL_ID }">
																	<span class="ico_state i_noreg"><em>미등록</em></span>
																</c:when>
																<c:otherwise>
																	<span class="ico_state i_noreg"><em>등록완료</em></span>
																</c:otherwise>
															</c:choose>
														</c:when> --%>
													</c:choose>
												</td>
											</c:if>
										</c:forEach>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- /content -->
</form>

<script type="text/javascript">
$(document).ready(function() {
 	tableScrollMotion();
 });
</script>
