<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
$(document).ready(function(){
	
	$("#chkAll").on("click", function(){
		$(".subchk").prop("checked", $("#chkAll").prop("checked"));
	})
	
});

function goPage(cd) {
	
	$("#mngLevelCd").val(cd);
	
	$("#fyerSchdulForm").attr({
        action : "/admin/order/fyerSchdulList.do",
        method : "post"
    }).submit();
}

function goDelete() {
	var p_seq = [];
	
	var chk = 0;
	
	$(".subchk:checked").each(function(i){
		p_seq[i] = $(this).val();
		chk++;
	})
	
	if(0 == chk) {
		alert('일정을 선택해주세요');
		return;
	}
	
	if (confirm("일정을 삭제 하시겠습니까?")) {
	
		pParam = {};
		pParam.seq = p_seq;
		
		$.ccmsvc.ajaxSyncRequestPost(
			'/admin/order/deleteFyerSchdul.do',
			pParam,
			function(data, textStatus, jqXHR){
				alert(data.message);
			}, 
			function(jqXHR, textStatus, errorThrown){
			});
		
		$("#fyerSchdulForm").attr({
			method : "post"
		}).submit();
	}
}

function fnMakeDate(formatedDt){
	var ymd = formatedDt.split(".");
	if(ymd[0].length > 4) {
		return ymd[0];
	} else {
		return ymd[0]+ymd[1]+ymd[2];		
	}
}

function goFyerSchdulListView(seq, mngLevelBgnde, mngLevelEndde, mngLevelTitle, mngLevelCn) {
	
	if('' != seq) {
 		$("#fyerSeq").val(seq);
 		$("#yyyy").val($("#orderNo").val());
	}

	$("#fyerSchdulForm").attr({
        action : "/admin/order/fyerSchdul.do",
        method : "post"
    }).submit(); 	
	
} 
</script>

<form method="post" id="fyerSchdulForm" name="fyerSchdulForm">
	<input name="fyerSeq" id="fyerSeq" type="hidden" />
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="ML02" />
	<input name="yyyy" id="yyyy" type="hidden" />	

	<!-- content -->
	<div id="main">
		<div class="group">
			<div class="header" style="margin-bottom: 17px;"><h3>일정 관리</h3></div>
			<div class="header">
				<div class="select">
					년도별 일정&nbsp;&nbsp;&nbsp;&nbsp; 
					<select class="ipt" style="width: 100px;" title="년도 선택" id="orderNo" name="orderNo" onchange="goPage('ML02'); return false;">
						<c:forEach var="orderList" items="${orderList}" varStatus="status">
							<option value="${orderList.orderNo}"
								<c:if test="${requestZvl.yyyy eq orderList.orderNo}">selected</c:if>>${orderList.orderNo}
							</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<ul class="tabs">
				<li class="tab"><a href="#" onclick="goPage('ML01'); return false;"><span>관리수준 진단</span></a></li>
				<li class="tab active"><a href="#"><span>관리수준 현황조사</span></a></li>
				<li class="tab"><a href="#" onclick="goPage('ML03'); return false;"> <span>서면점검</span></a></li>
			</ul>
			<div class="body">
				<div class="tabCont">
					<table class="board_list_normal">
						<thead>
							<tr>
								<th><input type="checkbox" id="chkAll" name="chkAll" class="custom"><label for="chkAll" class="text-none"></label></th>
								<th scope="col">번호</th>
								<th scope="col">일정</th>
								<th scope="col">제목</th>
								<th scope="col">등록일</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${!empty resultList}">
									<c:forEach var="list" items="${resultList}" varStatus="status">
										<tr>
											<td class="chk">
												<input type="checkbox" id="check${status.index}" name="check${status.index}" value="${list.seq}" class="custom subchk" /> 
												<label for="check${status.index}" class="text-none"></label>
											</td>
											<td class="num">${status.index + 1}</td>
										 	<fmt:parseDate value="${list.mngLevelBgnde}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
											<fmt:parseDate value="${list.mngLevelEndde}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
											<fmt:formatDate value="${dateStartFmt}" var="startFmt" 			pattern="yyyy.MM.dd HH:mm" />
											<fmt:formatDate value="${dateEndFmt}" var="endFmt" 				pattern="yyyy.MM.dd HH:mm" />
											<td class="center" style="width: 200px;">${startFmt} ~</br>${endFmt}</td>
											<td class="title">${list.mngLevelTitle}</td>
											<fmt:parseDate value="${list.registDt}" var="dateRegistFmt" 	pattern="yyyy-MM-dd HH:mm:ss.S" />
											<td class="date"><fmt:formatDate value="${dateRegistFmt}" 					pattern="yyyy.MM.dd" /></td>
											<td class="center" style="width: 100px;">
												<a href="#" onclick="goFyerSchdulListView('${list.seq}', '${startFmt}', '${endFmt}', '${list.mngLevelTitle}', '${list.mngLevelCn}');" class="link">수정</a>
											</td>										
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="6" class="none">등록된 데이터가 없습니다.</p>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					<div class="board_list_btn right">
						<a href="#" class="btn black" onclick="goDelete();">선택삭제</a>
						<a href="#" class="btn blue" onclick="goFyerSchdulListView('', '', '', '', '');">일정등록</a>
					</div>
				</div>
			</div>
			<!-- /content -->
		</div>
	</div>
</form>