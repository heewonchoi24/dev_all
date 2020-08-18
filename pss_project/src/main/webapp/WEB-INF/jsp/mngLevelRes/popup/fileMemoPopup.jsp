<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" href="/resources/front/css/default.css" />
<link rel="stylesheet" href="/resources/front/css/common.css" />

<script src="/resources/front/js/chkscript.js"></script>
<script src="/resources/front/js/jquery-1.11.2.min.js"></script>
<script src="/resources/front/js/jquery-migrate-1.2.1.min.js"></script>
<script src="/resources/front/js/jquery.dotdotdot.min.js"></script>
<script src="/resources/front/js/common.js"></script>
<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>

<script src="/js/custom.js" type="text/javascript"></script>
<script src="/js/jquery_ui/jquery-ui.js" type="text/javascript"></script>

<script type="text/javascript">
	function textarea_maxlength(obj){
		var maxLength = parseInt(obj.getAttribute("maxlength"));
		if(obj.value.length>maxLength){
			alert("글자수가 " + (obj.value.length-1)+"자 이내로 제한됩니다.");
			obj.value = obj.value.substring(0, maxLength);
		}
	}
	
	function fnSave() {
		
		if( $(".textarea").val() == ''){
			alert("메모를 입력해주세요.");
			return true;
		}

		var pUrl = "/mngLevelRes/updateMngLevelRes.do";
		var param = new Object();
		//var jsonObj = JSON.parse(${requestZvl.uploadedFilesInfo });

		param.atchmnfl_id = '${requestZvl.atchmnfl_id }';
		param.insttCd =  '${requestZvl.insttCd }';
		param.mngLevelIdxSeq =  '${requestZvl.mngLevelIdxSeq }';
		param.gubunCd =  '${requestZvl.gubunCd }';

		var memo = $(".textarea").val();
		param.memo = memo.replace("\n", " ");
		param.uploadedFilesInfo = ${requestZvl.uploadedFilesInfo };
		
		//$( "#uploadedFilesInfo" ).val( param.uploadedFilesInfo );
		
		if(param.atchmnfl_id == "") {
			pUrl = "/mngLevelRes/insertMngLevelRes.do";
		}
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
		}, function(jqXHR, textStatus, errorThrown){
				
		});
		
		document.form.action = "/mngLevelRes/mngLevelModifyList.do";
		document.form.submit();	 
		
	}  	
</script>

<form action="" method="post" id="form2" name="form2">
		
	<div class="wrap-popup-ty2">
		<div class="inner">
			<header class="header">
				<h1>파일 업로드</h1>
			</header>
			<section class="area_cont">
				<div class="wrap_table2">
					<table id="table-1" class="tbl">
						<tbody>
							<tr>
								<th class="bg" scope="row" style="width: 25%;">진단 항목</th>
								<td class="ta-l">${requestZvl.check_item }</td>
							</tr>
							<tr>
								<th class="bg" scope="row" style="width: 25%;">파일 첨부 메모</br>(변경 사유 메모)</th>
								<td class="ta-l">
									<div class="wra_texarea">
										<textarea class="textarea wa" maxlength="1000" onkeyup="return textarea_maxlength(this)"></textarea>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-bot2 ta-c">
					<a href="#" class="btn-pk n rv purple" onClick="javascript:fnSave(); return false;"><span>저장</span></a>
					<a href="#" class="btn-pk n rv gray b-close"><span>취소</span></a>
				</div>
			</section>
			<button class="b-close btn_close"><span class="blind">닫기</span><i class="icon-cross2"></i></button>
		</div>
	</div>    	
</form>