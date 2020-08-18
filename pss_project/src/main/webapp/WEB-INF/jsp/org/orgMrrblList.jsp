<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
#mergerReg .mIndex { margin-bottom: 5px; } #mergerReg select.ipt.insttBox { margin-right: 5px; }
</style>
<script>
var jsonList = JSON.parse('${jsonList}');
var jsonList2 = JSON.parse('${jsonList2}');
var lCnt = 1;
var pUrl, pParam;
var insttArray	= [];
var deleteOrgArray       = new Array();

$(document).ready(function(){
	fn_numberInit();
});

function list_Thread(pageNo) {
	document.form.pageIndex.value = pageNo;
	document.form.action = "/admin/org/orgMrrblList.do";
	document.form.submit();
}

function fnCheckMsg(index) {
	$( "input[name=seq_" + index + "]" ).prop( "checked", $( "#seq_all" ).prop( "checked" ) );
}  

function fnDeleteHist(index) {

	var cnt = 0;
/*     
	$( "input:checkbox[name=seq_" + index + "]" ).each( function() {
		if( $("input:checkbox[id=" + $(this).attr("id") + "]" ).prop( "checked")) {
			deleteOrgArray[cnt] = $(this).attr("id");
			cnt++;
		}
	});   
 */	
	deleteOrgArray[cnt] = index;

		if (confirm("삭제하시겠습니까?")) {
			var pUrl = "/admin/org/deleteHist.do";
	 		var param = new Object();
			
	 		param.seq  = deleteOrgArray;
			
	 		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
	 			alert(data.message);
	 		}, function(jqXHR, textStatus, errorThrown){
	 			
	 		});

	 		document.form.action = "/admin/org/orgMrrblList.do";
	 		document.form.submit();
		}
}  

function updateLayer(seq, nm, dwArr){
	
	modalFn.show($('#mergerReg'));
	
	var html ='';
	var delCnt=0;
	$(".mIndex").each( function() {
		if(0 != delCnt) {
			$(this).remove();
		}
		delCnt++;
	});
	lCnt = 1;
	
	$( "#label0" ).val('');
	$( "#label0" ).prop("disabled",false);
	
	$( "#insttBox0" ).val('');
	$( "#insttBox0" ).prop("disabled",false);

	var tmpArr = dwArr.split(',');
	if(seq == "") { // INSERT용
		html = ' <option value="">선택</option> '; 
	 	jsonList.forEach(function (val, index, array) {
				html +=  '<option value="' + val.INSTT_CD + '">' + val.INSTT_NM + '</option> ';
		}); 
	 	$( "#label0" ).html(html)
	 	$( "#insttBox0" ).html(html)
	 	
	} else {        // UPDATE용
		html = ' <option value="">선택</option> '; 
	 	jsonList2.forEach(function (val, index, array) {
				html +=  '<option value="' + val.INSTT_CD + '">' + val.INSTT_NM + '</option> ';
		}); 
	 	$( "#label0" ).html(html)
	 	$( "#insttBox0" ).html(html)
		
		$( "#label0" ).val(seq);
		$( "#label0" ).prop("disabled",true);
		
		$( "#insttBox0" ).val(tmpArr[0]);
		$( "#insttBox0" ).prop("disabled",true);
		
		if(tmpArr.length > 1) {
			for (var j=1; j < tmpArr.length; j++){
				var test = j-1;
				$( "#mIndex"+test).after(htmlMAdd(''));
				$( "#insttBox" + j ).val(tmpArr[j]);
				$( "#insttBox" + j ).prop("disabled",true);
			}
		}
	}
	
	$( "#label99" ).val(seq);
	
}

function updateLayer2(seq,nm,clcd,de,url,dr,no,yn,ip,del){

	$( "#insttCd" ).text(seq);
  	$( "#insttNm" ).text(nm);
 	$( "#insttClCd" ).text(clcd);
 	$( "#fondDe" ).text(de);
 	$( "#url" ).text(url);
 	$( "#outputOrdr" ).text(dr);
 	$( "#reprsntTelno" ).text(no);
 	$( "#cntrlPrearngeYn" ).text(yn);
 	$( "#permIp" ).text(ip);
	if(yn == "Y") {
		$("input:radio[id=cntrlPrearngeY]" ).prop("checked",true);
	} else {
		$("input:radio[id=cntrlPrearngeN]" ).prop("checked",true);
	}
	if(del == "Y") {
		$( "#deleteYn" ).text('미사용');
	} else {
		$( "#deleteYn" ).text('사용');
	}
	
	modalFn.show($('#mergerDetali'));
}

function fnSavOrgList() {
    var chkNull = 0;
	if(!$( "#label0"  ).val()){alert("상위기관 코드는 필수입력 사항입니다."); $( "#label0" ).focus(); return;}
    //
	//if(!$( "#label1"  ).val()){alert("통폐합 하위기관 코드는 필수입력 사항입니다."); $( "#label1" ).focus(); return;}
	
	$( ".insttBox" ).each( function() {		
		if($(this).val() =="") {
			alert("통폐합 하위기관 코드 미입력 항목이 존재합니다.");
			$(this).focus();
			chkNull++;
		} else if($(this).val() != $("#label0").val()){
			insttArray.push($(this).val());
		}
	});
	if(chkNull > 0) {
		return;
	}
    var pUrl = "/admin/org/orgHistModify.do";

	var param = new Object();
	
	param.insttCd   = $("#label0").val();
	param.insttDnCd = insttArray;
	if($("#label99").val() == "") {
		param.gubun = "I";
	} else {
		param.gubun = "U";
	}

	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		alert(data.message);
		
		document.form.action = "/admin/org/orgMrrblList.do";
		document.form.submit();
		
	}, function(jqXHR, textStatus, errorThrown){
		
	});
}  

function selectList(){
	$("#pageIndex").val("1");
	document.form.action = "/admin/org/orgMrrblList.do";
	document.form.submit();
}

function mAdd(el) {
	jQuery(el).parents(".mIndex").after(htmlMAdd('Y'));
}

function mDel(el) {
	jQuery(el).parent().remove();
}

function htmlMAdd(delStat) {
	
	var html = '';
	
	html += '<div class="mt05 mIndex" id=mIndex' + lCnt + '><select class="ipt insttBox" style="width: 220px;" id="insttBox' + lCnt + '" title="하위기관 선택"> ';
	html += ' <option value="">선택</option> '; 
	if(delStat == 'Y') {
	 	jsonList.forEach(function (val, index, array) {
	 				html +=  '<option value="' + val.INSTT_CD + '">' + val.INSTT_NM + '</option> ';
	 	}); 
	} else {
	 	jsonList2.forEach(function (val, index, array) {
				html +=  '<option value="' + val.INSTT_CD + '">' + val.INSTT_NM + '</option> ';
		}); 
	}
	html += ' </select> ';
	html += ' <button type="button" class="btn blue" onClick="mAdd(this);return false;">추가</button> ';
	if(delStat == 'Y') {
 		html += ' <button type="button" class="btn red" onClick="mDel(this);return false;">삭제</button> ';
	}
	html +=' </div> ';
	lCnt++;
	return html;
}

</script>

<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
    <!-- 기관 통폐합 -->
    
    <!-- 레이어 팝업 -->
    <section id="mergerReg" class="modal" style="max-width: 600px;">
    <div id="layer1" class="inner">
        <div class="modal_header">
            <h2>기관 통폐합</h2>
            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#mergerReg'))"></i></button>
        </div>
        <div class="modal_content">
            <div class="inner">
                <table class="board_list_write" summary="상위기관, 통폐합 하위기관으로 구성된 기관 통폐합 등록입니다.">
                    <colgroup>
                        <col style="width:150px;">
                        <col style="width:*">
                    </colgroup>                
                    <tbody>
                        <tr>
                            <th scope="row">상위기관</th>
                            <td>
	                        <select name="instt_up" id="label0" title="상위기관 선택" class="ipt" style="width: 220px;">
	                        	<option value="">선택</option>
	                        	<c:forEach var="i" items="${orgInsttList }" varStatus="status">
	                        	 	<c:choose>
		                       			<c:when test="${i.INSTT_CD == requestZvl.instt_nm  }">
		                       				<option value="${i.INSTT_CD }" selected>${i.INSTT_NM }</option>	
		                       			</c:when>
		                       			<c:otherwise>
		                       				<option value="${i.INSTT_CD }">${i.INSTT_NM }</option>
		                       			</c:otherwise>	
		                        	</c:choose>
	                        	</c:forEach>
	                        </select>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">통폐합<br/>하위기관</th>
                            <td>
                                <div class="mIndex" id="mIndex0">
			                        <select class="ipt insttBox" id="insttBox0" title="하위기관 선택" style="width: 220px;">
			                        	<option value="">선택</option>
			                        	<c:forEach var="i" items="${orgInsttList }" varStatus="status">
			                        	 	<c:choose>
				                       			<c:when test="${i.INSTT_CD == requestZvl.instt_nm  }">
				                       				<option value="${i.INSTT_CD }" selected>${i.INSTT_NM }</option>	
				                       			</c:when>
				                       			<c:otherwise>
				                       				<option value="${i.INSTT_CD }">${i.INSTT_NM }</option>
				                       			</c:otherwise>	
				                        	</c:choose>
			                        	</c:forEach>
			                        </select>
                       				<button type="button" class="btn blue" onClick="mAdd(this);return false;">추가</button>
                                </div>
                            </td>
                        </tr>                        
                    </tbody>
                    <input type="hidden" id="label99"  value="">                    
                </table>
                <div class="board_list_btn center">
                    <a href="#" class="btn blue" onclick="fnSavOrgList();">저장</a>
                    <a href="#" class="btn black" onclick="modalFn.hide($('#mergerReg'))">취소</a>
                </div>
            </div>
        </div>
    </div>
    </section>
    <!-- /기관 통폐합 -->
    
    <section id="mergerDetali" class="modal" style="max-width: 600px;"> 
    	<div id="layer2" class="inner">
	        <div class="modal_header" id="layerTitle">
	            <h2>상세조회</h2>
	            <button class="btn square trans modal_close"><i class="ico close_w" onclick="modalFn.hide($('#mergerDetali'))"></i></button>
	        </div>
	        <div class="modal_content">
	        	<div class="inner">
	        		<table class="board_list_write">
     			        <colgroup>
	                        <col style="width:160px;">
	                        <col style="width:*">
	                    </colgroup>     
	        			<tbody>
	        				<tr>
	                            <th><label for="insttCd">기관 코드</label></th>
	                            <td id="insttCd"></td>
	                        </tr>
	                        <tr>
	                            <th><label for="insttNm">기관명</label></th>
	                            <td id="insttNm" ></td>
	                        </tr>                        
	                        <tr>
	                            <th><label for="insttClCd" >기관 구분</label></th>
	                            <td id="insttClCd" ></td>
	                        </tr>
	                        <tr>
	                            <th><label for="fondDe">설립일자</label></th>
	                            <td id="fondDe" ></td>
	                        </tr>
	                        <tr>
	                            <th><label for="url">URL</label></th>
	                            <td id="url" ></td>
	                        </tr>
	                        <tr>
	                            <th><label for="outputOrdr" >출력순서</label></th>
	                            <td id="outputOrdr"></td>
	                        </tr>
	                        <tr>
	                            <th><label for="reprsntTelno">대표 전화번호</label></th>
	                            <td id="reprsntTelno" title="전화번호"></td>
	                        </tr>
	                        <tr>
	                            <th><label for="cntrlPrearngeYn">관제예정 기관여부</label></th>
	                            <td>
	                                <input type="radio" class="custom" id="cntrlPrearngeY" name="cntrlPrearngeYn" ><label for="cntrlPrearngeYn" disable>Y</label>
	                                <input type="radio" class="custom" id="cntrlPrearngeN" name="cntrlPrearngeYn" ><label for="cntrlPrearngeYn" disable>N</label>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th><label for="permIp">허용IP</label></th>
	                            <td id="permIp"></td>
	                        </tr>                        
	                        <tr>
	                            <th><label for="deleteYn">사용여부</label></th>
	                            <td id="deleteYn"></td>
	                        </tr>
	        			</tbody>
	        		</table>
	        		<div class="board_list_btn center">
	        			<a href="#" class="btn black modal_close" onclick="modalFn.hide($('mergerDetali'))">닫기</a>
	        		</div>
	        	</div>
	        </div>
        </div>
    </section>
    <!-- /레이어 팝업 --> 
		
<div id="main">
    <div class="group">
    <div class="header"><h3>기관 통폐합관리</h3></div>
	<!-- content -->
    <div class="body" id="container">
        <div class="content_wrap">
            <div class=board_list_top>
            	<div class="board_list_info">
            		전체 <span id="totalCount">${resultList[0].tempCnt}</span>개, 현재 페이지 
                    <span id="totalCount">${paginationInfo.getCurrentPageNo()}</span>/${paginationInfo.getLastPageNo()}
            	</div>
                <div class="board_list_search" style="width: 500px">
                	<div class="ipt_group">
                        <span class="ipt_left">
	                        <select name="instt_cl_cd" id="label0" title="기관구분 선택" class="ipt" style="width: 150px;">
	                            <option value="">기관구분 선택</option>
	                            <c:forEach var="i" items="${orgInsttClCdList }" varStatus="status">
		                            <c:choose>
		                       			<c:when test="${i.INSTT_CL_CD == requestZvl.instt_cl_cd  }">
		                       				<option value="${i.INSTT_CL_CD }" selected>${i.INSTT_CL_NM }</option>	
		                       			</c:when>
		                       			<c:otherwise>
		                       				<option value="${i.INSTT_CL_CD }">${i.INSTT_CL_NM }</option>
		                       			</c:otherwise>	
		                        	</c:choose>
	                        	</c:forEach>
	                        </select>
						</span>
                        <input type="text" title="검색어 입력" placeholder="검색어 입력" class="ipt" name="instt_nm" value="${requestZvl.instt_nm}" maxLength="50">
                        <span class="ipt_right addon"><input type="button" onclick="selectList();" value="검색" class="btn searhBtn"></span>
                    </div>
                </div>
            </div>            
                       
                <table class="board_list_normal" summary="전체선택, 번호, 기관명, 구분, 통폐합 일시, 관리로 구성된 기관 통폐합관리 리스트입니다.">
                    <colgroup>
                        <col style="width:100px;">
                        <col style="width:*">
                        <col style="width:500px;">
                        <col style="width:260px;">
                        <col style="width:100px;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">번호</th>
                            <th scope="col">기관명</th>
                            <th scope="col">구분</th>
                            <th scope="col">통폐합 일시</th>
                            <th scope="col">관리</th>
                        </tr>
                    </thead>
		                <tbody id="threadList">
			                <c:choose>
	 		                	<c:when test="${!empty resultList}">
				                	<c:forEach var="result" items="${resultList}" varStatus="status">
				                		<c:if test="${result.upperCd == ''}"> 
				                		<tr class="subject" >
				                			<td class="num">${result.seqNo}</td>
				                			<td class="center">${result.insttNm}</td>
				                			<td class="center">${result.insttClCdNm}</td>
				                			<td class="date">${result.registDt}</td>
				                			<td class="center"><a href="#" onclick="updateLayer('${result.insttCd}', '${result.insttNm}','${result.insttCdDw}');" class="link">수정</a> | <a href="#" onclick="fnDeleteHist(${result.insttCd});" class="link">삭제</a></td>
				                		</tr>
				                		</c:if>
				                		<c:if test="${result.upperCd != ''}"> 
				                		<tr class="low" >
				                			<td class="num"></td>
				                			<td class="center">${result.insttNm}</td>
				                			<td class="center">${result.insttClCdNm}</td>
				                			<td class="date">${result.registDt}</td>
				                			<td class="center"><a href="#" class="link" onclick="updateLayer2('${result.insttCd}','${result.insttNm}','${result.insttClCdNm}'
				                			,'${result.fondDe}','${result.url}','${result.outputOrdr}','${result.reprsntTelno}','${result.cntrlPrearngeYn}','${result.permIp}','${result.deleteYn}');" class="button bt2 layer_open2">상세</a></td>
				                		</tr>
				                		</c:if>
				                	</c:forEach>
				                </c:when>
				                <c:otherwise>
				                	<tr>
				                		<td class="none" colspan="6">등록된 데이터가 없습니다.</td>
				                	</tr>
				                </c:otherwise>
		                	</c:choose>
		                </tbody>
                </table>
                
				<div class="pagination">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="list_Thread" />
				</div>
                
                <div class="board_list_btn right">
	                <a href="#" onclick="updateLayer('','','');"class="btn blue" >기관 통폐합</a>
                </div>
                
            </div>
        </div>
    </div>
</div>
    
    <!-- /content -->
</form>