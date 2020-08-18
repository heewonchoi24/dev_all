<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 시스템관리 &#124; 게시판관리</title>

<script>
var pUrl, pParam;

$(document).ready(function(){
// 	$("input[name='useYn']:checkbox").change(function(){
// 		$this = $(this);
// 		if(confirm("상태를 변경하시겠습니까?")){
// 			pParam = {};
// 			pParam.use_yn = $this.prop("checked")?'Y':'N';
// 			pParam.bbs_cd = $this.val().split(":")[0];
//  			$.post("/notice/updateBbsStatus.do", pParam, function(data){
//  				$this.value = pParam.use_yn; 
// 				alert(data.message);
// 				$("#form").submit();
//  			});
// 		}else{
// 			$this.prop("checked", !$this.prop("checked"));
// 		}
// 	});

	
});

function validate(){
	return true;
}

function bbsList(bbsCd){
	$("#bbsCd").val(bbsCd);
	$("#form").attr({
		method : "post",
		action : "/admin/notice/mngNoticeDtlList.do"
	}).submit();
}

</script>
</head>

<form action="/notice/mngNoticeList.do" method="post" id="form" name="form" onsubmit="return validate();">
	<input type="hidden" name="bbsCd" id="bbsCd">
	<!-- content -->
	<div id="container">
		<div class="content_wrap">
			<h2 class="h2">게시판 관리</h2>

			<div class="content">				
				<table class="board" summary="번호, 게시판명, 전체 게시물, 생성일시, 관리로 구성된 게시판 리스트입니다.">
					<caption>게시판 관리 리스트</caption>
					<colgroup>
						<col style="width:80px;">
						<col style="width:*">
						<col style="width:100px;">
						<col style="width:180px;">
<%-- 						<col style="width:80px;"> --%>
						<col style="width:100px;">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">게시판명</th>
							<th scope="col">전체 게시글</th>
							<th scope="col">생성일시</th>
<!-- 							<th scope="col">사용유무</th> -->
							<th scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty noticeBbsList }">
								<tr>
									<td colspan="6">데이터가 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="i" items="${noticeBbsList }" varStatus="status">
									<tr>
										<td>${status.count }</td>
										<td class="subject"><a href="#" onclick="bbsList('${i.bbsCd}'); return false;" title="상세보기">${i.bbsNm }</a></td>
										<td>${i.threadCnt }</td>
										<td>${i.registDt }</td>
	<%-- 								<td><input type="checkbox" name="useYn" value="${i.bbsCd }:${i.useYn }"<c:if test="${i.useYn == 'Y' }"> checked</c:if>></td> --%>
										<td><a href="#" onclick="bbsList('${i.bbsCd}'); return false;" class="button bt2">관리</a></td>	
									</tr>	
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- /content -->
</form>