<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>.auth_info_table tbody tr th{width: 170px;}</style>
<script>

	var menuIdArr = new Array();
	
	$(function(){
		//readChk/writeChk/downChk
		$(".menuId").each(function(){
			menuIdArr.push($(this).val());
		})
	})
	
	function fnSavAuthList() {
	   
		if(!$( "#label0"  ).val()){alert("권한명은 필수입력 사항입니다."); $( "#label0" ).focus(); return;}
	    
	    var pUrl = "/admin/auth/authModify.do";

		var pParam = {};
		
		pParam.isModify = $("#isModify").val();
		pParam.authorNm = $("#label0").val();
		pParam.description = $("#label1").val();
		pParam.authorId = $("#authorId").val();
		pParam.menuIdArr = menuIdArr;
		
		$(".authChk").each(function(){
			if($(this).prop("checked")) pParam[$(this).attr("name")] = 'Y';
			else pParam[$(this).attr("name")] = 'N';
		})
		
		if($("input:radio[id=activeY]" ).prop("checked")) {
			pParam.deleteYn = 'N';
		} else if($("input:radio[id=activeN]" ).prop("checked")){
			pParam.deleteYn = 'Y';		
		}
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.form.action = "/admin/auth/authList.do";
			document.form.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
</script>
<!-- main -->
<div id="main">
    <div class="group">
        <div class="header">
            <h3>권한 등록/수정</h3>
        </div>
        <div class="body">
        	<form action="/admin/auth/authModify.do" method="post" id="form" name="form">
        	    <input type="hidden" id="isModify" value="${isModify}">
        	    <input type="hidden" id="authorId" value="${authorId}">
	            <table class="board_list_write auth_info_table">
	                 <tbody>
	                    <tr>
	                        <th>권한명</th>
	                        <td><input name="authorNm" id="label0" class="ipt" style="width: 300px;" <c:if test="${isModify eq 'Y'}">value="${resultList[0].SUBJECT}"</c:if> /></td>
	                    </tr>
	                    <tr>
	                        <th>권한설명</th>
	                        <td><input name="description" id="label1" class="ipt" style="width: 500px;" <c:if test="${isModify eq 'Y'}">value="${resultList[0].CONTENTS}"</c:if> /></td>
	                    </tr>
	                    <tr>
	                        <th>사용여부</th>
	                        <td>
		                       	<input name=deleteYn type="radio" id="activeY" class="custom" checked <c:if test="${isModify eq 'Y'}"><c:if test="${resultList[0].DELETE_YN eq 'N'}">checked="true"</c:if></c:if>/>
	                            <label for="activeY">사용</label>
	                            <input name="deleteYn" type="radio" id="activeN" class="custom" <c:if test="${isModify eq 'Y'}"><c:if test="${resultList[0].DELETE_YN eq 'Y'}">checked="true"</c:if></c:if>/>
	                            <label for="activeN">미사용</label>
	                        </td>
	                    </tr>
                    	<c:forEach var="auth" items="${authList}" varStatus="status">
                   			<c:set var="depth1" value="${auth.depth1st}"></c:set>
                    		<c:if test="${auth.depth2nd == 0}">
                    			<c:if test="${auth.depth1st != 1}"></td></ul></tr></c:if>
                    			<tr><th>${auth.MENU_NM}</th><td><ul class="customChkList">
                    		</c:if>
							<c:if test="${depth1 == auth.depth1st && auth.depth2nd != 0}">
					   			<c:forEach var="resultDetail" items="${resultDetailList }" varStatus="status"> 
	                   				<c:if test="${resultDetail.MENU_ID eq auth.MENU_ID}">
	                   					<c:set var="read" value="${resultDetail.AUTH_READ}"></c:set>
	                   					<c:set var="write" value="${resultDetail.AUTH_WRITE}"></c:set>
	                   					<c:set var="download" value="${resultDetail.AUTH_DOWNLOAD}"></c:set>
	                   				</c:if>
	                   			</c:forEach>
   		                        <li>
   		                        	<input type="hidden" value="${auth.MENU_ID}" class="menuId">
   		                        	<div class="tit" style="width: 200px;">${auth.MENU_NM}</div>
                                    <div class="cont">
                                        <input name="${auth.MENU_ID}_read" type="checkbox" id="${auth.MENU_ID }_1" class="custom readChk authChk" <c:if test="${read == 'Y'}">checked="true"</c:if>/>
                                        <label for="${auth.MENU_ID }_1">읽기</label>
                                        <input name="${auth.MENU_ID}_write" type="checkbox" id="${auth.MENU_ID }_2" class="custom writeChk authChk" <c:if test="${write == 'Y'}">checked="true"</c:if>/>
                                        <label for="${auth.MENU_ID }_2">쓰기</label>
                                        <input name="${auth.MENU_ID}_download" type="checkbox" id="${auth.MENU_ID }_3" class="custom downChk authChk" <c:if test="${download == 'Y'}">checked="true"</c:if>/>
                                        <label for="${auth.MENU_ID }_3">다운로드</label>
                                    </div>
								</li>	
							</c:if>     
                    	</c:forEach>
	                </tbody>
	           </table>
	           <div class="board_list_btn right">
	                <a href="/admin/auth/authList.do" class="btn black">목록으로</a>
	                <a href="#" class="btn blue" onclick="fnSavAuthList();">저장</a>
	            </div>
            </form>
        </div>
    </div>
</div>
<!-- main -->