<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="/js/jquery.form.js" type="text/javascript"></script>
<style>.ajax_image_upload2{position: absolute; right: 0;}</style>
<script>
var pUrl, pParam;

function fn_insert(){

	if (confirm("저장하시겠습니까?")) {

		$("#frm_1").attr("action",
				"/admin/contact/mainVisualRegistThread.do");

		var options = {
			success : function(data) {
				if (data.message == "생성이 실패하였습니다.") {
					alert(data.message);
					return false;
					
				} else {
					$("#frm_3").attr("action",
							"/admin/contact/mainVisualRegistThread.do?log=true");

					var options3 = {
						success : function(data) {
							if (data.message == "생성이 실패하였습니다.") {
								alert(data.message);
								return false;
							} else {
								alert(data.message);
								fn_init();
							}
						},
						type : "POST"
					};

					$("#frm_3").ajaxSubmit(options3);

				}
			},
			type : "POST"
		};

		$("#frm_1").ajaxSubmit(options);

	}

}

function fn_init() {
	$("#frm_1").attr({
		action : "/admin/contact/mainVisualList.do",
		method : "post"
	}).submit();
}
</script>
<!-- main -->
<div id="main">
	<c:if test="${not empty resultList}">
		<c:forEach items="${resultList}" var="list">
			<form id="frm_${list.SEQ}" name="frm_${list.SEQ}" method="post" enctype="multipart/form-data">
				<input type="hidden" id="seq" name="seq" value="${list.SEQ}" />
                <input type="hidden" id="img_nm_${list.SEQ}" name="img_nm" value="${list.IMG_NM}" />
                <input type="hidden" id="img_path_${list.SEQ}" name="img_path" value="${list.IMG_PATH}" />	
				<div class="group col2">
					<div class="header">
						<h3>메인타일 ${list.SEQ}</h3>
					</div>
					<div class="body" style="min-height: auto;">
						<table class="board_list_write">
							<tbody>
								<tr>
									<th class="req">이미지<br />[1920 x 700]
									</th>
									<td>
										<div class="uploadImgFile">
											<div class="thumb wide">
												<div class="img ajax_image_file_${list.SEQ}">
													<c:if test="${list.IMG_PATH != ''}">
														<img src="${list.IMG_PATH}/${list.IMG_NM}">
													</c:if>
												</div>
												<button type="button" class="btn_delete"
													onClick="javascript:fn_imageDelete('${list.SEQ}');"></button>
											</div>
											<div class="ajax_image_upload">
			                                    <div class="inp_file">
		                                    		<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
		                                        	<input class="imagefile_${list.SEQ} file_input_hidden" type="file" (change)="fileEvent($event)" id="imagefile_${list.SEQ}" name="imagefile" accept="image/*" />	 		                                        
			                                    </div>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>수식어</th>
									<td><input type="text" id="modifier" name="modifier"
										class="ipt" style="width: 100%;" value="${list.MODIFIER}" />
									</td>
								</tr>
								<tr>
									<th class="req">타이틀</th>
									<td><input type="text" id="title" name="title" class="ipt"
										style="width: 100%;" value="${list.TITLE}"
										placeholder="필수 입력 사항입니다." /></td>
								</tr>
								<tr>
									<th>내용</th>
									<td><textarea id="content" name="content" class="ipt"
											style="width: 100%;" rows="5" value="${list.CONTENT}">${list.CONTENT}</textarea></td>
								</tr>
								<tr>
									<th>하이퍼링크</th>
									<td><input type="text" id="link" name="link" class="ipt"
										style="width: 100%;" value="${list.LINK}" /></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

			</form>
		</c:forEach>
		<div class="group">
			<div class="body" style="min-height: auto;">
				<div class="board_list_btn right" style="margin-top: 0;">
					<a href="#" class="btn blue"
						onClick="javascript:fn_insert();">저장</a>
				</div>
			</div>
		</div>
	</c:if>
	<c:if test="${empty resultList}">
		<form id="frm_1" name="frm_1" method="post" enctype="multipart/form-data">
			<input type="hidden" id="seq" name="seq" value="1" />
            <input type="hidden" id="img_nm_1_1" name="img_nm" />
            <input type="hidden" id="img_path_1_1" name="img_path" />			
			<div class="group col2">
				<div class="header">
					<h3>메인타일 1</h3>
				</div>
				<div class="body" style="min-height: auto;">
					<table class="board_list_write">
						<tbody>
							<tr>
								<th>이미지<br />[1920 x 700]
								</th>
								<td>
									<div class="uploadImgFile">
										<div class="thumb wide">
											<div class="img ajax_image_file_1_1"></div>
											<button type="button" class="btn_delete"
												onClick="javascript:fn_imageDelete('1_1');"></button>
										</div>
										<div class="ajax_image_upload">
											<div class="inp_file">
		                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
		                                        <input class="imagefile_1_1 file_input_hidden" type="file" (change)="fileEvent($event)" id="imagefile_1_1" name="imagefile" accept="image/*" />
	                                        </div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>수식어</th>
								<td><input type="text" id="modifier" name="modifier"
									class="ipt" style="width: 100%;" value="" /></td>
							</tr>
							<tr>
								<th class="req"> 타이틀</th>
								<td><input type="text" id="title" name="title" class="ipt"
									style="width: 100%;" value="" placeholder="필수 입력 사항입니다." /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea id="content" name="content" class="ipt"
										style="width: 100%;" rows="5" value=""></textarea></td>
							</tr>
							<tr>
								<th>하이퍼링크</th>
								<td><input type="text" id="link" name="link" class="ipt"
									style="width: 100%;" value="" /></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</form>
		<form id="frm_3" name="frm_3" method="post" enctype="multipart/form-data">
		    <input type="hidden" id="seq" name="seq" value="3" />
            <input type="hidden" id="img_nm_3_1" name="img_nm" />
			<input type="hidden" id="img_path_3_1" name="img_path" />	  		
			<div class="group col2">
				<div class="header">
					<h3>메인타일 3</h3>
				</div>
				<div class="body" style="min-height: auto;">
					<table class="board_list_write">
						<tbody>
							<tr>
								<th class="req">이미지<br />[1920 x 700]
								</th>
								<td>
									<div class="uploadImgFile">
										<div class="thumb wide">
											<div class="img ajax_image_file_3_1"></div>
											<button type="button" class="btn_delete"
												onClick="javascript:fn_imageDelete('3_1');"></button>
										</div>
										<div class="ajax_image_upload">
		                                    <div class="inp_file">
		                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
		                                        <input class="imagefile_3_1 file_input_hidden" type="file" (change)="fileEvent($event)" id="imagefile_3_1" name="imagefile" accept="image/*" />	                                        
		                                    </div>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>수식어</th>
								<td><input type="text" id="modifier" name="modifier"
									class="ipt" style="width: 100%;" value="" /></td>
							</tr>
							<tr>
								<th><span style="color: red">*</span> 타이틀</th>
								<td><input type="text" id="title" name="title" class="ipt"
									style="width: 100%;" value="" placeholder="필수 입력 사항입니다." /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea id="content" name="content" class="ipt"
										style="width: 100%;" rows="5" value=""></textarea></td>
							</tr>
							<tr>
								<th>하이퍼링크</th>
								<td><input type="text" id="link" name="link" class="ipt"
									style="width: 100%;" value="" /></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="group">
				<div class="body" style="min-height: auto;">
					<div class="board_list_btn right" style="margin-top: 0;">
						<a href="#" class="btn blue"
							onClick="javascript:fn_insert();">저장</a>
					</div>
				</div>
			</div>
		</form>
	</c:if>
</div>
<!-- main -->

<script type="text/javascript">
$('.imagefile_1').on('change', function(e) {
	preveal_1(this);
});

function preveal_1(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('.img.ajax_image_file_1').html(
					'<img src="' + e.target.result + '">');
		}
		reader.readAsDataURL(input.files[0]);
	}
};

$('.imagefile_3').on('change', function(e) {
	preveal_3(this);
});

function preveal_3(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('.img.ajax_image_file_3').html(
					'<img src="' + e.target.result + '">');
		}
		reader.readAsDataURL(input.files[0]);
	}
};

$('.imagefile_1_1').on('change', function(e) {
	preveal_1_1(this);
});

function preveal_1_1(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('.img.ajax_image_file_1_1').html(
					'<img src="' + e.target.result + '">');
		}
		reader.readAsDataURL(input.files[0]);
	}
};

$('.imagefile_3_1').on('change', function(e) {
	preveal_3_1(this);
});

function preveal_3_1(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$('.img.ajax_image_file_3_1').html(
					'<img src="' + e.target.result + '">');
		}
		reader.readAsDataURL(input.files[0]);
	}
};

function fn_imageDelete(seq) {
	$('.img.ajax_image_file_' + seq).html('');
	$('#img_nm_' + seq).val('');
	$('#img_path_' + seq).val('');		
	$('#imagefile_' + seq).val('');	
}
</script>