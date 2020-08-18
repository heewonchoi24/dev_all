<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script>
	var pUrl, param;

	// 푸터 관리 화면
	function listThread() {
		$("#form").attr({
			method : "post"
		}).submit();
	}

	// 푸터 텍스트 등록
	function fn_footerTextInsert() {

		if (confirm("저장 하시겠습니까?")) {

			pUrl = "/admin/footer/footerTextInsert.do";

			param = new Object();

			param.fId = $("#fId").val();
			param.content = $("#content").val();
			param.content2 = $("#content2").val();
			
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR) {
				alert(data.message);
				listThread();
			}, function(jqXHR, textStatus, errorThrown) {

			});
		}
	}
</script>

<!-- main -->
<form action="/admin/footer/footerPage.do" id="form" name="form" method="post">
	<div id="main">
	    <div class="group">
	    	<div class="header"><h3>푸터 관리</h3></div>
	        <div class="body" style="min-height: auto;">
	           <table class="board_list_write">
	                <tbody>
	                	<input type="hidden" id="fId" name="fId" value="${footerText.F_ID }" />
	                    <tr>
	                        <td>
	                            <input type="text" id="content" name="content" class="ipt" style="width: 100%;" value="${footerText.CONTENT }" />
	                        </td>
	                    </tr>
	                    <tr>
	                        <td>
	                            <input type="text" id="content2" name="content2" class="ipt" style="width: 100%;" value="${footerText.CONTENT2 }" />
	                        </td>
	                    </tr>
	                </tbody>
	           </table>
	           <div class="board_list_btn right">
	                <a href="#" class="btn blue" onClick="javascript:fn_footerTextInsert(); return false;">저장</a>
	            </div>
	        </div>
	    </div>
	</div>
</form>
<!-- main -->