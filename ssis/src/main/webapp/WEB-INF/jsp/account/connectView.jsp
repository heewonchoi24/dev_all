<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		
<!-- Modal_ajax -->
<section id="connectView" class="modal">
	<div class="inner">
		<div class="modal_header">
			<h2>접속이력 상세</h2>
			<button class="btn square trans modal_close">
				<i class="ico close_w" onclick="modalFn.hide($('#connectView'))"></i>
			</button>
		</div>
		<div class="modal_content">
			<div class="inner">
				<ul class="connectHistory">
					<c:if test="${not empty connectViewList }">
						<c:forEach items="${connectViewList}" var="result" varStatus="status">
								<li>
									<span class="date">${result.REGIST_DT}</span>
									<a href="javascript:link('${result.VIEW_SEQ}','${result.BBS_CD}','${result.CRUD}','${result.URL}');">${result.MENU_NM}
										<c:if test="${result.VIEW_SEQ != ''}">NO.${result.VIEW_SEQ}</c:if> 
			                    		<c:if test="${result.CRUD == 'C'}">등록</c:if> 
			                    		<c:if test="${result.CRUD == 'R'}">조회</c:if> 
			                    		<c:if test="${result.CRUD == 'U'}">수정</c:if>
			                    		<c:if test="${result.CRUD == 'D'}">삭제</c:if> 
									</a>
								</li>
						</c:forEach>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</section>