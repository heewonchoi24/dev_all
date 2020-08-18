<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
var titleArray = [];

function fn_mainContentsSortInsert() {
	if (confirm("저장하시겠습니까?")) {
		
		if(titleArray == ""){ alert("변경사항이 없습니다."); return; }
		
	    var pUrl = "/admin/contact/mainContentsSortRegistThread.do";

		var param = {};
		
		$("#titleArrayInfo").val(titleArray);
		
		param.titleArrayInfo = $("#titleArrayInfo").val();

		$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
			alert(data.message);
			fn_init();
		}, function(jqXHR, textStatus, errorThrown){
		});	
		
	}
}

function fn_init() {
	$("#form").attr({
		action : "/admin/contact/mainContentsSortList.do",
		method : "post"
	}).submit();
}
</script>

<!-- main -->
<form action="" method="post" id="form" name="form">
	<input type="hidden" id="titleArrayInfo" name="titleArrayInfo" value="[]" />
	<div id="main">
	    <div class="slotTitle">
	        <div class="group col4">
	            <div class="header">
	                <h3>슬롯 1</h3>
	            </div>
	        </div>
	        <div class="group col4">
	            <div class="header">
	                <h3>슬롯 2</h3>
	            </div>
	        </div>
	        <div class="group col4">
	            <div class="header">
	                <h3>슬롯 3</h3>
	            </div>
	        </div>
	        <div class="group col4">
	            <div class="header">
	                <h3>슬롯 4</h3>
	            </div>
	        </div>
	    </div>
	    <div class="slotList">
	     	<c:if test="${!empty resultList}">
	    		<c:forEach items="${resultList}" var="result">
			        <div class="group col4" data-tit="${result.TITLE}">
			            <div class="body" style="min-height: auto;">
			               <div class="tit">${result.TITLE}</div>
			            </div>
			        </div>
		        </c:forEach>
		    </c:if>
	    	<c:if test="${empty resultList}">	    
		        <div class="group col4" data-tit="주요일정">
		            <div class="body" style="min-height: auto;">
		               <div class="tit">주요일정</div>
		            </div>
		        </div>    	
		        <div class="group col4" data-tit="공지사항">
		            <div class="body" style="min-height: auto;">
		               <div class="tit">공지사항</div>
		            </div>
		        </div>
		        <div class="group col4"  data-tit="자료실">
		            <div class="body" style="min-height: auto;">
		               <div class="tit">자료실</div>
		            </div>
		        </div>
		        <div class="group col4" data-tit="개인정보 언론동향">
		            <div class="body" style="min-height: auto;">
		               <div class="tit">개인정보 언론동향</div>
		            </div>
		        </div>
	        </c:if>
	    </div>
	    <div class="group">
	        <div class="body" style="min-height: auto;">
	           <div class="board_list_btn right" style="margin-top: 0;">
	                <a href="#" class="btn blue" onClick="javascript:fn_mainContentsSortInsert();">순서 저장</a>
	            </div>
	        </div>
	    </div>
	</div>
</form>
<!-- main -->
<script type="text/javascript">
    var ajaxImageUpload = {
        insertImg:function (obj){
            var button = $(obj), interval;
            new AjaxUpload(button,{
                action: '/image_upload.do',
                name: 'exh_file',
                onSubmit : function(file, ext){
                    this.disable();
                    var ext = file.substring(file.length - 3,file.length).toLocaleLowerCase();
                    if(/gif|jpg|png/.test(ext)) return true;
                    else{
                        alert("이미지[jpg, gif, png] 파일을 선택하세요.");
                        this.enable();
                        return false;
                    }
                },
                onComplete: function(file, response){
                    response = response.replace(/(<([^>]+)>)/ig,"");
                    this.enable();

                    var result = $.trim(response).split("|");
                    var status = result[0];
                    if (status == "__complete"){
                        var filename = result[1];
                        var upfilename = result[2];
                        $parent = $(obj).closest('.uploadImgFile');
                        $parent.find('.ajax_image_file').html('<img src="' + upfilename + '">');
                        $parent.find('.title').val(filename);
                        $parent.find('.hidden_img').val(upfilename);
                        $parent.find('.btn_delete').show();
                    }
                    else{
                        alert("파일을 업로드 할 수 없습니다.\n이미지[jpg, gif, png] 파일을 선택하세요.");
                    }
                }
            });
        },
        deleteImg : function (obj) {
            $parent = $(obj).closest('.uploadImgFile');
            $parent.find('.ajax_image_file').html('');
            $parent.find('.hidden_img').val('');
            $parent.find('.up_hidden_img').val('');
            $parent.find('.title').val('');
            $(obj).css("display","none");
        },
        init : function(){
            $(".ajax_image_file").each(function(){
                if($(this).html() == "") $(this).next().hide();
            }); 
            $(".ajax_image_upload,.ajax_image_upload2").click();
        }
    };

    $(function(){
        ajaxImageUpload.init();
        
        $(".slotList").kendoSortable({
            axis: "x",
            cursor: "move",
            container: ".slotList",
            placeholder: '<div class="group col4 placeholder"><div class="body" style="min-height: auto;"><div class="tit">Drop Here!</div></div></div>',
            hint: function (e) {
                return e.clone().addClass("tooltip").width($(e).width());
            },
            change: function (e) {
            	titleArray = [];
                $(".slotList .group").each(function() {
                	titleArray.push($(this).data('tit'));
                });
               
            }
        });
    });
</script>
<style type="text/css">
    .slotTitle .group { padding-bottom: 0; }
    .slotTitle .group .header { margin-bottom: 0; }
    .slotList .group .tit { text-align: center; font-size: 22px; font-weight: bold; color: #333; line-height: 420px; }
    .slotList .group .body { cursor: move; }
    .slotList .group.placeholder .body { border: 1px dashed #ccc; background-color: transparent; box-sizing: border-box;  }
    .slotList .group.placeholder .tit { color: #666; }

    .group.tooltip { opacity: .7; }
    .group.tooltip .tit { text-align: center; font-size: 22px; font-weight: bold; color: #333; line-height: 420px; }
</style>