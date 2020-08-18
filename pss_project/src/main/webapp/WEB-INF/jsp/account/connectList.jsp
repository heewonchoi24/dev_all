<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script>
var url = "";

function listThread(pageNo) {
	$("#pageIndex").val(pageNo);
	$("#form").attr({
		method : "post"
	}).submit();
}

function link(seq, bbsCd, crud, url){
	
	if(crud == "D"){
		alert("삭제된 게시물입니다.");
	}else if(seq != ""){
		$("#bbsSeq").val(seq);
		$("#bbsCd").val(bbsCd);
		
		window.open("", "viewer");
		document.form.action = "/admin/notice/noticeWrite.do"
		document.form.target = "viewer";
		document.form.method = "post";
		document.form.submit();
	}else if(bbsCd != ""){
		$("#bbsCd").val(bbsCd);
		window.open("/admin/notice/mngNoticeDtlList.do?bbsCd="+bbsCd);
	}else if(url != ""){
		window.open(url);
	}
	
} 

function selectList(){
	document.form.sdtp.value = $("#dtp1").val();
	document.form.edtp.value = $("#dtp2").val();
	$("#pageIndex").val("1");

	$("#form").attr({
		method : "post",
		action : "/admin/account/connectList.do"
	}).submit();
}
</script>

<!-- main -->
<form action="/admin/account/connectList.do" method="post" id="form" name="form">
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }" /> 
	<input type="hidden" name="bbsSeq" id="bbsSeq" value="" />
	<input type="hidden" name="bbsCd" id="bbsCd" value="" />
	<input type="hidden" name="sdtp" id="sdtp" value="${sdtp}" />
	<input type="hidden" name="edtp" id="edtp" value="${edtp}" />

	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<div id="main">
	    <div class="group">
	    	<div class="header"><h3>접속이력</h3></div>
	        <div class="body">
	            <div class="board_list_top">
	                <div class="board_list_info">
	                    Total. <span id="totalCount">${resultListCnt }</span>
	                </div>
	                <div class="board_list_search date">
	                    <div class="dataSearch">
	                        <div class="ipt_group datepicker">
	                            <input type="text" name="dtp1" class="ipt w100p" id="dtp1" value="${sdtp}">
	                            <label for="dtp1" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                        </div>
	                        <div class="div">~</div>
	                        <div class="ipt_group datepicker">
	                            <input type="text" name="dtp2" class="ipt w100p" id="dtp2" value="${edtp}">
	                            <label for="dtp2" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                        </div>
	                        <button onclick="selectList()" class="btn searhBtn">검색</button>
	                    </div>
	                    <script type="text/javascript">
	                        $(function () {
	                            $('#dtp1').datetimepicker({
	                                format: 'YYYY/MM/DD'
	                            });
	                            $('#dtp2').datetimepicker({
	                                format: 'YYYY/MM/DD',
	                                useCurrent: false
	                            });
	                            $("#dtp1").on("dp.change", function (e) {
	                                $('#dtp2').data("DateTimePicker").minDate(e.date);
	                            });
	                            $("#dtp2").on("dp.change", function (e) {
	                                $('#dtp1').data("DateTimePicker").maxDate(e.date);
	                            });
	                        });
	                    </script>
	                </div>
	            </div>
	            <table class="board_list_normal">
	                <thead>
	                    <tr>
	                        <th>번호</th>
	                        <th>접속자</th>
	                        <th>접속 IP</th>
	                        <th>구분</th>
	                        <th>일시</th>
	                        <th>대상</th>
	                        <th>게시물 이동</th>
	                    </tr>
	                </thead>
	                <tbody>
		                <c:if test="${not empty resultList }">
			                <c:forEach items="${resultList}" var="result" varStatus="status">
			                    <tr>
			                        <td class="num"><c:out value="${(pageIndex-1) * pageSize + status.count}"/></td>
			                        <td class="center">${result.USER_ID}</td>
			                        <td class="center">${result.IP}</td>
			                        <td class="center">
		                        		<c:if test="${result.CRUD == 'C'}">등록</c:if>
			                			<c:if test="${result.CRUD == 'R'}">조회</c:if>
			                			<c:if test="${result.CRUD == 'U'}">수정</c:if>
			                			<c:if test="${result.CRUD == 'D'}">삭제</c:if>
			                        </td>
			                        <td class="center" style="width: 127px;">${result.REGIST_DT_DAY}</br>${result.REGIST_DT_TIME}</td>
			                        <td class="center"><a href="#" class="link" onclick="modalFn.show('/admin/account/connectViewThread.do?seq=${result.SEQ}');">${result.MENU_NM}</a></td>
			                        <td class="center"><c:if test="${result.VIEW_SEQ != ''}"><a href="javascript:link('${result.VIEW_SEQ}','${result.BBS_CD}','${result.CRUD}','');" class="link">NO. ${result.VIEW_SEQ}↗</a></c:if></td> 
			                    </tr>
							</c:forEach>  
						</c:if>
						<c:if test="${ empty resultList }">
		                    <tr>
		                        <td class="none" colspan="9">리스트가 없습니다.</td>
		                    </tr>
						</c:if>	                    
	                </tbody>
	            </table>
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="listThread" />
				</div>
	        </div>
	    </div>
	</div>
</form>
<!-- main -->