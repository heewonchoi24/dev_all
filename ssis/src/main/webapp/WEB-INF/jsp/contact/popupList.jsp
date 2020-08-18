<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%>
<script src="/js/jquery.form.js" type="text/javascript"></script>
<style>.k-upload-button {position: absolute;right: 0;}</style>
<script>
var pUrl, pParam;
function fn_insert(){
	
	if (confirm("저장하시겠습니까?")) {
		
		$("#pop_type_1").val($("#pop_type_1 option:selected").val());
		$("#pop_type_2").val($("#pop_type_2 option:selected").val());
		$("#pop_type_3").val($("#pop_type_3 option:selected").val());
		
		$("textarea[name=content]").each(function(){
			$(this).val($(this).val().replace(/(?:\r\n|\r|\n)/g, '<br/>'));
		})
		
 		$("#frm_1").attr("action", "/admin/contact/popupRegistThread.do");		
 		
		var options = {
			success : function(data) {
				if (data.message == "생성이 실패하였습니다.") {
					alert(data.message);
					return false;
					
				} else {
					
					$("#frm_2").attr("action", "/admin/contact/popupRegistThread.do");

					var options2 = {
						success : function(data) {
							if (data.message == "생성이 실패하였습니다.") {
								alert(data.message);
								return false;
							} else {
								
								$("#frm_3").attr("action", "/admin/contact/popupRegistThread.do?log=true");

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

					$("#frm_2").ajaxSubmit(options2);

				}
			},
			type : "POST"
		};

		$("#frm_1").ajaxSubmit(options);		 
		
	}
	
}

function fn_init() {
	$("#frm_1").attr({
		action : "/admin/contact/popupList.do",
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
				<input type="hidden" id="icon_img_nm_${list.SEQ}" name="icon_img_nm" value="${list.ICON_IMG_NM}" />
				<input type="hidden" id="icon_img_path_${list.SEQ}" name="icon_img_path" value="${list.ICON_IMG_PATH}" />
				<input type="hidden" id="main1_img_nm_${list.SEQ}" name="main1_img_nm" value="${list.MAIN1_IMG_NM}" />
				<input type="hidden" id="main1_img_path_${list.SEQ}" name="main1_img_path" value="${list.MAIN1_IMG_PATH}" />
				<input type="hidden" id="main2_img_nm_${list.SEQ}" name="main2_img_nm" value="${list.MAIN2_IMG_NM}" />
				<input type="hidden" id="main2_img_path_${list.SEQ}" name="main2_img_path" value="${list.MAIN2_IMG_PATH}" />
				
			    <div class="group" style="max-width: 800px; clear: both;">
			        <div class="header">
			            <h3>팝업 ${list.SEQ}</h3>
			            <div class="switch" style="right: 180px;">
			                <label>
			                    <input type="checkbox" id="open_yn_${list.SEQ}" name="open_yn" value="${list.OPEN_YN}" <c:if test="${'Y' eq list.OPEN_YN}">checked</c:if>>
			                    <span class="lever"></span>
			                </label>
			            </div>
			            <div class="select">
			                <select class="ipt" id="pop_type_${list.SEQ}" name="pop_type" style="max-width: 200px;">
			                   <option value="1" <c:if test="${'1' eq list.POP_TYPE}">selected</c:if>>이미지+텍스트형</option>
			                   <option value="2" <c:if test="${'2' eq list.POP_TYPE}">selected</c:if>>텍스트형</option>
			                   <option value="3" <c:if test="${'3' eq list.POP_TYPE}">selected</c:if>>이미지형</option>
			                </select>
			            </div>
			        </div>
			        <div class="body" style="min-height: auto;">
			           <table class="board_list_write">
			                <tbody>
			                    <tr class="icon">
			                        <th>
			                            아이콘<br/>
			                            [30 x 30]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 100px;">
			                                <div class="thumb">
			                                    <div class="img ajax_image_file icon_${list.SEQ}">
													<c:if test="${list.ICON_IMG_PATH != ''}">
														<img src="${list.ICON_IMG_PATH}/${list.ICON_IMG_NM}">
													</c:if>				                                    
			                                    </div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('icon', '${list.SEQ}');"></button>
			                                </div>
			                                <div class="ajax_image_upload icon_${list.SEQ}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="icon" data-imgnum="${list.SEQ}" id="imagefile_icon_${list.SEQ}" name="imagefile_icon" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr class="tit">
			                        <th>제목</th>
			                        <td>
			                            <input type="text" id="title" name="title" class="ipt" style="width: 100%;" value="${list.TITLE}" />
			                        </td>
			                    </tr>
			                    <tr class="cont">
			                        <th>본문내용</th>
			                        <td>
			                            <textarea id="content" name="content" class="ipt" style="width: 100%;" rows="8">${fn:replace(list.CONTENT,br,cn)}</textarea>
			                        </td>
			                    </tr>
			                    <tr class="img1">
			                        <th>
			                            이미지<br/>
			                            [500 x 400]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 500px;">
			                                <div class="thumb" style="padding-bottom: 400px;">
			                                    <div class="img ajax_image_file main1_${list.SEQ}">
													<c:if test="${list.MAIN1_IMG_PATH != ''}">
														<img src="${list.MAIN1_IMG_PATH}/${list.MAIN1_IMG_NM}">
													</c:if>					                                    
			                                    </div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('main1', '${list.SEQ}');"></button>
			                                </div>
			                                <div class="ajax_image_upload main1_${list.SEQ}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2" style="position: absolute; right: 0;">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="main1" data-imgnum="${list.SEQ}" id="imagefile_main1_${list.SEQ}" name="imagefile_main1" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr class="img2" style="display: none;">
			                        <th>
			                            이미지<br/>
			                            [300 x 500]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 300px;">
			                                <div class="thumb" style="padding-bottom: 500px;">
			                                    <div class="img ajax_image_file main2_${list.SEQ}">
													<c:if test="${list.MAIN2_IMG_PATH != ''}">
														<img src="${list.MAIN2_IMG_PATH}/${list.MAIN2_IMG_NM}">
													</c:if>					                                    
			                                    </div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('main2', '${list.SEQ}');"></button>
			                                </div>
			                                <div class="ajax_image_upload main2_${list.SEQ}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="main2" data-imgnum="${list.SEQ}" id="imagefile_main2_${list.SEQ}" name="imagefile_main2" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th>하이퍼링크</th>
			                        <td>
			                            <input type="text" id="link" name="link" class="ipt" style="width: 100%;" value="${list.LINK}" />
			                        </td>
			                    </tr>
			                </tbody>
			           </table>
			        </div>
			    </div>
			</form>
		</c:forEach>
	</c:if>
	<c:if test="${empty resultList}">
		<c:forEach var="i" begin="1" end="3">
			<form id="frm_${i}" name="frm_${i}" method="post" enctype="multipart/form-data">
				<input type="hidden" id="seq" name="seq" value="${i}" />
				<input type="hidden" id="icon_img_nm_${i}" name="icon_img_nm" />
				<input type="hidden" id="icon_img_path_${i}" name="icon_img_path" />
				<input type="hidden" id="main1_img_nm_${i}" name="main1_img_nm" />
				<input type="hidden" id="main1_img_path_${i}" name="main1_img_path" />
				<input type="hidden" id="main2_img_nm_${i}" name="main2_img_nm" />
				<input type="hidden" id="main2_img_path_${i}" name="main2_img_path" />
				
			    <div class="group" style="max-width: 800px; clear: both;">
			        <div class="header">
			            <h3>팝업 ${i}</h3>
			            <div class="switch" style="right: 180px;">
			                <label>
			                    <input type="checkbox" id="open_yn_${i}" name="open_yn" value="N">
			                    <span class="lever"></span>
			                </label>
			            </div>
			            <div class="select">
			                <select class="ipt" id="pop_type_${i}" name="pop_type" style="max-width: 200px;">
			                   <option value="1" selected>이미지+텍스트형</option>
			                   <option value="2">텍스트형</option>
			                   <option value="3">이미지형</option>
			                </select>
			            </div>
			        </div>
			        <div class="body" style="min-height: auto;">
			           <table class="board_list_write">
			                <tbody>
			                    <tr class="icon">
			                        <th>
			                            아이콘<br/>
			                            [30 x 30]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 100px;">
			                                <div class="thumb">
			                                    <div class="img ajax_image_file icon_${i}"></div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('icon', '${i}');"></button>
			                                </div>
			                                <div class="ajax_image_upload icon_${i}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="icon" data-imgnum="${i}" id="imagefile_icon_${i}" name="imagefile_icon" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr class="tit">
			                        <th>제목</th>
			                        <td>
			                            <input type="text" id="title" name="title" class="ipt" style="width: 100%;" value="" />
			                        </td>
			                    </tr>
			                    <tr class="cont">
			                        <th>본문내용</th>
			                        <td>
			                            <textarea id="content" name="content" class="ipt" style="width: 100%;" rows="8"></textarea>
			                        </td>
			                    </tr>
			                    <tr class="img1">
			                        <th>
			                            이미지<br/>
			                            [500 x 400]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 500px;">
			                                <div class="thumb" style="padding-bottom: 400px;">
			                                    <div class="img ajax_image_file main1_${i}"></div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('main1', '${i}');"></button>
			                                </div>
			                                <div class="ajax_image_upload main1_${i}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="main1" data-imgnum="${i}" id="imagefile_main1_${i}" name="imagefile_main1" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr class="img2" style="display: none;">
			                        <th>
			                            이미지<br/>
			                            [300 x 500]
			                        </th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 300px;">
			                                <div class="thumb" style="padding-bottom: 500px;">
			                                    <div class="img ajax_image_file main2_${i}"></div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('main2', '${i}');"></button>
			                                </div>
			                                <div class="ajax_image_upload main2_${i}">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgtype="main2" data-imgnum="${i}" id="imagefile_main2_${i}" name="imagefile_main2" accept="image/*" />
		                                        </div>
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th>하이퍼링크</th>
			                        <td>
			                            <input type="text" id="link" name="link" class="ipt" style="width: 100%;" value="" />
			                        </td>
			                    </tr>
			                </tbody>
			           </table>
			        </div>
			    </div>
			</form>
		</c:forEach>
	</c:if>
    <div class="group" style="max-width: 800px; clear: both;">
        <div class="body" style="min-height: auto;">
           <div class="board_list_btn right" style="margin-top: 0;">
                <a href="#" class="btn blue" onClick="javascript:fn_insert();">저장</a>
            </div>
        </div>
    </div>		
</div>
<!-- main -->

<script type="text/javascript">
$('.imagefile').on('change', function(e) {
	preveal(this);
});

function preveal(input) {
	
	var imgarea = '';
	imgarea = '.img.ajax_image_file';
	
	if(input.dataset.imgtype == "icon"){ //아이콘[30 x 30]
		imgarea += '.icon_' + input.dataset.imgnum;
	}else if(input.dataset.imgtype == "main1"){ // 이미지 [500 x 400]
		imgarea += '.main1_' + input.dataset.imgnum;
	}else if(input.dataset.imgtype == "main2"){ // 이미지 [300 x 500]
		imgarea += '.main2_' + input.dataset.imgnum;
	}
	
	if (input.files && input.files[0]) {
		$(imgarea).html('');
		
		var reader = new FileReader();
		reader.onload = function(e) {
			$(imgarea).html(
					'<img src="' + e.target.result + '">');
		}
		reader.readAsDataURL(input.files[0]);
	}
	
};

function fn_imageDelete(type, seq) {
	
	if(type == "icon"){ //아이콘[30 x 30]
		$('.img.ajax_image_file.icon_' + seq).html('');
		$('#icon_img_nm_' + seq).val('');
		$('#icon_img_path_' + seq).val('');
		$('#imagefile_icon_' + seq).val('');	
	}else if(type == "main1"){ // 이미지 [500 x 400]
		$('.img.ajax_image_file.main1_' + seq).html('');
		$('#main1_img_nm_' + seq).val('');
		$('#main1_img_path_' + seq).val('');
		$('#imagefile_main1_' + seq).val('');	
	}else if(type == "main2"){ // 이미지 [300 x 500]
		$('.img.ajax_image_file.main2_' + seq).html('');
		$('#main2_img_nm_' + seq).val('');
		$('#main2_img_path_' + seq).val('');
		$('#imagefile_main2_' + seq).val('');	
	}

}

$(function(){
	
	var pop_type = [];
	
	pop_type.push($("[id=pop_type_1]").val());
	pop_type.push($("[id=pop_type_2]").val());
	pop_type.push($("[id=pop_type_3]").val());
	
	$.each( pop_type, function( key, value ) {		
		key = key+1;
		
		if(value == "1"){
			$('#frm_'+key).find('.group').find('tr').show();
			$('#frm_'+key).find('.group').find('tr.img2').hide();
		}else if(value == "2"){
			$('#frm_'+key).find('.group').find('tr').show();
			$('#frm_'+key).find('.group').find('tr.img1').hide();
			$('#frm_'+key).find('.group').find('tr.img2').hide();
		}else if(value == "3"){
			$('#frm_'+key).find('.group').find('tr').show();
			$('#frm_'+key).find('.group').find('tr.icon').hide();
			$('#frm_'+key).find('.group').find('tr.tit').hide();
			$('#frm_'+key).find('.group').find('tr.cont').hide();
			$('#frm_'+key).find('.group').find('tr.img1').hide();
 		}
	});
	
	// 팝업 타입
    $("[name=pop_type]").change(function(e) {
        switch ($(this).val()){
            case "1" :
                $(this).closest('.group').find('tr').show();
                $(this).closest('.group').find('tr.img2').hide();
                break;
            case "2" :
                $(this).closest('.group').find('tr').show();
                $(this).closest('.group').find('tr.img1').hide();
                $(this).closest('.group').find('tr.img2').hide();
                break;
            case "3" :
                $(this).closest('.group').find('tr').show();
                $(this).closest('.group').find('tr.icon').hide();
                $(this).closest('.group').find('tr.tit').hide();
                $(this).closest('.group').find('tr.cont').hide();
                $(this).closest('.group').find('tr.img1').hide();
                break;
        }
        $(this).closest('.group')
    });
   	
	// 팝업 노출 열부
    $("input:checkbox[name=open_yn]").change(function(e) {
        if($(this).prop('checked')){
        	$(this).prop('checked', true);
        	$(this).val('Y');
        }else{
        	$(this).prop('checked', false);
        	$(this).val('N');    
        }
    });
    
});
</script>