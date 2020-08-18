<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="/js/jquery.form.js" type="text/javascript"></script>
<script>
var pUrl, pParam;

function fn_insert(){
	
	var formSize = "5";
	
	if (confirm("저장하시겠습니까?")) {
		
		for(var seq = 1; seq < formSize; seq++){
			insertAjax(seq);
		}
		
	}
	
}

function insertAjax(seq){

	if(seq == "4"){
		$("#frm_"+seq).attr("action", "/admin/contact/quickMenuRegistThread.do?log=true");
	}else{
		$("#frm_"+seq).attr("action", "/admin/contact/quickMenuRegistThread.do");
	}
	
	var options = {
		success : function(data) {
			if (data.message == "생성이 실패하였습니다.") {
				alert(data.message);
				return false;
			} else {
				if(seq == "4"){
					alert(data.message);
					fn_init();
				}
			}
		},
		type : "POST"
	};
	
	$("#frm_"+seq).ajaxSubmit(options);
}

function fn_init() {
	$("#frm_1").attr({
		action : "/admin/contact/quickMenuList.do",
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
			            <h3>퀵메뉴 ${list.SEQ}</h3>
			            <div class="switch">
			                <label>
			                     <input type="checkbox" id="open_yn_${list.SEQ}" name="open_yn" value="${list.OPEN_YN}" <c:if test="${'Y' eq list.OPEN_YN}">checked</c:if>>
			                    <span class="lever"></span>
			                </label>
			            </div>
			        </div>
			        <div class="body" style="min-height: auto;">
			           <table class="board_list_write">
			                <tbody>
			                    <tr>
			                        <th class="req">아이콘<br/>[30 x 30]</th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 100px;">
			                                <div class="thumb">
			                                    <div class="img ajax_image_file_${list.SEQ}">
													<c:if test="${list.IMG_PATH != ''}">
														<img src="${list.IMG_PATH}/${list.IMG_NM}">
													</c:if>			                                    
			                                    </div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('${list.SEQ}');"></button>
			                                </div>
			                                <div class="ajax_image_upload">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2" style="position: absolute; right: 0;">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgnum="${list.SEQ}" id="imagefile_${list.SEQ}" name="imagefile" accept="image/*" value="2" />
		                                        </div>			                                    
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">아이콘명</th>
			                        <td>
			                            <input type="text" id="icon_nm" name="icon_nm" class="ipt" style="width: 110px;" value="${list.ICON_NM}" placeholder="필수 입력" maxlength="5" />
			                            <span style="color:red;font-size:13px"> * 5자까지 입력할 수 있습니다.</span>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">하이퍼링크</th>
			                        <td>
			                            <input type="text" id="link" name="link" class="ipt" style="width: 100%;" value="${list.LINK}" placeholder="필수 입력 사항입니다." />
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
		<c:forEach var="i" begin="1" end="4">
			<form id="frm_${i}" name="frm_${i}" method="post" enctype="multipart/form-data">
				<input type="hidden" id="seq" name="seq" value="${i}" />
	            <input type="hidden" id="img_nm_${i}" name="img_nm" />
	            <input type="hidden" id="img_path_${i}" name="img_path" />				
			    <div class="group col2">
			        <div class="header">
			            <h3>퀵메뉴 ${i}</h3>
			            <div class="switch">
			                <label>
			                    <input type="checkbox" id="open_yn_${i}" name="open_yn" value="N">
			                    <span class="lever"></span>
			                </label>
			            </div>
			        </div>
			        <div class="body" style="min-height: auto;">
			           <table class="board_list_write">
			                <tbody>
			                    <tr>
			                        <th class="req">아이콘<br/>[30 x 30]</th>
			                        <td>
			                            <div class="uploadImgFile" style="width: 100px;">
			                                <div class="thumb">
			                                    <div class="img ajax_image_file_${i}"></div>
			                                    <button type="button" class="btn_delete" onclick="javascript:fn_imageDelete('${i}');"></button>
			                                </div>
			                                <div class="ajax_image_upload">
												<div class="inp_file">
			                                    	<button class="k-button k-primary k-upload-button ajax_image_upload2">파일찾기</button>
			                                        <input class="imagefile file_input_hidden" type="file" (change)="fileEvent($event)" data-imgnum="${i}" id="imagefile_${i}" name="imagefile" accept="image/*" />
		                                        </div>					                                    
			                                </div>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">아이콘명</th>
			                        <td>
			                            <input type="text" id="icon_nm" name="icon_nm" class="ipt" style="width: 110px;" value="" placeholder="필수 입력" maxlength="5" />
			                            <span style="color:red;font-size:13px"> * 5자까지 입력할 수 있습니다.</span>			                           
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="req">하이퍼링크</th>
			                        <td>
			                            <input type="text" id="link" name="link" class="ipt" style="width: 100%;" value="" placeholder="필수 입력 사항입니다." />
			                        </td>
			                    </tr>
			                </tbody>
			           </table>
			        </div>
			    </div>
		    </form>
	    </c:forEach>
    </c:if>
    <div class="group">
        <div class="body" style="min-height: auto;">
           <div class="board_list_btn right" style="margin-top: 0;">
                <a href="#" class="btn blue" onClick="javascript:fn_insert();">저장</a>
            </div>
        </div>
    </div>
</div>
<!-- main -->

<script type="text/javascript">
$(function(){
	
	// 퀵 메뉴 노출 열부
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

$('.imagefile').on('change', function(e) {
	preveal(this);
});

function preveal(input) {
	
	var imgarea = '';
	imgarea = '.img.ajax_image_file';
	
	imgarea += '_' + input.dataset.imgnum;
	
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

function fn_imageDelete(seq) {
	
	$('.img.ajax_image_file_' + seq).html('');
	$('#img_nm_' + seq).val('');
	$('#img_path_' + seq).val('');
	$('#imagefile_' + seq).val('');
	
}
</script>