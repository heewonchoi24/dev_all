<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">

$(function(){
	fn_numberInit();
	if($("input:radio[name='cntrlPrearngeYn']:checked").length == 0) $("#cntrlPrearngeN").prop("checked", true);
})
function fnSavOrgList() {
    //연락처 val
	var vTel = $(".tel1").map(function(){return this.value;}).get().join("-");
	//연락처(첫번째) el
	var eTel2 = $("#reprsntTelno1");
	//연락처(두번째) el
	var eTel3 = $("#reprsntTelno2");

	if(!$( "#insttCd"  ).val()){alert("기관코드는 필수입력 사항입니다."); $( "#insttCd" ).focus(); return;}
	if(!$( "#insttNm"  ).val()){alert("기관명은 필수입력 사항입니다."); $( "#insttNm" ).focus(); return;}
	if(!$( "#insttClCd"  ).val()){alert("기관구분은 필수입력 사항입니다."); $( "#insttClCd" ).focus(); return;}
	if(!$( "#outputOrdr"  ).val()){alert("출력순서는 필수입력 사항입니다."); $( "#outputOrdr" ).focus(); return;}
	var cntrlPrearngeYn = $("input[name=cntrlPrearngeYn]:checked").val();
	if(cntrlPrearngeYn === undefined){alert("관제예정기관여부는 필수선택 사항입니다."); $("#cntrlPrearngeYn").focus(); return;}
	
	var chkIp = [];
	var ipField = '';
	var chkIpbool = true;
	$(".permIp").each(function(i){
		ipField = $(this).val();
		if(ipField == ''){
			alert("허용 IP는 필수입력 사항입니다.");
			$(this).focus();
			chkIpbool = false;
		}
		
		if(i==0 || i==3){
			if(parseInt(ipField) ==0 || parseInt(ipField) > 255) {
				alert("허용 IP가 유효하지 않습니다.:" + $(this).val()); 
				$(this).focus(); 
				chkIpbool = false;
			}
		} else {
			if(parseInt(ipField) > 255) {
				alert("허용 IP가 유효하지 않습니다.:"+ $(this).val()); 
				$(this).focus();
				chkIpbool = false;
			}
		}
		chkIp.push(ipField);
	})
	
	if(!chkIpbool)
		return;
	
    var pUrl = "/admin/org/orgModify.do";

	var param = new Object();
	
	param.insttNm   = $("#insttNm").val();
	param.insttClCd = $("#insttClCd").val();
	param.fondDe = $("#fondDe").val().replace(/\./gi, "");
	param.url = $("#url").val();
	param.outputOrdr = $("#outputOrdr").val();
	param.reprsntTelno = vTel;
	
	if($("input:radio[id=cntrlPrearngeN]" ).prop("checked")) {
		param.cntrlPrearngeYn = 'N';
	} else {
		param.cntrlPrearngeYn = 'Y';		
	}
	if($("input:radio[id=deleteN]" ).prop("checked")) {
		param.deleteYn = 'N';
	} else {
		param.deleteYn = 'Y';		
	}
	param.permIp = chkIp.join(".");
	param.insttCd = $("#insttCd").val();
	param.gubun = $("#gubun").val();
	
	var cMsg = ((param.gubun==="U") ? "정보를 수정하시겠습니까?" : "기관을 등록하시겠습니까?");
	if(confirm(cMsg)){
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			
			document.form.action = "/admin/org/orgList.do";
			document.form.submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}
	
}  

function selectList(){
	$("#pageIndex").val("1");
	document.form.action = "/admin/org/orgList.do";
	document.form.submit();
}

</script>

<form method="post" id="form" name="form">
	<input type="text" id="gubun" name="gubun" value="${zvl.gubun}">
	
	<!-- main -->
	<div id="main">
	    <div class="group">
	        <div class="header">
	            <h3>기관 등록/수정</h3>
	        </div>
	        <div class="body">
	           <table class="board_list_write">
	                <tbody>
	                    <tr>
	                        <th class="req">기관코드</th>
	                        <td>
	                            <input type="text" id="insttCd" class="ipt onlyNumber" style="width: 200px;" value="${result.INSTT_CD}" maxLength="7"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">기관명</th>
	                        <td>
	                            <input type="text" id="insttNm" class="ipt" style="width: 200px;" value="${result.INSTT_NM}" maxLength="50"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">기관 구분</th>
	                        <td>
	                           <select id="insttClCd" class="ipt" style="width: 200px;">
									<option value="">기관선택</option>
									<option value="IC01" <c:if test="${result.INSTT_CL_CD == 'IC01' }">selected</c:if>>보건복지부</option>
									<option value="IC02" <c:if test="${result.INSTT_CL_CD == 'IC02' }">selected</c:if>>본부</option>
									<option value="IC03" <c:if test="${result.INSTT_CL_CD == 'IC03' }">selected</c:if>>소속기관</option>
									<option value="IC04" <c:if test="${result.INSTT_CL_CD == 'IC04' }">selected</c:if>>산하공공기관</option>
	                           </select>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>설립일자</th>
	                        <td>
	                            <div class="ipt_group datepicker">
	                                <input type="text" id="fondDe" name="" class="ipt w100p" value="${result.FOND_DE}">
	                                <label for="fondDe" class="btn square trans"><i class="k-icon k-i-calendar"></i></label>
	                                <script type="text/javascript">
	                                    $(function () {
	                                        $('#fondDe').datetimepicker({
	                                            format: 'YYYY.MM.DD'
	                                        });
	                                    });
	                                </script>
	                            </div>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>URL</th>
	                        <td>
	                            <input type="text" id="url" class="ipt" style="width: 100%;" value="${result.URL}" maxLength="100"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">출력순서</th>
	                        <td>
	                            <input type="text" id="outputOrdr" class="ipt onlyNumber" style="width: 70px;" value="${result.OUTPUT_ORDR}" maxLength="14"/>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>대표 전화번호</th>
	                        <td>
                                <input type="text" id="reprsntTelno"  class="ipt tel tel1 onlyNumber"  title="전화번호 앞 자리(국번)" maxLength="4" value="${fn:split(result.REPRSNT_TELNO,'-')[0] }"><span class="hipun">-</span>                                
                                <input type="text" id="reprsntTelno1" class="ipt tel tel1 onlyNumber" title="전화번호 두번 째 자리" maxLength="4" value="${fn:split(result.REPRSNT_TELNO,'-')[1] }"><span class="hipun">-</span>
                                <input type="text" id="reprsntTelno2" class="ipt tel tel1 onlyNumber"  title="전화번호 끝 자리" maxLength="4" value="${fn:split(result.REPRSNT_TELNO,'-')[2] }">
	                        </td>
	                    </tr>
	                    <tr>
	                        <th class="req">관제예정<br/> 기관여부</th>
	                        <td>
	                            <input type="radio" id="cntrlPrearngeY" name="cntrlPrearngeYn" class="custom" <c:if test="${result.CNTRL_PREARNGE_YN == 'Y' }">checked</c:if>/>
	                            <label for="cntrlPrearngeY">Y</label>
	                            <input type="radio" id="cntrlPrearngeN" name="cntrlPrearngeYn" class="custom" <c:if test="${result.CNTRL_PREARNGE_YN == 'N' }">checked</c:if>/>
	                            <label for="cntrlPrearngeN">N</label>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>허용 IP</th>
	                        <td>
	                        	<c:if test="${!empty result.PERM_IP}">
		                            <input type="text" name="permIp1" id="permIp1" class="ipt permIp" maxLength="3" value="${fn:split(result.PERM_IP,'.')[0] }">&nbsp;
	                                <input type="text" name="permIp2" id="permIp2" class="ipt permIp" maxLength="3" value="${fn:split(result.PERM_IP,'.')[1] }">&nbsp;
	                                <input type="text" name="permIp3" id="permIp3" class="ipt permIp" maxLength="3" value="${fn:split(result.PERM_IP,'.')[2] }">&nbsp;
	                                <input type="text" name="permIp4" id="permIp4" class="ipt permIp" maxLength="3" value="${fn:split(result.PERM_IP,'.')[3] }">
	                            </c:if>
	                            <c:if test="${empty result.PERM_IP}">
		                            <input type="text" name="permIp1" id="permIp1" class="ipt permIp" maxLength="3" value="*">&nbsp;
	                                <input type="text" name="permIp2" id="permIp2" class="ipt permIp" maxLength="3" value="*">&nbsp;
	                                <input type="text" name="permIp3" id="permIp3" class="ipt permIp" maxLength="3" value="*">&nbsp;
	                                <input type="text" name="permIp4" id="permIp4" class="ipt permIp" maxLength="3" value="*">
	                            </c:if>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th>사용 여부</th>
	                        <td>
	                            <input type="radio" id="deleteN" name="deleteYn" class="custom" checked="" <c:if test="${result.DELETE_YN == 'N' }">checked</c:if>/>
	                            <label for="deleteN">사용</label>
	                            <input type="radio" id="deleteY" name="deleteYn" class="custom" <c:if test="${result.DELETE_YN == 'Y' }">checked</c:if>/>
	                            <label for="deleteY">미사용</label>
	                        </td>
	                    </tr>
	                </tbody>
	           </table>
	           <div class="board_list_btn right">
	                <a href="#" onclick="selectList();" class="btn black">목록으로</a>
	                <a href="#" onClick="fnSavOrgList(); return false;" class="btn blue">저장</a>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- main -->

</form>