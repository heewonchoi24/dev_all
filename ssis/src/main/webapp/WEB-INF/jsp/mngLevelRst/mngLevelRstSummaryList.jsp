<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	$(document).ready(function(){
		$(".selectMenu>li>a").on('click',function(e){
			$("#orderNo").val($(this).attr('value'));
			goAjax();
		});	
	});
	
	function fn_goDtl(insttCd, insttNm) {
		
		$("#insttCd").val(insttCd);
		$("#insttNm").val(insttNm);
				
    	$("#form").attr({
            action : "/mngLevelRst/mngLevelRstSummaryDtlList.do",
            method : "post"
        }).submit();
	}
	
	function goAjax(){
		document.form.action = "/mngLevelRst/mngLevelRstSummaryListAjax.do";
		document.form.submit();
	}	
</script>

<form method="post" id="form" name="form">
	
	<input name="insttCd" id="insttCd" type="hidden" value=""/>
	<input name="insttNm" id="insttNm" type="hidden" value=""/>
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.orderNo}" />
	
    <!-- content -->
    <section id="container" class="sub">
       <div class="container_inner">
       
			<div class="box-info mb30">
				<div class="icon"><span class="i-set i_info_i"></span></div>
				<div class="cont">
					<ul class="lst-dots">
						<li>기관명을 클릭하시면 수준진단 결과를 확인하실 수 있습니다.</li>
						<li>진단항목에 마우스 오버를 하시면 진단항목에 대한 자세한 설명을 보실 수 있습니다.</li>
					</ul>
				</div>
			</div>       
       
			<div class="layer-header1 clearfix">
				<div class="col-lft">
					<div class="box-select-ty1 type1">
						<div class="selectVal" tabindex="0"><a href="#this" tabindex="-1" >${requestZvl.orderNo}</a></div>
						<ul class="selectMenu">
							<c:forEach var="orderList" items="${orderList}"  varStatus="status" >
								<li><a href="#" value="${orderList.orderNo}">${orderList.orderNo}</a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>

           	<c:choose>
				<c:when test="${!empty resultList}">
		           	<div class="wrap_table inr-c">
		           		<table class="header-fixed"></table>
		                <table id="table-1" summary="기관명, 중간결과, 최종결과, 점검완료 일시로 구성된 수준진단 결과 리스트입니다.">
		                	<caption>수준진단 결과 리스트</caption>
		                    <colgroup>
							  <col class="th1_5">
							  <col>
		                    </colgroup>
		                    <thead>
		                        <tr>
									<th scope="col" id="th_b">기관명</th>
									<th scope="col" id="th_c">중간결과</th>
									<th scope="col" id="th_d">최종결과</th>
									<th scope="col" id="th_e">점검완료 일시</th>
		                        </tr>
		                    </thead>
		                    <tbody>
								<c:set var="tmpInsttCd" value=""/>
								<c:forEach var="list" items="${resultList}" varStatus="status">
			                    	<c:choose>
										<c:when test="${status.first}">
					                        <tr>
					                            <th class="th_st1 ta-c cate1"><a href="#" class="link1" onclick="javascript:fn_goDtl('${list.insttCd}', '${list.insttNm}'); return false;" title="상세보기">${list.insttNm}</a></th>
					                            <td>${list.totResultScore1}</td>
					                            <td>${list.totResultScore2}</td>
					                            <td>${list.evalDt}</td>
					                        </tr>
										</c:when>
										<c:otherwise>
											<tr>
												<th class="th_st1 ta-c cate1"><a href="#" class="link1" onclick="javascript:fn_goDtl('${list.insttCd}', '${list.insttNm}'); return false;" title="상세보기">${list.insttNm}</a></th>
					                            <td>${list.totResultScore1}</td>
					                            <td>${list.totResultScore2}</td>
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
		                <p class="c_gray f17">수준결과가 없습니다.</p>
		            </div>
		    	</c:otherwise>
		    </c:choose>
        </div>
    </section>
    <!-- /content -->
</form>

<script type="text/javascript">
  $(".wrap_table").tableFixed();
</script>
