<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
$(document).ready(function(){
	
	tableScrollMotion();
	// 검색 옵션 선택 시
	$(document).on("click",".selectMenu>li>a",function(){
		$("#order_no").val(this.dataset.yyyy);
		selectList();
	});
	<c:if test="${sessionScope.userInfo.authorId =='5'}">
		$(".selectMenu").hide();
	</c:if>
});

function fn_insertStatusExaminRes(instt_cd, instt_nm, instt_cl_cd, instt_cl_nm){
	
		$("#instt_cd").val(instt_cd);
		$("#instt_nm").val(instt_nm);
		$("#instt_cl_cd").val(instt_cl_cd);
		$("#instt_cl_nm").val(instt_cl_nm);
		
		$("#form").attr({
	        action : "/statusExaminReq/statusExaminResultModifyList.do",
	        method : "post"
	    }).submit();
		
}

function selectList(){
	
	$("#form").attr({
        action : "/statusExaminReq/statusExaminResultSummaryList.do",
        method : "post"
    }).submit();
	
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="instt_cd" name="instt_cd" value="">
	<input type="hidden" id="instt_cl_cd" name="instt_cl_cd" value="">
	<input type="hidden" id="instt_nm" name="instt_nm" value="">
	<input type="hidden" id="instt_cl_nm" name="instt_cl_nm" value="">
	<input type="hidden" id="order_no" name="order_no" value="${requestZvl.order_no}">
	
<section id="container" class="sub">
	<!-- content -->
	<div class="container_inner">

            <div class="layer-header1 clearfix">
				<div class="col-lft">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.order_no}</a></div>
						<ul class="selectMenu">
		                    <c:forEach var="orderList" items="${statusExaminInsttEvlOrderList}"  varStatus="status" >
		                    	<li><a href="#" data-yyyy="${orderList.ORDER_NO}">${orderList.ORDER_NO}</a></li>
			                </c:forEach>
	                	</ul>
                	</div>
               	</div>
				<div class="col-rgh">
					<span class="ico_state i_eval"><em>현장점검</em></span>
					<span class="ico_state i_result_total"><em>최종결과</em></span>
				</div>
			</div>	

			<div class="wrap_table">
				<div class="header-fixed abs"><table class="tb_1"></table><table class="tb_2"></table></div>
				<div class="header-tbody-th"><table class="tb_1"></table></div>
				<div id="wrap-Iscroll" class="inr-c">
					<div class="scroller">
						<table id="table-1" class="tbl">
							<caption>현장점검등록 목록</caption>
							<colgroup>
								<col class="th1_1">
								<col class="th1_6">
							</colgroup>
							<thead>
						<tr>
							<th scope="col" rowspan="4" colspan="2" id="th_a">진단항목</th>
							<c:forEach var="i" items="${statusExaminIdxList }" varStatus="status">
								<c:if test="${i.LV == '1' }">
									<th scope="colgroup" colspan="${i.DCNT }" ><span class="tooltip">${i.IDX }</span><div class="tooltip_cont"><span>${i.CONTENTS }</span></div></th>	
								</c:if>
							</c:forEach>
						</tr>
						<tr class="th_small1">
							<c:forEach var="i" items="${statusExaminIdxList }" varStatus="status">
								<c:if test="${i.LV == '2' }">
									<th scope="col" colspan="${i.DCNT }"><span class="tooltip">${i.IDX }</span><div class="tooltip_cont"><span>${i.CONTENTS }</span></div></th>
								</c:if>
							</c:forEach>
						</tr>
						<%-- 
						<tr class="th_small1">
							<c:forEach var="i" items="${statusExaminIdxList }" varStatus="status">
								<c:if test="${i.LV == '3' }">
									<th scope="col" colspan="${i.DCNT }"><span class="tooltip">${i.IDX }</span><div class="tooltip_cont"><span>${i.CONTENTS }</span></div></th>
								</c:if>
							</c:forEach>
						</tr>
						--%>
						<tr class="th_small1">
							<c:forEach var="i" items="${statusExaminIdxList }" varStatus="status">
								<c:if test="${i.LV == '4' }">
									<th scope="col" colspan="${i.DCNT }"><span class="tooltip">${i.IDX }</span><div class="tooltip_cont"><span>${i.CONTENTS }</span></div></th>
								</c:if>
							</c:forEach>
						</tr>
						 
					</thead>
							<tbody>
								<c:forEach var="i" items="${statusExaminInsttList }" varStatus="status">
							<tr>
								<c:choose>
									<c:when test="${status.first }">
										<th scope="col" rowspan="${i.DCNT }">${i.INSTT_CL_NM }</th>
										<th scope="row" class="th_st1"><a href="#" onclick="fn_insertStatusExaminRes('${i.INSTT_CD }', '${i.INSTT_NM }' , '${i.INSTT_CL_CD }' , '${i.INSTT_CL_NM }');" title="실적등록" class="link1">${i.INSTT_NM }</a></th>
										<c:set var="tmpInsttClCd" value="${i.INSTT_CL_CD }"/>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${i.INSTT_CL_CD != tmpInsttClCd}">
												<th scope="col" rowspan="${i.DCNT }">${i.INSTT_CL_NM }</th>
												<th scope="row" class="th_st1"><a href="#" onclick="fn_insertStatusExaminRes('${i.INSTT_CD }', '${i.INSTT_NM }', '${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }');" title="실적등록" class="link1">${i.INSTT_NM }</a></th>
											</c:when>
											<c:otherwise>
												<th scope="row" class="th_st1"><a href="#" onclick="fn_insertStatusExaminRes('${i.INSTT_CD }', '${i.INSTT_NM }', '${i.INSTT_CL_CD }', '${i.INSTT_CL_NM }');" title="실적등록" class="link1">${i.INSTT_NM }</a></th>
											</c:otherwise>
										</c:choose>
									<c:set var="tmpInsttClCd" value="${i.INSTT_CL_CD }"/>
									</c:otherwise>
								</c:choose>
						
								<c:set var="tmpInsttCd" value="${i.INSTT_CD }"/>
								<c:forEach var="x" items="${statusExaminInsttEvlList }" varStatus="status">
									<c:if test="${x.INSTT_CD == tmpInsttCd}">
										<td>
											<c:if test="${x.STATUS == 'ES01'}">
											<span class="ico_state i_eval""><em>현장점검</em></span>
											</c:if>
											<c:if test="${x.STATUS == 'ES05'}">
											<span class="ico_state i_result_total"><em>최종결과</em></span>
											</c:if>
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