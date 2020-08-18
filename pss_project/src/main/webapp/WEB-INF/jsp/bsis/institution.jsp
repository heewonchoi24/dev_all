<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
var authRead  = '${sessionScope.userInfo.authRead}';
var authWrite = '${sessionScope.userInfo.authWrite}';
var authDwn   = '${sessionScope.userInfo.authDwn}';

$(document).ready(function(){
	$(".selectMenu>li>a").on('click',function(e){
		$("#orderNo").val($(this).attr('value'));
		
		$("#form").attr({
	        action : "/bsis/institution.do",
	        method : "post"
	    }).submit();		
	});	
});

function fn_excel_download() {
	
	// DOWNLOAD 권한 체크
	if(authCheckDwn() == false) return false;
	
   	$("#form").attr({
	    action : "/bsis/institutionExcelDownload.do",
	    method : "post"
    }).submit();
}
</script>

<form action="/bsis/institution.do" method="post" id="form" name="form">
	<input type="hidden" id="orderChk" name="orderChk" value="" /> 
	<input type="hidden" id="insttCd" name="insttCd" value="" />
	<input type="hidden" id="searchInsttNm" name="searchInsttNm" value="" />	
	<input type="hidden" id="orderNo" name="orderNo" value="${requestZvl.orderNo}" />	
	<!-- content -->

	<section id="container" class="sub">
		<div class="container_inner">
			<div class="layer-header1 clearfix">
				<div class="col-lft">
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
				</div>
			</div>

			<div class="wrap_table inr-c">
				<table class="header-fixed"></table>
				<table id="table-1" class="tbl table-bordered">
					<caption>기초현황 리스트</caption>
					<colgroup>
						<col>
						<col>
						<col>
					</colgroup>
					<thead>
						<tr>
							<th scope="col" id="th_b">기관명</th>
							<th scope="col" id="th_c">기관개요</th>
							<th scope="col" id="th_d">개인정보 현황</th>
						</tr>
					</thead>
					<tbody>

					<script>
	            	var chk = 0;
	            	</script>

						<c:forEach var="i" items="${orgBoxClList }" varStatus="status1">

						<script>
	            		var idx = ['a','b','c','d','e','f','g'];
	            		</script>

							<c:forEach var="j" items="${orgBoxList }" varStatus="status">
								<c:if test="${i.code eq j.insttClCd }">
									<tr>
										<td class="cate1" headers="th_b a_"+idx[chk]>${j.insttNm }</td>
										<td headers="th_c a_"+idx[chk]><a href="#" class="link1" onClick="javascript:selectList('${j.insttCd}', '${j.insttNm}'); return false;">상세보기</a></td>
										<td headers="th_d a_"+idx[chk]>
											<span class="no_input">
												<c:if test="${j.cntSys eq 0 || j.cntVideo eq 0 }">
													미입력
												</c:if>
												<c:if test="${j.cntSys ne 0 and j.cntVideo ne 0 }">
													입력 완료
												</c:if>												
											</span>
										</td>
									</tr>
								</c:if>
							</c:forEach>

						<script>
	            		chk ++ ;
	            		</script>

						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- 관리자만 다운로도 가능하게 추가 2018-05-03 -->
			<c:if test="${sessionScope.userInfo.authorId eq '1'}">
				<div class="btn-bot2">
					<a href="javascript:fn_excel_download();" class="btn-pk s gray rv"><span class="i-aft i_down">전체 기관 담당자 엑셀 다운로드</span></a>
				</div>
			</c:if>
		</div>
	</section>
	<!-- /content -->
</form>

<script>
function selectList(insttCd, searchInsttNm){
	
 	$("#insttCd").val(insttCd);
	$("#searchInsttNm").val(searchInsttNm);
	
	$("#form").attr({
        action : "/bsis/institutionDetail.do",
        method : "post"
    }).submit(); 
}
</script>