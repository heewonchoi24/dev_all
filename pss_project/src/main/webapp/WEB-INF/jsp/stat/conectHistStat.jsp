<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<head>
<title>보건복지 개인정보보호 지원시스템 &#124; 통계현황 &#124; 일별 접속 통계</title>
<script src="/echarts/echarts.js" type="text/javascript"></script>
<script src="/js/chart.js" type="text/javascript"></script>
<script type="text/javascript">
	 $(document).ready(function(){
		drawChart();
	 });
 
	function drawChart(){
		
		var pParam = {};
		var pUrl = '/stat/conectHistDataList.do';
		
		pParam.fromDt = $("#fromDt").val();
		pParam.endDt = $("#endDt").val();
		
		var jsonArr1 = [];
		var jsonArr2 = [];
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, pParam, function(data, textStatus, jqXHR){
			
			$.each(data.resultList, function(index,obj){
				jsonArr1.push(obj.name);
				jsonArr2.push(obj.value);
			});
		}, function(jqXHR, textStatus, errorThrown){
			
		});
		
		if('' != jsonArr1) {
			initLineOneChart('conectChart', '일별 접속 통계', jsonArr1, jsonArr2);
		} else {
			$("#conectChart").attr("_echarts_instance_", "");
			$("#conectChart").attr("style", "");
			$("#conectChart").html('<div class="no_data">등록된 데이터가 없습니다.</div>');
		}
	}
	function selectList() {
		drawChart();
	}
	
	function searchClear(){
		$("#fromDt").val("");
		$("#fromDt").val("");
	}
</script>
</head>

<form method="post" id="statForm" name="statForm">
   	<!-- content -->
    <div id="container">
        <div class="content_wrap">
            <h2 class="h2">일별 접속 통계 현황</h2>
            
            <div class="content">
                <div class="search_wrap">
                	<strong>조회조건</strong>
                 	<label for="fromDt" class="hidden">시작일</label>
                    <input type="text" id="fromDt" name="fromDt" value="" class="w10 datepicker" placeholder="시작일" readonly="readonly">
                    <span class="hipun">~</span>
                    <label for="endDt" class="hidden">종료일</label>
                    <input type="text" id="endDt" name="endDt" value="" class="w10 datepicker" placeholder="종료일" readonly="readonly">
                    <input type="button" onclick="selectList();" value="검색" class="button bt3 gray">
                    <input type="button" onclick="searchClear();" value="초기화" class="button bt3">
                </div>
            </div>
            
            <div class="content">
                <div class="graph_wrap">
                    <div class="graph2 h500">
                        <div class="graph_header">일별 접속 통계</div>
                        <div class="graph_area" id="conectChart">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>