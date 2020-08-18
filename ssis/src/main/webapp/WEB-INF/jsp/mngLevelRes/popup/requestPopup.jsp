<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" href="/resources/front/css/default.css" />
<link rel="stylesheet" href="/resources/front/css/common.css" />
<script src="/js/ccmsvc.cmd.js" type="text/javascript"></script>

<script type="text/javascript">
	function request2Close(t){
		var $this = $(t);
		$this.closest(".layerPopup").find(".btn_close").trigger("click");
	}
	
	function done() {
		
		if($(".textarea").val() == ''){
			alert("재등록 요청 사유를 입력해주세요.");
			return true;
		}
		
		var pUrl = "/mngLevelRes/updateMngLevelResReAdd.do";
		
		var param = new Object();
		
		param.insttCd  = '${requestZvl.s_instt_cd}';
		param.indexSeq = '${requestZvl.indexSeq}';
		param.requstCn =  $(".textarea").val();
		
		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			
			alert("재등록 요청이 완료되었습니다.");
			
			$("#form").attr("action", "/mngLevelRes/mngLevelSummaryListDetail.do");
			$("#form").submit();
			
		}, function(jqXHR, textStatus, errorThrown){
			
		});
	}  	
</script>

<form action="/mngLevelRes/mngLevelSummaryListDetail.do" method="post" id="form" name="form">
	<div class="wrap-popup-ty2">
		<div class="inner">
			<header class="header">
				<h1>재등록 요청</h1>
			</header>
			<section class="area_cont">
				<div class="wrap_table2">
					<table id="table-1" class="tbl">
	
						<tbody>
							<tr>
								<th class="bg" scope="row">재등록 요청 항목</th>
								<td id="check_item" class="ta-l">${requestZvl.check_item}</td>
							</tr>
							<tr>
								<th class="bg" scope="row">재등록 요청 사유</th>
								<td class="ta-l">
									<div class="wra_texarea">
										<textarea class="textarea wa" id="requstCn" name="requstCn" maxLength="1000"></textarea>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-bot2 ta-c">
					<a href="#" class="btn-pk n rv purple" onClick="javascript:done(); return false;"><span>요청</span></a>
					<a href="#" class="btn-pk n rv gray b-close"><span>취소</span></a>
				</div>
			</section>
			<button class="b-close btn_close"><span class="blind">닫기</span><i class="icon-cross2"></i></button>
		</div>
	</div>
</form>


