<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var pUrl, pParam;
var deleteMsgArray       = new Array();

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "/admin/org/orgList.do";
	document.form.submit();
}

function fnCheckMsg(index) {
	$( "input[name=seq_" + index + "]" ).prop( "checked", $( "#seq_all" ).prop( "checked" ) );
}  

function fnDeleteMsg(index) {
	
    var cnt = 0;
	$( "input:checkbox[name=seq_" + index + "]" ).each( function() {
		if( $("input:checkbox[id=" + $(this).attr("id") + "]" ).prop( "checked")) {
			deleteMsgArray[cnt] = $(this).attr("id");
			cnt++;
		}
	});   

	if(cnt == 0){
		alert("기관을 선택해 주세요."); return false;
	}
	
		if (confirm("삭제하시겠습니까?")) {
			var pUrl = "/admin/org/deleteOrg.do";
	 		var param = new Object();
			
	 		param.seq  = deleteMsgArray;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		document.form.action = "/admin/org/orgList.do";
	 		document.form.submit();
		}
}

function orgWrite() {
	$("#gubun").val("I");
	document.form.action = "/admin/org/orgWrite.do";
	document.form.submit();
}

function orgUpdate(seq) {
	$("#gubun").val("U");
	$("#insttCd").val(seq);
	document.form.action = "/admin/org/orgWrite.do";
	document.form.submit();
}

function selectList(){
	$("#pageIndex").val("1");
	document.form.action = "/admin/org/orgList.do";
	document.form.submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="gubun" name="gubun">
	<input type="hidden" id="insttCd" name="insttCd">

	<!-- main -->
    <div id="main">
        <div class="group">
           	<div class="header"><h3>기관 관리</h3></div>
            <div class="body">
            	<div class="board_list_top">
	                <div class="board_list_info">
	                    Total. <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>
	                </div>
	                <div class="board_list_search">
	                    <div class="ipt_group">
	                        <%-- <input type="text" name="sw" value="${param.sw}" class="ipt" placeholder="검색어를 입력하세요"> --%>
	                        <input type="text" name="instt_nm" value="${requestZvl.instt_nm}" class="ipt" placeholder="검색어를 입력하세요">
	                        <span class="ipt_right addon">
	                        	<button type="submit" class="btn searhBtn" onclick="selectList();">검색</button>
	                        </span>
	                    </div>
	                </div>
	            </div>
                <table class="board_list_normal" summary="전체선택, 번호, 구분, 기관명, 출력순서, 등록일, 등록자, 사용여부, 관리로 구성된 기관관리 리스트입니다.">
                    <thead>
	                    <tr>
                            <th>
                            	<input type="checkbox" id="seq_all" onClick="javascript:fnCheckMsg('${pageIndex}');" class="custom">
                            	<label for="seq_all" class="text-none"></label>
                            </th>
	                        <th>번호</th>
	                        <th>구분</th>
	                        <th>기관명</th>
	                        <th>출력순서</th>
	                        <th>등록일</th>
	                        <th>등록자</th>
	                        <th>사용여부</th>
	                        <th>관리</th>
	                    </tr>
	                </thead>
		                <tbody id="threadList">
		                	<c:if test="${empty resultList}">
		                		<td class="none" colspan="9">리스트가 없습니다.</td>
		                	</c:if>
		                	<c:forEach var="result" items="${resultList}" varStatus="status">
		                		<tr>
                            		<td class="num">
                                		<input type="checkbox" class="custom" id="<c:out value="${result.SEQ}"/>" name="seq_<c:out value="${pageIndex}"/>">
                                		<label for="<c:out value="${result.SEQ}"/>" class="text-none"></label>
                            		</td> 
		                			<td class="num"><c:out value="${(pageIndex-1) * pageSize + status.count}"/></td>
		                			<td class="center"><c:out value="${result.INSTT_CL_CD_NM}"/></td>
		                			<td class="center">${result.INSTT_NM}</td>
		                			<td class="center">${result.OUTPUT_ORDR}</td>
		                			<td class="date">${result.REGIST_DT}</td>
		                			<td class="center">${result.TRNSMIT_NM}</td>
		                			<td class="state"><c:if test="${result.DELETE_YN eq 'N'}"><span class="active">사용</span></c:if>
		                			<c:if test="${result.DELETE_YN ne 'N'}"><span class="">미사용</span></c:if></td>
		                			<td class="center"><a href="#" onclick="orgUpdate('${result.SEQ}');" class="link">관리</a></td>
		                		</tr>
		                	</c:forEach>
		                </tbody>
                </table>
                
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
                
                <div class="board_list_btn right">
                	<a href="#" class="btn red" onClick="fnDeleteMsg('${pageIndex}')">선택삭제</a>
	                <a href="#" onclick="orgWrite();"class="btn blue" >기관등록</a>
	            </div>
            </div>
        </div>
    </div>
    <!-- /main -->
</form>