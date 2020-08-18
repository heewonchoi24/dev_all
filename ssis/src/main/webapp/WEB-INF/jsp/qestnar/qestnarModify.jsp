<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.no_modi, .no_modi2{display: none;}
	.ipt.no_modi, .ipt.no_modi2{height: auto; border: none; line-height: 2em;}
	.ipt.no_modi.item{font-weight: bold;}
	.ipt.no_modi.itemDetail{font-size: 0.9em;}
</style>
<script type="text/javascript">
	$(window).ready(function(){ // 설문 예정 or 신규작성
		if($("#qestnarSeq").val() == "" || $(".startDate").val() > $(".nowDate").val()){
			$(".no_modi").css("display", "none");
		}else{
			if($(".startDate").val() <= $(".nowDate").val()){ // 설문중 or 설문종료 : 설문항목 수정불가
				$(".modi, .surveyItem tbody tr td:last-child").css("display", "none");
				$(".no_modi").css("display", "inline-block");
				$(".addqest").hide();
				if($(".endDate").val() >= $(".nowDate").val()){ // 설문중 : 설문 기본설정만 수정 가능
					$("#beginDt").attr("readonly", "true");
					$("#beginDt").click(function(){
						alert("설문 시작일이 지난 후에는 설문 시작일을 수정하실 수 없습니다.");
					}) 
				}else if($(".endDate").val() < $(".nowDate").val()){ // 설문완료 : 상세보기
					$(".no_modi2").css("display", "inline-block");
					$(".modi2").css("display", "none");
				}
			}
		}
	});
	
	function add_object() {
	    var html = '<tbody id="quest">';
	        html += '    <tr>';
	        html += '        <th>설문 [객관식]</th>';
	        html += '        <th>질문</th>';
	        html += '        <td>';
	        html += '            <input type="text" id="item" name="" class="ipt w100p item" placeholder="질문을 입력하세요.">';
	        html += '            <div class="ipt_group" style="margin-top: 10px;">';
	        html += '                <input type="text" id="itemDetail" class="ipt itemDetail" placeholder="선택항목을 입력하세요.">';
	        html += '                <span class="ipt_right"><button type="button" class="btn blue" onclick="add_item(this);">추가</button></span>';
	        html += '            </div>';
	        html += '        </td>';
	        html += ' 		 <input id="qesitmCd" type="hidden" value="QQ01"/>';
	        html += '        <td style="width: 140px; text-align: center;">';
	        html += '            <div class="sortBtn">';
	        html += '                <button type="button" class="btn sortDown" onclick="sort_down(this);"></button>';
	        html += '                <button type="button" class="btn sortUp" onclick="sort_up(this);"></button>';
	        html += '            </div>';
	        html += '            <button type="button" class="btn red" onclick="del_survey(this);">설문삭제</button>';
	        html += '        </td>';
	        html += '    </tr>';
	        html += '</tbody>';
	
	    $('.surveyItem').append(html);
	}
	
	function add_subject() {
	    var html = '<tbody id="quest">';
	        html += '    <tr>';
	        html += '        <th>설문 [주관식]</th>';
	        html += '        <th>질문</th>';
	        html += '        <td>';
	        html += '            <input type="text" id="item" maxLength="1000" class="ipt w100p item" placeholder="질문을 입력하세요.">';
	        html += '        </td>';
	        html += ' 		 <input id="qesitmCd" type="hidden" value="QQ02"/>';
	        html += '        <td style="width: 140px; text-align: center;">';
	        html += '            <div class="sortBtn">';
	        html += '                <button type="button" class="btn sortDown" onclick="sort_down(this);"></button>';
	        html += '                <button type="button" class="btn sortUp" onclick="sort_up(this);"></button>';
	        html += '            </div>';
	        html += '            <button type="button" class="btn red" onclick="del_survey(this);">설문삭제</button>';
	        html += '        </td>';
	        html += '    </tr>';
	        html += '</tbody>';
	
	    $('.surveyItem').append(html);
	}
	
	function add_item(t) {
	    var html = '<div class="ipt_group" style="margin-top: 10px;">';
	        html += '    <input type="text" id="itemDetail" class="ipt itemDetail" placeholder="선택항목을 입력하세요.">';
	        html += '    <span class="ipt_right"><button type="button" class="btn blue" onclick="add_item(this);">추가</button></span>';
	        html += '    <span class="ipt_right"><button type="button" class="btn red" onclick="del_item(this);">삭제</button></span>';
	        html += '</div>';
	
	    $(t).closest('.ipt_group').after(html);
	}
	
	
	function del_survey(t) {
	    if(confirm("삭제하시겠습니까?")){
	        $(t).closest('tbody').remove();
	    }
	}
	
	function del_item(t) {
	    if(confirm("삭제하시겠습니까?")){
	        $(t).closest('.ipt_group').remove();
	    }
	}
	
	function sort_down(t) {
	    $(t).closest('tbody').next().after($(t).closest('tbody'));
	}
	
	function sort_up(t) {
	    $(t).closest('tbody').prev().before($(t).closest('tbody'));
	}
	
	function onUpdate() {
		if(!$( "#qestnarSj").val()){alert("설문제목은 필수입력 사항입니다."); $( "#qestnarSj" ).focus(); return;}
		if(!$( "#beginDt"  ).val()){alert("설문시작일은 필수입력 사항입니다."); $( "#beginDt" ).focus(); return;}
		if(!$( "#endDt"    ).val()){alert("설문종료일은 필수입력 사항입니다."); $( "#endDt" ).focus(); return;}
	
	       var p_item =  [];
	       var p_itemDetail =  [];
	       var p_qesitmCd =  [];
	       var index = 0;
	       var exit = true;
	       
			// 질문 For
			$('tbody#quest').each(function(idx1) {
				if(!exit) {
					return false;
				}
				//질문 값
				var item = $(this).find('.item').val();
				if('' == item) {
					alert('질문은 필수 입력입니다.');
					$(this).find('.item').focus();
					exit = false;
					return false;
				}
				var detailAll = '';
				$(this).find('.ipt_group').each(function(idx2) {
					
					if(!exit) {
						return false;
					}
					var itemDetail = $(this).find('.itemDetail').val();
	
					if('' == itemDetail) {
						alert('객관식질문의 선택항목은 필수 입력입니다.');
						$(this).find('.itemDetail').focus();
						exit = false;
						return false;
					}
					detailAll += itemDetail + ',';
				});
	
				p_item[index] = item;
				p_itemDetail[index] = detailAll;
				if(detailAll =="") {
					p_qesitmCd[index] = "QQ02";
				} else {
					p_qesitmCd[index] = "QQ01";
				}
				index++;
			});
		
		if(!exit) {
			return false;
		}
		if(index == 0) {
			alert('설문항목이 없습니다.');
			return false;
		}
	
		var pUrl = "/admin/qestnar/saveQestnar.do";
		
		var param = new Object();
	
	       param.qestnarSeq     = $("#qestnarSeq").val();
	       param.qestnarSj      = $("#qestnarSj").val();
	       param.qestnarCn      = $("#qestnarCn").val();
	       param.beginDt        = fnMakeDate($("#beginDt").val());
	       param.endDt          = fnMakeDate($("#endDt").val());
	
	       param.qesitmCd       = p_qesitmCd;
	       param.item           = p_item;
	       param.itemDetail     = p_itemDetail;
	       
	       if($("#qestnarSeq").val()==""){
	       	param.gubun = "I";
	       } else {
	       	param.gubun = "U";
	       }
	       
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.form.action = "/admin/qestnar/qestnarList.do";
		    document.form.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
	
	function onUpdate2() {
		if(!$( "#qestnarSj").val()){alert("설문제목은 필수입력 사항입니다."); $( "#qestnarSj" ).focus(); return;}
		if(!$( "#beginDt"  ).val()){alert("설문시작일은 필수입력 사항입니다."); $( "#beginDt" ).focus(); return;}
		if(!$( "#endDt"    ).val()){alert("설문종료일은 필수입력 사항입니다."); $( "#endDt" ).focus(); return;}
	
		var pUrl = "/qestnar/saveQestnar2.do";
		
		var param = new Object();
	
	       param.qestnarSeq     = $("#qestnarSeq").val();
	       param.qestnarSj      = $("#qestnarSj").val();
	       param.qestnarCn      = $("#qestnarCn").val();
	       param.beginDt        = fnMakeDate($("#beginDt").val());
	       param.endDt          = fnMakeDate($("#endDt").val());
	       param.gubun = "U";
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.form.action = "/admin/qestnar/qestnarList.do";
		    document.form.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
	
	function fnMakeDate(formatedDt){
		var ymd = formatedDt.split(".");
		if(ymd[0].length > 4) {
			return ymd[0];
		} else {
			return ymd[0]+ymd[1]+ymd[2];		
		}
	}
	
	function fnMakeTime(formatedDt){
		var ymd2 = formatedDt.split(" ");
		//YYYY.MM.DD A hh:mm
		return ymd2[1] + " " + ymd2[2];
		
	}
</script>

<form method="post" id="form" name="form">
<div id="main">
	<input type="hidden" value="${qestnarMastr.N_DT}" class="nowDate">
	<input type="hidden" value="${qestnarMastr.S_DT}" class="startDate">
	<input type="hidden" value="${qestnarMastr.E_DT}" class="endDate">
	<input name="qestnarSeq" id="qestnarSeq" type="hidden" value="${qestnarMastr.SEQ }"/>
	    <div class="group">
	        <div class="header">
				<h3>기본설정</h3>
	        </div>
		    <div class="body" style="min-height: auto;" id="container">
		    	<div class="board_write_top"><span class="req">*</span> 표시는 필수입력 사항입니다.</div>
					<table class="board_list_write" summary="설문제목, 설문기간, 설문내용으로 구성된 설문조사 기본등록입니다.">
						<colgroup>
							<col style="width:10%;">
							<col style="width:*;">
						</colgroup>
                        <tbody>
                            <tr>
                                <th class="req" scope="row">설문제목</th>
                                <td>
                                    <input type="text" id="qestnarSj" class="ipt w100p modi2" title="설문제목" value="${qestnarMastr.SUBJECT}" maxLength="50">
                                    <p id="qestnarSj" class="ipt w100p no_modi2">${qestnarMastr.SUBJECT}</p>
                                </td>
                            </tr>  
                            <tr>
                                <th class="req" scope="row"> 설문기간</th>
                                <td>
		                            <div class="dataSearch modi2">
		                                <div class="ipt_group datepicker beginDtDiv">
		                                    <input type="text" name="beginDt" class="ipt w100p" id="beginDt" value="${qestnarMastr.BEGIN_DT}" placeholder="시작일시" >
		                                    <label for="beginDt" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
		                                </div>
		                                <div class="div">~</div>
		                                <div class="ipt_group datepicker">
		                                    <input type="text" name="endDt" class="ipt w100p" id="endDt" value="${qestnarMastr.END_DT}" placeholder="종료일시" >
		                                    <label for="endDt" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
		                                </div>
		                            </div>
		                            <div class="dataSearch no_modi2">
		                            	<p class="ipt w100p no_modi2">${qestnarMastr.BEGIN_DT} &nbsp; ~ &nbsp; ${qestnarMastr.END_DT}</p>
		                            </div>
		                            <script type="text/javascript">
		                                $(function () {
		                                    $('#beginDt').datetimepicker({
		                                        //format: 'YYYY.MM.DD A hh:mm'
		                                        format: 'YYYY.MM.DD'
		                                    });
		                                    $('#endDt').datetimepicker({
		                                        //format: 'YYYY.MM.DD A hh:mm',
		                                        format: 'YYYY.MM.DD',
		                                        useCurrent: false
		                                    });
		                                    $("#beginDt").on("dp.change", function (e) {
		                                        $('#endDt').data("DateTimePicker").minDate(e.date);
		                                    });
		                                    $("#endDt").on("dp.change", function (e) {
		                                        $('#beginDt').data("DateTimePicker").maxDate(e.date);
		                                    });
		                                });
		                            </script>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row" class="">설문내용</th>
                                <td>
                                    <textarea rows="10" class="ipt modi2" id="qestnarCn" title="설문내용" style="width: 100%; height: auto;" maxLength="1000">${qestnarMastr.CONTENTS}</textarea>
                                    <p class="ipt no_modi2" id="qestnarCn" style="width: 100%; height: auto;">${qestnarMastr.CONTENTS}</p>
                                </td>
                            </tr>
                        </tbody>
                   	</table>
                    <c:if test="${!empty qestnarMastr.SEQ }">
	                    <div class="board_list_btn right">
	                        <a href="#" class="btn blue modi2" onClick="onUpdate2();return false;">저장</a>
	                        <a href="/admin/qestnar/qestnarList.do" class="btn black">취소</a>
	                    </div>
                   </c:if>
			</div>
		</div>
			
		<div class="group">
	        <div class="header">
	            <h3>설문항목</h3>
	        </div>
               <div class="body" style="min-height: auto;">
           		<div class="board_write_top">
                    <button type="button" onClick="add_object();return false;" class="btn blue addqest modi">객관식 추가</button>
                    <button type="button" onClick="add_subject();return false;" class="btn blue addqest modi">주관식 추가</button>
                </div>
                  	<table class="board_list_write surveyItem" summary="번호, 질문으로 구성된 객관식 설문항목 등록입니다.">
	                <c:choose>
						<c:when test="${!empty qestnarItemList}"> 
							<!-- 수정 시 -->
							<c:forEach var="list" items="${qestnarItemList}" varStatus="status">
								<c:choose>
									<c:when test="${list.QESITM_CD == 'QQ01'}">
	                                 <!-- 객관식 설문 -->
										<tbody id="quest">
											<tr>
												<th>설문 ${list.QESITM_NO } [객관식]</th>
												<th>질문</th>
												<td>
												<!-- 객관식 기본 -->
													<input type="text" id="item" class="ipt w100p item modi" title="질문" placeholder="질문을 입력하세요." value="${list.QESITM_CN}" maxLength="1000">
													<p id="item" class="ipt w100p item no_modi">${list.QESITM_CN}</p>
													<c:set var="tmpDetail" value="${list.SEQ }"/>
													<!-- /객관식 기본 -->
													<c:forEach var="list2" items="${qestnarDetailList}" varStatus="status">
														<c:if test="${list2.QESITM_SEQ == tmpDetail}">
															<div class="ipt_group" style="margin-top: 10px;">
																<input type="text" class="ipt itemDetail modi" id="itemDetail" placeholder="선택항목을 입력하세요." value="${list2.QESITM_DETAIL_CN}" maxLength="1000">
																<p class="ipt itemDetail no_modi" id="itemDetail">&nbsp;&nbsp;└ &nbsp;&nbsp;&nbsp; ${list2.QESITM_DETAIL_CN}</p>
																<span class="ipt_right"><button type="button" onClick="add_item(this);" class="btn blue modi">추가</button></span>
																<c:if test="${list2.QESITM_DETAIL_NO !=0}">
																	<span class="ipt_right">
																		<button type="button" onClick="del_item(this);" class="btn red modi">삭제</button>
																	</span>
																</c:if>
															</div>											
														</c:if>
													</c:forEach>
												</td>
												<input id="qesitmCd" type="hidden" value="QQ01"/> 
												<td style="width: 140px; text-align: center;">
													<div class="sortBtn">
														<button type="button" class="btn sortDown modi" onclick="sort_down(this);"></button>
														<button type="button" class="btn sortUp modi" onclick="sort_up(this);"></button>
						                         	</div>
													<button type="button" onClick="del_survey(this);" class="btn red modi">설문삭제</button>
                         						</td>	
											</tr>
										</tbody>
									<!-- /객관식 설문 -->   
									</c:when>
	            					<c:otherwise>
	            					<!-- 주관식 설문 -->
                           				<tbody id="quest">
											<tr>
											    <th>설문 ${list.QESITM_NO } [주관식] </th>
												<th>질문</th>
												<td>
											    	<input type="text" class="ipt w100p item modi" id="item" title="질문" placeholder="질문을 입력하세요." value="${list.QESITM_CN}" maxLength="1000">
											    	<p class="ipt w100p item no_modi" id="item">${list.QESITM_CN}</p>
											    </td>
												<input id="qesitmCd" type="hidden" value="QQ02"/> 
											    <td style="width: 140px; text-align: center;">
													<div class="sortBtn">
														<button type="button" class="btn sortDown modi" onclick="sort_down(this);"></button>
														<button type="button" class="btn sortUp modi" onclick="sort_up(this);"></button>
						                         	</div>
													<button type="button" onClick="del_survey(this);" class="btn red modi">설문삭제</button>
		                         				</td>	
											</tr>
	                             		</tbody>
                            			<!-- /주관식 설문 -->
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise> 
						<!-- 신규 작성 시 -->
							<tbody id="quest">
								<tr>
									<th>설문 [객관식]</th>
									<th>질문</th>
									<td>
										<input type="text"  class="ipt w100p item" id="item" title="질문" placeholder="질문을 입력하세요." maxLength="1000">
										<div class="ipt_group" style="margin-top: 10px;">
											<input type="text" class="ipt itemDetail" id="itemDetail" title="" placeholder="선택항목을 입력하세요."  maxLength="1000">
											<span class="ipt_right"><button type="button" onClick="add_item(this);return false;" class="btn blue">추가</button></span>
										</div>
										<div class="ipt_group" style="margin-top: 10px;">
											<input type="text" class="ipt itemDetail" id="itemDetail" title="" placeholder="선택항목을 입력하세요."  maxLength="1000">
											<span class="ipt_right"><button type="button" onClick="add_item(this);return false;" class="btn blue">추가</button></span>
											<span class="ipt_right"><button type="button" onClick="del_item(this);return false;" class="btn red">삭제</button></span>
										</div>
									</td>
									<td style="width: 140px; text-align: center;">
										<input id="qesitmCd" type="hidden" value="QQ01"/> 
										<div class="sortBtn">
										    <button type="button" class="btn sortDown" onclick="sort_down(this);"></button>
										    <button type="button" class="btn sortUp" onclick="sort_up(this);"></button>
										</div>
									    <button type="button" onClick="del_survey(this);" class="btn red">설문삭제</button>
									</td>
								</tr>
                               <!-- /객관식 설문 -->
							</tbody>
                            <tbody id="quest">
                                <!-- 주관식 설문 -->
                               <tr>
									<th>설문 [주관식]</th>
									<th>질문</th>
									<td>
										<input type="text"  class="ipt w100p item" id="item" title="질문" placeholder="질문을 입력하세요." maxLength="1000">
									</td>
									<td style="width: 140px; text-align: center;">
										<input id="qesitmCd" type="hidden" value="QQ02"/> 
										<div class="sortBtn">
										    <button type="button" class="btn sortDown" onclick="sort_down(this);"></button>
										    <button type="button" class="btn sortUp" onclick="sort_up(this);"></button>
										</div>
									    <button type="button" onClick="del_survey(this);" class="btn red">설문삭제</button>
									</td>
								</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
				</table>
                <div class="board_list_btn right">
                    <a href="#" class="btn blue modi addqest" onClick="onUpdate();return false;">저장</a>
                    <a href="/admin/qestnar/qestnarList.do" class="btn black">취소</a>
                </div>
			</div>
       	</div>
    <!-- /content -->
    </div>
</form>
