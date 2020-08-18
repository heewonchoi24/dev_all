<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 통계현황 &#124; 기관별 현황</title>
<script src="/echarts/echarts.js" type="text/javascript"></script>
<script src="/js/chart.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#orderNo").on("change", function(){
		drawChart();
	})
	
	<c:choose>
		<c:when test="${sessionScope.userInfo.authorId == '1' || sessionScope.userInfo.authorId == '4' }">
			drawChart();
		</c:when>
		<c:when test="${sessionScope.userInfo.authorId == '2' }">
			//drawMultiChart();
		</c:when>
	</c:choose>
		

})
 
function drawChart(){
	pParam = {};
	pUrl = '/stat/institutionStatDataList.do';
	
	var colNmArr1 = [];
	var valueArr1 = [];
	var colNmArr2 = [];
	var valueArr2 = [];
	var orderNo = '';
	
	pParam.orderNo = $("#orderNo").val();
	
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		orderNo = data.orderNo;
		$.each(data.insttStatManageLevelEvlList, function(index,obj){
			colNmArr1.push(obj.colNm);
			valueArr1.push(obj.value);
		})
		
		$.each(data.insttStatStatusExaminList, function(index,obj){
			colNmArr2.push(obj.colNm);
			valueArr2.push(obj.value);
		})
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
	if(colNmArr1 == ''){
		$("#chart").attr("_echarts_instance_", "");
		$("#chart").attr("style", "");
		$("#chart").html('<div class="no_data">등록된 데이터가 없습니다.</div>');
	}else{
		initLineChart('chart', '', colNmArr1, valueArr1, colNmArr2, valueArr2);	
	}
 }
 
function drawMultiChart(){
	pParam = {};
	pUrl = '/stat/bsisStatusDataList.do';
	
	var dataObj = {};
	var colNmArr = [];
	var valueArr = [];
	var chartId = '';
	var statNm = '';
	$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
		orderNo = data.orderNo;
		dataObj = data.bsisStatusDataList;
	}, function(jqXHR, textStatus, errorThrown){
		
	});
	
	$.each($(".chartArea"), function(){
		colNmArr = [];
		valueArr = [];
		chartId = this.id;
		
		if(chartId == 'fileChart'){
			statNm = '개인정보 파일';
			$.each(dataObj, function(index,obj){
				if(obj.code == 'S1'){
					colNmArr.push(obj.colNm);
					valueArr.push(obj.value);
				}
			})	
		}else if(chartId == 'cnsgnChart'){
			statNm = '개인정보 위탁관리';
			$.each(dataObj, function(index,obj){
				if(obj.code == 'S2'){
					colNmArr.push(obj.colNm);
					valueArr.push(obj.value);
					
				}
			})	
		}else if(chartId == 'sysChart'){
			statNm = '개인정보처리시스템';
			$.each(dataObj, function(index,obj){
				if(obj.code == 'S3'){
					colNmArr.push(obj.colNm);
					valueArr.push(obj.value);	
				}
			})	
		}else if(chartId == 'videoChart'){
			statNm = '영상정보처리기기';
			$.each(dataObj, function(index,obj){
				if(obj.code == 'S4'){
					colNmArr.push(obj.colNm);
					valueArr.push(obj.value);	
				}
			})	
		}
		
		if(colNmArr == ''){
			$(this).attr("_echarts_instance_", "");
			$(this).attr("style", "");
			$(this).html('<div class="no_data">등록된 데이터가 없습니다.</div>');
		}else{
			initBarChart(chartId, statNm, colNmArr, valueArr);	
		}
	})
 }
</script>
</head>

<div id="container">
	<div class="content_wrap">
		<c:choose>
			<c:when test="${sessionScope.userInfo.authorId == '1' || sessionScope.userInfo.authorId == '4' }">
				<h2 class="h2">기관별 현황</h2>
				<div class="year_search">
					<label for="label0">연도 선택</label>
					<select title="연도 선택" id="orderNo">
						<c:forEach var="i" items="${orderList }" varStatus="status">
							<option value="${i.orderNo }" <c:if test="${i.orderNo == currentOrderNo }">selected</c:if>>${i.orderNo }</option>
						</c:forEach>
					</select>
				</div>			
				
				<div class="content">
	                <div class="graph_wrap">
	                    <div class="graph2 h500">
	                        <div class="graph_header" id="statNm">기관별 현황</div>
	                        <div class="graph_area" id="chart">
	                        </div>
	                    </div>
	                </div>
	            </div>
			</c:when>
		</c:choose>
	</div>
</div>
<!-- /content -->