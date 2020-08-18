<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.menu_order > div ul li > div {top: 0;}
</style>
<script type="text/javascript">
	
	var jsonList = JSON.parse('${jsonList}');
	
	$(window).ready(function(){
		pageEvents();
	});
	
	function pageEvents() {
	    
	    $('.btn_move').unbind('click').bind('click',function(){
	        var $li = $(this).closest('li');
	        if($(this).attr('class')=="btn_move up") {
	        	if($li.prev().attr('class') != 'firstNum') $li.insertBefore($li.prev());
	        }
	        if($(this).attr('class')=="btn_move down") $li.insertAfter($li.next());
	    });
	}
	
	function updateMenu() {
		
		if('' == $("#menuNm").val()) {
			alert("메뉴명을 입력해 주세요");
			$("#menuNm").focus();
			return false;
		}
		if('' == $("#url").val()) {
			alert("URL을 입력해 주세요");
			$("#url").focus();
			return false;
		}
		
		var p_upperMenuId = '';
		var p_indictYn = '';
		var p_menuId =  [];

		$("input:radio").each(function( key ) {
			if($(this).prop("checked")) {
				p_indictYn = $(this).val();
			}
		});
		
		var menuIdDepths = $(".newMenu").attr('id').split('_');
		var newMenuId = menuIdDepths[0];
		var depths = menuIdDepths[1];
		var index = 0;
		
		if(1 == depths) {
			p_upperMenuId = 0;
			$('#ulDepth1').find('li').each(function(){
				if(!$(this).hasClass('firstNum')) {
					var menuIdDepth = $(this).attr('id').split('_');
					var menuId = menuIdDepth[0];
					p_menuId[index] = menuId;
					index++;
				}
			});
		} else if(2 == depths) {
			$('#ulDepth1').find('li').each(function(){
				if($(this).hasClass('on')) {
					var menuIdDepth = $(this).attr('id').split('_');
					p_upperMenuId = menuIdDepth[0];
				}
			});
			$('#ulDepth2').find('li').each(function(){
				if(!$(this).hasClass('firstNum')) {
					var menuIdDepth = $(this).attr('id').split('_');
					var menuId = menuIdDepth[0];
					p_menuId[index] = menuId;
					index++;
				}
			});
		} else if(3 == depths) {
		    $('#ulDepth2').find('li').each(function(){	    	
		    	if($(this).hasClass('on')) {
					var menuIdDepth = $(this).attr('id').split('_');
					p_upperMenuId = menuIdDepth[0];
		    	}
			});
		    $('#ulDepth3').find('li').each(function(){
		    	if(!$(this).hasClass('firstNum')) {
					var menuIdDepth = $(this).attr('id').split('_');
					var menuId = menuIdDepth[0];
					p_menuId[index] = menuId;
					index++;
		    	}
			});
		}
		
		var pUrl = '';
		var param = new Object();
		
		if (confirm("수정 하시겠습니까?")) {
			pUrl = "/admin/menu/updateMenu.do";
			
			param = new Object();
			
			param.menuId = newMenuId;
	        param.menuNm = $("#menuNm").val();
	        param.description = $("#description").val();
	        param.url = $("#url").val();
	        param.indictYn = p_indictYn;
	        param.upperMenuId = p_upperMenuId;
			param.menuIdList = p_menuId;
	        		
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				$("#menuForm").attr({
		            action : "/admin/menu/menuList.do",
		            method : "post"
		        }).submit();
				
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
	}
	
	function deleteMenu(menuId) {
		
		if (confirm("삭제하시겠습니까?")) {
			pUrl = "/menu/deleteMenu.do";
			
			param = new Object();
			param.menuId = menuId;
	        		
			$.ccmsvc.ajaxSyncRequestPost(pUrl, param, function(data, textStatus, jqXHR){
				alert(data.message);
				
				$("#menuForm").attr({
		            action : "/admin/menu/menuList.do",
		            method : "post"
		        }).submit();
				
			}, function(jqXHR, textStatus, errorThrown){
				
			});
		}
	}
</script>
<form action="/admin/menu/modifyMenu.do" method="post" id="menuForm" name="menuForm">
<div id="main">
    <div class="group">
	<!-- content -->
        <div id="container" class="header">
			<h3>메뉴 수정</h3>
        </div>
        <div class="body" style="min-height: auto;">
        
                <table class="board_list_write">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th scope="row">메뉴명</th>
                            <td><input type="text" class="ipt" id="menuNm" name="menuNm" value="${result.menuNm}" maxLength="25" /></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴설명</th>
                            <td><input type="text" class="ipt" id="description" name="description" value="${result.description}" maxLength="1000" /></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴 URL</th>
                            <td><input type="text" class="ipt" id="url" name="url" value="${result.url}" maxLength="50" style="width: 100%;"/></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴순서</th>
                            <td>
                                <div class="menu_order">
                                    <div>
                                        <ul id="ulDepth1">
                                            <li class="firstNum">1차메뉴</li>
                                            <c:forEach var="list" items="${resultList}" varStatus="status">
                                            	<c:if test="${list.displayLevel eq '1'}">
                                            		<c:set var="classOn" value=""/>
                                            		<c:if test="${list.menuId eq menuId_1}">
                                            			<c:set var="classOn" value="class='on'"/>
                                            		</c:if>
                                            		<c:choose>
														<c:when test="${'1' eq displayLevel and list.menuId eq menuId_1}">
															<li id="${list.menuId}_${list.displayLevel}" class="on newMenu">
																<span>${list.menuNm}</span>
																<div>
																	<button type="button" class="btn_move up">위로 이동</button>
																	<button type="button" class="btn_move down">아래로 이동</button>
																</div>
															</li>
														</c:when>
														<c:otherwise>
															<li id="${list.menuId}_${list.displayLevel}"  ${classOn}>${list.menuNm}</li>
														</c:otherwise>
                                            		</c:choose>
                                            	</c:if>
                                            </c:forEach>
                                        </ul>
                                    </div>
                                    <div>
                                        <ul id="ulDepth2">
                                            <li class="firstNum">2차메뉴</li>
                                            <c:if test="${null != menuId_2}">
	                                            <c:forEach var="list" items="${resultList}" varStatus="status">
	                                            	<c:if test="${list.displayLevel eq '2' and list.upperMenuId eq menuId_1}">
	                                            		<c:set var="classOn" value=""/>
	                                            		<c:if test="${list.menuId eq menuId_2}">
	                                            			<c:set var="classOn" value="class='on'"/>
	                                            		</c:if>
	                                            		<c:choose>
															<c:when test="${'2' eq displayLevel and list.menuId eq menuId_2}">
																<li id="${list.menuId}_${list.displayLevel}" class="on newMenu">
																	<span>${list.menuNm}</span>
																	<div>
																		<button type="button" class="btn_move up">위로 이동</button>
																		<button type="button" class="btn_move down">아래로 이동</button>
																	</div>
																</li>
															</c:when>
															<c:otherwise>
																<li id="${list.menuId}_${list.displayLevel}"  ${classOn}>${list.menuNm}</li>
															</c:otherwise>
	                                            		</c:choose>
	                                            	</c:if>
	                                            </c:forEach>
	                                    	</c:if>
                                        </ul>
                                    </div>
                                    <div>
                                        <ul id="ulDepth3">
                                            <li class="firstNum">3차메뉴</li>
                                            <c:if test="${null != menuId_3}">
	                                            <c:forEach var="list" items="${resultList}" varStatus="status">
	                                            	<c:if test="${list.displayLevel eq '3' and list.upperMenuId eq menuId_2}">
	                                            		<c:set var="classOn" value=""/>
	                                            		<c:if test="${list.menuId eq menuId_3}">
	                                            			<c:set var="classOn" value="class='on'"/>
	                                            		</c:if>
	                                            		<c:choose>
															<c:when test="${'3' eq displayLevel and list.menuId eq menuId_3}">
																<li id="${list.menuId}_${list.displayLevel}" class="on newMenu">
																	<span>${list.menuNm}</span>
																	<div>
																		<button type="button" class="btn_move up">위로 이동</button>
																		<button type="button" class="btn_move down">아래로 이동</button>
																	</div>
																</li>
															</c:when>
															<c:otherwise>
																<li id="${list.menuId}_${list.displayLevel}"  ${classOn}>${list.menuNm}</li>
															</c:otherwise>
	                                            		</c:choose>
	                                            	</c:if>
	                                            </c:forEach>
	                                    	</c:if>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">사용여부</th>
                            <td>
                                <input type="radio" id="indictYn1" class="custom" name="indictYn" value="Y" <c:if test="${result.indictYn == 'Y'}">checked="true"</c:if>>
                                <label for="indictYn1" >사용</label>
                                <input type="radio" id="indictYn2" class="custom" name="indictYn" value="N" <c:if test="${result.indictYn == 'N'}">checked="true"</c:if>>
                                <label for="indictYn2" class="custom">미사용</label>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="board_list_btn right">
                    <a href="/admin/menu/menuList.do" class="btn blue">목록으로</a>
                    <a href="#" class="btn black" onClick="javascript:updateMenu(); return false;">수정</a>
                </div>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>