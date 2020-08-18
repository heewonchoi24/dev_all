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
	// 검색 옵션 선택 시
	$(".selectMenu>li>a").on('click',function(e){
		$("#searchGb").val($(this).attr('value'));
	});
	
	// 체크박스 전체 클릭 시
	$("#seq_all").on('ifChanged', function(e){
		if( $("#seq_all").is(":checked")) $('input[name*="seq_"]').iCheck("check");
		else $('input[name*="seq_"]').iCheck("uncheck");
	});
	
});

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "<c:url value='/msg/trnsmitMsgList.do'/>";
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
		var pUrl = "/msg/deleteTrnsmitMsg.do";
 		var param = new Object();
		
 		param.seq  = deleteMsgArray;
		
 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
 			alert(data.message);
 		}, function(jqXHR, textStatus, errorThrown){
 			
 		});

 		document.form.action = "/msg/trnsmitMsgList.do";
 		document.form.submit();	 	
	}
}  

function detail_Thread(seq){
	document.form.threadSeq.value = seq;
	document.form.pageIndex.value = '${pageIndex}';
	document.form.action = "<c:url value='/msg/trnsmitMsgView.do'/>";
	document.form.submit();	
}

function selectList(){
	if($("#searchGb").val() == ''){
		alert("검색 구분을 선택 해주세요.");
		return;
	}
	document.form.searchGb.value = $("#searchGb").val();
	document.form.searchTx.value = $("#searchTx").val();
	$("#pageIndex").val("1");
	document.form.action = "/msg/trnsmitMsgList.do";
	document.form.submit();
}

function trnsmitMsg(){
	document.form.action = "/msg/trnsmitMsg.do";
	document.form.submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="threadSeq" name="threadSeq" value="">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="typeTR" name="typeTR" value="T">
	
<section id="container" class="sub mypage">
	<!-- content -->
    <div id="container" class="container_inner">
    
        <div class="box-select-gray">
			<div class="box-select-ty1 type1">
					<div class="selectVal" tabindex="0">
						<a href="#this" value="#this" tabindex="-1" >
							<c:choose>
								<c:when test="${requestZvl.searchGb eq null or requestZvl.searchGb eq ''}">선택</c:when>
								<c:when test="${requestZvl.searchGb eq '1'}">제목</c:when>
								<c:when test="${requestZvl.searchGb eq '2'}">내용</c:when>
								<c:otherwise>제목+내용</c:otherwise>
							</c:choose>
						</a>
						<input type="hidden" id=searchGb name="searchGb" value="" />
					</div>
					 <ul class="selectMenu" >
						<li><a href="#" value="1">제목</a></li>
						<li><a href="#" value="2">내용</a></li>
						<li><a href="#" value="3">제목+내용</a></li>
					 </ul>
				</div>
			<div class="inp_sch">
				<input type="text" class="inp_txt w100p" placeholder="검색어 입력" id="searchTx" name="searchTx" 
					<c:if test="${requestZvl.searchTx ==''}">title="검색어 입력" placeholder="검색어 입력"</c:if>
                    <c:if test="${requestZvl.searchTx !=''}">value="${requestZvl.searchTx}"</c:if>  >
				<button type="button" class="btn_sch" onclick="selectList();" ><span class="i-set i_sch">검색</span></button>
			</div>
		</div>

        <div class="layer-header1 clearfix">
			<div class="col-lft">
				<p class="t_total">전체 <strong class="c-blue2">${paginationInfo.getTotalRecordCount()}</strong>건의 게시물이 있습니다.</p>
			</div>
		</div>
		
		<div class="wrap_table2 bdno">
			<table id="table-1" class="tbl" summary="전체선택, 번호, 보낸사람, 제목, 받은날짜로 구성된 수신업무 리스트입니다.">
				<caption>게시판 리스트</caption>
				<colgroup>
					<col class="th1_7">
					<col class="th1_5">
					<col class="th1_4">
					<col>
					<col class="th1_8">
				</colgroup>
				<thead>
                        <tr>
                            <th scope="col">
                                <input type="checkbox" id="seq_all" class="ickjs" onClick="javascript:fnCheckMsg('${pageIndex}');">
                            </th>
                            <th scope="col">번호</th>
                            <th scope="col">받는사람</th>                                                        
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
		                                		<input type="checkbox" class="ickjs" id="<c:out value="${result.SEQ}"/>" name="seq_<c:out value="${pageIndex}"/>">
		                            		</td>                            		                		
				                			<td><c:out value="${result.ROWNUM}"/></td>
				                			<td>
				                			 	<c:if test="${result.TRNSMIT_CNT < 2 }"><c:out value="${result.TRNSMIT_NM}"/>
				                				</c:if>
				                			 	<c:if test="${result.TRNSMIT_CNT > 1 }"><c:out value="${result.TRNSMIT_NM}"/>외
				                			 	<c:out value="${result.TRNSMIT_CNT -1}"/>명
												</c:if>
											</td>
											<td class="ta-l"><a href="#" onclick="detail_Thread(&quot;${result.SEQ}&quot;);"><c:out value="${result.SUBJECT}"/></a></td>
				                			<td>	<c:if test="${result.RECPTN_YN =='Y' }"><c:out value="${result.RECPTN_DT}"/>
			                                        </c:if>
			                                        <c:if test="${result.RECPTN_YN =='N' }">미확인</c:if>
			                                        <c:if test="${result.RECPTN_YN =='' }">미확인</c:if>
		 		                			</td>
				                		</tr>
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
            </div>

			<div class="btn_clear clearfix">
				<div class="fl-l">
					<a href="#" class="btn-pk n black" onClick="javascript:fnDeleteMsg('${pageIndex}')">선택삭제</a>
				</div>
				<div class="fl-r">
					<a href="#" class="btn-pk n green rv" onClick="javascript:trnsmitMsg()">업무 송신</a>
				</div>
			</div>
			
			<div class="pagenation">
				<ul>
					<ui:pagination paginationInfo="${paginationInfo}" type="bbsImage" jsFunction="list_Thread" />
				</ul>
			</div>
                
    </div>
    <!-- /content -->
</section>
</form>

<script>
$('.ickjs').iCheck({
	checkboxClass: 'icheckbox_square3',
	radioClass: 'iradio_square3'
});
</script>
