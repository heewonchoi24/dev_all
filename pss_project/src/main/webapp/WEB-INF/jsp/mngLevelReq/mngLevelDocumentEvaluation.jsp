<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
$(document).ready(function(){
	
	$(".ico_state").on('click',function(e){
		e.preventDefault();
	});
	
	$(".selectMenu>li>a").on('click',function(e){
		$("#s_order_no").val($(this).attr('value'));
		goAjax();
	});	
	
	<c:if test="${'5' eq sessionScope.userInfo.authorId}">
	$(".col-lft").hide();
	</c:if>	
});

function fn_detail(instt_cl_cd, instt_cl_nm, instt_cd, instt_nm){
	document.form.instt_cl_cd.value = instt_cl_cd;
	document.form.s_instt_cl_nm.value = instt_cl_nm;
    document.form.s_instt_cd.value = instt_cd;
	document.form.s_instt_nm.value = instt_nm;
	document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationDetail.do";
	document.form.submit();
}

function goAjax(){
	document.form.action = "/mngLevelReq/mngLevelDocumentEvaluationAjax.do";
	document.form.submit();
}
</script>

<form method="post" id="form" name="form">
<!-- 	<input type="hidden" id="s_instt_cd" name="s_instt_cd" value="">
	<input type="hidden" id="s_instt_cl_cd" name="s_instt_cl_cd" value="">
	<input type="hidden" id="s_instt_nm" name="s_instt_nm" value=""> -->
	
	<input type="hidden" name="s_instt_cl_nm" value="" /> 
	<input type="hidden" name="instt_cl_cd" value="" />
	<input type="hidden" name="s_instt_cd" value="" /> 
	<input type="hidden" name="s_instt_nm" value="" />
	<input type="hidden" id="s_order_no" name="s_order_no" value="${requestZvl.s_order_no}" />	
	
   <section id="container" class="sub">
       <div class="container_inner">
       
			<div class="box-info mb30">
				<div class="icon"><span class="i-set i_info_i"></span></div>
				<div class="cont">
					<ul class="lst-dots">
						<li>기관명을 클릭하시면 서면평가 정보를 확인하실 수 있습니다.</li>
						<li>진단항목에 마우스 오버를 하시면 진단항목에 대한 자세한 설명을 보실 수 있습니다.</li>
					</ul>
				</div>
			</div>

			<div class="layer-header1 clearfix">
	 			<div class="col-lft">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.s_order_no}</a></div>
						<ul class="selectMenu">
							<c:forEach var="orderList" items="${orderList}"  varStatus="status" >
								<li><a href="#" value="${orderList.orderNo}">${orderList.orderNo}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				
				<div class="col-rgh">
					<span class="ico_state i_none"><em>해당없음</em></span>
					<span class="ico_state i_eval"><em>서면평가</em></span>
					<span class="ico_state i_mid"><em>중간결과</em></span>
					<span class="ico_state i_obj"><em>이의신청</em></span>
					<span class="ico_state i_eval_total"><em>최종평가</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
				</div>
			</div>
		               
			<div class="wrap_table">
				<div class="header-fixed abs"><table class="tb_1"></table><table class="tb_2"></table></div>
				<div class="header-tbody-th"><table class="tb_1"></table></div>
				<div id="wrap-Iscroll" class="inr-c">
					<div class="scroller">
						<table id="table-1" class="tbl">
							<caption>서면평가 목록</caption>
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
								<c:forEach var="i" items="${mngLevelInsttSelectList }" varStatus="status">	
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
														<th scope="row" class="th_st1 cate1"><a href="#" class="link1" onclick="fn_detail('${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }', '${i.INSTT_CD }', '${i.INSTT_NM }');"	title="실적등록">${i.INSTT_NM }</a></th>
													</c:otherwise>
												</c:choose>
												<c:set var="tmpInsttClCd" value="${i.INSTT_CL_CD }" />
											</c:otherwise>
										</c:choose>
										<c:forEach var="j" items="${mngLevelInsttEvlList }" varStatus="status">
											<c:if test="${j.INSTT_CD == tmpInsttCd}">
												<td headers="">
													<c:choose>
														<c:when test="${j.EXCP_PERM_YN == 'Y'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_none"><em>해당없음</em></span></a></c:when>
														<c:when test="${empty j.STATUS}"></c:when>
														<c:when test="${j.STATUS == 'ES01'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_eval"><em>서면평가</em></span></a></c:when>
				                						<c:when test="${j.STATUS == 'ES02'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_mid"><em>중간결과</em></span></a></c:when>
				                						<c:when test="${j.STATUS == 'ES03'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_obj"><em>이의신청</em></span></a></c:when>
				                						<c:when test="${j.STATUS == 'ES04'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_eval_total"><em>최종평가</em></span></a></c:when>
				                						<c:when test="${j.STATUS == 'ES05'}"><a href="#layerPopupT3" onclick="layerPopupV2.open('/mngLevelReq/popState.do?s_order_no=${requestZvl.s_order_no}&&s_index_seq=${j.INDEX_SEQ}&&s_instt_cd=${i.INSTT_CD }', prdCallback); return false;"><span class="ico_state i_result_total"><em>최종결과</em></span></a></c:when>
				                					</c:choose>
												</td>
											</c:if>
										</c:forEach>
									</tr>
								</c:forEach>
							</tbody>
					</table>
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