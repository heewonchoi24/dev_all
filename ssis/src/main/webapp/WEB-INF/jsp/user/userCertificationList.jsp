<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script>

	$(document).ready(function(){

		$("input[name='stateFilter']").on("click", function(){
			selectList();
		});
		
	});

	function list_Thread(pageNo) {
		document.form.pageIndex.value = pageNo;
		document.form.action = "/admin/user/userCertificationList.do";
		document.form.submit();
	}
	
	function selectList(){
		$("#pageIndex").val("1");
		document.form.action = "/admin/user/userCertificationList.do";
		document.form.submit();
	}
	
	function fnCheckMsg(index) {
		$( "input[name=seq_" + index + "]" ).prop( "checked", $( "#seq_all" ).prop( "checked" ) );
	}
	
	function updateLayer(seq,userNm,email){
		$( "#seq" ).val(seq);
	 	$( "#userNm" ).val(userNm);
	 	$( "#email" ).val(email);
	 	
	 	modalFn.show($('#userRegister'));
	}
	
	function fnDeleteMsg(index) {

		var cnt = 0;
		var deleteMsgArray       = new Array();
		
		$( "input:checkbox[name=seq_" + index + "]" ).each( function() {
			if( $("input:checkbox[id=" + $(this).attr("id") + "]" ).prop( "checked")) {
				deleteMsgArray[cnt] = $(this).attr("id");
				cnt++;
			}
		});
		
		if(0 == cnt) {
			alert('데이터를 선택해 주세요');
			return false;
		}

		if (confirm("삭제하시겠습니까?")) {
			var pUrl = "/user/deleteUserCertification.do";
	 		var param = new Object();
	 		param.seq  = deleteMsgArray;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		document.form.action = "/admin/user/userCertificationList.do";
	 		document.form.submit();
		}
	}
	
	function fn_save() {

		if(!$("#userNm").val()){alert("사용자 명은 필수입력 사항입니다."); $( "#userNm" ).focus(); return;}
		if(!$("#email").val()){alert("이메일은 필수입력 사항입니다."); $( "#email" ).focus(); return;}
		if(!emailRegExp.test($("#email").val())){alert("이메일 주소가 정확하지 않습니다."); return;}
		
	    var pUrl = "/admin/user/modifyUserCertification.do";

		var param = new Object();
		
		param.userNm   = $("#userNm").val();
		param.email = $("#email").val();

		if(!createCheck(param)) {
			alert('이미 등록된 사용자 입니다.');
			return false;
		}
		
		var msg = "";
		if("" == $("#seq").val()) {
			param.gubun = "I";
			msg = "등록";
		} else {
			param.gubun = "U";
			msg = "수정";
			param.seq = $("#seq").val();
		}

		if (confirm(msg+" 하시겠습니까?")) {
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
			}, function(jqXHR, textStatus, errorThrown){
				
			});
			document.form.action = "/admin/user/userCertificationList.do";
			document.form.submit();
		}
	}
	
	function createCheck(param) {

		var returnFlag = true;
		
	    var pUrl = "/admin/user/checkUserCertification.do";
		
		var msg = "";
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			if('E' == data.message) {
				returnFlag = false;
			}
		}, function(jqXHR, textStatus, errorThrown){
			
		});
		
		return returnFlag;
	}
</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<input type="hidden" id="seq" name="seq" value="">
	
    <!-- 레이어 팝업 -->
<section id="userRegister" class="modal" style="max-width: 500px;">
    <div id="layer1" class="inner">
        <div class="modal_header">
            <h2>사용자 사전 등록/수정</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#userRegister'))"></i></button>
        </div>
        <div class="modal_content">
            <div class="inner">
                <table class="board_list_write" summary="사용자 명, 사용자 이메일로 구성된 사용자 등록/수정입니다.">
                    <colgroup>
                        <col style="width:150px;">
                        <col style="width:*">
                    </colgroup>                
                    <tbody>
                        <tr>
                            <th scope="row" class="req">사용자 명</th>
                            <td><input type="text" id="userNm" class="ipt w100p" maxLength="10"></td>
                        </tr>
                        <tr>
                            <th scope="row" class="req">사용자 이메일</th>
                            <td><input type="text" id="email" class="ipt w100p" maxLength="50"></td>
                        </tr>
                    </tbody>                    
                </table>
                <div class="board_list_btn center">
                    <a href="#" class="btn blue" onClick="javascript:fn_save(); return false;">저장</a>
                    <a href="javascript:void(0);" class="btn black" onclick="modalFn.hide($('#userRegister'))">취소</a>
                </div>
            </div>
        </div>
    </div>
</section>
    <!-- /레이어 팝업 --> 
    
<div id="main">
    <div class="group">
	<div class="header"><h3>사용자 사전등록</h3></div>
	<!-- content -->
		<div class="body">
            <div class="board_list_top">
                <div class="board_list_info">
                	전체 <span id="totalCount">${paginationInfo.getTotalRecordCount()}</span>개, 현재 페이지 
                    <span id="totalCount">${paginationInfo.getCurrentPageNo()}</span>/${paginationInfo.getLastPageNo()}
                </div>
                <div class="board_list_filter">
                    <div class="stateFilter">
                        <input name="stateFilter" type="radio" id="stateFilterAll" value="" class="" checked >
                        <label for="stateFilterAll">전체</label>
                        <input name="stateFilter" type="radio" id="stateFilter1" class="" value="stateFilter1" <c:if test="${ stateFilter eq 'stateFilter1' }">checked</c:if>>
                        <label for="stateFilter1">등록</label>
                        <input name="stateFilter" type="radio" id="stateFilter2" class="" value="stateFilter2" <c:if test="${ stateFilter eq 'stateFilter2' }">checked</c:if>>
                        <label for="stateFilter2">미등록</label>
                    </div>
                </div>
                <div class="board_list_search">
	              <!-- <select name="instt_cl_cd" id="label0" title="기관구분 선택">
	                  <option value="">사용자</option>
	              </select> -->
		              <div class="ipt_group">
		                <input type="text" title="검색어 입력" placeholder="검색어를 입력하세요" class="ipt" name="searchUserNm" value="${searchUserNm}">
		                <span class="ipt_right addon"><button type="submit" onclick="selectList();" class="btn searhBtn">검색</button></span>
					</div>
                </div>
            </div>            
                       
            <table class="board_list_normal" summary="전체선택, 번호, 사용자, 이메일, 등록일, 등록자, 상태, 사용자등록일로 구성된 사용자 사전 등록 관리 리스트입니다.">
                 <colgroup>
                     <col style="width:100px;">
                     <col style="width:200px;">
                     <col style="width:*">
                     <col style="width:200px;">
                     <col style="width:200px;">
                     <col style="width:200px;">
                     <col style="width:200px;">
                 </colgroup>
                 <thead>
                     <tr>
                         <th scope="col">번호</th>
                         <th scope="col">사용자</th>
                         <th scope="col">이메일</th>
                         <th scope="col">등록일</th>
                         <th scope="col">등록자</th>
                         <th scope="col">상태</th>
                         <th scope="col">사용자등록일</th>
                     </tr>
                 </thead>
               <tbody id="threadList">
               	<c:choose>
               		<c:when test="${!empty resultList}">
	                	<c:forEach var="list" items="${resultList}" varStatus="status">
	                		<tr>
	                			<td class="num">${list.rowNum}</td>
	                			<td class="center"><a href="#" onclick="updateLayer('${list.seq}','${list.userNm}','${list.email}');" class="layer_open" style="color: #666;">${list.userNm}</a></td>
	                			<td class=""><a href="#" onclick="updateLayer('${list.seq}','${list.userNm}','${list.email}');" class="layer_open" style="color: #666;">${list.email}</a></td>
	                			<td class="date">${list.registDt}</td>
	                			<td class="center">${list.registNm}</td>
	                			<td class="state"><c:if test="${list.status==''}">미등록</c:if><c:if test="${list.status=='RS03'}">등록</c:if></td>
	                			<td class="date">${list.statusDt}</td>
	                		</tr>
	                	</c:forEach>
	                </c:when>
	                <c:otherwise>
	                	<tr><td class="none" colspan="7">등록된 데이터가 없습니다.</td></tr>
	                </c:otherwise>
	        	</c:choose>
               </tbody>
            </table>
                
			<div class="pagination">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
			</div>
                
            <div class="board_list_btn right">
                <!-- <div class="left_area">
                    <a href="#" class="button bt1 gray" onClick="javascript:fnDeleteMsg('${pageIndex}')">선택삭제</a>
                </div>  -->
            	<a href="#" onclick="updateLayer('','','');" class="btn blue" >사용자 사전 등록</a>
            </div>
       </div>
    </div>
</div>
    <!-- /content -->
</form>
