<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script src="/js/jquery.form.js" type="text/javascript"></script>
<script src="/js/jquery.dataTables.min.js" type="text/javascript"></script>
<script>
function goPage() {
	
	$("#fyerSchdulForm").attr({
        action : "/admin/order/fyerSchdulList.do",
        method : "post"
    }).submit();
	
}

function goSave() {
	
	var cd = "${mngLevelCd}";
	
	if(cd == "ML01" || cd == "ML02"){
		if('' == $("#mngLevelBgnde").val()) {
			alert('시작일자를 선택해주세요');
			return;
		}
		if('' == $("#mngLevelEndde").val()) {
			alert('종료일자를 선택해주세요');
			return;
		}
	}

	if('' == $("#mngLevelTitle").val()) {
		alert('일정 제목을 입력해주세요');
		return;
	}
	if('' == $("#mngLevelCn").val()) {
		alert('일정내용을 입력해주세요');
		return;
	}
	
	var msg = '';
	if('' == $("#fyerSchdulSeq").val()) msg = '등록'; else msg = '수정';
	
	if (confirm("일정을 "+msg+" 하시겠습니까?")) {
		
		$("#fyerSchdulForm").attr("action", "/admin/order/modifyFyerSchdul.do");
		
		var options = {
				success : function(data){
					alert(data.message);
					goPage();
				},
				type : "POST"
		};
		
		$("#fyerSchdulForm").ajaxSubmit(options);
	}
}
</script>

<!-- main -->
<form method="post" id="fyerSchdulForm" name="fyerSchdulForm">
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="${mngLevelCd}"/>		
	
	<div id="main">
	    <div class="group">
	        <div class="header">
	            <h3>일정 등록/수정</h3>
	        </div>
	        <div class="body">
	            <div class="board_write_top"><span class="req">*</span> 표시는 필수입력 사항입니다.</div>
	            <table class="board_list_write">
	                <tbody>
		            	<c:choose>
							<c:when test="${!empty resultList}">
								<c:forEach var="list" items="${resultList}">
									<input name="fyerSchdulSeq" id="fyerSchdulSeq" type="hidden" value="${list.seq}" />
									<input name="orderNo" id="orderNo" type="hidden" value="${list.yyyy}" />		
											                        
									<th class="req">일정</th>
			                        <td>
			                        	<c:if test="${list.mngLevelCd eq 'ML01' or list.mngLevelCd eq 'ML02'}">
			                        		<input type="hidden" id="mm" name="mm" />
			                        		
						                    <div class="dataSearch">
				                                <div class="ipt_group datepicker">
				                                	<fmt:parseDate value="${list.mngLevelBgnde}" var="mngLevelBgnde" pattern="yyyy-MM-dd HH:mm" />
				                                	<fmt:formatDate value="${mngLevelBgnde}" 	 var="startFmt" 	 pattern="yyyy.MM.dd HH:mm" />
				                                    <input type="text" id="mngLevelBgnde" name="mngLevelBgnde" class="ipt w100p" value="${startFmt}" placeholder="시작일시">
				                                    <label for="mngLevelBgnde" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
				                                </div>
				                                <div class="div">~</div>
				                                <div class="ipt_group datepicker">
				                                	<fmt:parseDate value="${list.mngLevelEndde}" var="mngLevelEndde" pattern="yyyy-MM-dd HH:mm" />
				                                	<fmt:formatDate value="${mngLevelEndde}" 	 var="endFmt" 	     pattern="yyyy.MM.dd HH:mm" />
				                                    <input type="text" id="mngLevelEndde" name="mngLevelEndde" class="ipt w100p" value="${endFmt}" placeholder="종료일시">
				                                    <label for="mngLevelEndde" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
				                                </div>
				                            </div>
				                            <script type="text/javascript">
				                                $(function () {
				                                    $('#mngLevelBgnde').datetimepicker({
				                                        format: 'YYYY.MM.DD HH:mm'
				                                    });
				                                    $('#mngLevelEndde').datetimepicker({
				                                        format: 'YYYY.MM.DD HH:mm',
				                                        useCurrent: false
				                                    });
				                                    $("#mngLevelBgnde").on("dp.change", function (e) {
				                                        $('#mngLevelEndde').data("DateTimePicker").minDate(e.date);
				                                    });
				                                    $("#mngLevelEndde").on("dp.change", function (e) {
				                                        $('#mngLevelBgnde').data("DateTimePicker").maxDate(e.date);
				                                    });
				                                });
				                            </script>
			                            </c:if>
										<c:if test="${list.mngLevelCd eq 'ML03'}">
											<c:set var="now" value="<%= new java.util.Date() %>" />
											<input type="hidden" id="mngLevelBgnde" name="mngLevelBgnde" value="<fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${now}"/>">
											<input type="hidden" id="mngLevelEndde" name="mngLevelEndde" value="<fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${now}"/>">
											 											
				                            <select class="ipt" style="width: 100px;" id="mm" name="mm">
				                               <option value="01" <c:if test="${list.mm eq '01'}">selected</c:if>>1월</option>
				                               <option value="02" <c:if test="${list.mm eq '02'}">selected</c:if>>2월</option>
				                               <option value="03" <c:if test="${list.mm eq '03'}">selected</c:if>>3월</option>
				                               <option value="04" <c:if test="${list.mm eq '04'}">selected</c:if>>4월</option>
				                               <option value="05" <c:if test="${list.mm eq '05'}">selected</c:if>>5월</option>
				                               <option value="06" <c:if test="${list.mm eq '06'}">selected</c:if>>6월</option>
				                               <option value="07" <c:if test="${list.mm eq '07'}">selected</c:if>>7월</option>
				                               <option value="08" <c:if test="${list.mm eq '08'}">selected</c:if>>8월</option>
				                               <option value="09" <c:if test="${list.mm eq '09'}">selected</c:if>>9월</option>
				                               <option value="10" <c:if test="${list.mm eq '10'}">selected</c:if>>10월</option>
				                               <option value="11" <c:if test="${list.mm eq '11'}">selected</c:if>>11월</option>
				                               <option value="12" <c:if test="${list.mm eq '12'}">selected</c:if>>12월</option>
				                            </select>
				                        </c:if>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">제목</th>
			                        <td>
			                            <input id="mngLevelTitle" name="mngLevelTitle" class="ipt" style="width: 100%;" value="${list.mngLevelTitle}">
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">일정내용</th>
			                        <td>
			                            <textarea id="mngLevelCn" name="mngLevelCn" rows="6" class="ipt" style="width: 100%; height: auto;" value="${list.mngLevelCn}">${list.mngLevelCn}</textarea>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th>하이퍼링크</th>
			                        <td>
			                            <input id="link" name="link" class="ipt" style="width: 100%;" value="${list.link}">
			                        </td>
			                    </tr>										
			                    </c:forEach>
		                    </c:when>
		                    <c:otherwise>
								<input name="fyerSchdulSeq" id="fyerSchdulSeq" type="hidden" value="" />
								<input name="orderNo" id="orderNo" type="hidden" value="" />	
								
			                    <tr>
			                        <th class="req">일정</th>
			                        <td>
			                        	<c:if test="${mngLevelCd eq 'ML01' or mngLevelCd eq 'ML02'}">
			                        	   <input type="hidden" id="mm" name="mm" />
			                        	   
				                           <div class="dataSearch">
				                                <div class="ipt_group datepicker">
				                                    <input type="text" id="mngLevelBgnde" name="mngLevelBgnde" class="ipt w100p" placeholder="시작일시">
				                                    <label for="mngLevelBgnde" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
				                                </div>
				                                <div class="div">~</div>
				                                <div class="ipt_group datepicker">
				                                    <input type="text" id="mngLevelEndde" name="mngLevelEndde" class="ipt w100p" placeholder="종료일시">
				                                    <label for="mngLevelEndde" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
				                                </div>
				                            </div>
				                            <script type="text/javascript">
				                                $(function () {
				                                    $('#mngLevelBgnde').datetimepicker({
				                                        format: 'YYYY.MM.DD 00:00'
				                                    });
				                                    $('#mngLevelEndde').datetimepicker({
				                                        format: 'YYYY.MM.DD 23:59',
				                                        useCurrent: false
				                                    });
				                                    $("#mngLevelBgnde").on("dp.change", function (e) {
				                                        $('#mngLevelEndde').data("DateTimePicker").minDate(e.date);
				                                    });
				                                    $("#mngLevelEndde").on("dp.change", function (e) {
				                                        $('#mngLevelBgnde').data("DateTimePicker").maxDate(e.date);
				                                    });
				                                });
				                            </script>
			                            </c:if>
										<c:if test="${mngLevelCd eq 'ML03'}">		
											<c:set var="now" value="<%= new java.util.Date() %>" />
											<input type="hidden" id="mngLevelBgnde" name="mngLevelBgnde" value="<fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${now}"/>">
											<input type="hidden" id="mngLevelEndde" name="mngLevelEndde" value="<fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${now}"/>">
											                          
				                            <select class="ipt" style="width: 100px;" id="mm" name="mm">
				                               <option value="01">1월</option>
				                               <option value="02">2월</option>
				                               <option value="03">3월</option>
				                               <option value="04">4월</option>
				                               <option value="05">5월</option>
				                               <option value="06">6월</option>
				                               <option value="07">7월</option>
				                               <option value="08">8월</option>
				                               <option value="09">9월</option>
				                               <option value="10">10월</option>
				                               <option value="11">11월</option>
				                               <option value="12">12월</option>
				                            </select>
				                        </c:if>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">제목</th>
			                        <td>
			                            <input id="mngLevelTitle" name="mngLevelTitle" class="ipt" style="width: 100%;" value="">
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">일정내용</th>
			                        <td>
			                            <textarea id="mngLevelCn" name="mngLevelCn" rows="6" class="ipt" style="width: 100%; height: auto;" value=""></textarea>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th>하이퍼링크</th>
			                        <td>
			                            <input id="link" name="link" class="ipt" style="width: 100%;" value="">
			                        </td>
			                    </tr>                    
		                    </c:otherwise>
	                    </c:choose>
	                </tbody>
	           </table>
	           <div class="board_list_btn right">
	                <a href="#" class="btn black" onclick="goPage(); return false;">목록으로</a>
	                <a href="#" class="btn blue" onclick="goSave(); return false;">저장</a>
	            </div>
	        </div>
	    </div>
	</div>
</form>
<!-- main -->