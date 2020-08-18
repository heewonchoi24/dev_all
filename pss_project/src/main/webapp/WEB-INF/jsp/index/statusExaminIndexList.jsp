<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>.board_list_write > tbody > tr > td.tc { text-align: center; }</style>

<script type="text/javascript">
	
	$(window).ready(function(){
	
		// 지표등록
	    $('#createIndex').unbind('click').bind('click',function(){
	    	if("${resultCheck}" == "Y"){
				alert("결과산정 방법을 입력해주세요.");
				return false;
			}
	    	$("#indexListForm").attr({
                action : "/admin/index/createStatusExaminIndex.do",
                method : "post"
            }).submit();
	    });
		 
	 // 기본사항등록
	    $('#createDefaultIndex').unbind('click').bind('click',function(){
	    	$("#indexListForm").attr({
                action : "/admin/index/createDefaultIndex.do",
                method : "post"
            }).submit();
	    });
	});
	
	function fn_default() {
		
    	$("#indexListForm").attr({
            action : "/admin/index/createDefaultIndex.do",
            method : "post"
        }).submit();
	}
	
	function fn_modify(lclas) {
		
		$("#lclas").val(lclas);
		
    	$("#indexListForm").attr({
            action : "/admin/index/modifyStatusExaminIndex.do",
            method : "post"
        }).submit();
	}
	
	function fn_excel_download() {
    	$("#indexListForm").attr({
            action : "/admin/index/sIndexExcelDownload.do",
            method : "post"
        }).submit();
	}
	
	function fn_init() {
    	$("#indexListForm").attr({
            action : "/admin/index/statusExaminIndexList.do",
            method : "post"
        }).submit();
	}
	
	function fn_excel_upload(){
		if("${resultCheck}" == "Y"){
			alert("결과산정 방법을 입력해주세요.");
			return false;
		}
		if (confirm("등록된 지표는 삭제됩니다. 엑셀 업로드 하시겠습니까?")) {
			$("#indexListForm").attr("action", "/admin/index/sIndexExcelUpload.do");
			
			var options = {
					success : function(data){
						alert(data.message);
						fn_init();
					},
					type : "POST"
			};
			
			$("#indexListForm").ajaxSubmit(options);
		} else {
			$("#excelFile").val("");
		}
	}
	
	function goOrderSearch() {
    	$("#indexListForm").attr({
            action : "/admin/index/statusExaminIndexList.do",
            method : "post"
        }).submit();
	}
</script>

<!-- <form action="/index/statusExaminIndexList.do" method="post" id="indexListForm" name="indexListForm" enctype="multipart/form-data"> -->
<form method="post" id="indexListForm" name="indexListForm" enctype="multipart/form-data">
	<input name="lclas" id="lclas" type="hidden" value=""/>
	<input name="mngLevelCd" id="mngLevelCd" type="hidden" value="ML02"/>
	<input name="addFlag" id="addFlag" type="hidden" value="${addFlag}"/>
	<input name="resultCheck" id="resultCheck" type="hidden" value="${resultCheck}"/>
	
    <!-- content -->
    <div id="main">
	    <div class="group">
	        <div class="header">
	            <h3>기본정보</h3>
	            <div class="select">
	                전년도별 지표조회&nbsp;&nbsp;&nbsp;&nbsp;
	                <select class="ipt" style="width: 100px;" title="년도 선택" id="orderNo" name="orderNo" onchange="goOrderSearch();">
	                    <c:forEach var="orderList" items="${orderList}"  varStatus="status" >
	 	                   <option value="${orderList.orderNo}" <c:if test="${requestZvl.orderNo eq orderList.orderNo}">selected</c:if>>${orderList.orderNo}</option>
	                	</c:forEach>
	                </select>
	            </div>
	        </div>
	        <%-- <c:if test="${resultCheck != 'Y'}"> --%>
		        <div class="body" style="min-height: auto;">
		            <table class="board_list_write">
		                <tbody>
                            <tr>
                                <th scope="row">차수</th>
                                <td>${requestZvl.orderNo}</td>
                                <th scope="row">결과산정 방법</th>
                                <c:if test="${'A' eq resultCheck}">
                                	<td>점수산정 방법</td>
                                </c:if>
                                <c:if test="${'B' eq resultCheck}">
                                	<td>등급산정 방법</td>
                                </c:if>
                                <c:if test="${'Y' eq resultCheck}">
                                	<td></td>
                                </c:if>                          
                            </tr>
		                </tbody>
		            </table>
		            <div class="board_list_btn right">
		                <a href="#" class="btn blue" onclick="javascript:fn_default(); return false;">기본정보 수정</a>
		            </div>
		        </div>
		    <%-- </c:if> --%>
	    </div>
	    <div class="group">
	        <div class="header">
	            <h3>지표등록 현황</h3>
	        </div>
	        <div class="body" style="min-height: auto;">
	        	<%-- <c:if test="${resultCheck != 'Y'}"> --%>
	            <div class="board_list_top">
	                <div class="board_list_search" style="text-align: right;">
	                    <a href="#" class="btn green" onclick="javascript:fn_excel_download(); return false;">엑셀양식 다운로드</a>
	                </div>
            	</div>
                <c:choose>
					<c:when test="${resultCheck != 'Y'}">
		                <c:choose>
							<c:when test="${!empty resultList}">
					            <table class="board_list_write">
					                <thead>
					                    <tr>
                     		 				<th style="width: 220px;">대분류</th>
			                                <th>중분류</th>
			                                <th>소분류</th>
			                                <th>점검지표</th>
			                                <th style="width: 120px;">상세·수정</th>
					                    </tr>
					                </thead>
					                <tbody>
					                	<c:set var="tmpLclas" value=""/>
	                                    <c:set var="tmpMlsfc" value=""/>
	                                    <c:set var="tmpSclas" value=""/>
				                        <c:forEach var="list" items="${resultList}" varStatus="status">
				                        	<c:choose>
												<c:when test="${status.first}">
													<tr>
						                                <th rowspan="${list.lclasCnt}" scope="rowgroup">${list.lclas}</th>
						                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
						                                <td rowspan="${list.sclasCnt}">${list.sclas}</td>
						                                <td>${list.checkItem}</td>
						                                <td rowspan="${list.lclasCnt}" class="tc">
						                                	<c:if test="${'Y' eq modifyFlag}">
						                                    	<a href="#" class="btn blue" onClick="fn_modify('${list.lclas}');return false;">수정</a>
						                                    </c:if>
						                                </td>
						                                <c:set var="tmpLclas" value="${list.lclas}"/>
	                                    				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
	                                    				<c:set var="tmpSclas" value="${list.sclas}"/>
					                            	</tr>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when test="${list.lclas != tmpLclas}">
															<tr>
								                                <th rowspan="${list.lclasCnt}" scope="rowgroup">${list.lclas}</th>
								                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
								                                <td rowspan="${list.sclasCnt}">${list.sclas}</td>
								                                <td>${list.checkItem}</td>
								                                <td rowspan="${list.lclasCnt}" class="tc">
								                                	<c:if test="${'Y' eq modifyFlag}">
								                                    	<a href="#" class="btn blue" onClick="fn_modify('${list.lclas}');return false;">수정</a>
								                                    </c:if>
								                                </td>
							                            	</tr>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${list.mlsfc != tmpMlsfc}">
																	<tr>
										                                <td rowspan="${list.mlsfcCnt}">${list.mlsfc}</td>
										                                <td rowspan="${list.sclasCnt}">${list.sclas}</td>
										                                <td>${list.checkItem}</td>
									                            	</tr>
																</c:when>
																<c:otherwise>
																	<c:choose>
																		<c:when test="${list.sclas != tmpSclas}">
																			<tr>
																				<td rowspan="${list.sclasCnt}">${list.sclas}</td>
										                                		<td>${list.checkItem}</td>
									                            			</tr>
									                            		</c:when>
									                            		<c:otherwise>
									                            			<tr>
										                                		<td>${list.checkItem}</td>
									                            			</tr>
									                            		</c:otherwise>
									                            	</c:choose>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>
					                                <c:set var="tmpLclas" value="${list.lclas}"/>
	                                   				<c:set var="tmpMlsfc" value="${list.mlsfc}"/>
	                                    			<c:set var="tmpSclas" value="${list.sclas}"/>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tbody>
					            </table>
					            <c:if test="${'Y' eq addFlag && 'Y' eq modifyFlag}">
	            					<div class="board_list_btn right">
					            		<a href="#" class="btn blue" id="createIndex">지표 등록</a>
					            		<label for="excelFile" class="btn green">지표 일괄 등록</label>
	                					<input type="file" id="excelFile" name="excelFile" class="upload_bt file_input_hidden" onChange="fn_excel_upload(); return false;" accept=".xlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="position: absolute; width: 0; height: 0; font-size: 0; left: 0;"/>
                					</div>
	            				</c:if>
	            				</c:when>
	            				<c:otherwise>
	            					<div class="box1 mt20">
					                    <p class="c_gray f17" style="text-align: center; margin-top: 85px;">등록된 지표가 없습니다.</p>
					                </div>
					            	<div class="board_list_btn right">
					            		<a href="#" id="createIndex" class="btn blue">지표 등록</a>
					                	<label for="excelFile" class="btn green" style="cursor: pointer;">지표 일괄 등록</label>
	                					<input type="file" id="excelFile" name="excelFile" class="upload_bt file_input_hidden" onChange="fn_excel_upload(); return false;" accept=".xlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="position: absolute; width: 0; height: 0; font-size: 0; left: 0;"/>
                					</div>
                				</c:otherwise>
                			</c:choose>
						</c:when>
						<c:otherwise>
							<div class="box1 mt20">
			                    <p class="c_gray f17" style="text-align: center; margin-top: 85px;">등록된 지표가 없습니다.</p>
			                </div>
			                <div class="board_list_btn right">
			            		<a href="#" id="createIndex" class="btn blue">지표 등록</a>
			            		<label for="excelFile" class="btn green" style="cursor: pointer;">지표 일괄 등록</label>
               					<input type="file" id="excelFile" name="excelFile" class="upload_bt file_input_hidden" onChange="fn_excel_upload(); return false;" accept=".xlsx, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel" style="position: absolute; width: 0; height: 0; font-size: 0; left: 0;"/>
            				</div>
						</c:otherwise>
				</c:choose>
	        </div>
	    </div>
	</div>
    <!-- /content -->
</form>