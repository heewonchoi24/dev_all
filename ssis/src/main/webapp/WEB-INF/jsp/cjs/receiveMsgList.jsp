<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<title>관제업무지원 시스템 &#124; 마의페이지 &#124; 업무 협업</title>

<script>
var pUrl, pParam;
var deleteMsgArray       = new Array();

$(document).ready(function(){

});

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "<c:url value='/cjs/receiveMsgList.do'/>";
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
   
	if (confirm("삭제하시겠습니까?")) {
		var pUrl = "/cjs/deleteReceiveMsg.do";
 		var param = new Object();
		
 		param.seq  = deleteMsgArray;
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		document.form.action = "/cjs/receiveMsgList.do";
 		document.form.submit();	 	
	}
}  

function detail_Thread(seq){
	document.form.threadSeq.value = seq;
	document.form.pageIndex.value = '${pageIndex}';
	document.form.action = "<c:url value='/cjs/receiveMsgView.do'/>";
	document.form.submit();	
}

function selectList(){
	document.form.searchGb.value = $("#label0").val();
	document.form.searchTx.value = $("#label1").val();
	$("#pageIndex").val("1");
	document.form.action = "/cjs/receiveMsgList.do";
	document.form.submit();
}

function trnsmitMsg(){
	document.form.action = "/cjs/trnsmitMsg.do";
	document.form.submit();
}

</script>
</head>

<form action="/cjs/receiveMsgList.do" method="post" id="form" name="form">
	<input type="hidden" id="threadSeq" name="threadSeq" value="">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="searchGb"  name="searchGb" value="">
	<input type="hidden" id="searchTx"  name="searchTx" value="">
	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">수신 업무</h2>
            
            <div class="content">
                <div class="board_search">
                        <fieldset>
                            <legend>게시물 검색</legend>
                            <select title="검색영역 선택" id="label0">
                                <option value="1" <c:if test="${requestZvl.searchGb =='1'}">selected</c:if>>제목</option>
                                <option value="2" <c:if test="${requestZvl.searchGb =='2'}">selected</c:if>>내용</option>
                                <option value="3" <c:if test="${requestZvl.searchGb =='3'}">selected</c:if>>제목+내용</option>
                            </select>
                            <input type="text" id="label1" class="w40"  maxLength="50"
                                   <c:if test="${requestZvl.searchTx ==''}">title="검색어 입력" placeholder="검색어 입력"</c:if>
                            	   <c:if test="${requestZvl.searchTx !=''}">value="${requestZvl.searchTx}"</c:if>
                             >
                            <input type="button" onclick="selectList();" value="검색" class="button bt3 gray">
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
                <table class="board" summary="전체선택, 번호, 보낸사람, 제목, 받은날짜로 구성된 수신업무 리스트입니다.">
                	<caption>수신업무 리스트</caption>
                    <colgroup>
                        <col style="width:50px;">
                        <col style="width:70px;">                       
                        <col style="width:160px;">
                        <col style="width:*">
                        <col style="width:180px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">
                                <input type="checkbox" id="seq_all" onClick="javascript:fnCheckMsg('${pageIndex}');">
                            </th>
                            <th scope="col">번호</th>
                            <th scope="col">보낸사람</th>                                                        
                            <th scope="col">제목</th>
                            <th scope="col">받은날짜</th>
                        </tr>
                    </thead>
 		                <tbody id="threadList">
 		                	<c:choose>
 		                		<c:when test="${!empty resultList}">
				                	<c:forEach var="result" items="${resultList}" varStatus="status">
				                		<tr>
				                		    <td>
		                                		<input type="checkbox" id="<c:out value="${result.SEQ}"/>" name="seq_<c:out value="${pageIndex}"/>">
		                            		</td>                            		                		
				                			<td><c:out value="${result.ROWNUM}"/></td>
				                			<td><c:out value="${result.TRNSMIT_NM}"/>
				                			</td>
				                			<td class="subject"><a href="#" onclick="detail_Thread(&quot;${result.SEQ}&quot;);">
				         			        <c:if test="${result.RECPTN_YN eq 'N'}"><strong class="c_blue"></c:if>
				                			<c:if test="${result.RECPTN_YN eq ''}"><strong class="c_blue"></c:if>
				                			<c:out value="${result.SUBJECT}"/>
				                			<c:if test="${result.RECPTN_YN eq 'N'}"></strong></c:if>
				                			<c:if test="${result.RECPTN_YN eq ''}"></strong></c:if>
				                			</a></td>
				                			<td><c:out value="${result.REGIST_DT}"/></td>
				                		</tr>
				                		<c:if test="${status.last}">
				                			<input type="hidden" id="userId"  name="userId" value="${result.USER_ID}">
				                			<input type="hidden" id="trnsmitId"  name="trnsmitId" value="">
				                		</c:if>                     		                					                		
				                	</c:forEach>
				                </c:when>
				                <c:otherwise>
				                	<tr>
				                		<td colspan="5">등록된 데이터가 없습니다.</td>
				                	</tr>
				                </c:otherwise>
 		                	</c:choose>
		                </tbody>
                </table>
 				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
                
                <div class="mt10 btn_area">
                    <div class="left_area">
                        <a href="#" class="button bt1 gray" onClick="javascript:fnDeleteMsg('${pageIndex}')">선택삭제</a>
                    </div>
                    <div class="right_area">
                        <a href="#" class="button bt1" onClick="javascript:trnsmitMsg()">업무 송신</a>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    <!-- /content -->
</form>