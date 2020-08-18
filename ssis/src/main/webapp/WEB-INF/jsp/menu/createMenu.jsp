<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	
	var jsonList = JSON.parse('${jsonList}');
	
	$(window).ready(function(){
		pageEvents();
	});
	
	function pageEvents() {
		
		$('#ulDepth1').find('li').unbind('click').bind('click',function(){
			
			if(!$(this).hasClass('on') && !$(this).hasClass('firstNum')) {
				$(".newMenu").remove();
				
				$(".menuAdd").show();
				$(".menuDel").hide();
				
		    	$('#ulDepth1').find('li').removeClass('on');
		    	$(this).addClass('on');
				var menuIdDepths = $(this).attr('id').split('_');
				var menuId = menuIdDepths[0];
				var depths = menuIdDepths[1];
				
				if(1== depths) {
					$('#ulDepth2').find('li').remove();
					$('#ulDepth3').find('li').remove();
				} else {
					$('#ulDepth3').find('li').remove();
				}
				
				var html1 = '<li class="firstNum">2차메뉴</li> ';
				var html2 = '<li class="firstNum">3차메뉴</li> ';
				
				jsonList.forEach(function (val, index, array) {
					if(1 == depths) {
						if(2 == val.displayLevel && menuId == val.upperMenuId) {
							html1 += makeHtml(val.displayLevel, val.menuId, val.menuNm);
						}
					} else if(2 == depths) {
						if(3 == val.displayLevel && menuId == val.upperMenuId) {
							html2 += makeHtml(val.displayLevel, val.menuId, val.menuNm);
						}
					}
				});
				$('#ulDepth2').append(html1);
				$('#ulDepth3').append(html2);
				pageEvents();
			}
		});
	    
	    $('#ulDepth2').find('li').unbind('click').bind('click',function(){
	    	
	    	if(!$(this).hasClass('on') && !$(this).hasClass('firstNum')) {
	    	
				$(".newMenu").remove();
				
				$(".menuAdd").show();
				$(".menuDel").hide();
				
		    	$('#ulDepth2').find('li').removeClass('on');
		    	$(this).addClass('on');
				var menuIdDepths = $(this).attr('id').split('_');
				var menuId = menuIdDepths[0];
				var depths = menuIdDepths[1];
				
				$('#ulDepth3').find('li').remove();
				
				var html = '<li class="firstNum">3차메뉴</li> ';
				
				jsonList.forEach(function (val, index, array) {
					if(3 == val.displayLevel && menuId == val.upperMenuId) {
						html += makeHtml(val.displayLevel, val.menuId, val.menuNm);
					}
				});
				$('#ulDepth3').append(html);
				pageEvents();
	    	}
		});
	    
	    $('#ulDepth3').find('li').unbind('click').bind('click',function(){
	    	
	    	if(!$(this).hasClass('on') && !$(this).hasClass('firstNum')) {
				$(".newMenu").remove();
				
				$(".menuAdd").show();
				$(".menuDel").hide();
		    	
		    	$('#ulDepth3').find('li').removeClass('on');
		    	$(this).addClass('on');
				pageEvents();
	    	}
		});
	    
	    $('.btn_move').unbind('click').bind('click',function(){
	        var $li = $(this).closest('li');
	        if($(this).attr('class')=="btn_move up") {
	        	if($li.prev().attr('class') != 'firstNum') $li.insertBefore($li.prev());
	        }
	        if($(this).attr('class')=="btn_move down") $li.insertAfter($li.next());
	    });
	}
	
	function makeHtml(displayLevel, menuId, menuNm) {
		var id = menuId+'_'+displayLevel;
		var html = '<li id="'+id+'">'+menuNm+'</li> ';
		return html;
	}
	
	function menuAdd() {
		
		if('' == $("#menuNm").val()) {
			alert("메뉴명을 입력해 주세요");
			$("#menuNm").focus();
			return false;
		}
		
		if('' == $("#description").val()) {
			alert("메뉴설명을 입력해 주세요");
			$("#description").focus();
			return false;
		}
		
		if('' == $("#url").val()) {
			alert("URL을 입력해 주세요");
			$("#url").focus();
			return false;
		}
		
		if('0' == $("#level").val()) {
			alert("메뉴레벨을 선택해 주세요");
			$("#level").focus();
			return false;
		}
		
		if('2' == $("#level").val()) {
			var cnt = 0;
			$('#ulDepth1').find('li').each(function(){
				if($(this).hasClass('on')) cnt++; 
			});
			if(0 == cnt) {
				alert("1차 메뉴를 선택해주세요");
				return false;
			}
		}
		
		if('3' == $("#level").val()) {
			var cnt = 0;
			$('#ulDepth2').find('li').each(function(){
				if($(this).hasClass('on')) cnt++; 
			});
			if(0 == cnt) {
				alert("2차 메뉴를 선택해주세요");
				return false;
			}
		}
		
		var id = '_'+$("#level").val();
		var html = "";
		html += '<li id="'+id+'" class="on newMenu">';
		html += '<span>'+$("#menuNm").val()+'</span>';
		html += '<div>';
		html += '<button type="button" class="btn_move up">위로 이동</button>';
		html += '<button type="button" class="btn_move down">아래로 이동</button>';
		html += '</div>';
		html += '</li>';
		
		$('#ulDepth'+$("#level").val()).find('li').removeClass('on');		
		$('#ulDepth'+$("#level").val()).append(html);
		
		$(".menuAdd").hide();
		$(".menuDel").show();
		
		pageEvents();
	}
	
	function menuDel() {
		
		$(".newMenu").remove();
		
		$(".menuAdd").show();
		$(".menuDel").hide();
		
		pageEvents();
	}
	
	function createMenu() {
		
		var cnt = 0;
		$('#ulDepth1').find('li').each(function(){
			if($(this).hasClass('newMenu')) {
				cnt++;
			}
		});
		$('#ulDepth2').find('li').each(function(){
			if($(this).hasClass('newMenu')) {
				cnt++;
			}
		});
		$('#ulDepth3').find('li').each(function(){
			if($(this).hasClass('newMenu')) {
				cnt++;
			}
		});
		if(0 == cnt) {
			alert('메뉴를 추가해주세요');
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
		
		if (confirm("등록 하시겠습니까?")) {
			pUrl = "/admin/menu/insertMenu.do";
			
			param = new Object();
			
	        param.menuNm = $("#menuNm").val();
	        param.description = $("#description").val();
	        param.url = $("#url").val();
	        param.level = depths;
	        param.indictYn = p_indictYn;
	        param.upperMenuId = p_upperMenuId;
			param.menuId = p_menuId;
	        		
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

<form action="/menu/createMenu.do" method="post" id="menuForm" name="menuForm">
<div id="main">
    <div class="group">
	<!-- content -->
	    <div id="container" class="header">
			<h3>메뉴 등록</h3>
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
                            <td><input type="text" class="ipt" id="menuNm" name="menuNm" maxLength="25" /></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴설명</th>
                            <td><input type="text" class="ipt" id="description" name="description" maxLength="1000" /></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴 URL</th>
                            <td><input type="text" class="ipt" id="url" name="url" maxLength="50" /></td>
                        </tr>
                        <tr>
                            <th scope="row">메뉴 레벨</th>
                            <td>
                                <select class="ipt"  id="level" name="level" title="메뉴 레벨 선택" style="max-width: 120px;">
                                    <option value="0">선택</option>
                                    <option value="1">1차메뉴</option>
                                    <option value="2">2차메뉴</option>
                                    <option value="3">3차메뉴</option>
                                </select>
                                <button type="button" class="btn blue menuAdd" onClick="javascript:menuAdd(); return false;">추가</button>
                                <button type="button" class="btn red menuDel" style="display:none" onClick="javascript:menuDel(); return false;">삭제</button>
                            </td>
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
                                            		<li id="${list.menuId}_${list.displayLevel}">${list.menuNm}</li>
                                            	</c:if>
                                            </c:forEach>
                                        </ul>                                        
                                    </div>
                                    <div>
                                        <ul id="ulDepth2">
                                            <li class="firstNum">2차메뉴</li>
                                        </ul>                                        
                                    </div>
                                    <div>
                                        <ul id="ulDepth3">
                                            <li class="firstNum">3차메뉴</li>
                                        </ul>                                        
                                    </div>                                    
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">사용여부</th>
                            <td>
                                <input type="radio" id="indictYn1" name="indictYn" value="Y" class="custom" checked="checked">
                                <label for="indictYn1" >사용</label>
                                <input type="radio" id="indictYn2" name="indictYn" value="N" class="custom" >
                                <label for="indictYn2">미사용</label>
                            </td>
                        </tr>
                    </tbody>
                </table>
           		<div class="board_list_btn right">
					<a href="/admin/menu/menuList.do" class="btn black">목록으로</a>
                    <a href="#" class="btn red" onClick="javascript:createMenu(); return false;">저장</a>
                    <a href="/admin/menu/menuList.do" class="btn blue">취소</a>
                </div>
            </div>
        </div>
    </div>
    <!-- /content -->
</form>