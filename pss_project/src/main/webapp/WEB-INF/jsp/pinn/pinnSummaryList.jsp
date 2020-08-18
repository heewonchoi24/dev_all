<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 차수 검색 선택 시
		$(".selectMenu>li>a").on('click',function(e){
			$("#searchYyyy").val($(this).attr('value'));
			selectList();
		});
		
		$("#searchInsttClCd").change(function(){
			changeInsttList(this.value);
		});
		
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
	
	function goDtl(insttCd, insttNm, insttClCd, insttClNm){
		$("#insttCd").val(insttCd);
		$("#insttNm").val(insttNm);
		$("#insttClCd").val(insttClCd);
		$("#insttClNm").val(insttClNm);
		
		$("#pinnForm").attr({
	        action : "/pinn/pinnDtlList.do",
	        method : "post"
	    }).submit();
	}

	function selectList(){
		
		$("#pinnForm").attr({
	        action : "/pinn/pinnSummaryList.do",
	        method : "post"
	    }).submit();
	}

	
</script>

<form method="post" id="pinnForm" name="pinnForm">
	<input type="hidden" id="insttCd" name="insttCd" value=""/>
	<input type="hidden" id="insttNm" name="insttNm" value=""/>
	<input type="hidden" id="insttClCd" name="insttClCd" value=""/>
	<input type="hidden" id="insttClNm" name="insttClNm" value=""/>

<section id="container" class="sub">
	<!-- content -->
    <div id="container" class="container_inner">
        <div class="layer-header1 clearfix">
            <div class="col-lft">
            	<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1">${requestZvl.searchYyyy }</a></div>
					<ul class="selectMenu">
            			<c:forEach var="list" items="${yyyyList}" varStatus="status" >
            				<li><a href="#" value="${list.yyyy}">${list.yyyy}</a></li>
		                </c:forEach>
		                <input type="hidden" id="searchYyyy" name="searchYyyy" value="${requestZvl.searchYyyy }" />
	                </ul>
                </div>
            </div>
           	<div class="col-rgh">
				<span class="ico_state i_reg_comp"><em>등록완료</em></span>
				<span class="ico_state i_result_total"><em>최종결과</em></span>
				<span class="ico_state i_noreg"><em>미등록</em></span>
			</div>
		</div>
            	
                <div class="wrap_table inr-c">
                	<table class="header-fixed"></table>
                	<table id="table-1" class="tbl table-bordered">
	                	<caption>서면점검 실적등록 및 조회 리스트</caption>
						<colgroup>
							<col class="th1_1">
							<col class="th1_2">
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
							<col>
						</colgroup>
					    <thead>
						    <tr>
						        <th scope="col" id="th_a1">구분</th>
								<th scope="col" id="th_a2">기관명</th>
								<th scope="col" id="th_b">1월</th>
								<th scope="col" id="th_c">2월</th>
								<th scope="col" id="th_d">3월</th>
								<th scope="col" id="th_e">4월</th>
								<th scope="col" id="th_f">5월</th>
								<th scope="col" id="th_g">6월</th>
								<th scope="col" id="th_h">7월</th>
								<th scope="col" id="th_i">8월</th>
								<th scope="col" id="th_j">9월</th>
								<th scope="col" id="th_k">10월</th>
								<th scope="col" id="th_l">11월</th>
								<th scope="col" id="th_n">12월</th>
						    </tr>
						</thead>
						<tbody>
							<tr>
								<c:set var="tmpInsttClCd" value=""/>
								<c:forEach var="list" items="${orgList}" varStatus="status">
									<c:choose>
										<c:when test="${status.first}">
											<tr>
												<th scope="rowgroup" rowspan="${list.rowCnt}" id="a_a">${list.insttClNm}</th>
												<th scope="row" id="a_a_1" class="th_st1"><a href="#" title="상세현황 보기" onclick="goDtl('${list.insttCd}','${list.insttNm}','${list.insttClCd}', '${list.insttClNm}' )" class="link1">${list.insttNm}</a></th>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${tmpInsttClCd ne list.insttClCd}">
													<tr>
														<th scope="rowgroup" rowspan="${list.rowCnt}" id="a_a">${list.insttClNm}</th>
														<th scope="row" id="a_a_1" class="th_st1"><a href="#" title="상세현황 보기" onclick="goDtl('${list.insttCd}','${list.insttNm}','${list.insttClCd}', '${list.insttClNm}' )" class="link1">${list.insttNm}</a></th>
												</c:when>
												<c:otherwise>
													<tr>
												  		<th scope="row" id="a_a_1" class="th_st1"><a href="#" title="상세현황 보기" onclick="goDtl('${list.insttCd}','${list.insttNm}','${list.insttClCd}', '${list.insttClNm}' )" class="link1">${list.insttNm}</a></th>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
	                              	</c:choose>
									<c:forEach var="resultList" items="${resultList}" varStatus="status1">
										<c:if test="${list.insttCd eq resultList.insttCd}">
											<td>
												<c:choose>
													<c:when test="${'' eq resultList.status}">
														<span class="ico_state i_noreg"><em>미등록</em></span>
													</c:when>
													<c:when test="${'RS03' eq resultList.status}">
														<span class="ico_state i_reg_comp"><em>등록완료</em></span>
													</c:when>
													<c:otherwise>
														<span class="ico_state i_result_total"><em>최종결과</em></span>
													</c:otherwise>
												</c:choose>
											</td>
											<c:set var="monthCnt" value="${12-resultList.mm }"></c:set>
										</c:if>
									</c:forEach>
									<!-- 일정등록이 되지 않았을 때 칸 만들기 -->
									<c:forEach begin="1" end="${monthCnt }">
										<td></td>
									</c:forEach>
								<c:set var="tmpInsttClCd" value="${list.insttClCd}"/>
							</c:forEach>
							</tr>
						</tbody>
               		</table>
            </div>                
        </div>
    </div>
</section>
    <!-- /content -->
</form>
