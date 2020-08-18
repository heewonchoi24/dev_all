<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
var pUrl, pParam;
var deleteMsgArray       = new Array();

$(document).ready(function(){

});

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "/admin/auth/authList.do";
	document.form.submit();
}
/*
function fnCheckMsg(index) {
	$( "input[name=seq_" + index + "]" ).prop( "checked", $( "#seq_all" ).prop( "checked" ) );
}  

function fnDeleteMsg(index) {
    var cnt = 0;
    var seq_id ="";
    var checkDel = "Y";
    
	$( "input:checkbox[name=seq_" + index + "]" ).each( function() {
		if( $("input:checkbox[id=" + $(this).attr("id") + "]" ).prop( "checked")) {
			seq_id = $(this).attr("id");

			deleteMsgArray[cnt] = $(this).attr("id");
			if($( "#seq" + seq_id).val() > 0) {
				alert($("#dat" + seq_id).val() + " 권한 사용자가 " + $( "#seq" + seq_id).val() + "명 있습니다. \n\n삭제 할 수 없습니다.");
				checkDel = "N";
				return;
			}
			cnt++;
		}
	});   
	if(checkDel == "Y") {
		if (confirm("삭제하시겠습니까?")) {
			var pUrl = "/auth/deleteAuth.do";
	 		var param = new Object();
			
	 		param.seq  = deleteMsgArray;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		document.form.action = "/auth/authList.do";
	 		document.form.submit();
		}
	}
}  
function updateLayer(seq, sub, cont,yn){
	$( "#label0" ).val(sub);
	$( "#label1" ).val(cont);
	if(yn == "N") {
		$("input:radio[id=label21]" ).prop("checked",true);
	} else {
		$("input:radio[id=label22]" ).prop("checked",true);
	}

	$( "#seq" ).val(seq);
}
function fnSavAuthList() {
    //
	if(!$( "#label0"  ).val()){alert("권한명은 필수입력 사항입니다."); $( "#label0" ).focus(); return;}
    
    var pUrl = "/auth/authModify.do";

	var param = new Object();
	
	param.authorNm = $("#label0").val();
	param.description = $("#label1").val();
	if($("input:radio[id=label21]" ).prop("checked")) {
		param.deleteYn = 'N';
	} else {
		param.deleteYn = 'Y';		
	}
	param.authorId = $("#seq").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		alert(data.message);
		
		document.form.action = "/auth/authList.do";
		document.form.submit();
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}  
*/
function modify(isModify, authorId) {
	$("#isModify").val(isModify);
	$("#authorId").val(authorId);
	$("#form").attr({
		method : "post",
		action : "/admin/auth/authWrite.do"
	}).submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="isModify" name="isModify">
	<input type="hidden" id="authorId" name="authorId">
	
	<div id="main">
	    <div class="group">
	    <div class="header"><h3>권한관리</h3></div>
		<!-- content -->
	    <div id="container" class="body">
			<div class="board_list_top">
			    <div class="board_list_info">
			        Total. <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>
			    </div>
			</div>
				<table class="board_list_normal">
					<thead>
					    <tr>
					        <th scope="col">번호</th>
					        <th scope="col" style="width: 300px;">권한명</th>
					        <th scope="col">권한설명</th>
					        <th scope="col">등록일</th>
					        <th scope="col" style="width: 150px;">등록자</th>
					        <th scope="col">사용여부</th>
					    </tr>
					</thead>
					<tbody id="threadList">
				  		<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>                        		                		
								<td class="num"><c:out value="${(pageIndex-1) * pageSize + status.count}"/></td>
								<td class="title"><a href="#" onclick="modify('Y','${result.SEQ}');" class="button bt2 layer_open">${result.SUBJECT}</a></td>
								<td class="title">${result.CONTENTS}</td>
								<td class="date">${result.REGIST_DT}</td>
								<td style="text-align: center;">${result.TRNSMIT_NM}</td>
								<td class="state"><c:if test="${result.DELETE_YN eq 'N'}"><span class="active">사용</span></c:if>
								<c:if test="${result.DELETE_YN ne 'N'}"><span>미사용</span></c:if></td>
								<%-- <input type="hidden" id="seq<c:out value="${result.SEQ}"/>"  name="seq<c:out value="${result.SEQ}"/>" value="${result.USE_CNT}"/>
								<input type="hidden" id="dat<c:out value="${result.SEQ}"/>"  name="dat<c:out value="${result.SEQ}"/>" value="${result.SUBJECT}"/> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
	                
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
	                
				<div class="board_list_btn right"">
			        <a href="#" onclick="modify('N','');"class="btn blue" >신규 등록</a>
				</div>
	                
	        </div>
	    </div>
	</div>
    <!-- /content -->
</form>