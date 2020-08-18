<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>

function sendUserList(idx) {
	$("#tran_idx").val(idx);
   	 
 	pUrl = "/admin/sms/smsSendUserList.do";
 	pParam = {};
 	pParam.tran_idx = idx;

 	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
 		var str = '';
 		for(var i in data.userList){
 			str += '<li><span class="title">' + data.userList[i].INSTT_NM + '</span>';
 			str += data.userList[i].USER_NM + ': ' + data.userList[i].MOBLPHON_NO + '</li>' ;
 		}	
 		$("#userList").html(str);
 			
 	}, function(jqXHR, textStatus, errorThrown){
 		
 	});
 	
 	modalFn.show($('#smsSendList'));	
}

function fn_newSms() {
   	$("#form").attr({
           action : "/admin/sms/smsPageList.do",
           method : "post"
       }).submit();
}


</script>
<!-- main -->

<form method="post" id="form"  name="form">
<input type="hidden" id="tran_idx" name="tran_idx" value="" />


<!-- Modal_ajax -->
<section id="smsSendList" class="modal">
    <div class="inner">
        <div class="modal_header">
            <h2>발송대상</h2>
            <button class="btn square trans modal_close"><i class="ico close_w"  onclick="modalFn.hide($('#smsSendList'))"></i></button>
        </div>
        <div class="modal_content">
            <div class="inner" >
                <ul class="list" id="userList">
                    <li><span class="title"></span></li>
                </ul>
            </div>
        </div>
    </div>
</section>
	
<div id="main">
    <div class="group">
        <div class="body">
            <div class="board_list_top">
                <div class="board_list_info">
					전체 <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>개, 현재 페이지 
	                <span id="totalCount">${paginationInfo.getCurrentPageNo()}</span>/${paginationInfo.getLastPageNo()}
			   </div>	
            </div>
            <table class="board_list_normal">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th style="width: 300px;">발신자수</th>
                        <th style="width: 150px;">발송자</th>
                        <th>생성일시</th>
                        <th>발송일시</th>
                        <th style="width: 150px;">보기</th>
                    </tr>
                </thead>
                <tbody>
	                <c:choose>
	                	<c:when test="${!empty resultList }">
               			<c:forEach var="s" items="${resultList}" varStatus="status">
		                    <tr>
		                        <td class="num">${s.TRAN_ETC1 }</td>
		                        <td class="center"><a href="javascript:void(0);" class="link" onclick="sendUserList('${s.TRAN_ETC1}');">${s.SEND_CNT }</a></td>
		                        <td class="center">${s.USER_NM }</td>
		                        <td class="date">${s.TRAN_DATE }</td>
		                        <td class="date">${s.TRAN_SENDDATE }</td>
		                        <td class="center"><a href="javascript:fn_newSms();" class="link">보기</a></td>
		                    </tr>
	                    </c:forEach>
	                   	</c:when>
	                   	<c:otherwise>
							<tr>
		                        <td class="none" colspan="6">리스트가 없습니다.</td>
		                    </tr>                   	
	                   	</c:otherwise>
	                </c:choose>
                </tbody>
            </table>
            
            <div class="pagination">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
			</div>
				
            <div class="board_list_btn right">
                <a href="javascript:fn_newSms();" class="btn blue">신규 등록</a>
            </div>
            
        </div>
    </div>
</div>
<!-- main -->

</form>