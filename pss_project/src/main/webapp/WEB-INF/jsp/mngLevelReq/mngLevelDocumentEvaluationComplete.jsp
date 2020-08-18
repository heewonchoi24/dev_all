<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="/resources/front/js/jquery.form.min.js"></script>
<script src="/js/jquery.form.js"></script>
<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>

<script type="text/javascript">
var pUrl, pParam, msg;

$(document).ready(function(){
	
});

function goBack(){
	document.form.action = '/mngLevelReq/mngLevelDocumentEvaluationDetail.do';
	document.form.submit();
}

function complete(){
	
	$("#form").attr("action", "/mngLevelReq/mngLevelDocumentEvaluationTotalRegist.do");
	
	var options = {
			success : function(data){
				
				alert(data.message);
				
				document.form.action = '/mngLevelReq/mngLevelDocumentEvaluationDetail.do';
				document.form.submit();
				
			},
			type : "POST"
	};
	
	$("#form").ajaxSubmit(options);
}
</script>

<form method="post" id="form" name="form">
	<input type="hidden" name="s_order_no" value="${s_order_no }"/>
	<input type="hidden" name="s_instt_cd" value="${s_instt_cd }"/>
	<input type="hidden" name="s_instt_cl_cd" value=""/>
	<input type="hidden" name="s_instt_nm" value="${s_instt_nm }"/>
	<input type="hidden" name="s_status" value="${mngLevelInsttTotalEvl.STATUS}" />
	<input type="hidden" name="s_instt_cl_nm" value="${s_instt_cl_nm}" />

    <!-- content -->
   <section id="container" class="sub">
       <div class="container_inner">
       		<h1 class="title2 pr-mb1">${s_order_no }년 ${s_instt_nm } <span class="fc_blue">서면평가</span></h1>

			<section class="area_tit1 inr-c">
				<div class="cont">
					<div class="wrap_table3">
						<table id="table-1" class="tbl">
		                    <caption>종합평가 의견 쓰기</caption>
		                    <colgroup>
								<col class="th1_1">
								<col>
		                    </colgroup>
		                    <tbody>
		                        <tr>
		                            <th id="th_a1" scope="row"><label for="">종합평가 의견</label></th>
		                            <td><textarea name="gnrlzEvl" class="textarea wa" maxlength="1000" title="내용을 입력하세요.">${mngLevelInsttTotalEvl.GNRLZ_EVL2 }</textarea></td>
		                        </tr>
		                    </tbody>
						</table>
					</div>
				</div>
			</section>
            <div class="btn-bot2 ta-c">
                <a href="#" onclick="goBack(); return false;" class="btn-pk n rv black">이전화면</a>
                <c:if test="${fn:contains(periodCode, 'B') ||  fn:contains(periodCode, 'D')}">
                	<a href="#" onclick="complete(); return false;" class="btn-pk n rv purple">최종완료</a>
                </c:if>
            </div>            
        </div>
    </section>
    <!-- /content -->
</form>