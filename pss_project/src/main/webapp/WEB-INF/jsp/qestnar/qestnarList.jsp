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
	document.form.action = "/admin/qestnar/qestnarList.do";
	document.form.submit();
}

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
				alert($("#dat" + seq_id).val() + "번 설문 응답자가 " + $( "#seq" + seq_id).val() + "명 있습니다. \n\n삭제 할 수 없습니다.");
				checkDel = "N";
				return;
			}
			cnt++;
		}
	});   
	if(checkDel == "Y") {
		if (confirm("삭제하시겠습니까?")) {
			var pUrl = "/admin/qestnar/deleteQestnar.do";
	 		var param = new Object();
			
	 		param.seq  = deleteMsgArray;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		document.form.action = "/admin/qestnar/qestnarList.do";
	 		document.form.submit();
		}
	}
}  

function fnModifyData(seq){

	$( "#qestnarSeq" ).val(seq);
	
	document.form.action = "/admin/qestnar/qestnarModify.do";
	document.form.submit();
}

function fnShowData(seq) {
	$( "#qestnarSeq" ).val(seq);

	document.form.action = "/admin/qestnar/qestnarResultList.do";
	document.form.submit();
}  

function selectList(){
	$("#pageIndex").val("1");
	document.form.srchDate.value = $("#label0").val();
	document.form.qustrnCn.value = $("#label1").val();
	document.form.action = "/admin/qestnar/qestnarList.do";
	document.form.submit();
}

</script>

<form method="post" id="form"  name="form">
	<input type="hidden" id="pageIndex"  name="pageIndex"  value="${pageIndex}">
	<input type="hidden" id="qestnarSeq" name="qestnarSeq" value="">
	<input type="hidden" id="srchDate"   name="srchDate" value="">
	<input type="hidden" id="qustrnCn"   name="qustrnCn" value="">
	
	<!-- content -->
<div id="main">
    <div class="group">
    	<div class="header"><h3>설문조사관리</h3></div>
        <div class="body">
            <div class="board_list_top">
	            <div class="board_list_info">
					전체 <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>개, 현재 페이지 
	                <span id="totalCount">${paginationInfo.getCurrentPageNo()}</span>/${paginationInfo.getLastPageNo()}
			   </div>	
			   <div class="board_list_filter">
	               <select title="진행상태 선택" id="label0" class="ipt" style="width: 135px;">
	                   <option value="">전체</option>
	                   <option value="1" <c:if test="${requestZvl.srchDate == '1'}"> selected </c:if>>설문 진행중</option>
	                   <option value="2" <c:if test="${requestZvl.srchDate == '2'}"> selected </c:if>>설문 완료</option>
	                   <option value="3" <c:if test="${requestZvl.srchDate == '3'}"> selected </c:if>>설문 예정</option>
	               </select>     
                </div>                       
	            <div class="board_list_search">
	            	<div class="ipt_group">
                        <input type="text" id="label1" title="검색어 입력" placeholder="검색어 입력" class="ipt" name="searchSub" value="${requestZvl.qustrnCn}" maxLength="50">
                        <span class="ipt_right addon"><button type="submit" onclick="selectList();" value="검색" class="btn searhBtn">검색</span>
                   	</div>	
	            </div>
	        </div>
                      
                <table class="board_list_normal" summary="전체선택, 번호, 설문제목, 진행기간, 참여현황, 결과보기, 등록일, 관리로 구성된 설문조사관리 리스트입니다.">
                    <colgroup>
                        <col style="width:50px;">
                        <col style="width:70px;">
                        <col style="width:*">
                        <col style="width:220px;">
                        <col style="width:100px;">
                        <col style="width:80px;">
                        <col style="width:100px;">
                        <col style="width:80px;">
                        <col style="width:70px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">
                                <input type="checkbox" id="seq_all" onClick="javascript:fnCheckMsg('${pageIndex}');" class="custom">
                                <label for="seq_all" class="text-none"></label>
                            </th>
                            <th scope="col">번호</th>
                            <th scope="col">설문제목</th>
                            <th scope="col">진행기간</th>
                            <th scope="col">진행상태</th>
                            <th scope="col">참여현황</th>
                            <th scope="col">결과보기</th>
                            <th scope="col">등록일</th>
                            <th scope="col">관리</th>
                        </tr>
                    </thead>
		                <tbody id="threadList">
		                	<c:choose>
 		                		<c:when test="${!empty resultList}">
				                	<c:forEach var="result" items="${resultList}" varStatus="status">
				                		<tr>
				                		    <td>
		                                		<input type="checkbox" class="custom" id="<c:out value="${result.SEQ}"/>" name="seq_<c:out value="${pageIndex}"/>">
		                                		<label for="<c:out value="${result.SEQ}"/>" class="text-none"></label>
		                            		</td>
				                			<td class="num"><c:out value="${result.ROWNUM}"/></td>
				                			<td><c:out value="${result.SUBJECT}"/></td>
				                			<td class="date"><c:out value="${result.BEGIN_DT} - ${result.END_DT}"/></td>              			
				                			<td class="state">
				                			<c:if test="${result.S_DT <= result.N_DT  }"> 
				                			    <c:if test="${result.E_DT >= result.N_DT  }"> 
				                					<span class="active">진행중</span>
				                				</c:if>
				                			    <c:if test="${result.E_DT < result.N_DT  }"> 
				                					<span class="active">설문완료</span>
				                				</c:if>
				                			</c:if>
				                			<c:if test="${result.S_DT > result.N_DT  }">
				                				<span class="bbs stats1">설문예정</span> 
				                			</c:if>
				                			</td>
				                			<td class="center">${result.RESULT_CNT} 명</td>
				                			<td class="center"><a href="#" onclick="fnShowData('${result.SEQ}');" class="link">결과보기</a></td>
				                			<td class="date">${result.REGIST_DT}</td>
				                			<td class="center">
				                			<c:choose>
				                				<c:when test="${result.S_DT <= result.N_DT && result.E_DT < result.N_DT}"> 
				                					<a href="#" onclick="fnModifyData('${result.SEQ}');" class="link">상세</a>
				                				</c:when>
				                				<c:otherwise>
				                					<a href="#" onclick="fnModifyData('${result.SEQ}');" class="link">수정</a>
				                				</c:otherwise>
				                			</c:choose>
				                			</td>
											<input type="hidden" id="seq<c:out value="${result.SEQ}"/>"  name="seq<c:out value="${result.SEQ}"/>" value="${result.RESULT_CNT}">
											<input type="hidden" id="dat<c:out value="${result.SEQ}"/>"  name="dat<c:out value="${result.SEQ}"/>" value="${result.ROWNUM}">
				                		</tr>
				                	</c:forEach>
				                </c:when>
				                <c:otherwise>
				                	<tr>
				                		<td class="none" colspan="9">등록된 설문조사가 없습니다.</td>
				                	</tr>
				                </c:otherwise>
 		                	</c:choose>
		                </tbody>
                </table>
                
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
                
                <div class="board_list_btn right">
	                <a href="#" class="btn black" onClick="javascript:fnDeleteMsg('${pageIndex}')">선택삭제</a>
                    <a href="#" onclick="fnModifyData('');"class="btn blue" >설문조사등록</a>
                </div>
        </div>
    </div>
 </div>
    <!-- /content -->
</form>