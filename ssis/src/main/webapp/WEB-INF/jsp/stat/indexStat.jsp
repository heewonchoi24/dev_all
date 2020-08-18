<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 통계현황 &#124; 지표별 현황</title>
<script src="/echarts/echarts.js" type="text/javascript"></script>
<script src="/js/chart.js" type="text/javascript"></script>
<script type="text/javascript">
	 $(document).ready(function(){
		drawChart();
	 });
 
	function drawChart(){
		
		var pParam = {};
		var pUrl = '/stat/indexStatDataList.do';
		
		pParam.orderNo = $("#orderNo").val();
		pParam.insttClCd = $("#insttClCd").val();
		
		var jsonArr1 = new Array();
		var jsonArr2 = [];
		var jsonArr3 = new Array();
		var jsonArr4 = [];
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			
			$.each(data.resultList1, function(index,obj){
				if('undefined' != typeof(obj.value)) {
					var object = new Object();
					object.name  = obj.name;
					object.max = 100;
					jsonArr1.push(object);
					
					jsonArr2.push(obj.value);
				}
			});
			
			$.each(data.resultList2, function(index,obj){
				if('undefined' != typeof(obj.value)) {
					var object = new Object();
					object.name  = obj.name;
					if('2' == data.auth) {
						object.max = 4;
					} else {
						object.max = 100;
					}
					jsonArr3.push(object);
					
					jsonArr4.push(obj.value);
				}
			});
		}, function(jqXHR, textStatus, errorThrown){
			
		});
		
		if('' != jsonArr1) {
			initRadarChart('manageChart', '관리수준진단', jsonArr1, jsonArr2);
		} else {
			$("#manageChart").attr("_echarts_instance_", "");
			$("#manageChart").attr("style", "");
			$("#manageChart").html('<div class="no_data">등록된 데이터가 없습니다.</div>');
		}
		if('' != jsonArr3) {
			initRadarChart('statusChart', '관리수준 현황조사', jsonArr3, jsonArr4);
		} else {
			$("#statusChart").attr("_echarts_instance_", "");
			$("#statusChart").attr("style", "");
			$("#statusChart").html('<div class="no_data">등록된 데이터가 없습니다.</div>');
		}
	}
	function orderNoChange() {
		drawChart();
	}
	
</script>
</head>

<form method="post" id="statForm" name="statForm">
   	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">지표별 현황</h2>
            
            <c:choose>
	            <c:when test="${sessionScope.userInfo.authorId == '1' || sessionScope.userInfo.authorId == '4' }">
		            <div class="content">
		                <div class="search_wrap">
		                	<strong>조회조건</strong>
		                 	<select id="orderNo" name="orderNo" title="연도">
		                 		<c:forEach var="list" items="${orderList }" varStatus="status">
									<option value="${list.orderNo }" <c:if test="${list.orderNo eq orderNo }">selected</c:if>>${list.orderNo }</option>
								</c:forEach>
		                 	</select>
		                 	<select id="insttClCd" name="insttClCd" title="기관구분 선택">
		                 		<option value="">전체</option>
		                        <c:forEach var="codeList" items="${codeList}"  varStatus="status" >
				                    <option value="${codeList.CODE}">${codeList.CODE_NM}</option>
				                </c:forEach>
		                 	</select>
		                 	<input type="button" onclick="drawChart();" class="button bt3 gray" value="조회">
		                </div>
		            </div>
		      	</c:when>
		      	<c:otherwise>
		      		<div class="year_search">
						<label for="orderNo">연도별 지표현황</label>
						<select id="orderNo" name="orderNo" title="연도" onchange="orderNoChange(); return false;">
	                 		<c:forEach var="list" items="${orderList }" varStatus="status">
								<option value="${list.orderNo }" <c:if test="${list.orderNo eq orderNo }">selected</c:if>>${list.orderNo }</option>
							</c:forEach>
	                 	</select>
					</div>	
		      	</c:otherwise>
		  	</c:choose>
            
            <div class="content">
                <div class="graph_wrap">
                    <div class="graph2 h400">
                        <div class="graph_header">관리수준진단</div>
                        <div class="graph_area" id="manageChart">
                        </div>
                    </div>
                    <div class="graph2 h400 pos_re">
                        <div class="graph_header">관리수준 현황조사</div>
                        <c:if test="${sessionScope.userInfo.authorId eq '2'}">
	                        <div class="caption">
	                            <ul class="list01">
	                                <li><strong class="c_black">우수</strong> : 4</li>
	                                <li><strong class="c_black">양호</strong> : 3</li>
	                                <li><strong class="c_black">보통</strong> : 2</li>
	                                <li><strong class="c_black">미흡</strong> : 1</li>
	                            </ul>
	                        </div>
	                   	</c:if>
                        <div class="graph_area" id="statusChart">
                        </div>
                    </div>                    
                </div>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>