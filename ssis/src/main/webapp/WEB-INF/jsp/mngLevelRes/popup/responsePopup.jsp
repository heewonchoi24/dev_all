<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<link rel="stylesheet" href="/resources/front/css/default.css" />
<link rel="stylesheet" href="/resources/front/css/common.css" />

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
										<textarea readonly class="textarea wa" id="requstCn" name="requstCn" maxLength="1000">${result.RERGIST_REQUST_CN}</textarea>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn-bot2 ta-c">
					<button class="b-close btn_close"><span class="blind">닫기</span><i class="icon-cross2"></i></button>
				</div>				
			</section>
		</div>
	</div>
</form>