<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>

$(document).ready(function(){
	//fn_numberInit();
});

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "/admin/order/orderList.do";
	document.form.submit();
}

function regist() {
	$("#form").attr({
		method : "post",
		action : "/admin/order/orderWrite.do"
	}).submit();
}

function modify(seq) {
	$("#orderNo").val(seq);
	$("#isModify").val('Y');
	
	$("#form").attr({
		method : "post",
		action : "/admin/order/orderWrite.do"
	}).submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<c:set var="now" value="<%= new java.util.Date() %>" />
	<input type="hidden" id="tmpOrder" name="tmpOrder" value="<fmt:formatDate pattern="yyyy" value="${now}"/>">
	<input type="hidden" id="orderNo" name="orderNo" value=""/>
	<input type="hidden" id="isModify" name="isModify" value="N"/>
    
<!-- main -->
<div id="main">
    <div id="container" class="group">
    	<div class="header"><h3>차수 관리</h3></div>
		<div class="body">
	        <div class="board_list_top">
	            <div class="board_list_info">
					전체 <span id="totalCount">${resultListCnt}</span>개
			   </div>		
			</div>
			<table class="board_list_normal" summary="번호, 차수, 관리수준 진단, 관리수준 현황조사, 최종 수정일, 관리로 구성된 차수관리 리스트입니다.">
				<colgroup>
					<col style="width:70px;">
					<col style="width:70px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:110px;">
					<col style="width:100px;">
					<col style="width:100px;">
				</colgroup>
				<thead>
	                  <tr>
	                      <th scope="col" rowspan="2">번호</th>
	                      <th scope="col" rowspan="2">차수</th>
	                      <th scope="colgroup" colspan="5">관리수준 진단</th>
	                      <th scope="colgroup" colspan="2">관리수준 현황조사</th>
	                      <th scope="col" rowspan="2">최종<br />수정일</th>
	                      <th scope="col" rowspan="2">관리</th>
	                  </tr>
	                  <tr>                           
	                      <th scope="col">실적등록<br>(본부+소속)</th>
	                      <th scope="col">실적등록<br>(산하)</th>
	                      <th scope="col">서면평가</th>
	                      <th scope="col">이의신청</th>
	                      <th scope="col">최종평가</th>
	                      <th scope="col">현장점검</th>
	                      <!-- <th scope="col">이의신청</th> -->
	                      <th scope="col">최종평가</th>
	                  </tr>               
				</thead>
				<tbody id="threadList">
		           	<c:choose>
		           		<c:when test="${!empty resultList}">
		         			<c:forEach var="result" items="${resultList}" varStatus="status">
		             		<tr>
		             			<td class="num"><c:out value="${(pageIndex-1) * pageSize + status.count}"/></td>
		             			<td class="center" style="width: 90px;">
		             				<c:choose>
			             				<c:when test="${result.CURRENT_YN == 'Y' }">
			             					<span style="color: #00a5e5; font-weight:bold;">${result.SEQ}</span>
			             				</c:when>
			             				<c:otherwise>
			             					<span>${result.SEQ}</span>
			             				</c:otherwise>
		             				</c:choose>
		             			</td>
		             			
							 	<fmt:parseDate  value="${result.MNG_LEVEL_REGIST_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.MNG_LEVEL_REGIST_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                  var="startFmt" 	pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 					 var="endFmt" 	    pattern="yyyy.MM.dd HH:mm" />
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			
							 	<fmt:parseDate  value="${result.MNG_LEVEL_REGIST_BGNDE2}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.MNG_LEVEL_REGIST_ENDDE2}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                   var="startFmt" 	 pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 					  var="endFmt" 	     pattern="yyyy.MM.dd HH:mm" />		             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			
							 	<fmt:parseDate  value="${result.MNG_LEVEL_EVL_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.MNG_LEVEL_EVL_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"               var="startFmt" 	 pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				  var="endFmt" 	     pattern="yyyy.MM.dd HH:mm" />			             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			
							 	<fmt:parseDate  value="${result.MNG_LEVEL_FOBJCT_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.MNG_LEVEL_FOBJCT_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                  var="startFmt" 	pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				     var="endFmt" 	    pattern="yyyy.MM.dd HH:mm" />			             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			 
							 	<fmt:parseDate  value="${result.MNG_LEVEL_RESULT_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.MNG_LEVEL_RESULT_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                  var="startFmt" 	pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				     var="endFmt" 	    pattern="yyyy.MM.dd HH:mm" />			             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			
							 	<fmt:parseDate  value="${result.STTUS_EXAMIN_REGIST_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.STTUS_EXAMIN_REGIST_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                 	var="startFmt" 	   pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				    	var="endFmt" 	   pattern="yyyy.MM.dd HH:mm" />		             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>
		             			<%-- 
							 	<fmt:parseDate  value="${result.STTUS_EXAMIN_FOBJCT_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.STTUS_EXAMIN_FOBJCT_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                 	var="startFmt" 	   pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				    	var="endFmt" 	   pattern="yyyy.MM.dd HH:mm" />		             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>		
		             			 --%>
							 	<fmt:parseDate  value="${result.STTUS_EXAMIN_RESULT_BGNDE}" var="dateStartFmt" pattern="yyyy-MM-dd HH:mm" />
								<fmt:parseDate  value="${result.STTUS_EXAMIN_RESULT_ENDDE}" var="dateEndFmt"   pattern="yyyy-MM-dd HH:mm" />
								<fmt:formatDate value="${dateStartFmt}"                     var="startFmt" 	   pattern="yyyy.MM.dd HH:mm" />
								<fmt:formatDate value="${dateEndFmt}" 				        var="endFmt" 	   pattern="yyyy.MM.dd HH:mm" />		             			
		             			<td class="date">${startFmt} ~ <br/>${endFmt}</td>			             			             			
		             			
		             			<td class="date">${result.updateDt}</td>
		 						<td class="center"><a href="#" onclick="modify(${result.SEQ});" class="link">수정</a></td>
		             		</tr>
		             		<c:if test="${status.last}">
		             			<input type="hidden" id="lastOrder"  value="${result.SEQ}">
		             		</c:if>
			             	</c:forEach>
						</c:when>
						<c:otherwise>
							<td class="none"  colspan="11">등록된 데이타가 없습니다.</td>
							<input type="hidden" id="lastOrder"  value="">
						</c:otherwise>
		           	</c:choose>
				</tbody>
			</table>
                
			<div class="pagination">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
			</div>
		
			<div class="board_list_btn right">
				<a href="#" onclick="regist();"class="btn blue" >차수등록</a>
			</div>
		</div>
    </div>
</div>
    <!-- /content -->
</form>