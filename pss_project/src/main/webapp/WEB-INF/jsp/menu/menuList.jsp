<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript">
	
	$(window).ready(function(){
		
	});
	
	function goPage(pageNo) {
		document.menuForm.pageIndex.value = pageNo;
		document.menuForm.action = "/admin/menu/menuList.do";
		document.menuForm.submit();
	}
	
	function modifyMenu(menuId, upperMenuId, displayLevel) {
		$("#menuId").val(menuId);
		$("#upperMenuId").val(upperMenuId);
		$("#displayLevel").val(displayLevel);
		$("#menuForm").attr({
			action : "/admin/menu/modifyMenu.do",
			method : "post"
		}).submit();
	}
	
	function go_search(){
		if($("#srchStr").val()){
			if(!$("#srchOpt").val()){alert("검색분류를 선택하세요."); return false;}
			$("#pageIndex").val("1");
		}
		
		$("#menuForm").attr({
			method : "post",
			action : "/admin/menu/menuList.do"
		}).submit();
	}
</script>
<div id="main">
<form action="/admin/menu/menuList.do" method="post" id="menuForm" name="menuForm">
	
	<input type="hidden" name="menuId" id="menuId" value=""/>
	<input type="hidden" name="upperMenuId" id="upperMenuId" value=""/>
	<input type="hidden" name="displayLevel" id="displayLevel" value=""/>
	<input type="hidden" name="pageIndex" id="pageIndex" value="${pageIndex }"/>
	
    <div class="group">
   		<div class="header">
            <h3>메뉴관리</h3>
        </div>
        <div class="body">
            
            <c:choose>
				<c:when test="${!empty resultList}">
					
	                <table class="board_list_normal">
	                    <colgroup>
	                        <col style="width:80px;">
	                        <col style="width:80px;">
	                        <col style="width:300px;">
	                        <col style="width:*">
	                        <col style="width:170px;">
	                        <col style="width:100px;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th scope="col">레벨</th>
	                            <th scope="col">순서</th>
	                            <th scope="col">메뉴명</th>
	                            <th scope="col">메뉴URL</th>
	                            <th scope="col">사용여부</th>
	                            <th scope="col">관리</th>
	                        </tr>
	                    </thead>
	                    <tbody>
							<c:forEach var="list" items="${resultList}" varStatus="status">
		                        <tr <c:if test="${list.displayLevel eq '1'}">class="depth1_bg"</c:if>>
		                            <td class="num">${list.displayLevel}</td>
		                            <td class="num">${list.outputOrdr}</td>
		                            <td class="depth depth${list.displayLevel}">
			                            	<c:choose>
			                            		<c:when test="${list.displayLevel eq '1'}">
			                            			${list.menuNm}
			                            		</c:when>
			                            		<c:when test="${list.displayLevel eq '2'}">
			                            			<span>└ ${list.menuNm}</span>
			                            		</c:when>
			                            		<c:otherwise>
			                            			<span>└└ ${list.menuNm}</span>
			                            		</c:otherwise>
			                            	</c:choose>
			                        </td>
		                            <td>${list.url}</td>
		                            <c:choose>
		                            	<c:when test="${list.indictYn eq 'Y'}">
		                            		<td class="state"><span class="active">사용</span></td>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<td class="state"><span class="">미사용</span></td>
		                            	</c:otherwise>
		                            </c:choose>
		                            <td class="center">
		                                <a href="#" class="link" onClick="modifyMenu('${list.menuId}', '${list.upperMenuId}', '${list.displayLevel}')">수정</a>
		                            </td>
		                        </tr>
		                	</c:forEach>
	                    </tbody>
	                </table>
					<div class="pagination">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="goPage" />
					</div>                
                   </c:when>
                   <c:otherwise>
                   	<div class="none" >
                		<p class="c_gray f17">등록된 메뉴가 없습니다.</p>
            		</div>
                   </c:otherwise>
               </c:choose>
                <div class="board_list_btn right">
                        <a href="/admin/menu/createMenu.do" class="btn blue">메뉴등록</a>
                </div>                
        </div>
    </div>
    <!-- /content -->
</form>
</div>