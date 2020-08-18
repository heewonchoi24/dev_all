<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>[type="checkbox"].custom+label.text-none { padding-left: 30px; } </style>
<script src="/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script>
$(document).ready(function(){
	
	$("#isModify").val("<c:out value='${requestZvl.isModify}' />"); // 수정인지 신규등록 인지
	var tmpOrder = "<c:out value='${requestZvl.tmpOrder}'/> "; // 넘겨받은 현재 년도
	if($("#isModify").val() !='Y') fnNewOrder(tmpOrder);
});

//신규 등록일 시 차수 option 변경
function fnNewOrder(tmpOrder){
		str = "";
		for(var i=0; i<5; i++) {
			str += '<option value=' + (parseInt(tmpOrder) + i) + '>' + (parseInt(tmpOrder) + i) + '</option>';
		}
		$("#label0").html(str);
		$( "#label0" ).attr("disabled",false);
		$( "#label0" ).focus();
}

function fnSavOrderList() {
    
	if(!$( "#label0"  ).val()){alert("차수는 필수입력 사항입니다."); $( "#label0" ).focus(); return;}
	if(!$( "#label11" ).val()){alert("진단 실적등록(본부+소속) 시작일은 필수입력 사항입니다."); $( "#label11" ).focus(); return;}
	if(!$( "#label12" ).val()){alert("진단 실적등록(본부+소속) 종료일은 필수입력 사항입니다."); $( "#label12" ).focus(); return;}
	if(!$( "#label211" ).val()){alert("진단 실적등록(산하) 시작일은 필수입력 사항입니다."); $( "#label211" ).focus(); return;}
	if(!$( "#label212" ).val()){alert("진단 실적등록(산하) 종료일은 필수입력 사항입니다."); $( "#label212" ).focus(); return;}
	if(!$( "#label21" ).val()){alert("진단 서면평가 시작일은 필수입력 사항입니다."); $( "#label21" ).focus(); return;}
	if(!$( "#label22" ).val()){alert("진단 서면평가 종료일은 필수입력 사항입니다."); $( "#label22" ).focus(); return;}
 	if(!$( "#label31" ).val()){alert("진단 이의신청 시작일은 필수입력 사항입니다."); $( "#label31" ).focus(); return;}
 	if(!$( "#label32" ).val()){alert("진단 이의신청 종료일은 필수입력 사항입니다."); $( "#label32" ).focus(); return;}
	if(!$( "#label41" ).val()){alert("진단 최종평가 시작일은 필수입력 사항입니다."); $( "#label41" ).focus(); return;}
	if(!$( "#label42" ).val()){alert("진단 최종평가 종료일은 필수입력 사항입니다."); $( "#label42" ).focus(); return;}
	if(!$( "#label51" ).val()){alert("현황 현장점검 시작일은 필수입력 사항입니다."); $( "#label51" ).focus(); return;}
	if(!$( "#label52" ).val()){alert("현황 현장점검 종료일은 필수입력 사항입니다."); $( "#label52" ).focus(); return;}
// 	if(!$( "#label61" ).val()){alert("현황 이의신청 시작일은 필수입력 사항입니다."); $( "#label61" ).focus(); return;}
// 	if(!$( "#label62" ).val()){alert("현황 이의신청 종료일은 필수입력 사항입니다."); $( "#label62" ).focus(); return;}
	if(!$( "#label71" ).val()){alert("현황 최종평가 시작일은 필수입력 사항입니다."); $( "#label71" ).focus(); return;}
	if(!$( "#label72" ).val()){alert("현황 최종평가 종료일은 필수입력 사항입니다."); $( "#label72" ).focus(); return;}

	if($( "#label11" ).val() > $( "#label12" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label11" ).focus(); return;
	}
	if($( "#label211" ).val() > $( "#label212" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label211" ).focus(); return;
	}
	if($( "#label21" ).val() > $( "#label22" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label21" ).focus(); return;
	}
	if($( "#label31" ).val() > $( "#label32" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label31" ).focus(); return;
	}
	if($( "#label41" ).val() > $( "#label42" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label41" ).focus(); return;
	}
	if($( "#label51" ).val() > $( "#label52" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label51" ).focus(); return;
	}
/* 	if($( "#label61" ).val() > $( "#label62" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label61" ).focus(); return;
	} */
	if($( "#label71" ).val() > $( "#label72" ).val()){
		alert("종료일이 시작일 이전입니다. 확인바랍니다."); $( "#label71" ).focus(); return;
	}
	
    var pUrl = "/admin/order/orderModify.do";

	var param = new Object();
	var tYear = $("#label11").val();

	if( $("#isModify").val() != 'Y' ) {
		param.gubun = "I";
	} else {
		param.gubun = "U";
	}
	
	param.orderNo = $("#label0").val();
	param.year    = tYear.substr(0,4);
	param.mngLevelRegistBgnde				= $("#label11").val();
	param.mngLevelRegistEndde				= $("#label12").val();
	param.mngLevelRegistBgnde2			    = $("#label211").val();
	param.mngLevelRegistEndde2				= $("#label212").val();
	param.mngLevelEvlBgnde					= $("#label21").val();
	param.mngLevelEvlEndde					= $("#label22").val();
	if($("#label31").val() !=""){
		param.mngLevelFobjctBgnde			= $("#label31").val();
		param.mngLevelFobjctEndde			= $("#label32").val();
	}
	param.mngLevelResultBgnde				= $("#label41").val();
	param.mngLevelResultEndde				= $("#label42").val();
	param.sttusExaminRegistBgnde			= $("#label51").val();
	param.sttusExaminRegistEndde			= $("#label52").val();
/* 	if($("#label61").val() !=""){
		param.sttusExaminFobjctBgnde		= $("#label61").val();
		param.sttusExaminFobjctEndde		= $("#label62").val();
	} */
	param.sttusExaminResultBgnde			= $("#label71").val();
	param.sttusExaminResultEndde			= $("#label72").val();
	
	if($("#currentYN").prop('checked') == true){
		$("#currentYN").val("Y");
		param.currentYN = $("#currentYN").val();
	}
	
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
		alert(data.message);
		
		document.form.action = "/admin/order/orderList.do";
		document.form.submit();

	}, function(jqXHR, textStatus, errorThrown){
		
	});
}  

function selectList(){
	$("#pageIndex").val("1");
	document.form.action = "/admin/order/orderList.do";
	document.form.submit();
}

</script>
<form method="post" id="form" name="form">
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}">
	<c:set var="now" value="<%= new java.util.Date() %>" />
	<input type="hidden" id="tmpOrder" name="tmpOrder" value="<fmt:formatDate pattern="yyyy" value="${now}"/>">
    
<div id="main">
    <div class="group">
        <div class="header">
            <h3>차수 등록/수정</h3>
        </div>
    <div class="body">
		<div class="board_write_top"><span class="req">*</span> 표시는 필수입력 사항입니다.</div> 
                <table class="board_list_write" summary="차수, 관리수준 진단-실적등록(본부+소속), 실적등록(산하), 서면평가, 이의신청, 최종평가, 관리수준 현황조사-현장점검, 이의신청, 최종평가로 구성된 차수관리 등록/수정입니다.">                
                    <colgroup>
                        <col style="width:150px;">
                        <col style="width:100px;">
                        <col style="width:*">
                    </colgroup>                
                    <tbody>
                        <tr>
                            <th scope="row" class="req" colspan="2">차수</th>
                            <td>
                            <c:choose>
                            	<c:when test="${requestZvl.isModify eq 'Y' }"> 
	                            	<select id="label0" class="ipt" style="width: 200px;" title="차수" disabled="true"	 >
	                            		<option id="${requestZvl.orderNo }" selected > ${requestZvl.orderNo } </option>
	                            	</select>
                            	</c:when>
                            	<c:otherwise>
                            		<select id="label0" class="ipt" style="width: 200px;" title="차수" >
                            		</select>
                            	</c:otherwise>
                           	</c:choose>
                           	<span style="margin-top: 5px; margin-left: 15px; display: inline-block;">
								<input type="checkbox" id="currentYN" name="currentYN" class="custom" value="N"  <c:if test="${resultList.CURRENT_YN != '' && resultList.CURRENT_YN == 'Y' }">checked</c:if>/>
								<label for="currentYN" class="text-none">현재 차수</label>
							</span> 
                            </td>
                        </tr>
                        <tr>
                            <th class="req" rowspan="5">관리수준 <br/>진단</th>
                            <th class="req">실적등록<br>(본부+소속)</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelRegistBgnde}" var="mngLevelRegistBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelRegistBgnde}" 	         var="startFmt" 	       pattern="yyyy.MM.dd HH:mm" />                            		
		                                <input type="text" id="label11" name="label11" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label11" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelRegistEndde}" var="mngLevelRegistEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelRegistEndde}" 	         var="endFmt" 	           pattern="yyyy.MM.dd HH:mm" />                                	
	                                	<input type="text" id="label12" name="label12" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label12" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label11').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label12').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label11").on("dp.change", function (e) {
                                        $('#label12').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label12").on("dp.change", function (e) {
                                        $('#label11').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <tr>
                            <th class="req">실적등록<br>(산하)</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelRegistBgnde2}" var="mngLevelRegistBgnde2" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelRegistBgnde2}" 	      var="startFmt" 	         pattern="yyyy.MM.dd HH:mm" />                             		
		                                <input type="text" id="label211" name="label211" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label211" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelRegistEndde2}" var="mngLevelRegistEndde2" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelRegistEndde2}" 	      var="endFmt" 	             pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label212" name="label212" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label212" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label211').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label212').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label211").on("dp.change", function (e) {
                                        $('#label212').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label212").on("dp.change", function (e) {
                                        $('#label211').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <tr>
                            <th class="req">서면평가</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelEvlBgnde}" var="mngLevelEvlBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelEvlBgnde}" 	      var="startFmt" 	     pattern="yyyy.MM.dd HH:mm" />                                  		
		                                <input type="text" id="label21" name="label21" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label21" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelEvlEndde}" var="mngLevelEvlEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelEvlEndde}" 	      var="endFmt" 	           pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label22" name="label22" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label22" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label21').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label22').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label21").on("dp.change", function (e) {
                                        $('#label22').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label22").on("dp.change", function (e) {
                                        $('#label21').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row" class="req">이의신청</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelFobjctBgnde}" var="mngLevelFobjctBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelFobjctBgnde}" 	         var="startFmt" 	       pattern="yyyy.MM.dd HH:mm" />                                  		
		                                <input type="text" id="label31" name="label31" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label31" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelFobjctEndde}" var="mngLevelFobjctEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelFobjctEndde}" 	         var="endFmt" 	           pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label32" name="label32" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label32" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label31').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label32').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label31").on("dp.change", function (e) {
                                        $('#label32').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label32").on("dp.change", function (e) {
                                        $('#label31').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <tr>
                            <th class="req">최종평가</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelResultBgnde}" var="mngLevelResultBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelResultBgnde}" 	         var="startFmt" 	       pattern="yyyy.MM.dd HH:mm" />                                  		
		                                <input type="text" id="label41" name="label41" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label41" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.mngLevelResultEndde}" var="mngLevelResultEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${mngLevelResultEndde}" 	         var="endFmt" 	           pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label42" name="label42" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label42" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label41').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label42').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label41").on("dp.change", function (e) {
                                        $('#label42').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label42").on("dp.change", function (e) {
                                        $('#label41').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <tr>
                            <!-- <th class="req" rowspan="5">관리수준 <br/>현황조사</th> -->
                            <th class="req" rowspan="2">관리수준 <br/>현황조사</th>
                            <th class="req">현장점검</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminRegistBgnde}" var="sttusExaminRegistBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminRegistBgnde}" 	        var="startFmt" 	             pattern="yyyy.MM.dd HH:mm" />                               		
		                                <input type="text" id="label51" name="label51" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label51" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminRegistEndde}" var="sttusExaminRegistEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminRegistEndde}" 	        var="endFmt" 	          pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label52" name="label52" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label52" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label51').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label52').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label51").on("dp.change", function (e) {
                                        $('#label52').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label52").on("dp.change", function (e) {
                                        $('#label51').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                        <%-- 
                        <tr>
                            <th scope="row">이의신청</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminFobjctBgnde}" var="sttusExaminFobjctBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminFobjctBgnde}" 	        var="startFmt" 	       		 pattern="yyyy.MM.dd HH:mm" />      
		                                <input type="text" id="label61" name="label61" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label61" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminFobjctEndde}" var="sttusExaminFobjctEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminFobjctEndde}" 	        var="endFmt" 	             pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label62" name="label62" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label62" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label61').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label62').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label61").on("dp.change", function (e) {
                                        $('#label62').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label62").on("dp.change", function (e) {
                                        $('#label61').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>
                         --%>
                        <tr>
                            <th class="req">최종평가</th>
                            <td>
                            	<div class="dataSearch">
                            		<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminResultBgnde}" var="sttusExaminResultBgnde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminResultBgnde}" 	        var="startFmt" 	             pattern="yyyy.MM.dd HH:mm" />                                  		
		                                <input type="text" id="label71" name="label71" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
                                    	<label for="label71" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
                                   	</div>
                                   	<div class="div">~</div>
                                	<div class="ipt_group datepicker">
	                                	<fmt:parseDate value="${resultList.sttusExaminResultEndde}" var="sttusExaminResultEndde" pattern="yyyy-MM-dd HH:mm" />
	                                	<fmt:formatDate value="${sttusExaminResultEndde}" 	        var="endFmt" 	             pattern="yyyy.MM.dd HH:mm" />                                 	
	                                	<input type="text" id="label72" name="label72" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
	                                    <label for="label72" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                </div>
                                </div>
                                <script type="text/javascript">
                                $(function () {
                                    $('#label71').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm'
                                    });
                                    $('#label72').datetimepicker({
                                        format: 'YYYY.MM.DD HH:mm',
                                        useCurrent: false
                                    });
                                    $("#label71").on("dp.change", function (e) {
                                        $('#label72').data("DateTimePicker").minDate(e.date);
                                    });
                                    $("#label72").on("dp.change", function (e) {
                                        $('#label71').data("DateTimePicker").maxDate(e.date);
                                    });
                                });
                            </script>
                            </td>
                        </tr>   
                    </tbody>
                    <input type="hidden" id="isModify"  name="isModify" value="">
                </table>
                <div class="board_list_btn right">
	                <a href="#" class="btn black" onClick="javascript:selectList();">목록으로</a>
                	<a href="#" class="btn blue" onClick="javascript:fnSavOrderList(); return false;">등록</a>
            	</div>
            </div>
        </div>
    </div>
    <!-- /레이어 팝업 --> 
</form>