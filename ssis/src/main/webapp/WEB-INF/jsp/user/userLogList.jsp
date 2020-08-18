<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 시스템관리 &#124; 시스템이력</title>

<script>

	$(document).ready(function(){
	
	});

	function list_Thread(pageNo) {
		document.form.pageIndex.value = pageNo;
		document.form.action = "/user/userLogList.do";
		document.form.submit();
	}
	
	function selectList(){
		$("#pageIndex").val("1");
		document.form.action = "/user/userLogList.do";
		document.form.submit();
	}
	
	function searchClear(){
		$("#searchConectCd").val("");
		$("#searchBgnde").val("");
		$("#searchEndde").val("");
	}
	
	function fn_dtl(seq, codeNm, userNm, ip, crud, conectDt) {
		
		$("#codeNm").text(codeNm);
		$("#userNm").text(userNm);
		$("#ip").text(ip);
		$("#conectDt").text(conectDt);
		$("#parameter").text($("#parameter"+seq).val());
		
		var crudNm = '';
		if('C' == crud)
			crudNm = '등록';
		else if('R' == crud)
			crudNm = '조회';
		else if('U' == crud)
			crudNm = '수정';
		else if('D' == crud)
			crudNm = '삭제';
		
		$("#crud").text(crudNm);
	}
</script>
</head>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	
	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">시스템이력</h2>
            
            <div class="content">
                <div class="board_search">
                        <fieldset>
                            <legend>게시물 검색</legend>
                            <select name="searchConectCd" id="searchConectCd" title="이력구분">
                            	<option value="">선택</option>
		                        <c:forEach var="codeList" items="${codeList}"  varStatus="status" >
				                    <option value="${codeList.CODE}" <c:if test="${searchConectCd eq codeList.CODE}">selected</c:if>>${codeList.CODE_NM}</option>
				                </c:forEach>
				           	</select>
				           	<label for="searchBgnde" class="hidden">시작일</label>
                            <input type="text" id="searchBgnde" name="searchBgnde" value="${searchBgnde}" class="w10 datepicker" placeholder="시작일" readonly="readonly">
                            <span class="hipun">~</span>
                            <label for="searchEndde" class="hidden">종료일</label>
                            <input type="text" id="searchEndde" name="searchEndde" value="${searchEndde}" class="w10 datepicker" placeholder="종료일" readonly="readonly">
                            <input type="button" onclick="selectList();" value="검색" class="button bt3 gray">
                            <input type="button" onclick="searchClear();" value="초기화" class="button bt3">
                        </fieldset>
                </div>
            </div>            
                       
            <div class="content">
                <div class="board_info">
                    <span>전체</span>
                    <strong class="c_black">${paginationInfo.getTotalRecordCount()}</strong>개,
                    <span class="ml05">현재 페이지</span>
                    <strong class="c_red">${paginationInfo.getCurrentPageNo()}</strong>/${paginationInfo.getLastPageNo()}
                </div>
                <table class="board" summary="번호, 이력구분, 접속자, 아이피, CRUD, 일시, 상세보기로 구성된 시스템이력 리스트입니다.">
                	<caption>시스템이력 리스트</caption>
                    <colgroup>
                        <col style="width:10%">
                        <col style="width:15%">
                        <col style="width:15%">
                        <col style="width:*">
                        <col style="width:10%">
                        <col style="width:15%">
                        <col style="width:10%">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">이력구분</th>
                            <th scope="col">접속자</th>
                            <th scope="col">아이피</th>
                            <th scope="col">CRUD</th>
                            <th scope="col">일시</th>
                            <th scope="col">상세보기</th>
                        </tr>
                    </thead>
		                <tbody id="threadList">
		                	<c:choose>
		                		<c:when test="${!empty resultList}">
				                	<c:forEach var="list" items="${resultList}" varStatus="status">
				                		<tr>                           		                		
				                			<td>${list.rowNum}</td>
				                			<td class="contents">${list.codeNm}</a></td>
				                			<td class="contents">${list.userNm}</a></td>
				                			<td>${list.ip}</td>
				                			<td>
				                			<c:if test="${list.crud == 'C'}">등록</c:if>
				                			<c:if test="${list.crud == 'R'}">조회</c:if>
				                			<c:if test="${list.crud == 'U'}">수정</c:if>
				                			<c:if test="${list.crud == 'D'}">삭제</c:if>
				                			<c:if test="${list.crud == ''}"> </c:if>
				                			</td>
				                			<td>${list.conectDt}</td>
				                			<td><button type="button" id="btn_${status.index}"  class="button bt2 layer_open" onClick="javascript:fn_dtl('${status.index}', '${list.codeNm}','${list.userNm}','${list.ip}','${list.crud}','${list.conectDt}'); return false;" >상세보기</button></td>
				                		</tr>
										<input type="hidden" id="parameter${status.index}" name="parameter" value="${list.parameter}">
				                	</c:forEach>
				                </c:when>
				                <c:otherwise>
				                	<tr><td colspan="7">등록된 데이터가 없습니다.</td></tr>
				                </c:otherwise>
				        	</c:choose>
		                </tbody>
                </table>
                
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
            </div>
        </div>
    </div>
    
    <!-- 레이어 팝업 -->
    <div id="layer1" class="layer">
        <div class="layer_top">
            <strong>시스템이력 상세보기</strong>
            <a href="#" class="close">닫기</a>
        </div>
        <div class="layer_content">
            <table class="write" summary="이력구분, 접속자, 아이피, CRUD, 일시, 내용으로 구성된 시스템이력 상세보기입니다.">
                <caption>시스템이력 상세보기</caption>
                <colgroup>
                    <col style="width:150px;">
                    <col style="width:*">
                </colgroup>                
                <tbody>
                    <tr>
                        <th scope="row">이력구분</th>
                        <td id="codeNm"></td>
                    </tr>
                    <tr>
                        <th scope="row">접속자</th>
                        <td id="userNm"></td>
                    </tr>
                    <tr>
                        <th scope="row">아이피</th>
                        <td id="ip"></td>
                    </tr>
                    <tr>
                        <th scope="row">CRUD</th>
                        <td id="crud"></td>
                    </tr>
                    <tr>
                        <th scope="row">일시</th>
                        <td id="conectDt"></td>
                    </tr>
                    <tr>
                        <th scope="row">PARAMETER</th>
                        <td id="parameter"></td>
                    </tr>
                </tbody>
            </table>
            <div class="tc mt30">
                <a href="#" class="button bt1 gray close">확인</a>
            </div>
        </div>
    </div>
    <!-- /레이어 팝업 -->
    <!-- /content -->
</form>